# Hero Copy — What People Look For First

Written by Claude (Claude Code), 4 November 2026, at the user's request: research what the first section of the website should say, from the visitor's side, and keep it short.

## The answer

| Part | Copy |
|---|---|
| **Headline** | The simple habit tracker with no subscription. |
| **Line under it** | Log your habits in a tap. Start free, and pay once if you ever want more. |
| **Buttons** | Get it on Google Play · Download on the App Store |
| **Quiet line** | No account. No ads. Your habits stay private. |

It replaces "A habit tracker that stays yours." That line was about privacy, and **users show privacy is rarely what they go looking for**.

## What a visitor needs from the first section

Reasoned from first principles, in order:

1. **What is this?** A habit tracker. If the words don't say so, the rest doesn't matter.
2. **Will it be easy, or another thing to manage?**
3. **What's the catch?** People in this category expect one.
4. **How do I get it, and does it work on my phone?**

Everything else (routines, widgets, quitting, backup) can wait for the sections below.

## What people say they were looking for

We scanned 1,238,784 reviews across 216 app and Play datasets for people saying what they were "looking for" or "searching for". That gave **4,476 distinct English statements** across 143 apps, mostly 5-star: real people describing the app they wanted, in their own words.

| What they wanted | Statements | Share of all 4,476 |
|---|---|---|
| **Simple, easy, not cluttered** | 511 | 11.4% |
| To-do and tasks in the same place | 454 | 10.1% |
| **Free, no subscription, one-time** | 293 | 6.5% |
| Motivation, fun, rewards | 230 | 5.1% |
| Routine, daily structure | 218 | 4.9% |
| Looks good | 153 | 3.4% |
| Reminders | 140 | 3.1% |
| Seeing progress | 136 | 3.0% |
| Flexible goals, custom schedule | 119 | 2.7% |
| Tracks many habits | 101 | 2.3% |
| Quitting or bad habits | 81 | 1.8% |
| Widgets | 49 | 1.1% |
| **Privacy, no account, offline** | 23 | 0.5% |

Another 2,620 name no specific wish ("an app like this"). A statement can count in more than one row.

Their own words:

| Review | Rating | What they said |
|---|---|---|
| HabitNow, Play `3fadf646-626f-402f-a787-39ce038f414d` | 5★ | "looking for a simple, but effective habit tracker" |
| Habit Tracker, App Store `12524435443` | 5★ | "a good habit tracker that's free and reliable" |
| Fabulous, App Store `11722341056` | 1★ | "something simple like a checklist and reminders" |
| Fabulous, Play `f8d02c62-420e-423d-910f-366209c451de` | 3★ | "a more simple reminder app, not a full immersive experience" |
| Routine Planner, Play `b2880169-aebb-445e-a972-e2e3aaf2dc2f` | 5★ | "most apps are subscription heavy" |

## What people praise and what they punish

Across 181 datasets with to-do, workout, journal and similar apps removed: 301,165 reviews of 4–5★ and 72,744 of 1–2★.

| Mentioned | In 4–5★ | In 1–2★ |
|---|---|---|
| **Simple, easy** | **13.0%** | 3.4% |
| **Subscription, paywall, price** | 4.5% | **28.6%** |
| Account, login, privacy | 0.5% | 8.2% |
| Ads | 1.2% | 3.6% |
| Reminders | 5.2% | 6.1% |
| Widgets | 2.5% | 1.8% |
| Stats, progress | 2.5% | 1.4% |

**So two things carry the most weight.** Simple is the most common praise. Subscription and paywalls are by far the most common anger, in more than one of every four low ratings. The headline uses exactly those two.

Account and login do show up in low ratings, but that count mixes in login bugs, so it's a reason for the quiet line, not the headline.

## What other habit apps say

Read on 4 Nov 2026: nine of twelve sites loaded (everyday, Habitica and HabitNow didn't).

- **Most sell a better life:** "Build Better Habits, Build a Better Life", "Make 2024 your most successful year ever".
- **Few say plainly what they are.** Streaks and HabitKit do. Only Streaks' hero mentions a one-time purchase, and it's Apple only.
- **Many lead with ratings or download counts.** We have none and won't invent any.

This isn't a reason to copy anyone. It shows the plain, specific line is open.

## Guidance on hero copy

No rigorous study of app heroes was found. Most guidance is from vendor blogs, and it's mixed: one Unbounce test had clever copy beating clear copy by about 18%, on an iPhone repair page. What holds up: people scan, the headline carries the most weight, and it should match what the visitor came for. NN/g's homepage principles ask for an immediately clear purpose.

## Why this wording

- **"The simple habit tracker"** says what it is and gives the most common wish. It's also the exact phrase people type.
- **"with no subscription"** answers the catch, and it's a search phrase too.
- **"Log your habits in a tap"** makes "simple" concrete.
- **"Start free, and pay once if you ever want more"** is honest about Plus. A free plan with a hidden limit is a known complaint: "you can only add 5 habits in the free version" (Productive, App Store `11437199237`, 2★). The 5-habit limit must stay clear on the Plus section.
- **"No account. No ads. Your habits stay private."** keeps our real privacy story without spending the headline on it.
- **Fact check against the app:** one payment and no subscription (`PlusScreen.kt`); no ads, `AD_ID` removed (`AndroidManifest.xml`); habits only on the phone and the person's own Drive or iCloud (Rulebook D16). "In a tap" is true of checks and stepped amounts; a typed amount takes a moment longer.

**Alternatives, if the user prefers:**

1. "A simple habit tracker. No subscription."
2. "Track your habits. Skip the subscription."
3. "Habits made simple. Pay once." (loses the words "habit tracker")

## What this can't tell us

- **It's a keyword scan, not a hand-coded study.** About 110 of the statements were read by hand; the counts are machine counts. Treat them as an order of size.
- **Reviewers aren't website visitors.** They've already installed something. Nobody has measured our own visitors, because we have none yet.
- **The "looking for" scan includes some to-do and workout apps,** which is partly why tasks rank so high. English only.
- **This is no conversion forecast.** After launch, Search Console will show which words people use and click.

## Sources

- [NN/g: homepage design principles](https://www.nngroup.com/articles/homepage-design-principles/)
- [CXL: findings about how people view websites](https://cxl.com/blog/10-useful-findings-about-how-people-view-websites/)
- [Unbounce: landing page copywriting tests](https://unbounce.com/?p=24327)
- Hero sections read: [Streaks](https://streaks.app/), [HabitKit](https://www.habitkit.app/), [Habitify](https://habitify.me/), [Griply](https://www.griply.app/), [Fabulous](https://www.thefabulous.co/), [Loop](https://loophabits.org/), [Way of Life](https://wayoflifeapp.com/), [Productive](https://productiveapp.io/), [Finch](https://www.finchcare.com/)
- Scan scripts and output: `Research/Temp/website-hero-v3/` (not in git)
- Earlier: [Hero Round 03](<Hero Round 03 — What Visitors Need First.md>)
