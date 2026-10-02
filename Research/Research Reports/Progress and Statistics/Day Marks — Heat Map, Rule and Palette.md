# Day Marks — Heat Map, Rule and Palette

Written by Claude (Claude Code), 2 October 2026, at the user's request. The user asked:
- which way of marking days people really like, decided only by the data and counted in every language;
- how people expect a heat map to work;
- one rule that works for every habit type;
- a palette whose shades are clearly visible.

The app now builds Progress's Week, Month and Year views from this report (branch `claude/progress-week-cards`).

Evidence: [`Day Marks Evidence/`](<Day Marks Evidence/>). Scripts are in `scripts/` and run from `Research/`. They write to `Temp/`.

## 1. Which day marks people like (every language)

### Corpus and method

The corpus is 1,237,000 store reviews in 40+ languages.
- English is about half.
- The other large languages are Spanish (182k), Portuguese (127k), Chinese (69k), Russian (59k), French, German, Arabic, Turkish, Italian, Indonesian, Polish, Korean and Japanese.

I wrote one set of terms per style in every major language, including local names:
- Korean 잔디 and Japanese 草を生やす for the GitHub grid;
- Chinese 打勾/打叉 and Japanese ○× for checks and crosses;
- Spanish palomita/tachar, German Häkchen/Kreuz and Russian галочка/крестик.

The script is `scan_all_lang.py`.

How a mention was counted:
- A mention is a sentence that contains a style term.
- Its sentiment is its review's stars: a 4–5★ review counts as positive.
- I then read a random sample of each style's positive mentions, in all languages, to find the share that truly praise that style.
- Ambiguous words were removed after reading. Examples: French "tique" matched inside "pratique", Korean 점이 means "a point", and Portuguese "corrente" also means "current".

### Results

| Style | Matches in 4–5★ reviews | Genuine share (hand-checked) | **Estimated genuine praise** | Avg ★ | Apps | Languages / countries |
|---|---|---|---|---|---|---|
| **Heat map / coloured squares** | 315 | 66% (n=80) | **≈ 210** | **4.55** | 61 | 34 |
| Check / ✗ calendar | 424 | 24% (n=50) | ≈ 100 | 4.25 | 54 | 31 |
| Chain drawn on a calendar | 508 | 18% (n=40)\* | ≈ 90 | 4.49 | 60 | 35 |
| Rings / circles filling | 200 | 37% (n=35) | ≈ 75, of which ≈ 30 are about history; the rest are about tapping today's ring | 4.12 | 45 | 23 |
| Dots | 65 | 27% (n=30) | ≈ 18 | 4.31 | 34 | 12 |
| Stamps / stickers | 83 | 20% (n=30) | ≈ 17 | 4.34 | 36 | 13 |

\* About 70% of chain mentions praise the "don't break the chain" idea, not a chain drawn on a calendar.

**Share of each app's own reviewers who praise its day marks.** These figures come from our hand-coded per-app reports, which read every review in every language.

| Style | App | Share of its reviews |
|---|---|---|
| Heat map | Evoday | 14.1% |
| Heat map | everyday | 10.5% |
| Heat map | HabitKit | 10.1% |
| Dots | DotHabit | 11.4% |
| Check calendar | Check Calendar | 9.9% |
| Stamps | DayStamp | 2.4% |
| Chain | Productive | 0.2% |

**The heat map leads every measure.** It has about twice the genuine praise of the next style, the highest rating, and the widest spread of apps and languages.

The check/✗ calendar comes second. Examples:
- Goal & Habit Tracker Calendar: "Big ticks and crosses great" (`c3f22699-9ccd-4115-af42-6d88978adeea`).
- The same app: "the simplicity with its giant checkmark ✅ or ❌ really speaks to me" (`fb0c7805-0e10-4e3b-b72a-ba0fc342d928`).

The chain is liked as an idea: "love the chains in the calendar" (Productive, `4228698193`).

**Limits.**
- Each estimate has an error of about ±10–15 percentage points, from the size of the hand-checked samples.
- Some phrasings in rare languages are still missed.
- Neither limit changes the order.

## 2. How people expect a heat map to work

I collected 2,267 reviews in every language that talk about a heat map. They come from two sources:
- reviews that name a heat map, in any app;
- reviews of heat-map apps (HabitKit, everyday, Evoday, Habit Pixel, HabitGrid and others) that talk about the grid.

The scripts are `collect.py` and `tag.py`. I read the reviews tagged for each question; the scripts let anyone list them again (`show.py <code>`).

| Expectation | What people say | Reviews |
|---|---|---|
| **The whole year at once** | "lets you see your entire year in one view" (`12210864361`); people ask for "a heat map for the past 365 days" | ~45 praise, ~6 ask |
| **Choose each habit's colour** | "more color options" (`13381064355`); people ask for a colour wheel or hex codes | ~52 ask (the largest ask) |
| **On the home-screen widget** | Praised again and again | 235 mention it |
| **All habits together** | "an overview of all your habits for the last year" (`11762071060`); "the heatmap of all habits in a glance" (`138249f1-e276-475c-af71-a86b963395e6`) | ~25 praise, ~8 ask |
| **Weekly goals shown properly** | "the days I don't need to complete the habit are just left blank (no streak for you!). It's very demotivating" (`fb5fa01c-c17d-4563-85d5-63ce2262f393`); "highlight only the scheduled days" (`14316211160`) | ~15 ask |
| **Skips as their own neutral mark** | everyday's skip: "feels like neutral data instead of a personal failing" (`10483508663`) | ~13 praise, ~4 ask |
| **Dates and labels** | "a heat map with squares and without specific dates. I NEED to see the dates" (`12744827601`); "no weeks or dates" (`d8f69999-ee53-45e3-a1b5-5820b569469d`); praised: "heatmap cells… display dates" (`6e4c778f-6970-437b-b671-a3db671fc475`) | ~7 complain, ~3 praise |
| **Tap a day to see or change it** | "tap on grids and see the dates" (`9976175371`) | ~8 praise, ~4 ask |
| **History kept** | "Can't scroll back more than 15 days" (`6823775426`) | ~3 complain |
| **Shade by how much was done that day** | "Different shades based on the frequency instead of just true/false" (Rise, `c92ea41d-a00a-4a57-a8d2-2a0331d53eab`) | ~7 ask, ~4 praise |
| **Missed different from not logged** | "a distinction between 'failed' days and days with no data" (`10089231057`) | ~4 ask |
| **Shades must be clearly different** | "colour depth… the contrast really isn't obvious" (`7618806923`) | a few |

**The "darker = longer run" variant.** In everyday, the colour deepens with each day in a row. It is praised in 228 reviews (10.5%), for example "I love the way the colors get darker" (`12153518690`). It also draws complaints:
- one miss resets the colour all the way: "drop one step in intensity, rather than resetting" (`12126118988`);
- long runs become "just a dark board" (`11113145328`);
- everyday cannot express "3 times a week", and its reviews keep asking for it.

**Decision (the user, 2 Oct 2026): darker means more done that day**, GitHub-style. It is the only meaning that works for every habit type. The run of days is shown as a number instead.

## 3. One rule for every habit type (reasoned, built on §1–2)

A square is one day. **Colour strength = how much of what that day asked for was done.**

The day's square uses one of these looks:
- **grey:** asked and not done;
- **five steps:** up to ⅓, up to ⅔, more, goal met (the habit's own colour), more than the goal;
- **dashed:** nothing was asked that day;
- **ring:** today;
- **nothing:** before the habit's start, and days still to come.

| Habit type | A day's square |
|---|---|
| Once, several times a day, amount, time, checklist | Share of the day's goal |
| Certain weekdays, every N days | Due days judged; other days dashed |
| Times a week/month | A done day is full; other days are dashed, never grey |
| Total a week/month | Share of a fair day's part (70 km a week → 10 km fills a day)\* |
| Daily limit | Within the limit = full; over = grey |
| Week/month limit | Full while the running total is within; grey from the day it goes over\* |
| Quit | Clean = full; slip = grey |
| Skipped, paused | Dashed (Week and Month show the sign) |

\* Reasoned from first principles. The reviews ask that weekly goals be shown properly, but not for this exact rule.

## 4. The palette

Each habit colour has grey plus five steps, in light and dark mode. The script is `make.py`; its output is `heat_palette.json` and the two palette images.

How the steps are set:
- **One lightness per step for every hue.** In light mode the steps are 0.855, 0.78, 0.71, 0.64 and 0.52; the goal-met step is the habit's own colour. In dark mode they are 0.415, 0.49, 0.565, 0.64 and 0.76. So no colour looks stronger than another.
- **Chroma** is kept as high as the screen allows.

Measured results:
- Neighbouring steps differ by **at least 0.07 in OKLab**, about 3.5 times the smallest difference people can see.
- Under simulated protanopia, deuteranopia and tritanopia (Machado 2009), they still differ by **at least 0.043**.
- A number on a square, in black or white (whichever is clearer), reaches **at least 4.3:1** contrast.
- "Gray" habits get a cool slate tint, so their steps never read as the not-done grey.
