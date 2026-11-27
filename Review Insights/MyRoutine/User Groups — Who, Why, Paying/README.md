# User Groups — Who, Why, Paying (MyRoutine)

Written by Claude (Claude Code), 27 November 2026, at the user's request. **This file is the prompt.** An agent picking
up this work reads it whole, then follows the steps. One report per year. It is the same study as
[Routinery's](<../../Routinery/User Groups — Who, Why, Paying/README.md>), set up for MyRoutine.

## What we're trying to find out

The user's words, 26 November 2026 (for Routinery, and the same for MyRoutine on 27 November): *"When I say user
group, it's for like a UX user group. Who is your target user? … Who are using this application and the why and all
of that is it's all about user research, understanding the users."*

For each year of MyRoutine's store reviews:

1. **User groups, with counts.** A user group is **people who share a pain point or problem** (or a set of them):
   "I can't keep a habit past three days", "I've tried every app and planner". It is **never** a country, language or
   store.
2. **Why each group uses the app:** the pain in their own words, and the **free features** they like.
3. **Paying, per group:** whether they pay, what percentage, and **for what**: which feature, or, if it isn't a
   feature, why they paid.

## Rules (never break these)

- **Independent of our own app.** Often Enough, its features and its code must not influence anything: what's
  counted, how groups are named, what's recommended. Treat this as research for a new product or a full rebuild.
  Never mention Often Enough in a report.
- **Use the labels; don't reread the reviews.** Every review is already labelled and checked in
  `Review Labels/MyRoutine/<YEAR>/labels.jsonl` (who, why_chose, chose_for, liked, paid, problems, each with an exact
  quote). Read a review in full (`reviews.jsonl`) only to settle a doubt about one label.
- **Read every `who` and `why_chose` yourself** (the `list` command) and put each person in groups by hand. No keyword
  grouping of people. One person can be in several groups.
- **"Not said" is never "no".** Most reviews don't say who they are or whether they paid; say so, and give every share
  with its denominator (of all reviews, of those naming a pain point, of those saying anything about paying).
- **Every number resolves to reviews.** Quote people exactly, in their language, with a translation; cite short
  review IDs; end with the appendix table; run `check` before committing.
- **Small numbers are labelled small.** Group paying rates rest on a handful of people; never rank groups on them.
- **Plain English**, the same structure every year, and a comparison with earlier years.
- **Work on `main`** and push there (the user, 26 Nov 2026: no extra branches). Commit message:
  `MyRoutine <YEAR>: user groups by pain point, why, paying`.

## The app, in short (from the labels, not the store page)

Minding. co., Ltd.'s routine app from Korea (App Store `1518956326`, Google Play `com.minding.myroutine`); see
[`Review Labels/MyRoutine/App.md`](<../../../Review Labels/MyRoutine/App.md>). In 2020 it was a **daily check-off
list of routines** with a **social side** (see other people's routines, copy them with a long press, follow
"routiners", a Best Routine page), a **reflection** (daily diary) section, a **green light** for a day done, reminders,
and versions for the **web, PC and phone**. The phone apps came out in July 2020 for people already on the web
version. It is **not a timer app** like Routinery, so the feature kinds in `insights.py` are MyRoutine's own.

## The groups so far

Codes used in `Tools/groups_<YEAR>.py`. They are **Routinery's codes**, so the two apps compare; use the same code
for the same pain, and **add a new group only when the year's own words show one**, and say so in that year's report.

| Code | Group | Typical words |
|---|---|---|
| `START` | Can't start or keep going | plan but don't act (생각만 하고), no willpower (의지박약), quit after 3 days (작심삼일), tedious to start |
| `NOTHING` | Tried other apps, planners or paper; nothing stuck | other routine or habit apps given up within days; a paper or analog diary too much work; "nothing suitable" |
| `OVERWHELM` | Overwhelmed | other apps too much to learn; a first blank list feels daunting (막막해서) |
| `FORGET` | Forget small habits | medicine, tasks at set times |
| `DISTRACT` | Lose time | hectic, frantic days (정신없이), distracted, can't manage time |
| `MORNING` | Mornings go badly | oversleep, rush, late (none in 2020) |
| `ND` | Have ADHD/ADD, autism, OCD, executive dysfunction, depression, anxiety | only when they say it about themselves (none in 2020) |
| `LOST` | Lost their structure | COVID, working or studying from home, a life change (none in 2020) |
| `CARER` | Parents and carers | home and family load (none in 2020) |
| `METHOD` | Follow a method | Miracle Morning, Atomic Habits, a 5 AM wake-up challenge only when it's named as a method (none in 2020) |
| `GOAL` | Only a goal, no pain | "build good habits", "the days I want to live"; reported separately, not a pain group |

Identity alone (a student, an iPhone or Galaxy user, a web-version user) isn't a pain point: count it under "Who they
say they are", not as a group, unless their words also name a pain. **How they found the app** (an editors' pick, an
Instagram ad, a friend) is not a pain either: list it under "How they found it".

## Steps for a new year

Run from the repository root. `T="Review Insights/MyRoutine/User Groups — Who, Why, Paying/Tools/insights.py"`

1. **`python3 -I "$T" status <YEAR>`**: the year must be fully labelled and checked. If not, stop and tell the user.
2. **`python3 -I "$T" basics <YEAR>`**: the year in numbers.
3. **`python3 -I "$T" list <YEAR>`**: every review with a `who` or `why_chose`, by line number. Read all of them and
   write `Tools/groups_<YEAR>.py` in the shape of `groups_2020.py` (`GROUPS` with the codes you use, `MAP` from line
   number to codes, and a comment listing the lines left out). Reviews with only an identity, a device or how they
   found the app are left out.
4. **`python3 -I "$T" stats <YEAR>`**: per group size, share, rating, paying, liked-feature kinds; the year's liked
   features, paying by language, premium contents, objections, who-they-are counts. **The keyword counts are a
   start, not an answer:** list each kind's matches and fix the traps by hand (see `insights.py`'s FEATURES and WHO
   notes). Add a feature kind when a year's words show a new one.
5. **`python3 -I "$T" limit <YEAR>`**: anything about a free-plan limit, sorted by hand. **2020 had no paywall in the
   reviews** (one asks whether routines stop at nine); watch for one appearing.
6. **`python3 -I "$T" payers <YEAR>`**: sort every payer into one reason (whole app works or liked it, a named
   feature, worth the price, paying as a commitment, free trial first, support the developer, regret/cancel/refund,
   no reason…) and check that the reasons add up to the number of payers. List unexpected charges separately, and
   the "would pay if…" lines in `note`.
7. **`python3 -I "$T" problems <YEAR>`**: what's broken and what's wished for, sorted by hand into themes. Bugs were
   41% of 2020's reviews, so report them beside paying.
8. **`python3 -I "$T" quotes <YEAR>`**: pick quotes for each group.
9. **Write the report** as `MyRoutine <YEAR> — User Groups, Why They Use It, and What They Pay For.md`, with the same
   sections as 2020: the short answer (with the group table), 1 the year in numbers, 2 the groups (who they are, why
   with quotes, free features they like, paying), 3 paying (how many, by group, by language, why payers paid with IDs,
   what premium holds, why others won't pay), 4 free features liked, 5 who they say they are and how they found it,
   6 what's broken and what's wished for, 7 what changed (a table across every year so far), 8 limits, appendix.
10. **`python3 -I "$T" appendix <YEAR> >> "<report>"`**, then **`python3 -I "$T" check <YEAR>`** (must say nothing
    missing or ambiguous).
11. **Update `../README.md`** (the MyRoutine page: the year's row and the trend table) and the apps table in
    `Review Insights/README.md`, then commit and push to `main`.

## Known traps

- **Nearly every review is Korean** (all 131 in 2020). Quote the Korean exactly and translate; paying by language
  starts to mean something only once other languages appear (Japanese, English and Chinese grow from 2021, per
  `App.md`).
- **Reviews come in clusters.** In 2020, 8 App Store reviews, all 5★, came on 6 July (the iPhone app's first day), and
  9 of the 18 people naming a pain point wrote on 13 or 26 October, all 5★. The cause isn't in the reviews; say how
  much of a group comes from such days, and don't read a group's 5★ average as typical of every user.
- **Bug waves** (14 December 2020: 10 reviews, mostly the app not opening after an update) swamp a month. Report a
  wave by its date so later years can tell a bad update from a bad app.
- Feature keyword traps found in 2020: `look` matched "looking for", `design` matched "layout designed", `fun`
  matched the social "fun to peek at others", `easy` matched "easy to copy others' routines", `check` matched
  "check each day's state" (a reflection). Each pattern was narrowed; list every kind's matches again each year.
- `who` in 2020 is mostly a device (iPhone, Galaxy, iPad, PC or web): count them, but they aren't people's problems.
- `why_chose` often holds **how they found it** (editors' pick, a friend, an Instagram ad, store search): count those
  separately and leave the person out of the groups unless a pain or goal is said too.
- Conditional paying ("I'd buy it if it had colours", "I'll pay once it's stable") sits in `note` with `paid`
  `not_said`. Report it as its own line, never as paid or refused.
- The App Store app ID `1518956326` isn't a review ID (`check` ignores it).

## Files

| File | What it is |
|---|---|
| `MyRoutine <YEAR> — User Groups, Why They Use It, and What They Pay For.md` | One report per year |
| `Tools/insights.py` | Every step above; `python3 -I insights.py` alone prints its help. A copy of Routinery's with MyRoutine's app name, app ID, feature kinds and a `problems` command |
| `Tools/groups_<YEAR>.py` | The hand-made map of people to groups for that year |
