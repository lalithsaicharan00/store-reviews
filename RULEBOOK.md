# The Rulebook

Written by Claude (Claude Code), 3 October 2026, at the user's request: "Everything should be in one place, so that
every agent reads it before implementing anything and avoids the same repeating mistakes."

**Every agent (Claude, Codex or any other) reads this whole file before changing anything in this repository.** It
takes about ten minutes. To point an agent here, say **"read the Rulebook"** or **"follow the Rulebook"**; to point at
one rule, use its number ("that breaks S5").

How it works:

- **Every rule that applies to any change is here, and only here.** Each one exists because a mistake was made once
  and cost something. The *why* (measurements, reviews, incidents) is in the evidence linked at the end of each
  section; read it when a reason is unclear or before arguing for a change.
- **Rule groups:** **S** speed · **D** data safety · **U** design and behaviour · **T** testing · **W** how we work.
- **Decisions about one screen** (what it shows, its copy, its layout) are in
  [Design Rules — Don't Regress](<iOS/Design Rules — Don't Regress.md>), one section per screen, and in that screen's
  spec ([iOS/Docs index](<iOS/Docs/README.md>)). Before changing a screen, read its section there too (U12).
- **A rule changes only here,** with the date and the reason. A product rule changes only with the user's say-so.
- **Learned something new** (a mistake, a measurement, a near miss)? Add or sharpen the rule here **the same day**,
  and put the numbers in the evidence file.

## Before a piece of work is done: the checklist

1. `iOS/Tools/perf/check_rules.sh` passes (a second, works on Linux; run it before every push). Never loosen it.
2. The tests for what changed have run and passed, **once, at the end of the piece of work** (T7). A screen or
   `HabitStore` change also gets a speed run (S2).
3. Anything that stores, sends, deletes or moves data meets every D rule.
4. A visual or layout change has been looked at on the real iPhone before it's called done (U9).
5. What you learned is written down: rules here, numbers in the evidence, the user's points ticked in their checklist.

---

## S — Speed (top priority: a change that makes the app slower is not finished, however it looks)

**Targets** (GitHub's simulator, a year of history): hitch time under **5 ms/s** while scrolling, tapping or typing;
**no freeze of 100 ms** or more; **opening a screen adds under 50 ms** to a blank page pushed the same way in the same
run (the hosted simulator's push alone is 120–200 ms; the iPhone 16's 45–85 ms). **The phone has the final word.**

| # | Rule | The mistake behind it |
|---|---|---|
| S1 | **The phone build is optimised.** The user installs *Debug* from Xcode, so Debug keeps `SWIFT_OPTIMIZATION_LEVEL = -O` and `KOTLIN_FRAMEWORK_BUILD_TYPE = release` | Every screen ran several times slower unoptimised (L1) |
| S2 | **Measure; never judge speed by eye, screenshots or reasoning.** Speed runs (`[ios-perf]`): the app drives itself (`PerfDriver`, a scenario per screen and interaction, handled with `.onPerfCommand`), records its own stalls (`MainThreadMeter`) and times suspect work (`perfTimed`, the "Timed work" table). Never measure through XCUITest. Typing goes through the focused field's `insertText`/`deleteBackward`, never by replacing the Binding | Screenshots and XCUITest showed freezes that weren't there and hid real ones (L2, L3) |
| S3 | **Only the smallest view that shows the time ticks** (a running row's clock, the timer bar, the player's clock). Never a `TimelineView`, `Timer` or ticking `@State` around a screen or list, not even once a minute: keep the time in `@State` and move it with a `.task` that sleeps until the next moment that matters | Today redrew every row every second; a once-a-minute ticker made scrolling 55 % busy (L4) |
| S4 | **A `TimelineView` is anchored at a fixed date**, never `.now` or `.distantPast`, and a view never switches between a `TimelineView` and a plain view (pause = a schedule that never ticks) | The app froze; the player's circle faded on Pause (L5) |
| S5 | **Anything that walks days or history is worked out once in `HabitStore` and remembered** (`streak`, `bestStreak`, `daySummary`, `placements`); never in a view's `body`. Read one habit's entries (`entries(of:)`), never every entry. Change entries only with `insertEntry` / `removeEntry(at:)` / `replaceEntry(_:at:)`. Keep the coalesced `entries` notification (one per main-actor turn) and the in-place `_modify` accessor | One tap recalculated every row's streak over a year (L6) |
| S6 | **Keep what a redraw touches small.** State that changes while scrolling lives in its own small `@Observable` read only by the view that needs it. A value read by every row is read in the smallest view that uses it. A covered screen stops drawing and its clocks pause. Stable view identities: never `.id(UUID())` | Each row's appearance rebuilt Today; Today redrew behind the player and under menu pages (L9, L15, L16) |
| S7 | **A tap changes the screen at once; the database write follows** (`addLogged`, `removeLogged`, `toggleTimer`). On a failed write, reload and say so. Never make a tap wait for storage | Quick taps landed on the old state (L14) |
| S8 | **`body` stays cheap:** no sorting or filtering of history, no `Calendar` arithmetic in loops (`LocalDay.adding(days:)`, `weekday`), no formatter or big string built per row (make it once and keep it) | A `NumberFormatter` per number was most of a row's time (L7) |
| S9 | **In a `List` with a selection, use `NavigationLink { Page() } label: { … }`**, not `NavigationLink(value:)` | The habit page never opened from All Habits |
| S10 | **Rows stay light.** A shadow only on a background shape, never on text, never a `.clear` shadow; one `.sheet(item:)` per row; no `GeometryReader` just to size a fill (`scaleEffect(x:anchor:)`); **no `ViewThatFits` in a row** (it lays out every option; choose the layout from `dynamicTypeSize` instead) | Every Today row paid an offscreen pass, four sheets and a geometry pass (L13); the after-log line's `ViewThatFits` doubled the cost of changing days (L21) |
| S11 | **Typing updates only the field.** The typed text lives in a small `@Observable` read only by the field, **and the field's binding is made in the field's own view** (`DraftTextField`, `NameField`). The form reads only "is it valid / is there a name". Anything that follows the text catches up when typing pauses (0.3 s); saving reads the live text. Never animate per keystroke | The habit form rebuilt per letter (92 % busy); the entry editor cost 24 ms/s against a bare field's 0 (L8) |
| S12 | **Charts are drawn in one pass** (`LightBarChart`, `LightLineChart`: one `Canvas`, every bar for VoiceOver, a chart descriptor for Audio Graphs). No Swift Charts in a screen that scrolls | A 1–2.7 s freeze the first time the habit page reached its chart (L10) |
| S13 | **Never a lazy grid (`LazyVGrid`/`LazyHGrid`) inside a `List` or `Form` row.** Use a plain `Grid` sized up front; lazy grids only in a `ScrollView` | Opening any habit's page crashed the app on the iPhone (L19) |
| S14 | **Ids in one lazy grid are one type** (an enum: `.weekday(i)`, `.place(i)`), and cells whose places are fixed are keyed by position, not content | Days 1–6 of every month were never drawn; cells slid on a month change (L11, L12) |
| S15 | **No `UserDefaults` write on every data change.** Write only when the value changes, or keep it in memory and save on leaving the app | The Day sheet: 535 ms/s and 36 freezes (L17) |
| S16 | **Work set off by every data change waits until the changes stop.** Widgets publish 2 s after the last change (and at once when the app goes to the background); reminders re-plan 300 ms after. Nothing heavy runs per tap on the main thread | The widgets' month projection ran on every tap: 362 ms, up to 118 ms each (2 Oct) |

**Finding a slow spot:** time and count before changing anything (`perfTimed`; "Count: …" redraw counters); measure a
control in the same run (a blank page, a bare text field); bisect with scenario variants when profiles disagree (a
profile on the shared Mac can lose 60 % of its samples); look at *when* a freeze happens (opening, first scroll, after a
tap); measure first openings on their own; repeat a surprising number (hosted runs vary 2–3×); test with a year of
history; and confirm on the phone (`iOS/Tools/perf/measure_perf_device.sh`). Keyboards are judged on the phone only (the
first keyboard is 136 ms there, 2.1 s on the simulator: L18).

*Evidence:* [PERFORMANCE-LESSONS.md](iOS/PERFORMANCE-LESSONS.md) (lessons L1–L19 with every number, the iPhone
results, what's still open) · `iOS/Tools/perf/` (scripts) · the speed tables on the `ci-results` branch.

---

## D — Data safety (people's data must never be lost)

| # | Rule | Why |
|---|---|---|
| D1 | **The phone's own database is the source of truth; everything works offline.** The server only syncs and backs up | Online-only apps lose people the moment the network or server fails |
| D2 | **Every database upgrade is tested from every past version, keeps a copy first, and never resets on error** (a column added only if missing; `MigrationTest`) | An update that wiped data is the most damaging failure in 1.5 M reviews (53.9 % 1★) |
| D3 | **Signing in merges and never deletes.** An unknown sign-in never quietly creates an account (`create: true` only after "Create account"); show which account before merging | Sign-ins that wiped or swapped data |
| D4 | **Backup is automatic, on by default, free and visible** ("Backed up 2 min ago"), and counts only when the copy is read back and checked (server or iCloud, by checksum) | Backups that were hidden, manual, paid or silently broken |
| D5 | **Restore is round-trip tested; every export can be imported; a restore keeps an undo file** (30 days) | Restores that failed or brought back half |
| D6 | **Deleting is archiving, with undo.** Schedules and goals change from an effective date and keep their past; streaks are computed from records, never stored | Edits that rewrote history; streaks reset wrongly |
| D7 | **A day is the local calendar day at the moment of logging.** Day start and week start apply everywhere or nowhere; never subtract hours from a moment | Check-ins moved to the wrong day on time-zone and daylight-saving changes |
| D8 | **A test launch never touches the person's data.** `-uitest` runs on an in-memory database, signed out as its own store ("uitest"), with its own backup state and folder and no iCloud. Anything new that stores or sends data does the same for test launches | A test run on the iPhone could have synced or backed up demo habits over the person's own (found 2 Oct) |
| D9 | **Deleting an account removes everything, in a safe order** (the directory first, then the data, backups, snapshots), revokes Sign in with Apple, and erases this phone only if the person chooses | App Review 5.1.1(v); people who couldn't get rid of an account |
| D10 | **Data is never held hostage:** backup, export and sync of what someone has are free, and an ended purchase never hides data | Paywalled data drove 1★ reviews |
| D11 | **Secrets never go in the repository or a chat.** Keys go in with `wrangler secret put`; the `.p8` stays with the user; the server never logs request bodies or tokens. **The repository is public**: no secrets, no other apps' or designers' images in git | — |

*Evidence:* [Data Safety — Every Way Users Lose Data, and the Rules That Prevent It](<Research/Research Reports/Data, Sync and Accounts/Data Safety — Every Way Users Lose Data, and the Rules That Prevent It.md>)
(Part 1: the 15 worst failures; Part 5: rules 1–17) · [Data Safety, Accounts and Sync](<Architecture/Data Safety, Accounts and Sync.md>)
(the architecture) · [server/README.md](server/README.md) (accounts, deletion, Apple sign-in revocation, releases).

---

## U — Design and behaviour

| # | Rule | Why |
|---|---|---|
| U1 | **Native iOS only:** SwiftUI components, SF Symbols, system fonts; light and dark; Dynamic Type up to the accessibility sizes; a VoiceOver label on everything that means something | The app is meant to feel like part of the iPhone |
| U2 | **Colour belongs to the habits; the chrome is monochrome.** Switches are the iPhone's green and edit-mode selection its blue (the ink tint is unreadable on them in dark mode). A `Toggle` inside a `Menu` sets `.toggleStyle(.automatic)` | Near-white switches; menu toggles that stopped responding (2 Oct) |
| U3 | **Nothing counts against anyone.** Never red; never "missed", "failed", "relapse", "reset", "due" or "overdue". Skipped, paused and not-its-day days are neutral | Shame language drives people away |
| U4 | **Nothing on Today moves during a run of taps** (`TodayLayout.hold`; things settle 1.5 s after the last tap); feedback comes from the tap, never from a redraw | Rows jumped under people's fingers |
| U5 | **A new feature never removes an old one** without listing what the old view showed and keeping each item, or saying why it goes | Adding ▶ deleted "N left" |
| U6 | **Text:** names and checklist items 24 characters, times of day 16, units 12 (`TextLimit`, `limitText`); never `.fixedSize()` a text field; every typing field stays above the keyboard. A value cut back while a field is changing is put back on the next turn, or the field keeps showing what wasn't kept | Clipped and hidden fields; a name field showed 39 letters while 24 were kept (3 Oct) |
| U7 | **Never put `.toolbar`, `.onChange` or `.task` on a Form `Section`** (it repeats per row); a pushed screen keeps its own `@FocusState` | Four Next buttons on one keyboard |
| U8 | **One app, one set of IDs:** Often Enough, `com.oftenenough.app` ([App Identity](<Architecture/App Identity — Name, Domain and IDs.md>)); replace any leftover `com.lalithsaicharan.habits` | Mixed IDs break signing, widgets and purchases |
| U9 | **Check every visual or layout change on the real iPhone before calling it done** | The habit-page crash and the unreadable switches never showed on the simulator (2 Oct) |
| U10 | **Progress only reads; its overview counts habits, not ticks** | It must agree with Today's day bar |
| U11 | **Words:** say it the way people do ("Log time manually", "For today", "Planned for Wed 1 Oct"); see Design Rules' "Words the app never uses" | Copy that confused people |
| U12 | **Before changing a screen, read its section in Design Rules and its spec** | Per-screen decisions that agents undid |
| U13 | **Order is the person's own.** Nothing reorders itself: not reminder times, a new day, a sync or an edit. New habits and tasks go to the end of their section; sorting is a one-off action; **done habits move below the rest, only after the pause** (U4; the user's final call, 3 Oct 2026, after a day of "stay in place"; Appearance → Done Habits → Stay in Place keeps them where they are). Timed sections follow their times; Anytime and Quitting are placed by the person (the user, 3 Oct 2026) | 35 of 179 order reviews: "the app reshuffles my list" (report 27). 90 of 243 want done rows to sink, 7 kept (report "Ticking Off"): the default sinks, the option keeps |
| U14 | **A row's gestures follow one model, the iPhone's own.** Tap the round control to act, the row to open (its Day sheet, for the day shown). **✓ toggles that day's tick; + adds and never takes back** (a habit counted several times a day is a +1 counter). Swipes *reveal* labelled buttons: left Note, Skip, Pause; right a named Undo. Only a harmless action (Note) runs on a full swipe. **Undo always names what it takes back** ("Undo +1 glass"), one entry, never the day. **Delete is never on a swipe or in view**: it's in a ⋯ menu that asks first and offers Archive | Can't un-check (33 reviews, 2.97★), a second tap doing something else (15, 2.80★), swipes that act unseen (35 accidental, 14 "which way"), deletes too easy (79) yet unfindable (63): report "Today's Rows", 3 Oct |
| U15 | **In the Day sheet, Skip and Undo skip keep one place.** Skipping changes only that day's state: the Skip button becomes Undo skip where it was. Keep the usual logging controls visible but disabled; keep saved logs and the day note visible and the note editable. Never move Undo skip into the logging control or delete records as a side effect | The user's 4 Oct design review: moving Undo hid the action's origin and made the note and progress disappear |
| U16 | **Day-sheet action emphasis follows the goal.** Quick and manual logging controls use equal native-size hit areas, with style expressing priority. Positive goal actions such as Mark done, Add 1 glass and Start timer may be prominent; logging toward an at-most limit or recording a slip stays plainly available without a prominent invitation | The user's 4 Oct design review: a filled Add 1 cup for an at-most-2-cups goal suggests the wrong next action |
| U17 | **Day-sheet spacing shows what belongs together.** Keep the selected-day state close to its logging controls and any log heading close to its records. Give the whole day-activity group larger outside margins before the habit identity and note; separate the note from Skip/Undo skip. Use gaps between elements, not larger card padding, and adapt them for Dynamic Type | The user's 4 Oct spacing review: equal gaps made every element read as one section despite different jobs; [spacing study](<Research/Research Reports/Day Structure and Organization/Day Details and Entry Editor Handoff/The Habit Day Sheet — Wording, Hierarchy and Actions.md#spacing-and-grouping-4-october>) |
| U18 | **The Day-details sheet dismisses with the standard Close icon.** Its actions save when tapped, so use the SF Symbol `xmark` as an icon-only toolbar control with a 44 pt hit region and accessible name **Close**. Keep the selected-day title centred between equally sized leading ⋯ and trailing Close targets. Preserve text Cancel/Save/Done in editors that have a draft or completion step | The user's 4 Oct close-control review; Apple's toolbar and sheet guidance, documented in the [Day-sheet study](<Research/Research Reports/Day Structure and Organization/Day Details and Entry Editor Handoff/The Habit Day Sheet — Wording, Hierarchy and Actions.md#close-icon-in-the-day-sheet-4-october>) |
| U19 | **Edit one saved record only where it has an independent fact to correct.** Amount records expose their value and unit; duration records expose tap-to-type hours/minutes/seconds, including decimal seconds; a multi-check record can edit its integer count; a quit slip edits **when it happened**, date and time in its recorded zone. Single done checks, one-check records, checklist steps and one-time tasks correct through named Day-sheet controls instead of a redundant “Times 1” editor. Keep day/source as context, never imply that saving changes the whole day. **Delete this log/slip is a distinct native button near the editor bottom, with no divider above it; tapping it opens a native confirmation pop-up before removing that one record.** Keep it separate from Save and confirm while no durable one-record Undo exists. Moving a slip to another tracking day must atomically update the same record ID, timestamp, day indexes and quit run, then show its destination day; never offer a Date picker that silently fails to save | The user's 4 Oct Entry-page, time-edit and Delete-placement reviews, the 47 habit-app reviews about correcting one amount/time record, and the [single-record editor study](<Research/Research Reports/Day Structure and Organization/Day Details and Entry Editor Handoff/Editing One Habit Log — Scope, Fields and Recovery.md>) |

*Evidence:* [Design Rules — Don't Regress](<iOS/Design Rules — Don't Regress.md>) (every screen's decisions, with the
research behind each) · `Research/Research Reports/` (the research, [index](<Research/Research Reports/README.md>)).

---

## T — Testing

| # | Rule | Why |
|---|---|---|
| T1 | **Builds and tests run on GitHub Actions, never on the user's MacBook** (battery); cloud sessions are Linux, with no Xcode. `[ios-ci]` and `[ios-perf]` in a commit message, or run the workflow with `tests`, `perf` and `scenarios`. **Minutes are free and unlimited** (public repo), but a job stops at 60 minutes, and a branch keeps only **one** waiting run (a third cancels it). Results: `git fetch origin ci-results && git show origin/ci-results:latest.md` | Runs lost to cancellation; the user's battery |
| T2 | **A failing test is never assumed to be a flake.** Read its log and screenshots first; rerun once only to confirm; a second failure is real. Never skip, disable or loosen a test to get green | Two "flaky" tests were real bugs (2 Oct: a menu's toggles, an off-screen button) |
| T3 | **When a label changes, update the UI tests that tap it in the same change.** Test typing key by key, at the real iPhone size, with the keyboard up | Tests that passed while people saw nothing |
| T4 | **Every new screen or interaction gets a `PerfDriver` scenario** when it's built (S2) | A screen with no scenario has no speed: two froze unseen |
| T5 | **On the iPhone:** speed with `iOS/Tools/perf/measure_perf_device.sh`; UI tests only with test launches (D8) | The phone is where people feel it |
| T6 | **The server:** `npm test` and `npm run typecheck` pass; deploy to dev and run the live checks; production only through `npm run release:production` (gradual, checked, rolls back), with the user's go-ahead | — |
| T7 | **Test once per piece of work, not after every change** (the user, 3 Oct 2026). While building, push without `[ios-ci]`; when the item is done, run the test classes it touches (and a speed run if it changed a screen or `HabitStore`) in one go, fix what fails, and only then move `main` | Runs after every small change cost hours of waiting for little |
| T8 | **A test leaves nothing behind for the next one.** Every test launch (`-uitest` or `-dbname`) resets any saved setting a test can change (Today's filters, Progress's options); a test that changes one is never the only thing turning it back. A failing test's saved state must not fail the tests after it | One test failed with Hide Completed on, and the saved switch failed the four Today tests after it (3 Oct) |
| T9 | **An accessibility id on a container needs `.accessibilityElement(children: .contain)`**, or SwiftUI gives every control inside it the container's id. **Traits, a default action and a hint are worse:** on a container they merge its texts into one element, so names stop being text. Give a container only *named* actions (`.accessibilityAction(named:)`). And `reveal` scrolls the *first* list on screen: in a sheet, that can be the screen behind it, so scroll the sheet's own content | The quit card's id replaced Log a Slip's; a New Habit test scrolled Today behind the form; a row's button trait turned every name on Today into a button and failed 17 tests (3 Oct) |
| T10 | **Coordinate CI before starting tests; ordinary pushes stay untagged** (the user, 4 Oct 2026). Ordinary documentation/work-in-progress commits have no CI/performance trigger tags; they may be pushed while tests run because the iOS job is skipped before its job-level concurrency applies. Add `[ios-ci]`, `[ios-perf]` or `[ios-perf-xctest]` only when deliberately starting the required validation. **Before a tagged push, workflow dispatch or rerun, inspect live repository-wide Actions runs and jobs. If another agent's tests are queued, waiting or running, wait for them to complete, then check again immediately before starting yours.** Do not rely on the user to remind you, a fixed delay, branch names or a stale `ci-results` summary. If ownership is unclear, treat the active tests as another agent's; if live status is unavailable, do not start more tests until it can be verified. Never cancel or replace someone else's run to make room. **Avoid `[ios-widgets]` for now:** it sets `cancel-in-progress`; use it only after explicit user authorization and after confirming it cannot cancel another agent's work. The workflow reads the pushed head commit's full message, so keep trigger/cancellation tags out of ordinary subjects, bodies and merge messages. Recheck the actual workflow if its behavior changes. This applies to every agent, regardless of provider | Skipped ordinary pushes must remain safe; new test runs can replace a waiting run, and the widget tag can cancel an active run |

*Evidence:* [.github/workflows/ios-tests.yml](.github/workflows/ios-tests.yml) (the header explains every option) ·
[iOS/README.md](iOS/README.md) (building, signing, the iPhone) · [server/README.md](server/README.md).

---

## W — How we work

| # | Rule |
|---|---|
| W1 | **Write every point the user makes into a checklist before starting** (`iOS/Docs/Checklists/`), and tick each one as it's done. The user's running list is [Current Work Checklist](<iOS/Docs/Checklists/Current Work Checklist.md>); broader capabilities and dated build history are in [Product Roadmap](<iOS/Product Roadmap.md>). For overlapping items, the current checklist owns the current status. **Fix existing issues before starting later feature work** (the user, 4 Oct 2026); retain original item numbers and record validation evidence before marking work complete |
| W2 | **Research before building.** Reports in plain English, opening "Written by …, date", added to the research index. Never type a review ID from memory; say "users show…", never "a competitor does it". Research rules: [Research/CLAUDE.md](Research/CLAUDE.md) |
| W3 | **One branch per agent.** Never commit to another agent's branch or touch its untracked files. `main` moves only to commits whose tests passed. Which branches can go: [Merging the Branches](<iOS/Docs/Checklists/Merging the Branches.md>) |
| W4 | **Commit only when asked** (or when the task you were given says to). Scratch files go in `Research/Temp/` (ignored by git), never `/tmp` |
| W5 | **Record what you learn the same day:** a rule here, the numbers in the evidence, progress in the plan ([Merge and Hardening](<Architecture/Merge and Hardening — Plan and Progress.md>)) |
