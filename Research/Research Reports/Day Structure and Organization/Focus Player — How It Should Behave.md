Written by Claude (Claude Code), 29 September 2026.

# Focus Player — How It Should Behave

The user asked for a hands-on bug hunt of the full-screen routine (focus) player that Codex built ([Full-screen Focus Player — One Thing at a Time](<Full-screen Focus Player — One Thing at a Time.md>)), with research first: how should the whole player behave? This report is that reference. Each numbered behaviour (P1…) is what the manual test checks. The user's points are in [the bug-hunt checklist](<../../../iOS/Docs/Checklists/Focus Player — Manual Bug Hunt Checklist.md>).

## Evidence

- **Scope:** every review in the App Store, Play Store and native corpora (1,487,223). **Signal:** reviews that mention a routine together with a timer, a step or a task: **2,271**. They were sorted into ten themes by keyword (`Research/Temp/focus-manual/scan.py`), and up to 60 per theme were read by hand. Most come from the two timed-routine apps, Routinery and RoutineFlow.
- **Limits:** the theme counts are keyword matches, not hand-coded counts, so they rank concerns rather than measure them. Reviews overweight what went wrong.

| Theme | Matches | What users show (read by hand) |
|---|---:|---|
| Skip, go back, reorder | 152 | Wanted and praised; skipping must never mark done |
| Controls and visuals | 130 | Buttons that stop responding or can't be pressed are among the most damaging bugs |
| Untimed steps | 71 | Some steps are just done or not done; don't force a timer on them |
| Pause and resume | 68 | **The most repeated bug: pause doesn't hold** |
| End-of-step alerts | 66 | One clear signal; no repeats, no nagging while the routine runs |
| Full screen, one thing at a time | 63 | The main thing people love about routine players |
| Adjusting time | 40 | Adding time should be quick, from the clock itself |
| Auto-next | 38 | A choice, not forced; being stuck on a timer screen is disliked |
| Screen and lock screen | 13 | Keep the screen on; the lock-screen timer must follow the current step |
| Total time and summary | 7 | Nice to have; low priority |

What users show, in their words (IDs checked against the corpus):

- **Pause must hold.** "When I pause my routine, and come back to it, the timer always starts again without me knowing" (`1f6078c7-88fc-40b3-9cf4-c6a98547e56a`). "Pausing does not actually pause the task, the timer will continue in the background" (`2f735eb3-f35f-443a-90e4-3a9151c14b68`). "it won't save the time I've gone thru and it would discard it" (`3c90725a-5faf-4867-acec-444b7c690978`).
- **Leaving must not mark done.** "if I click to leave the routine it gets marked as done" (`d178c105-d555-4a91-9e07-1cb3620cf496`).
- **Controls must always work and fit.** "bugs that won't let me pause the timer, skip, or really press anything while the routine is going" (`cbb9e1be-b199-4142-b512-2dd860b13dbb`). "everything on the app is enlarged … I can't even press the 3 buttons below" (`cec9908f-6dee-4487-afb6-c963148f3a48`).
- **Adding time should be one touch.** "I just add a couple more minutes to the task (touch the countdown clock and a plus and minus box pops up) or pause it" (`8b9f72e6-5e96-4b8c-8daa-f8df6fe1cc37`). "You can pause and add more time to a task" (`10191779042`).
- **Keep the screen on.** "Dark Mode and Keep Screen On are so worth it" (`e09c16ff-2542-446e-8378-f63dd77bad07`).
- **Don't trap people or crowd the screen.** The Live Activity "doesn't update once one task ends", and people get "stuck on the screen with the timer" (`12397332591`). "the bottom of the timer screen is now cluttered" (`13871771640`).
- **Done-or-not steps.** "indicating if you're done with a habit or not to move on … instead of putting a timer for each habit" (`6661289869`).

## How the player should behave

**Starting and leaving**

- **P1** Start on a section opens the player full screen on the first unfinished habit. A timed habit's clock starts when you arrive on it, and the screen says so ("Timer running").
- **P2** Close saves any running time and returns to Today. **Closing never marks anything done.**
- **P3** Leaving the app, locking the phone or switching apps never changes a paused timer, and a running one keeps counting. Coming back shows the true time.

**Pause and resume (the most reported bug in other apps)**

- **P4** Pause stops the clock at once and keeps it stopped. Resume continues from the saved total. Nothing is lost.
- **P5** The Pause/Resume button always looks like the main button: readable in light and dark, never black, blank or greyed while it saves. Its label and icon change the moment it's tapped.

**Adding time or an amount by hand**

- **P6** Add Time / Add Amount is one tap away on the player itself.
- **P7** Its sheet opens **fully**, with nothing to scroll or drag up: the number or time input, the Add button and the current progress all visible, and the keyboard or wheels ready.
- **P8** A running timer is saved before the sheet opens, so time is never counted twice. After Add, the player's clock or number shows the new total straight away, with Undo.
- **P9** Tapping the clock itself opens Add Time (the "touch the countdown clock" pattern).

**Moving through the routine**

- **P10** Next, Skip and Back are one tap each. Skip keeps partial progress and never marks done. The routine list lets you jump to any habit.
- **P11** Checks, amounts, checklists and limits work without a timer. A timed habit never auto-advances.
- **P12** The latest entry can be undone from the player.

**Screen, lock screen and alerts**

- **P13** The screen stays awake while a timer runs in the player.
- **P14** The Live Activity shows the current habit's timer, follows Next and Skip, and ends when paused or closed.
- **P15** Reaching a time goal gives one signal: no repeats, and no "start your routine" reminder while you're in it.

**Look and feel**

- **P16** Everything readable in light and dark. No clipped sheets, no layout jumps, no controls hidden at large text sizes, and a calm, uncluttered bottom bar.
- **P17** The finish summary is honest (done, checked in, left for later) and one tap returns to Today.

## Round 2: the flow (the user, 29 Sep)

The user asked for the flow itself to be redesigned: free movement between habits without "skipping", a real Up next, controls where people expect them, and **"Log time manually"** instead of "Add Time" (which reads as adding extra time on top).

**What users show about moving through a routine:**

- Being held to the order is annoying: "you have to do things in the order they're placed in unless you press 'skip' on a task … sometimes you have done some of the upcoming tasks but can't check them off" (`74f9ae1c-7952-4880-971f-1435463bb26d`).
- They want to return to what they passed: "I wish it was possible to go back to a task that I've skipped" (`47b6f23c-aee7-4591-91e5-4db8b599c053`); "push it to the end to come back to it later" is praised (`36f563d0-837f-46cc-9d16-60d8cb433ba3`).
- No confirmations: "annoying pop-ups if you want to skip a routine or move back a step" (`cc63e6ec-7c61-4fdc-8206-8c02f3a29281`).
- The next step must be right and readable: "i actually need the next step" (`10077195804`).

**The mental model:** a playlist. The routine is a row of habits; you're on one; you can go to any other. Reasoned from first principles: that's how people already move through Music, Podcasts and Stories, so no new rule has to be learned.

- **P18** Swipe left or right to move between habits, or tap Up next. **Moving on never marks anything done and never asks to confirm.** The word "Skip" goes: you're just going to the next one.
- **P19** A row of segments at the top, one per habit: filled when done, bright for the current one, grey for what's left. It says where you are and what's done at a glance.
- **P20** Each habit says its goal in the app's own sentence ("20 min a day", "8,000 steps a day", "3 times a week", "At most 3 coffees a day") instead of a label like "TIME TO FOCUS".
- **P21** **Up next is a card**: the next habit's icon, name and goal, tappable. On the last habit it's "Finish routine". A ‹ button goes back.
- **P22** One main action per type, in the same place: Start/Pause/Resume (time), "+1,000 steps" (amount), Mark done / Log one (check-off), tick the steps (checklist), "+1 coffee" (cut down). The second action is "Log time manually" or "Log amount manually", for time and for amounts, cut down included.
- **P23** Cut down is a check-in, never "done": it shows what's logged against the limit ("2 of 3 coffees · within your limit").

## What this report is not

A review-based reference, not a usability study. P9 and P13 come from single clear requests, and P15 from the alert theme. They are reasoned choices that fit the evidence, not counts.
