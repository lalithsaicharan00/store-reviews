Written by Claude (Claude Code), 4 October 2026.

# Time Limits — Should Cut Down Allow Time?

**The user's question (4 Oct):** an old habit on the iPhone, "Social media: 30 minutes max", still works, but the Limit's
units have no minutes now and the habit can't be changed. Should Cut down allow time? It's a genuine use case, but a
timed *build* habit could do the same, except this isn't building, it's cutting down. "We shouldn't add something
just because of one use case: check whether it's genuine, and if it is, add it."

**Answer, in short:**
- **Yes, it's genuine.** People ask, in their own words, for "at most 2 hours of Netflix", "not more than X hours of TV a
  week", a "screen time habit limit for 1 hour for Instagram". They describe it as a bad habit to reduce, not a goal to
  build. A timed build habit would count going over as success, the opposite of what they want.
- **So a Limit can be in minutes**: the Limit's units now include **minutes** (Cut down → Limit → Unit → Time), and an
  existing timed limit is editable. It times with ▶ (or is typed), and Today says "30 min max".
- **Once made, a limit stays on its side**: a limit in minutes keeps minutes and a counted limit keeps counting, so past
  days never change meaning (Rulebook D6).
- **The stronger wish is automatic**: about as many reviews want screen time read from the iPhone's Screen Time instead
  of typed. That needs Apple's Screen Time API and its permission; it's recorded for later, not built now.

The app already supported timed limits underneath (Today, the timer, the goal alert's "That's your 1 h limit"); only the
Limit's unit list left time out ("Time isn't a unit here"). That's why the old habit worked but couldn't be shown or
changed. The habit itself came from a debug build's "one habit of every kind" demo on the phone.

## How this was researched

- `Research/Temp/limit2/scan.py` read all 1,200,544 reviews outside the gym app. **226** mention screens, phones, social
  media, TV or games next to a limit word and a time word; all were read. **47** of them track or cap that time
  explicitly; the rest only say an app helped them use their phone less.

## What users show

| Theme | Reviews | What they say |
|---|---|---|
| **A time cap as a habit to cut down** | **≈7** | "set a goal not to watch more than X hours of TV a week" (`9101571667`); "'at most' (watch at most 2 hours of Netflix)… If you go over, it doesn't count" (`e611cbad…`); "limit the time of watching tv" (`10096953628`); "I have a screen time habit limit for 1 hour for Instagram" (`13759922947`); "how many hours did I watch TV this week?… bad habits to be reduced" (`1325376912`); "limiting screen time… a positive result when under the target" (`c262007a…`); phone time with a max (`8a572798…`) |
| **Read it from the iPhone's Screen Time** | ≈7 | "time spent on social media — why the heck I should put this manually when the data are available on iphone?" (`12581664688`); "integrating it with iOS's Screen Time" (`13297744521`); "link… a bad habit that automatically fetches social media screen time" (`13739990490`) |
| Social media kept off with a days-since counter instead | ≈5 | "I use the app to quit social media" (`13434276029`); start/stop a timer for YouTube (`13199473906`) |
| "It helped me use my phone less" (no time tracking) | many | Outcomes, not a feature ask |

Seven explicit asks is a small number, but it isn't one use case: TV, Netflix, Instagram, phone time and screen time
are five, from five different apps, and Habitify already offers it. The ask is consistent: a ceiling, measured in time,
where staying under counts.

## Decision (built 4 Oct 2026, branch `claude/timer-swipe-limits-and-fixes`)

| Where | What | Basis |
|---|---|---|
| **Cut down → Limit → Unit** | A **Time** group with **minutes**: "No more than 30 minutes" → "Social media: at most 30 min a day" | Users show it (≈7) |
| **Today** | A time limit has ▶ (the timer, which says "That's your 30 min limit" when reached) and the Day sheet's Add Entry for typing minutes | Already built for timed habits |
| **Editing** | The limit and its period change freely; the unit stays minutes (or stays counted for a counted limit) | D6: past entries keep their meaning |
| **Screen Time** | Not built: needs Apple's Screen Time API and its permission. Recorded in the Product Roadmap | Users show it (≈7); a separate decision |

**Checked:** `NewHabitUITests.testLimitCanBeTimeAndStaysEditable` makes "Social media" with a 30-minute limit, checks ▶ on
Today, then edits it to 45 minutes and checks the unit stayed minutes.
