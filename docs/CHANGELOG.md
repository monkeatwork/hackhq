# Changelog

## 2026-11-06: Repository setup

- **What changed:** Imported the handoff (HANDOFF.md, CLAUDE.md, court and build
  templates, sandbox Dockerfile and script). Added a stub README and this changelog.
  Ignored the original handoff zip.
- **Why:** Plan step 1, get the project into a public repo before building.
- **Files:** README.md, docs/CHANGELOG.md, .gitignore, HANDOFF.md, CLAUDE.md,
  templates/*, sandbox/*
- **Known issues:** Nothing verified live yet. The court template uses template
  format version 1; current Switch docs prefer version 2, so import may need changes.
  Sandbox image not built yet.
- **Next step:** Import templates/hackhq-court.template.yaml in Switch Console and
  build the sandbox image.

## 2026-11-06: Plan update, certificate clerk

- **What changed:** Added step 3b to HANDOFF.md: a clerk agent that issues
  Participant, Shortlisted and Winner certificates after a human RULING, with a
  verifiable ledger.
- **Why:** The hackathon issues certificates; giving the court's result to the
  participant closes the workflow and adds another human-gated Switch step.
- **Files:** HANDOFF.md, docs/CHANGELOG.md
- **Known issues:** Docker Desktop not running, so the sandbox image is not built.
  Builder agent lacks "can manage agents", so the court template is imported from
  Switch Console. Codex is not installed and opencode sign-in is unknown on this Mac.
- **Next step:** Import the court template (all agents on claude), build the sandbox image.

## 2026-11-06: Sandbox verified live

- **What changed:** Built `hackhq-sandbox:latest` and ran a smoke case (C-0) on
  octocat/Hello-World: clone, exec, numbered evidence log, writes to /etc refused
  (non-root), non-GitHub URL rejected. Evidence removed afterwards.
- **Why:** Step 2, the verifier depends on the image.
- **Files:** HANDOFF.md, docs/CHANGELOG.md
- **Known issues:** Court template not imported yet.
- **Next step:** Import the court template in Switch Console, confirm 4 rooms and kickoffs.

## 2026-11-06: Court created on Switch

- **What changed:** Saved the court template in Switch (private, `hackhq-court`) and ran it:
  4 agents (all claude) and 4 Discord rooms in HackHQ Building, with role, docs and links.
- **Why:** Step 2, bring the court up.
- **Files:** HANDOFF.md, docs/CHANGELOG.md
- **Known issues:** Owner not added to private chamber channels by Discord. Verifier's
  clone carries the builder's CLAUDE.md, which may confuse it. Kickoff replies not yet
  confirmed (builder is not a member of the court rooms).
- **Next step:** Confirm kickoffs, then file the first case (step 3).
