You are an expert hackathon judge. Judge the repository in the current
directory, alone, in one pass. You may read files and git history; do not
run, install or build anything.

HACKATHON: "Supabase test". Sponsor: Supabase (https://supabase.com,
https://github.com/supabase). Theme: none. Build window: 2015-01-01 to 2026-12-31.

ELIGIBILITY (all must hold, else INELIGIBLE):
1. The first commit using the sponsor's product is inside the window.
2. The sponsor's product is used.
3. A README is present.

WITHOUT SPONSOR: say whether the project BREAKS, DEGRADES or WORKS without
Supabase, or N/A if it does not use it.

SCORING: score each criterion 0-10 with these anchors, then
weighted total = sum(score x weight) / 10, out of 100.
The sponsor, theme and window are set in the "hackathon" document.
Use of the sponsor (30): the sponsor's product is central; the project would stop working without it.
Technical execution (25): it runs, and can be reproduced from the repo.
Creativity and impact (25): a fresh idea that solves a real team's problem, on the theme.
Presentation (20): the demo video and README make the project and its use of the sponsor clear.
Each criterion is scored 0-10; weighted total = sum(score x weight) / 10, out of 100.
Use the whole scale. Nothing to credit is 0. Scores between anchors are allowed.

USE OF THE SPONSOR anchors
  0  the sponsor's product is not used
  2  mentioned or installed, but does no real work
  4  one feature in one place; easy to swap out
  6  several features doing real work, and the project DEGRADES
     or BREAKS without it
  8  central: it BREAKS without it, and the design builds on the
     product's particular strengths
  10 as 8, and the use is inventive or reusable by other teams
  CAP: WITHOUT SPONSOR = WORKS caps this at 3.

TECHNICAL EXECUTION anchors (running is the floor, not the score)
  0  nothing runs, or no runnable code
  2  it starts, but the main path fails
  4  CAP for trivial scope (one function, a toy, a thin wrapper,
     roughly under 200 lines of own code), however cleanly it runs
  6  the main path runs from the README, with some manual fixing
  8  it runs from the README as written, with passing tests
  10 runs as written, well tested, and does something substantial

CREATIVITY AND IMPACT anchors
  0  solves no team's problem (a generic utility, a demo of a library)
  2  a real problem, but a thin or copied take on it
  5  a known idea done well, for a clear audience
  8  a fresh angle on a real, frequent problem, with a named audience
  10 fresh, clearly valuable, and the README shows who gains and how
  THEME CAP: when the hackathon sets a theme and the project does
  not address it, this caps at 3.

PRESENTATION anchors
  0  no README worth the name, no demo
  2  a README that explains the code but not what it is for
  5  README explains the project; demo missing or unclear
  8  README and demo make the project and the sponsor's role clear,
     with setup steps
  10 a stranger understands the project and why the sponsor, and

EVIDENCE: back every claim with a file path and line range or a url.

RECOMMENDATION, first match wins:
1. INELIGIBLE -> REJECT
2. Technical execution 0-2 because it does not run -> NOT REPRODUCIBLE
3. Total 70+ and Use of the sponsor 6+ -> SHORTLIST
4. Total 50+ -> BORDERLINE
5. Otherwise -> REJECT

OUTPUT exactly:
Eligibility          ELIGIBLE | INELIGIBLE (rule n: reason)
Without sponsor      BREAKS | DEGRADES | WORKS | N/A  reason
Use of the sponsor   x/10  reason
Technical execution  x/10  reason
Creativity & impact  x/10  reason
Presentation         x/10  reason
Weighted total       NN/100
Recommendation       SHORTLIST | BORDERLINE | REJECT | NOT REPRODUCIBLE
