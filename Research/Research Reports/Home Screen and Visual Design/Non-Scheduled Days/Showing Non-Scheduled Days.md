# Showing Non-Scheduled Days

> **Written by Claude (Claude Code)**, 24 September 2026. Authorship of every report is listed in the [Research Reports index](<../../README.md>).

**Status: research, not a decision.** Decisions live in Notion.

**The question.** A habit is scheduled for Monday, Thursday and Friday. How should the other four days look, on Today and in the Week, Month and Year views?

**Basis.**
- **Screened:** all 1,487,223 reviews.
- **Read in full:** 2,910 matched reviews (every high-signal match, plus a random 300 of the generic ones).
- **Relevant:** 479 say how off days should be shown or counted.
- **External check:** six competitor apps' own documentation.

Citations such as `A1#901` point to line 901 (from 0) of `App Store Reviews/1. …/reviews.jsonl`. `P` means Play Store and `N` means the native apps.

---

## What to do

1. **Week, Month and Year show all seven days.** On an off day, show a small neutral **dash**. It must not look like done (tick or fill), missed (empty ring) or nothing at all (blank).
2. **Today shows only habits due today.** Habits that aren't due go into a closed **"Not due today (n)"** row at the bottom.
3. **Only scheduled days count** toward streaks, percentages, "x of y this week" and perfect days.
4. **Logging on an off day is allowed.** It counts as a **bonus**: it adds to totals but is never required.
5. **Done, missed, skipped and off each look different.** Only done may look like done.
6. **"3 times a week" habits** show every day until the goal is met, then move to "Not due today". Only the days actually done get ticks.

---

## Key findings

**1. The biggest complaint is off days treated as failures (169 reviews, 50 apps).** They show as missed, they break the streak, or they lower the percentage.
- "why do we lose our streaks if we don’t complete a habit that weren’t supposed to be done in the week days we set?" `A1#901`
- "it looks like I’m failing when I’m not" `A24#36568`

**2. A blank off day is not neutral. It reads as a gap.**
- "the days I don't need to complete the habit are just left blank (no streak for you!). It's very demotivating." `P9#484`

**3. Users want a distinct off-day mark, and they rate it well.** 49 reviews ask for one and 17 praise apps that have one. The group's mean rating is 4.3★, the highest of the display groups.
- "you cab clearly see missed habits and which ones you just weren't scheduled for" `P3#7043`
- 102 more reviews in calendar apps ask for days off to be *marked* (red dates, 休/班), not removed.

**4. Hiding off days from the history views is rarely asked for.** Only 4 habit-app reviews ask for a grid of scheduled days only. 10 complain when an app shows fewer than seven days: "Why not show the whole week?" `A20#3539`.

Our Week view is also one shared grid of seven columns. Removing days for one habit would break its alignment with the other rows and the date strip.

**5. A badly designed off-day mark backfires (24 reviews).** The failures were:
- **It looks like done:** "it shows the non selected days as completed and mark yellow circle...it creates a confusion" `P44#124`
- **It pads the streak:** "Adds grey starts to days I didn't do the habit and then counts them in the streak" `P3#9354`
- **"Goal met" ticks the whole week:** "cause it’s not true that I’ve exercised everyday" `A1#44597`

**6. On Today, people want habits that aren't due out of the list (104 reviews). Greying them in place is disliked.**
- "they are visible on days they aren’t due (slightly greyed out) and it’s confusing, I only want to see what I need to do for the day" (Streaks) `A23#1958`
- "my screen is never clear when I accomplish all of my goals bc there’s unnecessary goals greyed out on my screen" `A31#3753`

**7. But hiding them completely costs something (82 reviews).**
- **46 want to log extra sessions:** "a habit frequency of M,W,F should still let you clock that habit on the weekends" `A53#1553`
- **36 want to see what's coming.**
- **Only 6 want off-day logging blocked.**

The closed "Not due today" row answers both sides.

**8. Streaks and percentages must ignore off days.** Weekly habits that block "perfect days" are a repeated complaint: "I shouldn’t have 4 imperfect days after I accomplish my task" `A48#2503`. Apps that get this right are praised: "I love that I can still keep my streak when I purposfully don't do certain activities on specific days of the week" `A23#4507`.

**9. A planned off day is not the same as a skip.**
- 109 reviews ask for a skip, rest day or pause.
- Reviewers also want the states kept apart: "Skipped and Missed should have different tagging or color for easy reference" `P10#7699`.

**10. "x times a week" is the largest request in the set (342 reviews).** These habits have no fixed off days, so they need the "show until goal met" behaviour above.

---

## The five states

| State | Week cell | Month | Year | Counts? |
|---|---|---|---|---|
| Done | Filled circle + mark | Filled square | Filled cell | Yes |
| Missed | Empty ring | Empty square | Empty cell | Yes, against |
| **Off** | **Small dash, no ring** | **Small dot** | **Faint dot** | **No** |
| Skipped / rest | Dash in a dashed ring | Hatched square | Hatched cell | No |
| Bonus (off-day log) | Filled circle + small **+** | Filled + **+** | Filled | Totals only |

Tell the states apart by **shape, not colour alone** (WCAG 1.4.1). The difference must hold in every theme, icon style and completion mark.

```
            F  S  S  M  T  W  T
Gym         ●  –  –  ●  –  –  ○      2 of 3 this week
```

---

## What other apps do

| App | How off days look | How they count |
|---|---|---|
| [Habitify](https://intercom.help/habitify-app/en/articles/6113616-see-the-progress-of-a-good-habit) | No mark | Left out: "all averages are calculated based only on the days the habit was active" |
| [Loop](https://github.com/iSoron/uhabits/discussions/689) | Auto hollow ticks | Praised by some, confusing to others |
| [Streaks](https://streaksapp.com/) | Dimmed on the main grid | Don't break the streak |
| [Habitica](https://github.com/HabitRPG/habitica/issues/494) | Grey in the list | Not due |
| [HabitKit](https://habitkit.app/help/habits-and-streaks/how-streaks-are-counted) | Gaps; no specific weekdays | Off days look like misses |

Every app that supports weekdays leaves off days out of the numbers. None pairs a **distinct history mark** with **hiding on Today**, which is the gap this recommendation fills.

---

## For our wireframes

The Figma Home wireframes have no weekday-only habit yet. Add a Mon/Thu/Fri **Gym** habit, then:
- **Week view:** dash on off days.
- **Month view:** dot on off days.
- **Year view:** faint dot on off days.
- **Today:** hide Gym on off days and add the "Not due today · 1" row.
- **Date strip:** each day's ring counts only the habits due that day.

---

**Limits.**
- **Keyword-based screen:** roughly 350–1,030 generic mentions were sampled rather than read, and the sample changes no finding.
- **App concentration:** Loop supplies many of the off-day mark reviews.
- **One coder:** Claude coded every review. The codebook and the per-review map are in the evidence folder.

**Evidence:** [Non-Scheduled Days Evidence](<Non-Scheduled Days Evidence/>) holds:
- the screen script, codebook and per-review classification map
- the counts (`groups.json`)
- the external sources
- `verify_report.py`
