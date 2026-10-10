# Merge and Hardening — Plan and Progress

*Written by Claude (Claude Code), 1 Oct 2026. Kept on `claude/server-and-sync`, then on `integration` and `main` once
merged. **Any session picking this up: read this first, then update it as items move.***

## The task (the user's words, tidied, 1 Oct 2026, 18:00 UTC)

1. **Write down everything still to do** (this note; what needs the user is also at the top of
   [Server, Sync and Launch — Status](<Server, Sync and Launch — Status.md>)).
2. **Merge everything into `main`**, through `integration` or directly, except **`analytics`** (Codex is working on
   it). There are too many branches and conflicts are growing; the goal is to delete the unneeded ones. Keep the
   branch checklist ([Merging the Branches](<../iOS/Docs/Checklists/Merging the Branches.md>), on `integration`)
   current: say clearly when a branch is safe to delete.
3. **Then test thoroughly. Performance is the top priority** (the rules: `PERFORMANCE.md`, the Design Rules' speed
   section, `iOS/Tools/check_rules.sh`). Then **data robustness** (data must never be lost), widgets, and bugs.
   Fix whatever can be fixed from here; the rest goes on the list.
4. **`main` must be ready and steady** for testing on the real iPhone, Google sign-in, and the Apple Developer account.
5. **Check-ins:** the first fires 2 h 10 min after 18:05 UTC (20:15 UTC); each one schedules the next for 5 h 10 min
   later; four in all. Each says: continue and complete the task.

## Plan

| # | Step | Status |
|---|---|---|
| P1 | Note everything down (this file) | ✅ 1 Oct |
| P2 | Schedule the check-ins (send_later) | ✅ check-in 1 at 20:15 UTC (`trig_01Mpn2S8ZZHVi68YRGvJSmFi`); it schedules 2, 2 schedules 3, 3 schedules 4 |
| P3 | Find what isn't merged yet | ✅ Only `claude/server-and-sync` (47 commits) and `analytics` (excluded). Checked, not assumed: `claude/free-plan-data-safety` and `claude/pensive-bardeen-ou4hiw` are fully inside `claude/server-and-sync`; `claude/eloquent-turing-oznzs3`'s one extra commit is a "superseded, don't merge" note |
| P4 | Merge `integration` into `claude/server-and-sync`, resolving every conflict keeping both sides (the Status note §2 checklist: sync schema renumbered to 7, `entry.source` synced, new write paths through `SyncWriter`) | ✅ `b8edab4` + build fix `1218890` + `b745b78` (decisions below) |
| P5 | Run everything: server (129), Core JVM + sync (JVM, JS), the website check, iOS build + the UI suite in halves on GitHub, `check_rules.sh` | ✅ Server 129/129, Core, website, rules; iOS: every class the merge touched passes (Backup 8/8, Sync, Persistence 4/4, Onboarding 6/6, Today 8/8, Progress 10/10, New Habit 19/19, Habit Creation 6/6, Undo, Timer 2/2, Groups 5/5) |
| P6 | Move `integration`, then `main`, to the merged result; update the branch checklist | ✅ 1 Oct 23:45 UTC, fast-forward; checklist says which branches are safe to delete |
| P7 | Performance: measure every screen with the app-driven runner (`[ios-perf]`), fix every regression and the known slow spots (opening a screen 500–1,300 ms, Today's first scroll 180–440 ms) | In progress. Done (`6d04d35`, `69e2227`, `943e4e5`): quit rows tick only their two times (the whole row re-walked its history every second); a habit's runs remembered for today (one walk after a save, not two); the habit form builds sub-screens when opened (it built every one, three whole forms on the type question); Privacy's Face ID check off the main thread; Progress's weekday names once; backup and sync files off the main thread. Next: the first keyboard of a launch (habit form 2.8 s, entry editor 1.3 s), Progress's first open (2.8 s; bisect), keeping Progress's snapshot between opens |
| P8 | Data robustness: migrations from every shipped schema, restore/merge, sync, low storage, kill mid-write; widgets reading the shared store | — |
| P9 | Bugs: the older failing UI tests (Focus player, Routine Calendar, Goal flow, Schedule), anything found on the way | — |

## Branches

| Branch | State | Safe to delete? |
|---|---|---|
| `claude/server-and-sync` | In `main` (P6) | **Yes** |
| `claude/serene-wright-mcvmrx` | Nothing beyond `main` (this session's starting branch) | **Yes** |
| `claude/free-plan-data-safety`, `claude/pensive-bardeen-ou4hiw` | Fully inside `claude/server-and-sync`, now in `main` | **Yes** |
| `analytics` | Codex, still being worked on | **No**: it merges `main` itself when ready |
| Everything else | See [Merging the Branches](<../iOS/Docs/Checklists/Merging the Branches.md>) "Branches to delete" | As listed there |

## Still to do that needs the user (from the Status note, 1 Oct)

**GitHub Mac minutes: no limit** (the user, 2 Oct 2026): the repository is public, so Actions minutes are free and
unlimited. Run whatever a change needs; only GitHub's 60-minute job limit applies (split long suites).

The Apple Developer account; trying Google sign-in on the iPhone; the website's origins on the Google web client;
removing the parked DNS records for `oftenenough.com`; `support@oftenenough.com`; Resend; monitoring set-up
(Analytics Engine, token, uptime monitor, alerts, turning off Web Analytics injection); a separate production
Cloudflare account and Workers Paid; the Plus and Plus Family screen designs; reading the privacy policy and terms;
a WAF rule. Details and where each is done: the Status note's "What needs you".

## Decisions made in the merge (1 Oct)

- **One backup page:** ≡ → **Backup & Export** (the menu's name stays, per the Design Rules' menu order) is now the
  account-aware screen from `claude/server-and-sync`: status, where the backup goes, Back Up Now, Restore (account
  copies, iCloud, a file; preview, Replace or Merge, Undo for 30 days), Move to Another Device, **Save a Backup File**,
  **Export a Spreadsheet (CSV)** (from integration), "Before You Delete the App" (shown with no account), Sync, the
  account, Erase. Integration's identifiers (`backup-save`, `backup-export-csv`, `backup-restore`) kept, so its tests
  and speed scenario still find them. The temporary avatar and its settings sheet are gone; the empty Today's and the
  welcome's "Restore from a Backup File" open this page; the backup-problem notification opens it on Today's stack.
- **One backup file format:** the documented `.zip` (format 1, also what the server keeps). Restore still accepts the
  `.db` files integration's page made (they're merged in: only what's missing is added), so no file is ever orphaned.
- **Copy:** Plus is "unlimited habits, iPad, Apple Watch and sync" (Help, the welcome, the Plus screen); automatic backup
  is free with an account, so it's no longer listed as Plus. Help explains the free account backup. *The user may
  want to word the Plus screen differently: its design is still theirs to give.*
- **Data:** schema 7 = sync tables; a database from a pre-merge server-sync test build (its "6" had the sync tables
  and no `entry.source`) gets the column and opens (test `serverSyncTestBuildVersion6StillOpens`).
- **Found by the merge:** Info.plist had two `CFBundleURLTypes` keys (the second silently replaces the first, so the
  widgets' `oftenenough://` links would have stopped opening the app): now one key with both schemes. The type name
  `BackupCheck` existed twice (Core's and integration's debug check runner): Core's is qualified.

## Progress log

- **4 Oct 2026 (Codex, shared CI policy and documentation sync):** Rulebook T10 and both root agent entry points
  now require ordinary pushes without trigger tags, live repository-wide checks before starting validation, and
  waiting for other agents' tests without cancelling them. The widget cancellation tag needs explicit authorization.
  Remote main was already current; imported the routine-player requirements from `e657641` as documentation only.
  Its old checklist items 22/23 map to Current Work Checklist 33/34; implementation and completion claims remain
  pending verification. No app code was merged by this sync.
- **4 Oct 2026 (Codex, documentation organization):** renamed `iOS/Build Plan.md` to
  [Product Roadmap](<../iOS/Product Roadmap.md>) and “Next Up” to
  [Current Work Checklist](<../iOS/Docs/Checklists/Current Work Checklist.md>). The roadmap retains broad capabilities
  and dated build history; the current checklist owns recent feedback and overlapping current status. Existing
  issues and validation come first under the user's latest priority, with planned improvements and completed work
  separate. All 21 checklist entries, original item numbers and evidence were preserved; document links checked.
  No app issue was marked fixed by this documentation change.
- **1 Oct 18:10 UTC:** P1–P3 done.
- **1 Oct 20:20 UTC:** P4 done; check-in 1 fired, check-in 2 scheduled for 2 Oct 01:28 UTC
  (`trig_01M4BDue4Sp5aLwpVmyuPy8t`). P5: everything off the Mac passes; the iOS run is going.
- **1 Oct 20:50 UTC:** first iOS run of the merge: 25/27. Speed fixes from reading the code (a helper agent's review
  of the slowest first openings; its full list is the P7 "Next"). Rerun of the touched tests plus speed runs going.
- **1 Oct 21:50 UTC:** `670d321`: Backup 8/8, New Habit 19/19, Progress 10/10, Habit Creation 5/6 (`testBigNumbers`:
  the test runner timed out reading the screen; passed twice on `integration`; the whole run was slow, rerun alone).
  The job hit GitHub's 60-minute limit before Today, Undo and the speed runs: now run separately (speed first).
- **1 Oct 23:10 UTC:** speed run of `9da8d2c` against `integration`'s last: Progress first open 2818 → 746 ms, habit
  form first open 2789 → 1441 ms (typing hitches 64 → 17 ms/s), All Habits first 1397 → 256 ms, Privacy 666 → 208 ms,
  New Habit 630 → 304 ms. One regression from the merge, confirmed side by side in the same hour: the Day sheet's add,
  edit and undo, 535 ms/s and 36 freezes against 134 and 2. Cause: the backup's "changed" flag written to
  `UserDefaults` after every change; fixed (`d0a116d`): 64 ms/s, no freezes. Lesson L17. The quit page's open (1.4–2 s)
  is the same on both. `testBigNumbers` passed alone. Today, Undo, Timer and Groups running.
- **1 Oct 23:45 UTC:** Today 8/8, Undo, Timer 2/2, Groups 5/5 pass. **P6 done:** `integration` and `main`
  fast-forwarded to the merged branch (`2beaaec`, then `94748f4`). The speed job had read "failure" on every run
  because two scenarios only open screens; fixed (`cb73f0c`). 
  **Next speed work, in order of daily use:** Today's first scroll (one 250–310 ms freeze), Today's +1 and day
  switch (137 ms/s), Progress's period and range switch (1.1 s, 7 freezes), the habit page's first scroll (1 s),
  saving an entry (0.6–0.8 s), the quit page's open (1.4–2 s, also before the merge), menu pages' opens (200–600 ms).
  The first keyboard of a launch (L18) needs the real iPhone first: on the simulator it's 3–7 s, on phones usually far
  less. Every one of these was the same or worse before the merge.
- **2 Oct 01:30–03:20 UTC (check-in 2; check-in 3 at 06:40, `trig_01R434hhycafwGKY6qa9QpFA`):**
  - Speed runs now time the app's own suspect work (`perfTimed`, a "Timed work" table): Progress's numbers take at
    most 48 ms for a year, so its slow period and range switch is drawing, not counting.
  - Progress: month strips drawn as up to five shapes instead of 31 views and an offscreen pass per row: the
    switch's longest freeze 1,320 → 236 ms (more, smaller freezes: 24 of 100–236 ms; total hitch ~unchanged, next).
  - Today: one sheet per row again (rule 10 had regressed), duration rows keep one clock host across days (rule 4),
    the day's 6/15 redraws alone, offers cleared only when set. Scrolling hitch 46–70 → 21 ms/s; +1 and day switch
    unchanged (~141 ms/s; the helper's next steps: per-habit entry observation, the row's offer lines in a small view).
  - Found and fixed: the demo data put a Call family call inside this week on some weekdays, so on a Friday the row
    started ticked and three Today tests failed on `main` too (seen in the failure screen dump). Today 8/8 again.
- **2 Oct 04:00 UTC:** the user: `analytics` is finished, merge it too. Merged (`5c895cd`, details in Merging the
  Branches T4); testing on `integration` (Analytics, Backup, Persistence, Onboarding, Sync) and on this branch (Today,
  Undo, Timer, Groups + speed; then Progress, New Habit, Tasks, Placement, Widgets, Reminders). `main` moves when all pass.
- **2 Oct 04:30–06:45 UTC:** every app test class passed on the merged code (Analytics' 101 native checks included);
  `main` moved to `976439e`. The user's Apple Developer account is ready (team `MHTC4C9P8F`); the app was signed and
  installed on the iPhone. The iPhone found three bugs the simulator never showed:
  - opening a habit's page from Progress or All Habits crashed (a lazy grid inside a List row; lesson L19): fixed
    with plain Grids (`1452369`), tests running;
  - "on" switches and Select's circles were near-white: now the system green and blue (`951f3e8`), tests running.
  - Sign in with Apple token revocation built (`3618736`; App Review 5.1.1(v)): live on dev, 29/29 live checks.
    Production release and the `APPLE_SIGNIN_KEY` secret wait on the user.
  `main` moves to these once their runs pass. Check-in 4 at 11:51 UTC (`trig_01TfDDShWjY3WHZiNZMzJNa5`), the last.
- **2 Oct 07:55 UTC:** Apple token revocation is live in production and checked on the iPhone: a fresh Apple sign-in,
  then deleting the account, removed Often Enough from the Apple ID's Sign in with Apple list. (The first try failed
  only because the account had been signed in by the older app, which never sent Apple's code.) The `.p8` is kept by
  the user outside the repo.
- **2 Oct 08:30 UTC:** the user checked on the iPhone: habit pages open from Progress and Habits (no crash), switches
  are green, Select's circles blue. Progress's View Options menu fixed (`5e2c7c5`, the green switch style had reached
  its toggles), tests running. Speed work continues, slowly and measured (the user: "take your time"): first, why
  every screen's opening stalls 150–280 ms, with a blank page pushed the same way as the control.
- **2 Oct 11:30 UTC:** `main` and `integration` at `5457ec2`. Speed findings: menu pages open within noise of a blank
  page's push (lesson in PERFORMANCE-LESSONS); the habit form's 1.3 s first opening is the launch's first keyboard
  (2.1 s on the simulator; the form alone 562 ms once, then ~240 ms). **Data safety fixed:** `-uitest` launches used
  the app's own sign-in, backup state, iCloud and folders: on a real iPhone a test run could sync or back up demo
  habits over the person's (`5ec0547`). Backup 8/8, Sync, Persistence, Onboarding, Today pass. Next: the speed run on
  the iPhone (`Tools/perf/measure_perf_device.sh`). **Open:** `testDeletingTheAccountAndErasingThisPhone` sometimes
  hangs ~74 s right after launching with a CI sign-in (4 of 13 runs, 1-2 Oct), before any step; passes on rerun.
- **2 Oct 11:55 UTC (check-in 4, the last):** `main` at `5457ec2`, every test class green on today's code. First
  speed run on the user's iPhone 16: no freeze of 100 ms anywhere; the first keyboard 136 ms (L18 is a simulator
  artifact); what's left is a few per-action hitches (lessons file). Widget tests queued on the latest code (last run
  04:05). Branch checklist updated with the Progress agents' new branches. Next, without check-ins: the typing
  control and Today's split, the widget results, then the per-action hitches.
- **2 Oct 13:30 UTC:** speed, measured on the phone and fixed with timed tables: entry-editor and log-sheet typing
  (the field's binding in its own view, 23.6 → 2–6 ms/s); widgets publish 2 s after the last change (362 → 93 ms of
  projections in the Day sheet test). Redraw counts show each screen redraws only what changed. Widget tests green
  (Lock Screen skipped by design on the simulator). Speed work at diminishing returns; the Progress redesign carries
  the last big one (period switch, 110 ms/s on the phone).
- **10 Oct 2026 12:00 UTC:** `main` at `3110756e` holds `app-lock-privacy-security` (App Lock, Account and Backup & Export, iCloud fixes, free accounts sync one device, Move to Another Device through the server) and `habit-progress-milestones` (the habit Progress tab), merged by the user's one-time decision before the last tests finished, then each fix once its run passed; every class they touch passed, the SE and speed runs included (runs in [Merging the Branches](<../iOS/Docs/Checklists/Merging the Branches.md>)). Both branches and their scratch copies are safe to delete. Server: dev only; production waits for the user's go-ahead. iPhone checks (U9) are the user's.
