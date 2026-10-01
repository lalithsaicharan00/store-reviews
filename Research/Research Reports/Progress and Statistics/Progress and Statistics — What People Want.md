# Progress and Statistics — What People Want

Written by Claude (Claude Code), 29 September 2026. Build Plan #60. The user asked for a lot of research here: which statistics people need, how they want them shown, and where. The Feature Ledger frames it: [C011](<../Feature Ledger.md#c011>) weekly / monthly / yearly reports (34 apps), [C012](<../Feature Ledger.md#c012>) week / month / year grids (36 apps), [C234](<../Feature Ledger.md#c234>) statistics stay free, [C216](<../Feature Ledger.md#c216>) a forgiving long-run measure beside streaks, [C256](<../Feature Ledger.md#c256>) skip / miss / not-yet are distinct in the stats, [C217](<../Feature Ledger.md#c217>) an unexplained number reads as broken, [C047](<../Feature Ledger.md#c047>) totals, and [C038](<../Feature Ledger.md#c038>) numbers correct on every surface.

## Answer

**Where:** one tap from Today, on the top bar (the chart button already there), and a habit's own numbers on its page. Statistics tucked into a profile or a menu go unfound.

**What, in the order people ask for it:**

1. **The overall share of what was planned that got done, across all habits.** The most-requested statistic by a distance: 330 reviews in 52 apps, one calling it "the only thing which makes me return to my previous app". Show the percentage **with its raw numbers** ("23 of 28 planned") and **the period before** ("last week 76%").
2. **Each day's share as a bar** ("On Monday 9 of 10"), with the exact numbers when a bar is touched.
3. **Every habit side by side**, each with its own percentage and a bar, so it's clear at a glance which are going well and which need attention. Tapping one opens its page.
4. **Counted on each habit's own rhythm.** A "3 times a week" goal done three times is 100%, not 43%. A weekly goal isn't a day's work, so it stays out of the daily bars. Skipped and paused days don't count; today counts once it's done.
5. **Week, Month and Year, stepped back with ‹ ›**, including all of the past, not only the last 30 days.
6. **A year grid of every day** (GitHub's contribution chart), overall in Year and per habit on its page. The long view people love most.
7. **Totals and averages in the habit's own unit**: "42 km", "52 h", "143 times", "average 5,200 steps on the days you logged it".
8. **A habit's page adds its success rate this month and all time, its total, a 30-day chart for amounts and time with the goal line, and the last 12 months as a grid.**
9. **Quit habits:** slips in the period and the best run, never a score.
10. **Explain every number where it's shown**, in one line under it. **All of it free.** **No scores, grades, radar charts or AI "insights".**

## What the reviews say

Scan of 1,238,784 App Store and Play Store reviews for statistics words (stat, chart, graph, percentage, heat map, overview, report, trend, success rate, consistency and others; `Research/Temp/scan.py`): 10,300 hits, 9,201 about statistics in this sense, 8,801 of them in 148 habit and routine trackers. By hand: all 604 English *requests* for statistics, a random 260 of the 1,980 four- and five-star *praises*, and every review in the smaller themes (where statistics live, date ranges, days of the week, comparisons, reports: 553). The counts below are pattern matches in habit and routine trackers, checked against that reading.

| Theme | Reviews | Apps | Mean ★ |
|---|---|---|---|
| Graphs of progress over time, trends | 762 | 74 | 4.34 |
| One overall figure or view for all habits together | 330 | 52 | 4.15 |
| Totals, averages, cumulative counts | 284 | 54 | 4.13 |
| Statistics behind a paywall | 209 | 54 | 3.30 |
| Year view, heat map, GitHub-style grid | 177 | 54 | 4.36 |
| Statistics for each habit, not only overall | 138 | 36 | 4.24 |
| Compare habits side by side | 73 | 25 | 4.48 |
| A daily completion share ("8 of 10 today") | 72 | 27 | 4.39 |
| Longer ranges: all time, past years, a chosen range | 66 | 26 | 4.38 |
| Statistics couldn't be found | 44 | 21 | 4.09 |
| Asks for fewer statistics, or praises having few | 32 | 20 | 4.09 |
| A percentage that makes no sense or isn't explained | 26 | 12 | 3.73 |
| A weekly goal's percentage counted as if daily | 22 | 15 | 4.00 |

### 1. The overall figure, with its numbers and the week before

- "Can you please add the overall percentage of all habits (not only one). This is the only think which makes me to return to my previous app" (Habit, 3★, `6949334514`).
- "It's very important to add a global indicator, that shows the percentage achieved in a week, considering all goals together" (Do Habits, 5★, `1751693731`).
- "statistics of all the habits combined in one view, e.g. on Monday you did 8/10, on Tuesday 9/10 etc." (HabitNow, 5★, `8502b10c-b560-4c64-aea5-e053bbaa442d`); "On Monday you successfully finished 9 out of 10 habits / X% of all tasks" (Loop, 5★, `d0a7084a-174f-4fd8-bedf-a1099f986192`).
- With the period before: "I want to see how disciplined I've become since last week … last week 75% … this week done only 71%" (Loop, 4★, `f9aa4227-c189-4278-87f7-8caa9f2a9b38`).
- **Raw numbers, not only a percentage:** "there is no reference to total successes, fails and skips. You have to add them up yourself" (Habitify, 3★, `13291400972`); "Please add count number in addition to bar graph" (Do Habits, 4★, `7908224726`); "If I could see the exact numbers when I click on the chart … I would definitely give 5 stars" (Habit Tracker, 4★, `11596679734`).

### 2. On each habit's own rhythm

The most damaging mistake in competitors' statistics, and the ledger's C043 ("non-scheduled days neutral in the statistics"):

- "If I track a habit to complete … once every week, why when I check it off for one day the completion rate only goes up around 3-4%?" (Habit, 4★, `3901732031`); "I go to the gym three times a week which I have been completing, but my percentage is still low" (Habit, 4★, `4685770593`).
- "it would be great if the average completion rate for the day didn't take into account weekly habits" (Habitify, 3★, `13572292515`). Hence weekly and monthly goals stay out of the daily bars and count once per week or month in the overall figure.
- An unfinished today mustn't pull the number down: "I do wish they wouldn't preemptively set your percent success rate to 97% if you haven't performed the habit yet that same day" (HabitBull, 5★, `0f9dd5bd-44f7-4470-be65-bd99402b7821`).
- A blank day must be distinct from a miss: "blank should mean 'no answer' and ignored in the stats compilations" (Loop, 4★, `1592f94f-9fb9-4772-8835-5aa34e94e307`). Skipped and paused days are neutral here, as in the streak.
- Editing a goal mustn't rewrite the past: the percentage "counts all the previous weeks and drops" after changing 4 to 5 a week (HabitBull, 4★, `95a98ad1-0f48-4dac-bae7-73c6fe59c616`). Every past day is judged by the rule it had (goal history, already built).

### 3. Recent periods first, all of the past within reach

- Why the current period matters: "The feature of having stats for the last month and last 7 days is also exactly on point. Many others give you your stats since the birth of the app which means if you fall off for 4 months you can never get to the rewarding acknowledgement" (Streaks, 5★, `1437821189`).
- And the long view: "a nice ring giving your percentage by this week, last week, months, and all time so you can see your improvement" (Habit Hub, 5★, `3990165913`); "the option to show more than the last 30 days. Six months, three months, a year, and all time" (Streaks, 3★, `10796378002`).
- So Progress defaults to this week, with Month and Year and ‹ back through every period; a habit's page shows this month and all time side by side.

### 4. Every habit side by side, then each habit's own page

- "Add a screen that consists of stats of all habits which one you are acing and which one need improvement" (HabitNow, 5★, `221e4dc8-d0d1-4e9a-8d1f-3e884aaa34f0`); "useful to see at a glance which habits I would need to pay closer attention to" (HabitNow, 4★, `131f4112-62f6-45e5-be00-4ecd52046282`).
- Per habit, not only overall: "I really wish that there was a way to see stats about individual habits and not just your overall completion rate" (Habit Tracker, 2★, `6887607446`); "statistics for single habits, like how often did you complete the habit last month, how long is your streak" (Avocation, 3★, `3a77d6dc-dcad-4e6a-bbd1-392c64c395a9`).
- Praise for the success rate since the start: "I love that the app shows the 'success percentage' that let you know how well youre doing so far since the start date" (HabitNow, 5★, `ee72ae06-ac2d-4456-b19c-e680fcfe0ca0`).

### 5. The year grid

"I would like to suggest a heat map for the past 365 days" (Onrise, 4★, `13591528677`); "please add a heatmap for the whole year to have a better view on progress and consistency" (HabitNow, 4★, `34a397f6-1f85-4d7d-aa4e-b6ec2b15a214`); "After seeing my GitHub graph from last year, I just knew this was the right tool. It has been simply amazing for my ADHD" (HabitKit, 5★, `13605202758`); "The yearly reports resemble the activity grid on GitHub. Well done!" (Habit Tracker, 5★, `6200105633`). A partly done day is a lighter square: "It would be nice if there would different shades of tiles based on how much you completed" (`00138abf-7bdd-4f34-95d3-e921e54bb8e6`).

### 6. Totals and averages in the person's own units

"a function of Cumulative total chart that shows how many times or amounts we have done … I looked for a total increase graph and looked about 150apps" (HabitNow, 5★, `8195196b-300c-4e7e-879d-72d907061da4`); "for quantity/time based habits, it would be helpful to see a daily average" (HabitNow, 5★, `80ed39e8-151b-4d05-be0d-861cded196b4`); "how Many push-ups I did this week vs last week it should just show one single number of the TOTAL" (Do Habits, 4★, `7462593752`); "I thought the app would tell me how many times I've done something; not make me go back each 365 days and count it up myself" (Productive, 1★, `8501717309`). Partial progress should show: "if the goal is 30 minutes a day, but you only completed 20 minutes. It would be nice to see it in the stats section" (Productive, 4★, `11462493635`). Hence the 30-day chart shows the amount each day against the goal line.

### 7. Where: one tap from home

"I only stumbled on the charts in the profile section by accident!" (Today, 5★, `1708111245`); "when I wanted to see my overall progress I couldn't find it. You have to hunt thru the app just to find a progress chart" (Fabulous, 3★, `14404234567`); "It is not intuitive or easy to find the stats" (Streaks, 2★, `5320800014`); "Would love a separate stats tab instead of having to click on individual habits to view them" (HabitNow, 4★, `3e0b5ae2-cf51-4280-8803-fcda678efca1`); "I want to go to the statistics easily from today tab" (HabitNow, 4★, `ac836111-021a-4ec8-9516-7f17d937e810`).

### 8. Explained, calm and free

- **Explained:** "Percentage Makes No Sense … I now haven't ticked off one of my habits for over a month but it still shows as 100%" (Habit, 3★, `6256517334`); "wish it was more accurate with the percentage and provided with an explanation" (HabitBull, 4★, `34c2cff3-d15d-407b-9956-9056f2a2b1b2`).
- **Calm:** a real group wants less, not more: "No clutter with unnecessary stats, just the numbers you need to keep yourself motivated" (Strides, 5★, `996936287`); "I want good habits, I don't need a million bells and whistles and charts. In fact, for most of us with ADHD those are the fastest ways to get hyper focused, distracted, and then bored" (Do Habits, 5★, `8101391015`). So Progress is its own screen, never on Today, with one figure at the top and nothing that scores or grades.
- **Quit habits:** some want the trend ("Are your relapses getting further and further apart", Days Since, 5★, `10193651577`) while others find it hurts ("seeing the longest streak and average streak ruins the progress if I keep comparing myself to the past", Days Since, 2★, `8404418658`). Progress shows only the slips in the period and the best run, in plain words.
- **Free:** statistics behind a paywall average 3.30★ (209 reviews): "unfortunately it's not even useful if you're wanting to use it for free because the statistics is none" (Grit, 1★, `11282934508`). C234 is the rule: the progress view stays free.

## The design, reasoned from first principles on top of that

- **What is the person trying to do?** See whether it's working, without effort, and find what needs attention. So the answer comes first (one figure), then the evidence (bars, habits), then the long view (the year).
- **One definition everywhere:** the overall figure, each habit's figure and the page's figures all count the same way: a planned day once, a period goal once per period; skipped and paused days neutral; today and a week still going count only once met. The footer says exactly this.
- **Native parts only:** a segmented control for Week / Month / Year, a List, Swift Charts bars with touch selection, a plain progress bar per habit, and a Canvas grid.
- **Fast:** the numbers are worked out once when the data or the period changes (`HabitStore.revision`), never while a finger moves over the chart.

## Not built, on purpose

- **Overlaying several habits on one graph / correlations** (73 reviews compare; a handful want correlation): the side-by-side list answers "which is weak"; correlation needs daily readings (mood, sleep) the app doesn't record yet (spec §10: readings are out of scope).
- **Scores, grades, strength percentages and radar charts:** a forgiving measure is wanted (C216), but a computed score needs explaining and reads as broken when it isn't (C217); the plain share with its numbers is that measure here.
- **Category or group statistics:** the app has no categories (times of day aren't categories).
- **Export and reports sent by email:** export is its own feature (C020), with backup.
- **Time of day a habit is usually done:** asked by a few (medication, sleep); it needs the time of each tick on screen first.

## Limits

Keyword counts are floors and the themes overlap; the habit-tracker filter is by app name. The design is reasoned from the reviews and hasn't been tested with people.
