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

## 2026-11-06: Step 2 done, builder rules moved

- **What changed:** Kickoffs confirmed (presiding intro in the courtroom, each evaluator
  answered in its chamber). Builder joined the courtroom. Moved builder rules from
  CLAUDE.md to docs/BUILDING.md and updated the build template to point there.
- **Why:** The verifier works in a clone of this repo and was loading the builder's rules.
- **Files:** docs/BUILDING.md (was CLAUDE.md), templates/hackhq-build.template.yaml,
  HANDOFF.md, .gitignore, docs/CHANGELOG.md
- **Known issues:** The verifier's current session may still hold the old rules until reset.
- **Next step:** File the first case (step 3).

## 2026-11-06: Scoring tuned after case C-1

- **What changed:** Court template and live court: score anchors for all four criteria;
  technical execution capped at 4 for trivial scope; new `eligibility` document (Switch
  work dated 4-7 Nov 2026, Switch used, README present); auditor reports commit dates
  and a WITHOUT SWITCH verdict (BREAKS / DEGRADES / WORKS / N/A, WORKS caps Use of
  Switch at 3); draft ruling gains Eligibility and Without Switch lines, a REJECT
  recommendation and fixed thresholds (SHORTLIST 70+ with Use of Switch 6+,
  BORDERLINE 50+, else REJECT; ineligible always REJECT).
- **Why:** C-1 (is-odd, a 2014 one-function library with no Switch) scored 29/100 and
  was recommended BORDERLINE: no anchors, "runs" earned 8/10, no eligibility check, and
  no REJECT recommendation existed.
- **Files:** templates/hackhq-court.template.yaml, HANDOFF.md, docs/CHANGELOG.md
- **Known issues:** Template-created room documents cannot be edited by an agent; the
  old `rubric` and `docket-format` in the courtroom must be deleted by a person before
  the new ones are added. Saved Switch template `hackhq-court` not yet updated.
- **Next step:** Re-file is-odd as C-2 and check it comes out REJECT (ineligible).
