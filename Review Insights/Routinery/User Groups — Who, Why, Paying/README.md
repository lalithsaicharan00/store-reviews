# User Groups — Who, Why, Paying (Routinery)

Written by Claude (Claude Code), 26 November 2026, at the user's request. **This file is the prompt.** An agent picking
up this work reads it whole, then follows the steps. One report per year.

## What we're trying to find out

The user's words, 26 November 2026: *"When I say user group, it's for like a UX user group. Who is your target user?
… Who are using this application and the why and all of that is it's all about user research, understanding the
users."*

For each year of Routinery's store reviews:

1. **User groups, with counts.** A user group is **people who share a pain point or problem** (or a set of them):
   "my mornings go badly", "I can't start or keep going", "I have ADHD". It is **never** a country, language or store
   (the first 2019 report did that and was rejected).
2. **Why each group uses the app:** the pain in their own words, and the **free features** they like (free features
   are the same for everyone, so what matters is which ones each group values).
3. **Paying, per group:** whether they pay, what percentage, and **for what**: which feature, or, if it isn't a
   feature, why they paid.

## Rules (never break these)

- **Independent of our own app.** Often Enough, its features and its code must not influence anything: what's
  counted, how groups are named, what's recommended. Treat this as research for a new product or a full rebuild.
  Never mention Often Enough in a report.
- **Use the labels; don't reread the reviews.** Every review is already labelled and checked in
  `Review Labels/Routinery/<YEAR>/labels.jsonl` (who, why_chose, chose_for, liked, paid, problems, each with an exact
  quote). Read reviews in full only to settle a doubt about one label. The user, 26 Nov 2026: *"Already in the JSON
  structure, we have the who … So why you are chunking and rereading everything?"*
- **Read every `who` and `why_chose` yourself** (the `list` command) and put each person in groups by hand. No keyword
  grouping of people. One person can be in several groups.
- **"Not said" is never "no".** Most reviews don't say who they are or whether they paid; say so, and give every share
  with its denominator (of all reviews, of those naming a pain point, of those saying anything about paying).
- **Every number resolves to reviews.** Quote people exactly, in their language, with a translation; cite short
  review IDs; end with the appendix table; run `check` before committing.
- **Small numbers are labelled small.** Group paying rates rest on a handful of people; never rank groups on them.
- **Plain English**, the same structure every year, and a comparison with earlier years.
- **Work on `main`** and push there (the user, 26 Nov 2026: no extra branches). Commit message:
  `Routinery <YEAR>: user groups by pain point, why, paying`.

## The groups so far

Codes used in `Tools/groups_<YEAR>.py`. Keep them, so years compare; **add a new group only when the year's own words
show one** (OVERWHELM appeared in 2021; 2023–2025 needed none), and say so in that year's report.

| Code | Group | Typical words |
|---|---|---|
| `MORNING` | Mornings go badly | oversleep, groggy, scroll in bed, rush, late to work or school, dazed |
| `START` | Can't start or keep going | procrastinate, lazy, no willpower, quit after 3 days (작심삼일), task initiation, lethargy |
| `DISTRACT` | Lose time | distracted (often by the phone), space out, time blindness, can't manage time, chaotic days |
| `FORGET` | Forget steps and small habits | forget meds, vitamins, teeth, steps; "out of sight, out of mind" |
| `ND` | Have ADHD/ADD, autism, OCD, executive dysfunction, brain fog, depression, anxiety | only when they say it about themselves |
| `LOST` | Lost their structure | COVID, working or studying from home, breakup, new baby, broken leg, back to school |
| `CARER` | Parents and carers | home and family load; running routines with or for their children |
| `NOTHING` | Tried other apps, planners or paper; nothing stuck | searched for years; left Fabulous, Tiimo, Productive …; a weak "exactly what I was looking for" doesn't count |
| `METHOD` | Follow a method | Atomic Habits, Tiny Habits / BJ Fogg, Miracle Morning, GTD, Bullet Journal |
| `OVERWHELM` | Overwhelmed | long to-do lists, planning is stressful, other apps too busy or complicated |
| `GOAL` | Only a goal, no pain | "build habits", "plan my day"; reported separately, not a pain group |

Identity alone (a student, an Apple Watch user, a shift worker) isn't a pain point: count it under "Who they say they
are", not as a group, unless their words also name a pain.

## Steps for a new year

Run from the repository root. `T="Review Insights/Routinery/User Groups — Who, Why, Paying/Tools/insights.py"`

1. **`python3 -I "$T" status <YEAR>`**: the year must be fully labelled and checked. If not, stop and tell the user.
2. **`python3 -I "$T" basics <YEAR>`**: the year in numbers.
3. **`python3 -I "$T" list <YEAR>`**: every review with a `who` or `why_chose`, by line number. Read all of them and
   write `Tools/groups_<YEAR>.py` in the shape of `groups_2022.py` (`GROUPS` with the codes you use, `MAP` from line
   number to codes). Reviews with only an identity, or nothing that says a pain or goal, are left out.
4. **`python3 -I "$T" stats <YEAR>`**: per group size, share, rating, paying, liked-feature kinds; the year's liked
   features, paying by language, premium contents, objections, who-they-are counts. **The keyword counts are a
   start, not an answer:** fix the known traps listed in `insights.py` (`WHO`) by hand.
5. **`python3 -I "$T" limit <YEAR>`**: sort by hand into wants more / says two are enough / paid for more / not about
   the limit. (The free plan allows two routines; this has been the main paywall every year so far.)
6. **`python3 -I "$T" payers <YEAR>`**: sort every payer into one reason (whole app works or liked it, a named
   feature, worth the price, free first then paid, support the developer, a promotion, regret/cancel/refund, no
   reason…) and check that the reasons add up to the number of payers. List unexpected charges separately.
7. **`python3 -I "$T" quotes <YEAR>`**: pick quotes for each group.
8. **Write the report** as `Routinery <YEAR> — User Groups, Why They Use It, and What They Pay For.md`, with the same
   sections as 2022: the short answer (with the group table and last year's shares), 1 the year in numbers, 2 the
   groups (who they are, why with quotes, free features they like, paying), 3 paying (how many, by group, by
   language, why payers paid with IDs, what premium holds, why others won't pay), 4 free features liked, 5 who they
   say they are, 6 what changed (a table across every year so far), 7 limits, appendix.
9. **`python3 -I "$T" appendix <YEAR> >> "<report>"`**, then **`python3 -I "$T" check <YEAR>`** (must say nothing
   missing or ambiguous).
10. **Update `../README.md`** (the Routinery page: the year's row and the trend table), then commit and push to
    `main`.

## Known traps

- The labels' split between `who` and `why_chose` drifts by year (2020: 153 / 210; 2022: 388 / 63). Always read both.
- Keyword lists for "who": `son` matches "person", `cat` matches "medication", `stud` matches "Bible study", `class`
  matches "classic ADHD", `parent` matches minors whose parents pay, `work` matches "working on finding themselves".
- The routine-limit pattern catches bug reports ("routines disappeared after subscribing") and praise ("two free
  routines are enough"): sort them by hand.
- From 2023 the feature kinds also match "voice", "nudge", "history" and "weekday and weekend", so a few counts for
  2020–2022 differ slightly from what `stats` prints now.
- The App Store app ID `1450486923` isn't a review ID (`check` ignores it).
- Korean reviewers have paid at 3–4× the English rate every year: report paying by language.
- More `who` traps found in 2023: `executive` matches "an executive with a busy day", `stud` matches a teacher who
  "has students", `subscri` matches "a loyal long-time subscriber", `mental` matches "mentally queueing tasks",
  "several devices" matches "tried many apps", and `child`/`son` match parents of children.
- From 2023 many payers mention paying only to report a bug or a subscription the app stopped recognising. Sort them as
  their own reason ("no reason; writes about a bug"), and report payers' average rating beside the count.
- The 2023 labels put many goal-only reasons in `why_chose` (76 goal-only people against 8 in 2022): compare pain
  groups across years, not goal-only counts.
- More `who` traps found in 2024: `class` matches "Galaxy Watch 4 Classic", `school` matches a parent's "preschool",
  `work` matches "working hard to be top of the class", `ADHD` matches "not ADHD", `child` matches "a child with
  anxiety" (a minor, not a parent).
- From 2024 many Korean "payers" write only to ask for a refund (9 of 21). Report them beside the unexpected charges:
  the line between `paid` and `charged_unexpectedly` is the reviewer's own wording.
- More `who` traps found in 2025: `ADHD` misses "AuDHD" and Spanish "TDA" (add them by hand), and matches a therapist
  who "recommends it to patients with ADHD" and a parent of an ADHD son; `mental health` matches "has no mental health
  disorders"; `parent` matches a 12-year-old whose "parents don't let them" take the phone; `years old` matches "32 years
  old".
- From 2025 many `why_chose` reasons are outcomes ("now I'm never late"): count them under the pain they imply, and say
  so in Limits.

## Files

| File | What it is |
|---|---|
| `Routinery <YEAR> — User Groups, Why They Use It, and What They Pay For.md` | One report per year |
| `Tools/insights.py` | Every step above; `python3 -I insights.py` alone prints its help |
| `Tools/groups_<YEAR>.py` | The hand-made map of people to groups for that year |
