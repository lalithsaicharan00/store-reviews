# Today top area, round 2: questions (2026-09-24)

Screens studied:
- The new Day board from round 1: Figma section 38:2, board A 38:4.
- The old Week, Month and Year boards: 19:4, 19:442 and 19:1172.

The user's rule for this round:
- Things people use often go up front.
- Things people use rarely are tucked away, but are easy to find when looked for, in as few taps as possible.
- Nothing in the header is redundant.
- Everything reads in the user's own words (their mental model and the apps they already use) and scans fast.

## Q1. How often do people switch Day / Week / Month / Year?
- Do people switch views often, or pick one and stay there?
- If switching is rare, a full-width segmented control spends a whole row on a rare action.
- Would a title dropdown be better ("Today ▾" → This week / This month / This year)? Verify before recommending it.

## Q2. The period title: consistent, short, no repetition
- The current titles:
  - Day: "Today · Thursday 24 September"
  - Week: "This week 18–24 Sep"
  - Month: "September 2026"
  - Year: "This year Oct–Sep"
- They are inconsistent and long. How should each view's title read?
- The title must not repeat what the strip or grid already shows. For example, "Thursday 24" appears in the title, in the strip and in "5 of 11".

## Q3. The calendar strip: is it worth a row?
- What do people value in it: today's ring and progress, going to another day, or seeing the week at a glance?
- In which views is it needed? In Week view it repeats the grid's 7 day columns (F S S M T W T, 18–24).
- If it stays in every view, it should sit above the view control.
- How should it be used to move between days?

## Q4. Groups and the filter: how often, and what for?
- Do people use groups often? The earlier reports suggest groups are mainly for filtering.
- What does the filter need to hold: groups, "due now", "hide completed"?
- Is "All" the right label?
- How should combined states show without long, odd text (for example Health + Due now + Hide completed)?

## Q5. The options sheet: what it holds and how it's worded
- Should it be a bottom sheet rather than a small popup?
- How should it be worded in users' own words?
- Where do editing day sections and editing groups go? "Edit sections and groups…" is unclear.
- The overall job, per the user: show options, group filter, and a shortcut to change the day's sections.

## Q6. The whole header: layout and scanning
- On a past day, "Back to today", "All" and the date are crammed into one line.
- What is the minimum header that keeps what's used often up front and everything else a tap away, with no repetition in any view?
- This question pulls Q1 to Q5 together.

## Process
- Research each question in turn, one report per question, and merge questions only when they genuinely overlap.
- Sources: the whole review corpus, the earlier research reports (Day Structure, Organization, Home Screen, round 1), external UX sources (Apple HIG, NN/g, Material) and competitors' own help pages.
- Then update the Figma designs: a new section, top area only.
