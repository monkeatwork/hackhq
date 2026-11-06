# Building HackHQ

Rules for whoever builds this repository (people and the builder agent). Court agents
(presiding, verifier, auditor, defense) follow their own instructions, not this file.

Hackathon judging court built on Switch, for the Flip the Switch hackathon.
**Read `HANDOFF.md` first.** It holds the goal, deadline, architecture, current state
and plan. Update its "Next action" line at the end of every session.

## Rules

- Never add AI or Claude attribution anywhere: no `Co-Authored-By` trailers, no
  "Generated with" lines, in commits, PRs, README, docs or the blog.
- This repo is public. Never commit tokens, API keys or personal data.
- Never run, install or build a submission's code outside `sandbox/sandbox.sh`.
- Do not build on Switch's task operations (`delegate_task` etc.): the protocol docs
  say they are not ready for use.
- After editing a template, check it: valid YAML, every `{placeholder}` declared in
  `params:` or a builtin (`$creator`, `$agents_dir`, `$date`, `$timestamp`,
  `$creator_email`), and every room's `agents:` names an agent the template creates.
- 20-minute stuck rule: stuck for 20 minutes, stop and report the exact error.
- Keep messages short: what changed, what is verified, what is next.

## Commands

```bash
./sandbox/sandbox.sh build
./sandbox/sandbox.sh start C-1 https://github.com/<owner>/<repo>
./sandbox/sandbox.sh exec  C-1 "npm ci" 600
./sandbox/sandbox.sh stop  C-1
```

Switch docs over MCP: `claude mcp add switch-docs --transport http https://docs.switchagents.ai/mcp`
