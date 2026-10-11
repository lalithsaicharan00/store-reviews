# Apple Watch — Design Notes

Written by Claude (Claude Code), 10 October 2026. The text that goes with the pictures in this folder: the decisions
made before drawing, how the app navigates, and a note for every screen. Drawn at Apple Watch Series 10 · 46 mm
(208 × 248 points), dark as watchOS always is. The pictures use SF Pro (SF Compact isn't installed in the design tool);
the app uses the system's own SF Compact. Mockups show hierarchy and behaviour; native SwiftUI components decide the
final pixels, and the real Watch has the last word (U1, U9).

Rule numbers: U, S, D, T and W are the Rulebook's; WA1–WA13 are in [the Watch report](<../Research/Apple Watch App — What People Want, What Breaks, and How Ours Works.md>) §5.2;
R1–R9 in [Running a Routine on the Watch](<../Research/Running a Routine on the Watch — Can It Be Done.md>) §5.

## The pictures

| Picture | What's in it |
|---|---|
| [0 · Decisions](<0 · Decisions — what’s on the Watch, and how it navigates.png>) | What's on the Watch and what stays on the iPhone; navigation (the same text as below) |
| [A · Today](<A · Today.png>) | A1 opening the app · A2 the whole list · A3 after a tap · A4 all done · A5 nothing planned · A6 first launch · A7 no habits yet |
| [B · Day details](<B · Day details (tap a row), today only.png>) | B1 amount · B2 scrolled, today's logs · B3 log manually (an amount) · B4–B5 check · B6 time · B7 running · B8 wrist down · B9 checklist · B10 quit · B11 one log · B12 delete asks first · B13 ⋯ More · B14 skipped · B15 log manually (time) · B16 an amount that asks how much · B17 decimals from the last value · B18 saying or typing a number |
| [C · Running a routine](<C · Running a routine.png>) | C1–C3 one habit per page · C4 the routine's list · C5 done · C6 closed with a timer running |
| [D · Notifications](<D · Notifications and alerts.png>) | D1 amount reminder · D2 check reminder · D3 a timer reached its goal · D4 names hidden |
| [E · Watch face and Smart Stack](<E · Watch face and Smart Stack.png>) | E1 complications · E2 logging from the face · E3 while a routine runs · E4 Smart Stack · E5 names hidden · E6 choosing a complication |
| [F · How the screens connect](<F · How the screens connect.png>) | The navigation map |
| [G · Plus on the Watch](<G · Plus on the Watch.png>) | G1 without Plus (and scrolled) · G2 Apple's purchase sheet · G3 Plus is yours · G4 waiting for approval · G5 couldn't reach the App Store · G6 Plus ended · G7 our complication without Plus |
| [H · Added after the cross-check](<H · Added after the cross-check.png>) | H1–H3 limits · H4 a week goal · H5 tasks · H6 skipped and paused · H7–H8 a slip · H9 milestone · H10 streak · H11–H12 alarms · H13–H15 more reminders · H16 Siri · H17 controls · H18 couldn't save · H19 42 mm · H20 larger text |

## What the Watch does, and what stays on the iPhone (decided before drawing)

**On the Watch: today, in seconds**
- Today: today's habits and tasks, in Today's own order and sections; done ones sink after the pause (U13, U4).
- Log the way Today does: ✓ toggles today, + adds the habit's step ("+1", "+250"), ▶ starts or pauses a timer, steps tick one by one, a slip is recorded plainly (U14, U16).
- Log manually with the Digital Crown (no number pad).
- Undo the last log by name; remove a log (asks first).
- Skip today and Undo skip.
- Run a routine (any time-of-day section) with the player, the Watch alone (R1–R9).
- A quit habit's current run.
- Reminders with their Done / +1 buttons; the alert when a timer reaches its goal; the iPhone's alarms (Apple shows them on the Watch).
- Watch face and Smart Stack: complications and widgets that log.

**Only on the iPhone: set up, look back, change**
- Add, edit, archive or delete habits and tasks: goals, schedules, units, steps, icons, colours.
- Sections, order, what's in a routine.
- Reminder times and words.
- The habit page: History, Progress, streak details, notes, any day but today.
- Settings: day start, week start, appearance, App Lock, backup, iCloud.
- Plus Family (the Watch itself sells Plus, G).
- Which habit a complication shows is chosen in Apple's own watch-face editor, not in our app.

**Left off the Watch on purpose**
- No statistics or charts: the Watch is for a glance and a tap.
- No sign-in, no settings screen, no onboarding on the Watch (WA12).
- No notes, no typing of names: notes and names stay on the iPhone.
- No past days: the Watch is today only (the wrong-day failures, WA5).
- No "complete all" button (WA8).
- Nothing that waits for the iPhone to show something (WA1).

**Follows the iPhone by itself**
- Names, colours, icons, goals, units, order and sections.
- Day start and week start, so "today" is the same day on both (D7).
- "Hide names outside the app": complications show counts only and notifications the person's own words; their buttons still log.
- Plus: the Watch reads the same App Store purchase; nothing to restore.

## Navigation: the way people already move on Apple Watch

**Structure**
- One stack with one large title: the app opens on Today (NavigationStack; Apple: "Minimize the depth of hierarchy"). Not a split view (there's one list, not peers) and not tabs (one main job).
- Two levels at most: Today → Day details → Log manually or one log.
- Back is the system's glass ‹ at the top left, and a swipe from the left edge. The time stays top right. Titles and buttons sit inside the rounded corners.
- A routine is a mode, like a workout: it covers the screen and closes with ✕ at the top left. Leaving keeps everything (R2).

**The Digital Crown and touch**
- The Crown scrolls Today and Day details (today's logs are below the dial).
- In a routine the Crown moves between habits: one habit per vertical page, page dots beside the Crown. Moving never logs or skips (R5).
- Every Crown action has a touch backup: swipe the page; the routine's list (bottom left) jumps to any habit.
- Log manually: the Crown turns the number; − and + do the same by touch; tap the number to say or type it.

**Where actions sit**
- A list row: tap the round button to act, tap the row to open Day details (U14, WA6).
- A section header: ▶ starts that section's routine (filled in the Now section, grey in the others, none for Quitting).
- Day details (a dial view, as Apple's Timers): the one main action in the middle of the bottom bar, white like the iPhone player's ink; Log manually (pencil) and ⋯ in the bottom corners.
- After a log, "Undo +1 glass" appears right where the tap was (U14).
- Double Tap presses the page's main action (one per screen); on lists it scrolls, as watchOS does by itself.

**Feel**
- Nothing moves under a finger: rows hold their places through a run of taps and sink 1.5 s after the last (U4).
- Colour belongs to habits; the chrome is monochrome (U2). A running timer tints the whole page in its habit's colour (Apple: colour can show state).
- Haptics: a tap gives the system's click; a goal met gives success (the completion sound's place).
- Always On: with the wrist down a running timer shows minutes, not seconds, and dims.

## A · Today
- **A1** Opens straight on Today from the Watch's own database (WA1). Large title and time sit inside the rounded corners. The day bar counts habits, not ticks (U10). Every section has its own ▶: filled in the Now section, grey in the others; Quitting has none. Rows use the iPhone's own line: "3/8 glasses", "12/20 min", "2/5 steps", "Every day" for a single tick, "Skipped today".
- **A2** The whole scroll. Each round button does what Today's does (U14): ▶ starts the timer, ✓ toggles today, +1 / +500 add the saved step, ☰ opens the steps, ↗ opens the quit habit. Done rows sit below the rest of their section after the pause (U13).
- **A3** +1 fills the row at once and the write follows (S7). "Undo +1 glass" appears where the finger is and names what it takes back (U14). Nothing moves during a run of taps (U4).
- **A4** The day bar fills; a finished section shows ✓ instead of ▶. The success haptic played when the last goal was met.
- **A5–A7** Nothing planned (neutral, U3). First launch says what it's waiting for and never "no habits" before hearing back (WA2). No sign-in or setup on the Watch (WA12).

## B · Day details (today only)
- **What it is** The Watch's version of Day details, the sheet a Today row opens on the iPhone, for today only: progress, the main logging action, today's logs, Skip today. Not the habit page: History, Notes and Progress stay on the iPhone. No notes on the Watch, neither adding nor reading.
- **B1** A dial, centred between the header and the bottom bar. One main action in white (the iPhone player's ink); the pencil "Log manually" and ⋯ More in the bottom corners. Double Tap presses the main action. Never a "complete the day" button (WA8).
- **B2** The Crown scrolls below the dial: up to three logs (four or more: the two newest and "All 4 logs ›", U17), Skip today last and plain.
- **B3** Log manually, an amount: the value has the Crown's focus; − and + do the same by touch. The unit sits under the number (U22).
- **B4–B5** A check marks today in one tap; done fills the ring in the habit's colour and the main action becomes a named Undo in glass (U14).
- **B6–B8** The timer is a start time in the database, shared with the iPhone (WA10, R4). Running tints the page in the habit's colour; with the wrist down it dims and shows minutes. An alert is scheduled for the goal (R3). Never a workout.
- **B9** A checklist is a list: tap a step to tick it. The ring fills only when all are done. Undo says "Undo last step" (U14).
- **B10** A quit habit shows its current run and best (U25). Record a slip is available but not invited: glass, not white (U16). Never red, never "reset" (U3).
- **B11–B12** A log shows what, when and where from (U19). Editing is on the iPhone; Delete is plain red text and asks first, naming what goes; the view goes back before the log is removed (U27).
- **B13–B14** ⋯ holds only what this habit can do here. Skipped is neutral: the logging control stays in place but off, Undo skip sits on the page (U15).
- **Log manually** On the Watch for amounts and times, in the iPhone's words: "+1 glass" beside the pencil "Log manually" (B1), "Start" beside "Log manually" (B6), and "Log amount" as the main action when an amount asks how much every time (B16). For some habits it's the only way to log.
- **B15** Time: hours and minutes wheels, as in Apple's own Timers; the Crown turns the focused wheel. Ends now ("Finished now, 10:09"); a different time of day is set on the iPhone (U19). No seconds on the Watch.
- **B16–B17** An amount that asks how much opens at the last value logged, so most entries are a short turn: decimals step by one decimal place (72.4 kg); the last value and its day are shown.
- **B18** A number far from the last one: tap it to say it or type it with Apple's own input (dictation, Scribble, the keyboard on larger watches). We draw nothing here.

## C · Running a routine
- **C1–C3** Any section's ▶ opens its unfinished habits one at a time (the iPhone's rule). One habit per vertical page; the Crown or a swipe moves and never logs or skips (R5). When a goal is met the main action becomes Next, or Finish on the last.
- **C2** Started here or on the iPhone, it's the same timer. Wrist down, app suspended or the Watch restarted: reopening shows this page and the right time (R2).
- **C4** The bottom-left button: the touch backup for the Crown. Tap a habit to jump to it; nothing here logs.
- **C5** Everything was saved as it happened (R9), so Done only closes. Anything left is "still open on Today", never "missed".
- **C6** ✕ never stops a timer or loses the place: the section's ▶ resumes it, and the running row ticks.

## D · Notifications
- **D1–D2** As on the iPhone: the habit's name, then the person's "Reminder says…" words or today's line; "Not done yet · …" for a Remind Again. The habit's own action: Done for a check or task, "+1 glass" for an amount; timers and checklists have none (no misleading Done). Saved with the same ID wherever it's pressed (WA13, D13). Dismiss never logs. Several reminders at one time come as one: "Morning · Water, Vitamins, Read +2".
- **D3** The iPhone's own words: "20 min done. The timer keeps going until you stop it." (a limit: "That's your 20 min limit for today."). A scheduled notification, made by the device that started the timer, so it arrives once and never depends on the app running (R3). Stop timer is new on both devices (proposed).
- **D4** With "Hide names outside the app" on, as on the iPhone: "Reminder · 8:00" and the person's own words, never the name; the buttons still log ("Done", or "+1" without the unit).

## E · Watch face and Smart Stack
- **E1** Rectangular: the day bar and what's left in the person's order. Circular: a ring to the goal, a check's icon, a quit run. Drawn from the Watch's own snapshot, so the face never lies (WA11).
- **E2** Up to three habits, each a button that does exactly what it shows (U26); the system asks first when a tap looks accidental.
- **E3** While a routine or timer runs: the current habit and time left (R7).
- **E4** A timer started on the iPhone already shows as its Live Activity; tapping it opens the routine at that habit (R8). Our widget lists what's next with its buttons.
- **E5–E6** Names hidden: counts only, no names, icons or colours; the buttons still log, as the iPhone's discreet widgets do. Which habit a complication shows is chosen in Apple's own face editor.

## G · Plus on the Watch
- **G1** Shown when the Watch app opens without Plus (the moment of need; never a launch prompt on the iPhone). State first, then the offer (W6): what the Watch does in one line, then "Get Plus · $24.99" with the App Store's own price (`displayPrice`). Scrolling shows Continue on iPhone (Handoff to ≡ › Plus there), "One-time, no subscription", and Restore Purchases, always on the page (Apple 3.1.1). Plus Family is chosen on the iPhone. Reminders still reach the wrist for free: watchOS mirrors the iPhone's notifications without our Watch app.
- **G2** Apple's own purchase sheet (StoreKit's `purchase(options:)`, watchOS 8 and later); we don't draw it. The person confirms with the side button.
- **G3** Bought here or anywhere on the same Apple Account (or shared by their Apple family): Plus is read from StoreKit, nothing to restore. Continue goes to A6 (getting your habits) or Today.
- **G4** Ask to Buy in an Apple family: honest waiting, and it opens by itself once approved (StoreKit tells us).
- **G5** The App Store can't be reached (developers report a watchOS 26 StoreKit fault): nothing was charged; Try Again, or Continue on iPhone.
- **G6** After a refund or a family's sharing ends: the Watch first sends what's waiting, then shows this. Nothing deleted (D10).
- **G7** Our complication without Plus: the app's name and "Part of Plus"; tapping opens G1. No habit names or counts.

## H · Added after the cross-check
- **H1–H3** Limit (cut-down) habits: "1/2 cups max", a neutral fill, never the habit colour or red; Day details names it "Daily limit", then "Limit reached" or "Over the limit" plainly. Logging toward a limit is available but not invited: glass, not white (U16, U25).
- **H4** A check counted toward a week goal: the ring fills toward this week (U25); each Add a check adds one check and never takes one back (U14).
- **H5** Tasks sit in their sections with the habits, as on the iPhone ("Task · 2:00 PM"), ✓ to finish.
- **H6** A skipped habit stays in place, neutral: "Skipped today". Paused habits leave Today and sit folded at the end, with when they come back; resuming is on the iPhone.
- **H7–H8** "Record a slip?" asks first, with its time. The run starts again from the slip; the last run and the best stay. Never "reset" or "failed" (U3). Undo slip, named.
- **H9–H10** Milestones show beside the named Undo, as on the iPhone ("30 days in a row"), never a pop-up. The streak sits under the dial in Day details, best beside it; Show Streaks off hides both.
- **H11–H12** Alarms: watchOS has no alarm API (AlarmKit is iPhone and iPad only), but Apple shows an iPhone app's alarms on the paired Watch by itself. So the iPhone's alarm reaches the wrist with its title, our name and its buttons: Done for a check or task, "+1 glass" for an amount, nothing for a timer or checklist. Apple draws it; which buttons the Watch shows is to be checked on the Series 10.
- **H13–H15** Remind Again: "Not done yet · 3/8 glasses". Several at one time come as one ("Morning · Vitamins, Meditate, Stretch"). Timers and checklists get no Done button; tapping opens the habit.
- **H16** Siri on the Watch runs the same App Intents as the iPhone (Log a Habit, What's Left Today, Open a Habit); the result names what was logged, with a named Undo.
- **H17** watchOS 26 controls: Start the Now routine and +1 for a chosen habit, in Control Center, the Smart Stack and the Ultra's Action button. Proposed for after version 1.
- **H18** A failed write: the Watch goes back to what's saved and says so (S7). Rare: the Watch's database is local.
- **H19–H20** The 42 mm Watch (187 × 223) and larger text: rows grow and wrap; the round button moves to the row's top line; nothing is cut off.

## As built: where version 1 differs from the pictures (11 Oct 2026)

Built on branch `apple-watch` (Current Work 82). The built screens, photographed on CI, are in
[Built Screens](<../Built Screens/>). What differs, and why:

- **E2, a tap on the watch face:** the face changes at once (the app's own "after one tap" card), and the tap is on
  disk from that moment, but it's saved into the Watch's database the next time the app runs: on opening, on its
  background refresh (about four an hour with a complication on the face), or when the iPhone's changes wake it.
  watchOS runs a complication's intent in the widget extension and has no way to hand it to the app's process (the
  iPhone does that with a `LiveActivityIntent`, Rulebook U26), so the tap waits in the shared waiting-taps file.
- **H16, Siri:** the result names what was logged; it has no Undo button (App Intents' result on the Watch shows a
  dialog, not buttons). Undo is on Today and Day details as always.
- **H17, controls:** not built (after version 1, as the notes say).
- **D, notifications and H11–H12, alarms:** drawn by watchOS, not by the app; XCUITest can't photograph them, so the
  screenshot review covers them through the categories and words the app registers, and the Series 10 check (U9).
- **E, the watch face:** XCUITest can't photograph a real face; the screenshot review shows the complications'
  own views in a gallery screen (`-face-gallery`, test launches only), the same views the face draws.
- **Continue on iPhone (G1):** watchOS can't put an app on the iPhone's screen, so the page offers Handoff for as long
  as it's open (the app's icon in the iPhone's app switcher opens ≡ › Plus), and the button says where to look.
- **H10, the streak in Day details:** a habit with logs older than the Watch's 400 days in memory shows its streak
  only when it certainly falls inside them, and no best; the iPhone has both (Architecture 12, "What's read into
  memory").
- **Messages between the two apps** go straight away while both are running (`sendMessage`), and are queued by the
  system otherwise (`transferUserInfo`), as Architecture 12 §3.1 describes; repeats are harmless.
