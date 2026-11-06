# HackHQ Court

A hackathon judging court that runs inside Discord on [Switch](https://github.com/sandbox-quantum/switch).
Built for the **Flip the Switch** hackathon (WeMakeDevs + DevTools Academy), Track 01: Best Business Workflow.

Human judges file a submission as a case. Independent agent evaluators examine it in
private rooms: a verifier runs the README in a locked-down sandbox, an auditor checks
how the project uses Switch, and a defense agent makes the strongest evidence-backed
case for it. A presiding agent applies an evidence gate and drafts a ruling.
**Only a human judge's ruling is final.**

> Work in progress. Full README (architecture, setup, sandbox safety model, results)
> is coming before submission.

## Layout

```
templates/hackhq-court.template.yaml   the court: 4 agents, 4 rooms, links, role, docs
templates/hackhq-build.template.yaml   a Switch room for building HackHQ itself
sandbox/                               Docker sandbox for running submissions
HANDOFF.md                             project plan and current state
```

## Credit

The adversarial-evaluation pattern (isolated evaluators, evidence gate, steel-man) is
inspired by [Crossfire](https://github.com/hriday-singh/crossfire), winner of
Code2Create 7.0 at VIT. HackHQ uses the pattern only, no code, names or verdict labels.
