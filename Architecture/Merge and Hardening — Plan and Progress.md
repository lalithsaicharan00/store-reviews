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
| P5 | Run everything: server (129), Core JVM + sync (JVM, JS), the website check, iOS build + the UI suite in halves on GitHub, `check_rules.sh` | Server 129/129, Core (JVM + sync JVM/JS, 7 migration tests), website 21 checks, `check_rules.sh`: pass. iOS `1218890`: 25/27 (Sync, Persistence 4/4, Onboarding 6/6, Today 8/8, Backup 6/8: two checks looked below the fold, fixed in `670d321`); rerun with speed runs going |
| P6 | Move `integration`, then `main`, to the merged result; update the branch checklist | — |
| P7 | Performance: measure every screen with the app-driven runner (`[ios-perf]`), fix every regression and the known slow spots (opening a screen 500–1,300 ms, Today's first scroll 180–440 ms) | In progress. Done (`6d04d35`, `69e2227`, `943e4e5`): quit rows tick only their two times (the whole row re-walked its history every second); a habit's runs remembered for today (one walk after a save, not two); the habit form builds sub-screens when opened (it built every one, three whole forms on the type question); Privacy's Face ID check off the main thread; Progress's weekday names once; backup and sync files off the main thread. Next: the first keyboard of a launch (habit form 2.8 s, entry editor 1.3 s), Progress's first open (2.8 s; bisect), keeping Progress's snapshot between opens |
| P8 | Data robustness: migrations from every shipped schema, restore/merge, sync, low storage, kill mid-write; widgets reading the shared store | — |
| P9 | Bugs: the older failing UI tests (Focus player, Routine Calendar, Goal flow, Schedule), anything found on the way | — |

## Branches

| Branch | State | Safe to delete? |
|---|---|---|
| `claude/server-and-sync` | Being merged (P4) | After P6 |
| `claude/serene-wright-mcvmrx` | Nothing beyond `main` (this session's starting branch) | **Yes** |
| `claude/free-plan-data-safety`, `claude/pensive-bardeen-ou4hiw` | Fully inside `claude/server-and-sync` (checked 1 Oct) | **Yes** once server-sync is in `main` |
| `analytics` | Codex, still being worked on | **No**: it merges `main` itself when ready |
| Everything else | See [Merging the Branches](<../iOS/Docs/Checklists/Merging the Branches.md>) "Branches to delete" | As listed there |

## Still to do that needs the user (from the Status note, 1 Oct)

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
