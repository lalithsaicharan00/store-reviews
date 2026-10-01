# Onboarding — The Name, What's Free, and a First Habit

Written by Claude (Claude Code), 1 October 2026. Build Plan #62 (onboarding) and #71 (help content), for the iOS app.
It builds on [The First Run — Start in One Tap](<The First Run — Start in One Tap.md>) (30 Sep), which decided that the app
opens on Today with no tour forced. The user then asked for more:
- an onboarding that is neither empty nor heavy;
- one screen that explains the name *Often Enough* in plain words, and sits well beside streaks;
- nobody left on an empty screen, without forcing them to do anything;
- clear expectations: what's free, no account, what we offer.

Ledger cards: [C203](<../Feature Ledger.md#c203>), [C075](<../Feature Ledger.md#c075>), [C185](<../Feature Ledger.md#c185>), [C209](<../Feature Ledger.md#c209>), [C159](<../Feature Ledger.md#c159>), [C111](<../Feature Ledger.md#c111>), [C145](<../Feature Ledger.md#c145>), [C283](<../Feature Ledger.md#c283>), [C160](<../Feature Ledger.md#c160>), [C236](<../Feature Ledger.md#c236>), [C181](<../Feature Ledger.md#c181>), [C305](<../Feature Ledger.md#c305>), [C153](<../Feature Ledger.md#c153>), [C176](<../Feature Ledger.md#c176>), [C157](<../Feature Ledger.md#c157>), [C216](<../Feature Ledger.md#c216>), [C201](<../Feature Ledger.md#c201>), [C024](<../Feature Ledger.md#c024>), [C292](<../Feature Ledger.md#c292>), [C290](<../Feature Ledger.md#c290>), [C288](<../Feature Ledger.md#c288>), [C146](<../Feature Ledger.md#c146>).

## Answer

Four short screens, every one skippable, shown once on a fresh install. Then Today.

| # | Screen | What it says | Why |
|---|---|---|---|
| 1 | **Often Enough** | "A habit doesn't need a perfect record. It needs to happen often enough." Three lines: you choose how often; streaks count your goal, so 3 times a week, every week, is a streak; skipped and paused days never count against you | The name, justified by what the app actually does (§1) |
| 2 | **Free, with no account** | Up to 5 habits free forever, with reminders, streaks, progress and all history; tasks unlimited. No account, no ads. Your habits stay on this iPhone, in its backup, and you can save a backup file any time. Plus, if you want more: one payment, not a subscription | Expectations before any effort (§2) |
| 3 | **Your days and weeks** | When a new day starts (Midnight to Noon) and the first day of the week, both already set to sensible defaults | Decided in the Backlog (28 Sep); shift workers (§3) |
| 4 | **What's one habit to start with?** | Eight ideas that fill in the New Habit form (nothing is saved until Save), Something Else…, and Not Now | No empty screen, nothing forced (§4) |

- **Skip** is on screens 1–3 and goes straight to Today. Not Now on screen 4 does the same.
- **Restore from a Backup File** is on screen 1, for people coming back. It ends onboarding and opens the restore.
- **An empty Today** (Not Now, Skip, or every habit deleted) says what to do and offers: New Habit, Start From an Idea, Restore from a Backup File, How It Works.
- **Notifications are not asked for in onboarding.** The app asks the first time someone turns on a reminder, as it already does.
- **Help & Feedback** is a searchable How It Works, Contact Us, and Show the Welcome Again. About has the version, privacy in plain words, and open-source acknowledgements (§5).

## 1. The name: what "often enough" means

**What people say.** Fresh scans of 1,238,784 App Store and Play Store reviews (`Research/Temp/onboarding/scan.py`), then a narrower pass on the 892,342 habit and routine app reviews (`scan2.py`). The counts below are keyword floors. Samples were read by hand.

| Theme | Reviews | Apps | Mean ★ |
|---|---|---|---|
| Perfection, all-or-nothing, "doesn't have to be perfect" | 482 | 68 | 4.62 |
| "Not every day", "most days", "N times a week" | 879 | 82 | 4.02 |
| Praise for a goal of N times a week (habit apps only) | 132 | 39 | 4.33 |
| Streak pressure, anxiety or guilt | 126 | 29 | 4.10 |
| A missed day that broke a streak and made them give up | 94 | 30 | 4.02 |

- **One missed day sends perfectionists into a spiral.** Users show: "For a perfectionist like me, missing one day and breaking my streak tends to send me into a spiral where I give up and backtrack on my success. This app changed all that!" (Habit — Daily Tracker, 5★, `6179162507`); "the pressure to maintain a streak encourages perfectionism, which is anti-self-care, imo. Also it gives me anxiety" (Finch, 4★, `11892154825`).
- **A weekly goal is the relief they name.** Users show: "doing something 3 days a week still counts towards my goal, I don't have to get a perfect every day" (Streaks, 4★, `10278937369`); "I can set a goal of 3 days a week without having to choose specific days" (EZ Habit, 5★, `b113c45d-df88-4f79-b94c-06244b7b2ec9`); and its failure: "when I choose to perform a habit 6 times a week, it still breaks my streak" (Loop, 3★, `56b3a85a-ad15-49a5-b94e-7577b4aa9f4d`).
- **"Better, not perfect" is a selling point in their own words.** Users show: a review titled "Better, Not Perfect": "as someone who suffers from perfectionism and binary thinking … you're never thinking about the cliff edge of losing a streak" (Awesome Habits, 5★, `13969274929`); "I like this because it doesn't punish me for missing a day" (Loop, 5★, `337255bd-4e3c-4900-a70e-f71293ceafa7`).
- **But streaks are loved too** (C024: streak psychology is the highest-satisfaction theme in report 23, 902 reviews at 4.75★). Users show: "It makes it real and you will try hard not to break the streak" (Days Since, 5★, `8430939983`). So the name must not say "no streaks". It says what the streak counts.

**What the research on habits says.** In the best-known study of how habits form in daily life, *missing one opportunity to do the behaviour did not materially affect the habit forming* (Lally, van Jaarsveld, Potts & Wardle, 2010, *European Journal of Social Psychology* 40(6), [doi:10.1002/ejsp.674](https://onlinelibrary.wiley.com/doi/abs/10.1002/ejsp.674)). This is the name's whole idea: regular repetition builds a habit, and a perfect record isn't needed.

**What the app already does that earns the name** (each is built; see What's Built):
1. **You choose how often:** every day, N times a week, month or year, totals ("20 km a month"), set days, every few days.
2. **The streak counts your goal, not days:** "4 wk" means four weeks in a row at the goal; a day the habit isn't planned never breaks it; a 3-times-a-week habit counts as done for the day once ticked.
3. **Skip and pause are neutral:** a skipped or paused day is never a missed day.
4. **Part credit:** a 6-of-8-glasses day fills its ring part of the way, and Progress's Full Day can be set to 80% or 60% (C201).

**The screen (reasoned from first principles).** One idea, said once, then three facts, each something the person will see in the app. Plain words, no slogan the app can't back up. The honest limit: a *daily* habit's streak does end on a missed day that wasn't skipped, so the screen never says "missing a day doesn't matter". It says skipped and paused days never count against you, which is true everywhere.

> **Often Enough**
> A habit doesn't need a perfect record. It needs to happen often enough.
> - **You choose how often.** Every day, 3 times a week, or 20 km a month.
> - **Streaks count your goal.** 3 times a week, every week, is a streak. Days you didn't plan never break it.
> - **Life gets in the way.** Skip a day or pause a habit. Skipped and paused days never count against you.
>
> *Missing a day now and then doesn't stop a habit forming. Doing it often enough does.*

## 2. Expectations: what's free, no account, where the data lives

| Theme | Reviews | Apps | Mean ★ | 1★ |
|---|---|---|---|---|
| Long onboarding or questionnaire | 531 | 44 | 1.75 | 66% |
| A limit or price found only after setting up (habit apps) | 31 | 11 | 1.74 | 65% |
| Lost everything on a new phone or reinstall (habit apps) | 335 | 50 | 2.41 | 42% |
| Easy or quick to set up | 952 | 73 | 4.75 | 2% |

- **Say it before they invest** (C236, C181, C111). Users show: "I got through the whole question and answer part and then found out it's not free after the 7-day trial period. You should have said that up front. I have wasted my time." (Me+, 1★, `9a462ffc-57c8-448f-8150-1588d4339a00`); "Claims to be 'free forever' at first, but once you create an account you learn that the free version is quite limited. They should state this up front." (everyday, 3★, `8680118578`). The Free Plan Design report already decided that "onboarding says it once" (§8.3).
- **No account is praised as a feature** (C209). Users show: "I was able to start a counter super quickly, with no account creation screen. That's awesome." (Days Since, 5★, `9590050027`); "I admire it doesn't require an account registration or personal information" (Habit Tracker, 5★, `bceede16-7dd9-480b-ab91-4417d18061c2`).
- **But no account raises "what if I lose my phone?"** (C153, C176). Users show: "You cannot log in with any way … if you pay and something bad happens to your phone you can't recover the data" (Me+, 1★, `10827625776`); "I tried everything but deleting the app since I'd lose all my data" (Habit Tracker, 3★, `6553122718`). Report 23 in the ledger: a backup that existed was found only through support, and reviewers raised their rating on learning of it, so the fix is to name it at first run. So screen 2 says where the habits live and how to keep a copy, as a fact, never as fear (C176).
- **One payment, not a subscription** (C305): people who mistook a one-time price for a subscription reviewed it as one (2.20★ vs 4.60★). Plus is named once, with its price shape, and never pushed (no button to buy on this screen).

> **Free, with no account**
> - **Free forever: up to 5 habits.** With reminders, streaks, progress and all your history. Tasks are unlimited.
> - **No account, no ads.** Nothing to sign up for.
> - **Your habits stay on this iPhone.** They're included in your iPhone's backup, and you can save a backup file any time in ≡ › Backup & Export.
> - **Plus, if you want more.** One payment, not a subscription: unlimited habits, iPad, Apple Watch, sync and automatic backup.

Widgets are free (Backlog, 29 Sep) but aren't in this branch yet; add "and widgets" to the first line when `codex/iphone-widgets` is merged. Never list a feature the app doesn't have (C218).

## 3. Setup: only what can't wait

- **Day start and week start** are asked in onboarding (Backlog, decided 28 Sep). 576 reviews in 70 apps ask to choose when the day ends, mostly shift workers and late sleepers (Settings report). Both rows start on the right answer for most people (Midnight; the region's first weekday), so Continue works without touching anything. The screen says both can be changed later in ≡ › Day and Week.
- **Nothing else is asked.** No goals survey, no "what do you want to improve" quiz, no personality score (C283), no pledge (C161), no name or email. Long onboarding is the worst-rated theme here (1.75★). A question the app can't act on is worse than none (C160).
- **No notification permission at launch.** iOS asks once; a "no" given before the person has a reminder to protect is hard to undo (C288). The app already asks the first time Remind Me is turned on, and the Reminders page explains how to turn notifications back on.

## 4. A first habit, and the empty Today

| Theme (habit apps) | Reviews | Apps | Mean ★ |
|---|---|---|---|
| Habit ideas, suggestions or presets helped | 103 | 25 | 4.09 |
| Wanted to make their own habits | 135 | 26 | 3.67 |
| An empty screen with no idea where to start (all apps) | 208 | 36 | 2.75 |

- **Ideas help when they're offered, not imposed** (C203, C292). Users show: "The habit presets are perfect, I only had to manually add one" (Routine Planner, 5★, `d2dae464-4027-46ee-b2ab-fe38ebd5b161`); and against forcing them: "I bought it to make my own habits rather it's forcing habits on me" (Fabulous, 1★, `13599849437`); "it starts you out with drinking a glass of water, I already do that as soon as I wake up" (Fabulous, 2★, `02fda23e-8d10-4714-8f97-74b9fee4c8b9`).
- **So an idea only fills in the form.** It sets the name, how it's tracked and how often; nothing is saved until Save, and everything can be changed. Amounts stay empty, as everywhere in the form (Design Rules: "Amounts start empty"). This keeps C292 (a preset never writes data) and C203 (the user authors the routine).
- **Eight ideas covering the common shapes**, so they also teach what the app can do. [How People Describe a Habit](<How People Describe a Habit — 4,407 Descriptions From Reviews.md>) found every day (30.7%), an amount a day (22.1%) and N times a week (16.2%) are the shapes people say most, and its examples are these same activities (water, reading, walking, meditation, the gym). Quitting and cutting down cover the other half of the New flow (reasoned from first principles: one idea per type a new person might not know exists):

| Idea | How it's tracked | How often |
|---|---|---|
| Drink water | Track an amount | Every day |
| Exercise | Check it off | 3 times a week |
| Read | Time it | Every day |
| Meditate | Time it | Every day |
| Walk | Track an amount | Every day |
| Go to bed on time | Check it off | Every day |
| Stop smoking | Quit | — |
| Less coffee | Cut down | Every day |

- "Exercise, 3 times a week" is on purpose: the first list a person sees shows the name at work.
- **Not Now** is a full answer, never hidden or greyed (C145: every step dismissible on the smallest screen).
- **The empty Today** is where Not Now, Skip, or deleting every habit leads. Its old line, "Add the first thing you want to do every day", contradicted the name; it becomes "Add something you'd like to do often enough, or start from an idea." Its buttons: New Habit, Start From an Idea, Restore from a Backup File, How It Works.

## 5. Help & Feedback and About

- **How It Works:** short answers, searchable, each naming the exact button in the app's own words (C075; 482 missing-help reviews at 2.69★ in the Settings report; 394 "no instructions" at 2.57★ here). The questions are the ones reviews show people can't answer: delete, undo, backfill, skip vs pause, how streaks and Progress count, a day that ends after midnight, where the data is, backup.
- **Contact Us:** an email to support@oftenenough.com, with the app and iOS versions filled in and none of the person's habits. If the phone has no mail app, the address is shown with Copy. The mailbox must exist before release (Build Plan #72).
- **Show the Welcome Again:** screens 1 and 2, for someone who skipped them (C075: replayable).
- **About:** the version, privacy in plain words (no account, no ads, nothing leaves the phone unless you share it), and the open-source acknowledgements the libraries' licences require. No links to pages that don't exist yet.
- **Not included:** a chatbot, videos, a forced tutorial, a public feature-request board (C298).

## Reasoned from first principles

- **The first screen is a promise; keep it to what's true.** A polished onboarding converts but doesn't retain (C185), so the words describe the app as it is, and nothing is shown that the person can't find afterwards.
- **Four screens is the floor for what must be said, not a ceiling to fill.** The name, the free plan and the day's start each have a review-backed reason to be said before use; the first habit is the action the person came for. Anything else (themes, reminders, groups, routines) is found in the app when needed.
- **Every screen can be left.** Skip, Not Now and the Restore link mean the shortest path to Today is one tap.
- **January** (C146): the largest cohort of the year judges onboarding in its first days. Nothing in it touches the network, so it can't fail on a slow connection.

## Files

- Scans: `Research/Temp/onboarding/scan.py`, `scan2.py` (gitignored scratch; results `scan.json`, `scan2.json`).
- Build: `iOS/Habits/Onboarding/`, `iOS/Habits/Help/`; checklist `iOS/Docs/Checklists/Onboarding and Help.md`.
