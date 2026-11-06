# HackHQ handoff

Read this whole file before doing anything. It is the state of the project as of
Fri 6 Nov 2026, 15:45 IST.

## 1. The hackathon

**Flip the Switch** (WeMakeDevs + DevTools Academy, powered by Switch from SandboxAQ).

- **Deadline:** Sat 7 Nov 2026, 23:59 IST. **Our target: submit by 21:00 IST.**
- **Submit:** repo + demo video + README. At least one AI agent and one person complete
  a real task through Switch, Switch is central, and the README shows how it was used.
  The Switch setup and workflow must be built during the hackathon (4–7 Nov). Existing
  libraries and agents are fine. AI coding tools are allowed, but the entrant must
  understand and be able to explain everything.
- **Track entered:** Track 01, Best Business Workflow ($2,000). Also: Best Blog side track,
  and a #HowISwitch social post.
- **Judging weights** (DevTools Academy page): Use of Switch 30%, Technical execution 25%,
  Creativity and impact 25%, Presentation and documentation 20%.
  - Use of Switch: Switch is central; the project would stop working without it.
  - Technical execution: it runs and can be reproduced from the repo.
  - Creativity and impact: a fresh idea solving a real team's problem.
  - Presentation: the demo video and README make Switch's use clear.
- Shortlisting: WeMakeDevs reviews every submission, then a joint panel
  (Switch, DevTools Academy, WeMakeDevs) judges finalists.
- Pages: https://www.wemakedevs.org/hackathons/switch (rules: /rules, schedule: /schedule,
  resources: /resources). Help: WeMakeDevs Discord.

## 2. The product: HackHQ Court

A hackathon judging court that runs inside Discord on Switch. Human judges file a
submission as a case; independent agent evaluators examine it in private rooms; a
presiding agent applies an evidence gate and drafts a ruling; **only a human judge's
ruling is final.**

**Why it matters to each organiser:**
- **WeMakeDevs** sells hackathons to devtool companies and reviews every submission by
  hand before shortlisting. HackHQ does the first pass: reproducibility and evidence.
- **Switch** gets a hackathon judged on Switch, the same "we built Switch with Switch"
  story SandboxAQ tells, plus a reusable template every future sponsor sees.
- **DevTools Academy** co-hosts these events and sells honest technical content; the
  case records are exactly that kind of evidence.

**Why Switch is central** (the 30% criterion): evaluator independence is enforced by
room membership (an agent only sees rooms it belongs to), not by code. Addressing
policies stop contestants instructing evaluators. An exclusive `presiding` role,
room documents (rubric, evidence gate, ruling format), linked rooms, agents on
different providers, and a human decision gate.

**Credit:** the adversarial-evaluation pattern (isolated evaluators, evidence gate,
steel-man) is inspired by Crossfire, which won Code2Create 7.0 at VIT
(https://github.com/hriday-singh/crossfire). We use the pattern only: no code, names
or verdict labels from it. Say so in the README.

### Architecture

Rooms (one Switch group, Discord channels):

| Room | Type | Members | Purpose |
|---|---|---|---|
| `hackhq-courtroom` | public | presiding + human judges | File cases, read draft rulings, give the RULING |
| `hackhq-chamber-repro` | private | presiding + verifier | Technical execution evidence |
| `hackhq-chamber-switch` | private | presiding + auditor | Use of Switch evidence |
| `hackhq-chamber-defense` | private | presiding + defense | Strongest evidence-backed case FOR the project |

Agents:

| Agent | Addressing | Job |
|---|---|---|
| `hackhq-presiding` | anyone (in its rooms) | Docket, brief evaluators, gather, cross-examine, draft ruling, record human RULING |
| `hackhq-verifier` | owner-agents | Runs the submission's README inside `sandbox/sandbox.sh`, cites `log#n` |
| `hackhq-auditor` | owner-agents | Reads the repo, lists Switch features used, "what breaks without Switch" |
| `hackhq-defense` | owner-agents | Steel-man: strongest cited case for the project |

Case flow: judge posts `@hackhq-presiding case <repo url> [video] [notes]` in the
courtroom → presiding gives it id `C-n` → for each chamber: `connect_to_room(chamber)`
+ `send_targeted_message(evaluator)` → back to courtroom → polls each chamber every
60 s with `read_context(room_id=…)` for a message starting `FINDINGS C-n` (20 min cap;
missing = UNRESOLVED, never zero) → evidence gate + cross-examination → draft ruling in
the `docket-format` layout in the case thread + `create_room_document("case-C-n")` →
a human replies `RULING: SHORTLIST | BORDERLINE | REJECT` → presiding records it.

Findings format every evaluator posts (via `post_message`, no @mentions):

```
FINDINGS C-n | criterion: <name> | score: X/10
MERIT 1: ... | EVIDENCE: log#n | file:path#La-Lb | url
OBJECTION 1: ... | EVIDENCE: ...
UNRESOLVED: ...
```

**Why polling instead of Switch tasks:** the agent protocol docs say the task
operations (`delegate_task` and friends) are "present but not ready for use". Do not
build on them.

## 3. Files

```
templates/hackhq-court.template.yaml   the court: 4 agents, 4 rooms, links, role, 3 docs, kickoffs
templates/hackhq-build.template.yaml   a Switch room for building HackHQ itself (dogfooding)
sandbox/Dockerfile                     node:22-bookworm + python, unprivileged user
sandbox/sandbox.sh                     build | start C-n <url> | exec C-n "<cmd>" [timeout] | stop C-n | ps
evidence/                              per-case logs (gitignored)
```

`sandbox.sh` guarantees: GitHub https URLs only, case ids `C-<digits>`, no host mounts,
no docker socket, `--cap-drop ALL`, `no-new-privileges`, 2 GB / 2 CPU / 512 pids,
1–1800 s timeout, numbered evidence log with full output per command.
`SANDBOX_NETWORK=none` cuts the network.

## 4. State

**Done and checked:**
- Court template written against Switch's template language (`docs/TEMPLATES.md`) and
  checked against the server's models (`core/switch_core/rooms_yaml.py`,
  `agent_templates.py`, `template_lint.py`): valid keys, every placeholder declared,
  links and room agents resolve.
- `sandbox.sh` dry-run with a stub `docker`: logging, numbering, exit codes and the
  input guards all work.

**Not yet verified live (do these first):**
1. The template imports in Switch Console and creates all 4 rooms in Discord.
2. The verifier builds the sandbox image (Docker Desktop must be running; first build
   takes a few minutes).
3. **Biggest risk:** the presiding agent switching rooms with `connect_to_room` to brief
   evaluators, and reading chambers with `read_context(room_id=…)`. Test with one small
   public repo before anything else.

Set up so far: Switch Console installed, Discord connected, a test agent answered.

## 5. Plan

| When (IST) | Goal | Done when |
|---|---|---|
| Fri 16:00–16:30 | Push this repo public as `monkeatwork/hackhq` | Repo visible on GitHub |
| Fri 16:30–18:00 | Import the court template, kickoffs run | Presiding introduces the court; verifier reports the image built |
| Fri 18:00–19:00 | First case end to end | A draft ruling appears in the courtroom thread |
| Sat 09:00–11:00 | Step 3b: certificate clerk (see below) | A judge's RULING produces a verifiable certificate in Discord |
| Fri 19:00–23:00 | Three test repos, tune instructions | Rulings match what we expected for each fixture |
| Sat 09:00–13:00 | Fixes + "court vs one strong prompt" comparison | Table of results for the README |
| Sat 13:00–17:00 | README (architecture diagram, reproduce steps), demo video (2–3 min) | Video uploaded, README complete |
| Sat 17:00–19:00 | Blog post (Best Blog), #HowISwitch post | Both published |
| Sat by 21:00 | Submit | Confirmation received |

**Backlog (in priority order):**
1. Three demo fixture repos with predictable rulings: a solid Switch project, a broken
   README, a project where Switch is decorative. Label them clearly as test fixtures.
2. Comparison: same 3–4 repos through the court vs one strong single prompt.
3. README: problem, who benefits, architecture diagram, Switch features used and why,
   one-template setup, sandbox safety model, Crossfire credit, limitations.
4. Demo video: one full case in Discord, from filing to human RULING.
5. Blog for a first-time Switch user (judged on clarity, accuracy, usefulness).
6. Stretch: `@scout` (creativity / prior art); presiding creates a fresh set of rooms per
   case with `create_room_from_yaml`.

### Step 3b: certificate clerk (added Fri 6 Nov)

A `hackhq-clerk` agent issues certificates in three tiers, only after a human judge's
RULING is recorded:
- **Participant**: every submission that was filed as a case.
- **Shortlisted**: second stage (RULING: SHORTLIST).
- **Winner**: named by a human judge after shortlisting.

Each certificate (PDF/PNG: name, project, tier, date, certificate id) is posted as a
Discord attachment (`send_attachment`). Its id and SHA-256 hash go in a ledger (room
document + JSON in the repo) so anyone can ask the clerk `verify <id>`. Certificates are
clearly HackHQ Court certificates, not official Flip the Switch ones. Build only after
the first case works end to end. Inspired by the idea of https://certify-weld.vercel.app/
(participant lookup + PDF download); verification is our addition.

## 6. Useful Switch facts

- Docs over MCP: `claude mcp add switch-docs --transport http https://docs.switchagents.ai/mcp`
- Source and docs: https://github.com/sandbox-quantum/switch (clone beside this repo for
  reference). Key files: `docs/TEMPLATES.md`, `docs/official/internals/agent-protocol.md`,
  `docs/official/building/payments-room.md`, `examples/room-templates/red-blue-workroom.template.yaml`.
- Agent operations include: `list_rooms`, `connect_to_room`, `post_message`,
  `send_targeted_message`, `read_context(limit, since, before, room_id)`,
  `create_room_document`, `load_internal_documents`, `assume_role`, `release_role`,
  `list_linked_rooms`, `create_room_from_yaml`.
- Addressing: `owner` (default), `owner-agents`, `anyone`. Agents start closed.
- Room commands: `!roles`, `!agents-status`, `!list-agents`, `!list-documents`, `!help`.
  A `!` at the start of a message is always a command, even inside backticks.
- An agent can edit only documents it wrote; for a person's document it suggests edits.
- One role per agent at a time, across all rooms.
- Telegram cannot create chats; Discord can. We use Discord.

## 7. Rules for whoever continues

- **No AI or Claude attribution anywhere:** no co-author trailers, no "generated with"
  lines in commits, PRs, README, docs or the blog.
- The repo is public: never commit tokens (Discord bot token, API keys) or personal data.
- Never run submission code outside `sandbox/sandbox.sh`.
- **20-minute stuck rule:** stuck for 20 minutes, stop, write down the exact error, post
  in the WeMakeDevs Discord, and move to the next item.
- Keep updates dense and short. End every work session by writing the next action at
  the bottom of this file.

## Next action

Repo is public at https://github.com/monkeatwork/hackhq (Fri 16:45 IST). Next: import
`templates/hackhq-court.template.yaml` in Switch Console (check whether template format
version 1 is still accepted) and run `./sandbox/sandbox.sh build`.
