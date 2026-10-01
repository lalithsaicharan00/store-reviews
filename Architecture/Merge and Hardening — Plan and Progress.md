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
| P4 | Merge `integration` into `claude/server-and-sync`, resolving every conflict keeping both sides (the Status note §2 checklist: sync schema renumbered to 7, `entry.source` synced, new write paths through `SyncWriter`) | — |
| P5 | Run everything: server (129), Core JVM + sync (JVM, JS), the website check, iOS build + the UI suite in halves on GitHub, `check_rules.sh` | — |
| P6 | Move `integration`, then `main`, to the merged result; update the branch checklist | — |
| P7 | Performance: measure every screen with the app-driven runner (`[ios-perf]`), fix every regression and the known slow spots (opening a screen 500–1,300 ms, Today's first scroll 180–440 ms) | — |
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

## Progress log

- **1 Oct 18:10 UTC:** P1–P3 done.
