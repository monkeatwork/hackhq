# Court vs one strong prompt

Same three repositories, same hackathon settings (sponsor Supabase, no theme,
window 2015-01-01 to 2026-12-31), same rubric, eligibility and recommendation
rules. The single prompt (`single-prompt.md`) is one Claude run that may read
files but not run anything. Raw outputs are in `results/`.

| Repo | Expected | Court | Single prompt |
|---|---|---|---|
| jonschlinkert/is-odd | no sponsor use | 16, REJECT (ineligible) | 14, REJECT (ineligible) |
| 1Mbuilders/onemillion | shallow use | 42, REJECT (works without Supabase, use capped at 3) | 38, REJECT (degrades without it, use 4) |
| zernonia/madewithsupabase | deep use | 64, BORDERLINE | 69, BORDERLINE (one point from SHORTLIST) |

## What this shows

- On honest repositories a single strong prompt reaches the same recommendations.
  The court's value is not a different number on easy cases.
- The court ran the code: the verifier found madewithsupabase's `yarn install` fails on
  Node 22 and that onemillion's build succeeds; the single prompt could only read.
- The court checked eligibility from commit history; the single prompt could not run
  `git log` and inferred dates from package versions and README text.
- The single prompt's madewithsupabase result is one Creativity point from SHORTLIST,
  and says so. There is no second view and no gate; the court splits each criterion
  across isolated evaluators and the presiding judge checks a citation from each.
- Next: a prompt-injection fixture, to test whether either can be talked into a score.
