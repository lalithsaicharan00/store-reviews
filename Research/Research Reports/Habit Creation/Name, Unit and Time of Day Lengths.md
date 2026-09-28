Written by Claude (Claude Code), 28 September 2026.

# Name, Unit and Time of Day Lengths

**The user's request (28 Sep):** set limits on habit names, units and time-of-day names instead of allowing very long text. They should be generous, but these are meant to be short. The user suggested about 8–12 characters for units and 16–20 for habit names.

**Before:** names 100, checklist items 60, times of day 30, units 24. Today already shows only 15 characters of a name, then "…", and a folded section header shows 8 letters, so anything longer was mostly hidden anyway.

## What users show

Scan: `Research/Temp/text-limits/scan.py` across all 1,238,784 reviews.

**1. The habit names people write are short.** 156 unique names were quoted in reviews ("a habit called '…'", "my '…' habit"). The long ones were checked by hand.

| Length | Share of names |
|---|---|
| ≤ 12 | 56% |
| ≤ 16 | 75% |
| ≤ 20 | 87% |
| ≤ 24 | 94% |
| ≤ 30 | 98% |

Median 11 characters. Most names over 24 carry their goal or schedule ("drink 10 glasses of water", "read at least 5 pages at least 3 days a week"), and here that goes in Goal and Repeat, not the name. Examples are in `names.json`.

**2. A limit that's too tight draws complaints.** Of 29 "character limit / cut off" hits (read in full), most are about support forms and notes. Five are about names:

| Review | App | What they say |
|---|---|---|
| `3029138384` | Do Habits, 4★ | "my gripe is the **20 character limit** on task titles" |
| `13670415847` | (Not Boring) Habits, 3★ | "there's a **tight character limit** on each habit. I found it hard to squeeze some of my habits in" |
| `d2d93e85-834f-48c5-843f-32ff83226e31` | My Study Life, 4★ | "extend the character limit for task title" |
| `9fce654b-ae06-4b7c-8892-520130c30fbd` | Habit Tracker, 4★ | asks for higher limits on the goal name field |
| `44dc7a4e-da9c-41e3-8a08-454651bfe0e6` | Me+, 2★ | "a character limit for everything which can be annoying" |

So 20 is known to pinch. The generous version of "short" is just above it.

**3. Units are single short words.** From the round-2 unit count (`Research/Temp/goals/round2/units_counts.json`, about 860 mentions): glasses 7, steps 5, pages 5, push-ups 8, servings 8, chapters 8, cigarettes 10, tablespoons 11.

**4. Times of day are one or two words.** In reviews: morning 1,732, evening 225, night 222, bedtime 65, afternoon 51, after school, wake up. Custom ones people write: "Before work" 11, "After school" 12, "Lunch break" 11.

## Decision

| Text | Before | **Limit** | Why |
|---|---|---|---|
| Habit and task names | 100 | **24** | 94% of quoted names fit, even with goals written in. 20 is the limit reviewers complained about. Today still shows 15 characters, then "…" |
| Checklist items | 60 | **24** | The same kind of short label ("Double cleanse, oil then gel" → 24) |
| Times of day | 30 | **16** | Fits "After school" and "Before breakfast". Headers show 8 letters folded and the full name open |
| Units | 24 | **12** | Every common unit fits; the longest, "tablespoons", is 11 |

**How it behaves:**
- Typing stops at the limit, and a paste keeps its first characters.
- **In the last 5 characters,** the field says "3 characters left". At the limit it says "That's the most: 24 characters." So the limit is never a surprise. *Reasoned from first principles: tell people before they hit a wall.*
- **Text already saved is kept as it is.** Limits apply to typing only, so nobody's existing habit is cut.
- The Unit screen's hint is now "Anything you count, in a word or two: prayers, laps, sets." The old example, "glasses of juice", is 16 characters and no longer fits.

**Built** in `TextLimit` (`iOS/Habits/Model/Habit.swift`), with notes under the name field, the Time of Day editor and "Create Your Own Unit". The `-longtext` demo now uses names at the new limits. **Checked:** `LongTextUITests` (3 tests) pass on the iPhone 16.
