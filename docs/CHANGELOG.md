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
