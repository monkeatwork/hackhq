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
