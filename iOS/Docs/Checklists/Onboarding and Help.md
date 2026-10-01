# Onboarding and Help — the User's Points

Written by Claude (Claude Code), 1 October 2026. Branch: `onboarding-and-help`, made from `integration` (the merge of every
feature branch, 08:17 on 1 Oct) plus the app-identity note and the ledger gaps in the Build Plan. Build Plan #62 and #71.

The old branch name `claude/eloquent-turing-oznzs3` couldn't be deleted from this session; it is an older copy of the start of
this branch. Nothing is lost by ignoring it.

## The user's points (1 Oct 2026)

| # | Point | Research | Built | Tested |
|---|---|---|---|---|
| 1 | New branch from the latest code (or rename this one), so merging is easy | — | [x] `onboarding-and-help` from `integration` | — |
| 2 | **Design the best possible onboarding:** read the ledger cards and the reviews; not empty, not heavy | [x] report §1–4, 22 ledger cards | [x] four skippable screens | [x] |
| 3 | **One screen on the name:** why the app is called *Often Enough*; concise, plain English; it must justify the name, and sit well beside streaks. Research it | [x] report §1 (perfection 482, weekly goals 132, Lally et al. 2010) | [x] screen 1, with a week picture | [x] |
| 4 | **The user shouldn't land on an empty screen:** encourage them to do at least something, without forcing anything | [x] report §4 | [x] eight ideas that fill in the form; Something Else…; Not Now | [x] |
| 5 | **If they do land on an empty Today:** handle it well | [x] report §4 | [x] New Habit, Start From an Idea, Restore, How It Works | [x] |
| 6 | **Set everything up that onboarding needs to set** (day start and week start are decided, Backlog 28 Sep) | [x] report §3: nothing else; no permission asked | [x] screen 3 | [x] |
| 7 | **Set expectations clearly, so we don't get bad reviews:** what we offer | [x] report §2 | [x] screen 2 | [x] |
| 8 | **It's a free app:** consider showing what the free plan gives | [x] report §2 | [x] screen 2: up to 5 habits free forever, tasks unlimited, Plus one payment | [x] |
| 9 | **No account for free users**, and say so clearly | [x] report §2 | [x] screen 2: "No account, no ads"; where the data lives and how to back it up | [x] |
| 10 | **Help content** (Help & Feedback, as described: searchable How It Works, Contact Us, replay the tour; About) | [x] report §5 | [x] `HelpView` (33 answers), `AboutView` | [x] |
| 11 | Research extensively first (cards, reports, reviews), make the plan, then build without waiting | [x] [report](<../../../Research/Research Reports/Habit Creation/Onboarding — The Name, What's Free, and a First Habit.md>) | — | — |
| 12 | Test everything thoroughly; make it robust | — | — | [x] GitHub runs below |

## Notes as the work goes

- **Research** (1 Oct): [Onboarding — The Name, What's Free, and a First Habit](<../../../Research/Research Reports/Habit Creation/Onboarding — The Name, What's Free, and a First Habit.md>). Two fresh scans (1,238,784 reviews; 892,342 in habit apps), samples read by hand, 22 ledger cards, and the habit-formation study behind the name.
- **Built:** `Habits/Onboarding/Onboarding.swift` (the welcome, ideas, `IdeasSheet`), `Habits/Help/HelpView.swift`, `Habits/Help/AboutView.swift`; `HabitForm(type:idea:)` fills in a name and how often; the empty Today in `TodayView`; shown from `HabitsApp` on a fresh install.
- **Decisions while building:** the welcome is never shown with `-uitest` or `-dbname` (every other test) unless `-onboarding`; someone who already has habits never sees it; the empty Today's line "Add the first thing you want to do every day" contradicted the name and was rewritten; the app's own name in the welcome and help is `Onboarding.appName` ("Often Enough"), though the home-screen name changes only with the bundle ID on `claude/server-and-sync`.
- **Before release:** create support@oftenenough.com (Build Plan #72); add widgets to the free line once `codex/iphone-widgets` is merged.

## Results (GitHub, 1 Oct 2026)

| Run | What | Result |
|---|---|---|
| f764668 | Onboarding, Persistence, Backup, Today | Didn't start building: xcodebuild's start-up error went to stderr, which the old Build step dropped. Took `codex/iphone-widgets`' Build step, verbatim |
| 21f1728 | Same | Builds. 18 of 20 pass: every Today (8), Backup (3) and Persistence (3) test, and the full welcome walkthrough. Two test mistakes: an amount idea needs its amount before Add (by design: amounts are never filled in), and iOS 26 search has no Cancel |
| e390a77 | Onboarding, HabitCreation (6), NewFlow | 12 of 13 pass: the form change breaks none of the creation tests. Screenshots led to two design fixes (Make Your Own always in view; headings no longer faded). One test step: an active search hides Help's title |
| 2991754 | OnboardingUITests | **6 of 6 pass**: welcome to first habit (with the day start reaching ≡ › Day and Week), Skip to a helpful Today and an idea added, Not Now, Make Your Own, Help search, Contact Us without a mail app, the welcome again, About, Restore from the welcome, no welcome in other runs, largest text size |

Speed runs weren't needed: the welcome never shows in them (`-uitest`), and Today only changed its empty state.
