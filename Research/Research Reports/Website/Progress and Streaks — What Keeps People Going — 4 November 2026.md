# Progress and Streaks — What Keeps People Going

Written by Claude (Claude Code), 4 November 2026, at the user's request: what's the next most important section after Free and Plus, for people and for search, and how should its copy read?

## The answer

**"Will this actually help me stick with it?"** The fourth section shows progress, streaks and what happens on a day that goes wrong.

By now a visitor knows what the app is, what it can track and what it costs. The page hasn't shown what they get back for logging. That's also the biggest reason happy reviewers give for liking a habit app.

## What people show

**Scan:** the same 372,850 unique English reviews across 181 collections of habit and routine apps as the last two sections: 281,936 of 4–5★ and 70,237 of 1–2★. Counted by machine, with samples read by hand. These are rough counts, for size and direction. Reviews come from people who already have an app, not website visitors, so they show what matters and not what a visitor asks first.

**What happy people praise, and what unhappy people raise** (a sentence on the theme, positive in 4–5★, negative in 1–2★):

| Theme | Praised (4–5★) | Share | Raised (1–2★) |
|---|---:|---:|---:|
| **Motivation, staying on track** | **11,328** | **4.02%** | 259 |
| Routine, order of the day | 9,232 | 3.27% | 1,089 |
| Looks | 7,822 | 2.77% | 588 |
| Reminders | 7,467 | 2.65% | 1,434 |
| **Seeing progress** | **3,289** | **1.17%** | 157 |
| Widgets | 2,484 | 0.88% | 441 |
| **Streaks** | **1,659** | **0.59%** | 241 |
| Sync | 714 | 0.25% | 439 |
| **Skip, pause** | **570** | **0.20%** | 230 |
| Backup | 397 | 0.14% | 422 |
| Privacy | 146 | 0.05% | 126 |
| Lost data | 97 | 0.03% | 466 |

- **Motivation is the top reason, and it's an outcome.** Nobody can build "motivation", so the section shows what delivers it: seeing progress and streaks. Those three themes belong together.
- **It's the most one-sided theme.** Motivation is praised about 44 times for every complaint; reminders, 5 to 1. People don't leave over it, they stay for it.
- **Routine, reminders and widgets** are large too, and they make the natural next section: how the app fits into a day.
- **Backup, lost data and privacy** barely show up in praise, but they outnumber it in complaints. They're a worry, so they fit a later "your habits are safe" section, closer to the decision.

**A missed day is where people fall away** (machine counts, read by hand for direction):

| What the review says | 4–5★ | 3★ | 1–2★ |
|---|---:|---:|---:|
| See how far they've come, or their progress | 527 | 22 | 20 |
| A streak and a skip, pause, holiday or sick day in one thought | 113 | 23 | 22 |
| A missed day that's fine, or that they could carry on from | 48 | 11 | 10 |
| A streak lost or reset | 168 | 45 | 71 |

The last row is noisy: many 4–5★ mentions are people saying the fear of losing a streak keeps them going. Reading samples, people pull both ways:

- A streak works because they don't want to lose it.
- For someone else, one lost streak sets off giving up altogether. One 5★ reviewer calls it a "spiral where I give up".
- Others ask for exactly what we have: "Would be the best if we could skip one day without ending the streak."
- One 5★ reviewer praises a weekly goal for this reason: it "doesnt not break your streak when you dont do a day as long as you reach you weekly number".

So the section needs both halves: a streak worth keeping, and a plain answer to "what if I miss a day?". That answer is also what the name means, and it follows the second section's line that often enough doesn't mean every day.

**Outside the reviews:** UCL's account of the Lally study says missing one opportunity didn't significantly affect habit formation, though people who were very inconsistent didn't form habits. It's one small study (39 people's data behind its well-known average) and a replication is under way, so it supports the design and doesn't go on the page as a claim.

## What the app really does

Read from `Core/spec/streaks.md`, `Android/…/ui/habit/` and Figma's Android file, not from memory. **This is what the copy must stay inside:**

| Fact | Where |
|---|---|
| **Skipped, paused and not-its-day days are neutral**: a streak walks past them | ST-2 |
| **A due day not done ends the current streak.** So we never say a miss doesn't break a streak | ST-2 |
| **An unfinished today never breaks a streak** | ST-1 |
| **The best streak and every run stay**, and history is kept | ST-4 |
| **A streak's unit follows the goal:** days, times, weeks, months or years | ST-1 |
| **A week can't be lost to a pause** | ST-3 |
| **Milestones** come from the streak and the total, with the next one shown ("7 to go") | ST-7, A21 |
| **The app's own line:** "Nothing here counts against you: skipped, paused and no-goal days are left out of every count." | `HeatSquares.kt` |
| **Week, month and year views, streaks and milestones are free.** Only Year in Pixels on a habit's page is Plus | `ProgressTab.kt:442`, A110 |
| **Quit habits have runs, not streaks** | ST-5 |

So the calendar card shows Month (free) with no tag, and Year in Pixels has its own card with a Plus tag.

## How the copy should read

**Use people's words.** Sentences in 4–5★ and 1–2★ reviews:

| Word | 4–5★ | 1–2★ |
|---|---:|---:|
| motivat… | 14,580 | 863 |
| progress | 5,104 | 731 |
| on track | 5,037 | 132 |
| streak | 3,704 | 639 |
| consisten… | 2,606 | 217 |
| calendar | 1,871 | 675 |
| stats | 1,474 | 197 |
| graphs, charts | 1,341 | 124 |
| keep going | 832 | 50 |
| see my progress | 722 | 29 |
| miss a day | 232 | 30 |
| milestone | 231 | 16 |
| how far | 277 | 8 |

**Rules:**

1. **Say "progress", "streak", "calendar", "milestones" and "miss a day".** They're what people type and write. Never "insights", "analytics", "momentum" or "journey".
2. **Promise what's shown, not what it does to you.** Reviewers say an app motivates them, but the page shouldn't claim it will: "See your progress" can be checked, "Stay motivated" can't.
3. **Say the honest version of a miss.** "Skip a day and your streak stays" is true. "Miss a day and your streak stays" isn't. Saying a missed day ends the current streak but keeps the rest builds more trust than a vague "no pressure".
4. **Name the real reasons for a skip:** sick, travelling, a rest day. They're people's words, and they show the feature is meant to be used.
5. **No shame words and no cheering.** No "failed", "broken", "crush your goals".
6. **No science claims on this page.** No "66 days", no "builds habits faster".

**The words we chose:**

| Part | Words | Why |
|---|---|---|
| Heading | **See your progress. Keep your streak.** | Two plain promises in the two words people use, and two sentences like the sections before |
| Lead | Calendars, streaks and milestones show how far you've come. A missed day never wipes it out. | Lists what's below for search and AI tools, and answers the fear at once |
| Calendar | **Every day at a glance** · Week, month and year views show the days you did it, habit by habit. | "At a glance" is people's phrase, and the card shows it |
| Streaks | **Streaks that fit your schedule** · Your streak counts in days, weeks or months, so a habit you do 3 times a week has one too. | No other part of the page says this, and it carries on from flexible schedules |
| Milestones | **Milestones along the way** · See what you've reached, and how close the next one is. | The app shows "7 to go": a next step, not just a past badge |
| Year in Pixels | **Your year in pixels** (Plus tag) · Every day of a habit's year as one square, on its page. One look shows how your whole year went. | Added at the user's request, the same day. The first sentence is the app's own Plus screen line |
| Missed days | **Skip a day and your streak stays.** · Sick, travelling or need a rest? Skip the day or pause the habit. If you miss one, your best streak and all your history stay. | The question people raise, in their words, with the honest limit |

**Shown on phone screens (the user, 4 Nov 2026).** Streaks, milestones and Year in Pixels became the app's real screens in a phone, because the milestones in particular "looks really good in the mobile screen". The words above didn't change. The earlier cards are on Figma's archive page.

**Later the same day (the user):** the streak rows became Today itself, in a half phone beside the streak history, and each cut phone ends in a gap. The app's rows say 🔥 6 wk, so the design does too. The phone layout leaves out the history phone to stay short; that's a design call, reasoned from first principles, not from reviews.

## Year in Pixels

**The user's call, 4 November 2026:** it's a highlight of the section because it's a really good feature and looks really good. Reviews don't drive this: a year-wide view is rarely named (54 mentions of a heat map, 10 of a year view and 11 of a pixel grid, calendar or year at a glance, counted by machine), and "whole year" in reviews is mostly about billing. Its job is different: it shows at once what a year of logging gives you, and it's the most striking picture the app has.

It carries the Plus tag and a link to Plus, because it's the one thing here that isn't free. The calendar card above stays free, so nobody takes month and year views for Plus.

**The user's review, the same day:** one year, not three; every square exactly as in the app's "What the squares mean"; and a different colour, with the section in harmony. So it shows one habit in orange, the section's one warm colour, beside the app's key. Mint, blue and purple stay on the cards around it. Orange also suits the grid: its Strong shade is easy to tell from Done, where purple's nearly matches.

The key's closing line is the app's own and repeats the section's promise: "Nothing here counts against you: skipped, paused and no-goal days are left out of every count."

## Search and AI tools

- **Why it helps:** "streaks", "calendar", "progress" and "milestones" are the features people compare, and "habit tracker with streaks" and "doesn't reset when you miss a day" are questions a person might put to a search box or an AI tool. A quick search of that second question found mostly App Store listings and articles from other apps' own sites, so it's a question people are being answered on. That's a light check, not keyword data: we have no search volumes yet, and Search Console will show the real terms after launch.
- **Plain facts as text.** "Skip a day and your streak stays" is the kind of sentence an AI tool can quote, so it's a heading, not words in a picture. Every number in the cards is real text.
- **Later:** a search page on missed days and streaks could grow from this section once the main pages are done. It isn't on the list yet.

## What comes after

Reasoned from the table above, to be checked again at each step: **5, fits into your day** (routine, reminders, widgets), **6, your habits are safe** (privacy, backup, no account), then questions and the final download.

## Sources

- Scan scripts: `Research/Temp/website-section-4/` (not in git)
- [UCL: How long does it take to form a habit?](https://www.ucl.ac.uk/news/2009/aug/how-long-does-it-take-form-habit) · [Replication preprint on Lally et al.](https://rr.peercommunityin.org/download/t_recommendations.reply_pdf.8382af6b73bdd0f7.6d616e757363726970745f7072657072696e742e706466.pdf)
- [Streak Anxiety: Habit Trackers That Forgive](https://habitdoom.com/blog/streak-anxiety-habit-trackers) · [7 Best Streak Tracker Apps](https://habi.app/insights/best-streak-tracker-apps/) (vendors' own articles, seen only as search results)
- Earlier: [Free and Plus](<Free and Plus — What People Need to Know — 4 November 2026.md>) · [After the Hero](<After the Hero — What People Want to Know Next — 4 November 2026.md>)
