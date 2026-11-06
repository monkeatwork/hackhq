#!/usr/bin/env bash
# HackHQ sandbox: run an untrusted submission inside a throwaway container
# and keep a numbered evidence log the court can cite (log#n).
#
#   sandbox.sh build
#   sandbox.sh start <case-id> <github repo url>
#   sandbox.sh exec  <case-id> "<command>" [timeout seconds, default 600, max 1800]
#   sandbox.sh stop  <case-id>
#   sandbox.sh ps
#
# Evidence lands in ./evidence/<case-id>/ next to this repository:
#   log.md        one numbered entry per command (cite as log#n)
#   cmd-<n>.out   full output of command n
#
# Environment:
#   SANDBOX_NETWORK  docker network for the container (default: bridge).
#                    Use "none" to cut the network once dependencies are in.
set -euo pipefail

IMAGE="hackhq-sandbox:latest"
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EVIDENCE_ROOT="${EVIDENCE_ROOT:-$HERE/../evidence}"
NETWORK="${SANDBOX_NETWORK:-bridge}"

die() { echo "sandbox: $*" >&2; exit 1; }

check_case() {
  [[ "${1:-}" =~ ^C-[0-9]{1,4}$ ]] || die "case id must look like C-12, got '${1:-}'"
}

container() { echo "hackhq-$1"; }

next_entry() {
  local log="$1"
  if [[ -f "$log" ]]; then
    echo $(( $(grep -c '^### log#' "$log") + 1 ))
  else
    echo 1
  fi
}

record() {
  # record <case> <command> <exit> <seconds> <output file>
  local case="$1" cmd="$2" code="$3" secs="$4" out="$5"
  local dir="$EVIDENCE_ROOT/$case" log="$EVIDENCE_ROOT/$case/log.md"
  local n; n="$(next_entry "$log")"
  mv "$out" "$dir/cmd-$n.out"
  {
    echo "### log#$n"
    echo "\$ $cmd"
    echo "exit $code after ${secs}s  (full output: cmd-$n.out)"
    echo '```'
    tail -n 25 "$dir/cmd-$n.out"
    echo '```'
    echo
  } >> "$log"
  echo "log#$n  exit $code  ${secs}s"
}

cmd_build() {
  docker build -t "$IMAGE" "$HERE"
}

cmd_start() {
  local case="${1:-}" url="${2:-}"
  check_case "$case"
  [[ "$url" =~ ^https://github\.com/[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+(\.git)?/?$ ]] \
    || die "repo must be a https://github.com/<owner>/<repo> url, got '$url'"
  docker image inspect "$IMAGE" >/dev/null 2>&1 || die "image missing: run 'sandbox.sh build' first"

  local name; name="$(container "$case")"
  docker rm -f "$name" >/dev/null 2>&1 || true
  mkdir -p "$EVIDENCE_ROOT/$case"

  # No host mounts, no docker socket, no extra privileges, bounded resources.
  docker run -d --name "$name" \
    --network "$NETWORK" \
    --memory 2g --cpus 2 --pids-limit 512 \
    --cap-drop ALL --security-opt no-new-privileges \
    --label hackhq.case="$case" \
    "$IMAGE" sleep infinity >/dev/null

  local out; out="$(mktemp)"; local start=$SECONDS code=0
  docker exec "$name" git clone --depth 1 "$url" /work/repo >"$out" 2>&1 || code=$?
  record "$case" "git clone --depth 1 $url" "$code" $((SECONDS - start)) "$out"
  [[ $code -eq 0 ]] || die "clone failed; see the log"
  echo "sandbox $name ready; repo at /work/repo"
}

cmd_exec() {
  local case="${1:-}" command="${2:-}" limit="${3:-600}"
  check_case "$case"
  [[ -n "$command" ]] || die "no command given"
  [[ "$limit" =~ ^[0-9]+$ ]] && (( limit >= 1 && limit <= 1800 )) || die "timeout must be 1-1800 seconds"
  local name; name="$(container "$case")"
  docker inspect "$name" >/dev/null 2>&1 || die "no sandbox for $case; run 'sandbox.sh start' first"

  local out; out="$(mktemp)"; local start=$SECONDS code=0
  docker exec -w /work/repo "$name" timeout --kill-after=10 "$limit" bash -lc "$command" >"$out" 2>&1 || code=$?
  [[ $code -eq 124 ]] && echo "[sandbox] timed out after ${limit}s" >> "$out"
  tail -n 200 "$out"
  echo "----"
  record "$case" "$command" "$code" $((SECONDS - start)) "$out"
}

cmd_stop() {
  local case="${1:-}"
  check_case "$case"
  docker rm -f "$(container "$case")" >/dev/null 2>&1 && echo "stopped $case" || echo "no sandbox for $case"
}

cmd_ps() {
  docker ps --filter label=hackhq.case --format '{{.Names}}\t{{.Status}}'
}

case "${1:-}" in
  build) shift; cmd_build "$@" ;;
  start) shift; cmd_start "$@" ;;
  exec)  shift; cmd_exec "$@" ;;
  stop)  shift; cmd_stop "$@" ;;
  ps)    shift; cmd_ps "$@" ;;
  *) sed -n '2,20p' "$0"; exit 2 ;;
esac
