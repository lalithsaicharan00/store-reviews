Written by Claude (Claude Code), 28 September 2026.

# Timing a Habit — Start, See and Stop

**The user's question (28 Sep):**
- Right now, ▶ on a timed habit starts a timer at once. The button changes from ▶ to ⏸, but nothing else on the screen shows that a timer is running.
- Should ▶ open a full-screen timer instead?
- Whatever the goal is (10 minutes or 8 hours), do people expect a timer at all?
- The user wants to know what users expect, and to build that.

**Answer, in short:**
- ▶ keeps starting the timer in place, with one tap, for every timed habit. **No full screen.**
- What's missing is **seeing** it: in the row, when the row is off screen, and on the Lock Screen.
- Add **one** alert when the goal is reached.
- A timer is never the only way to log: **tapping the row still opens Add Time.**

## How this was researched

- `Research/Temp/timer/scan.py` searched all 1,238,784 reviews for timers. Its search words were timer, stopwatch, countdown, pomodoro and "timed habit". **3,877 reviews** matched.
- `split.py` left out two groups:
  - Hevy's gym rest timers.
  - Quit apps' "time since" counters.
- It kept the reviews that ask for, praise or complain about something.
- That left **2,335 reviews**. Every one was read, in chunks: `read_00.txt` … `read_15.txt`.
- Hand notes are in `notes.txt`.
- `tally.py` counts each theme from those hand codes. One review can count in more than one theme.
- About 50 reviews were about fake "offer ends in…" countdowns on paywalls. They were read and set aside.

**Where the reviews come from:**
- Habit trackers: Habit Tracker, HabitNow, Productive, Streaks, Habitify, HabitMinder, Rabit.
- Routine players: Routinery, RoutineFlow, Fabulous.
- Focus timers: Finch, Onrise, TrackIt.

The routine players matter here: they are the full-screen, one-task-at-a-time design the user asked about.

## What users show

| Theme | Reviews | What they say |
|---|---|---|
| **The timer must keep running when I leave the app or lock the phone** | **113** | The top complaint by far. Timers that stop, reset or pause in the background "defeat the purpose" |
| **Let me see it running without opening the app** (Lock Screen, Dynamic Island, notification, status bar) | **73** | Second. People are away from the app while they do the thing |
| **Tell me once when the goal is reached** (sound or buzz) | **53** | Otherwise they miss it and "lose track of time" |
| **Don't force the timer; let me tick it or type the time** | 37 habit-tracker + 52 routine-app reviews | Many forget to start it, or time it in another app (Headspace, the Clock app) |
| **Stopping early must keep the time** (sessions add up) | 20 | "Discards my 45 minutes" is a common complaint |
| **Keep counting past the goal** | 20 | "I want credit for 40 minutes when the goal is 30" |
| Timers cause anxiety (mostly routine apps) | 20 | Countdowns "like a race", a timer that "stresses me out" |
| Start with one tap from the list | 16 | "Why is it not counting as I click it" |
| Buzzing or a new notification every second while it runs | 12 | Some stopped using the timer because of this |
| Timer started by itself, or by accident | 11 | "Timers starting automatically are annoying" |
| Stuck on a timer screen I can't leave | 10 | "Once in the timer there is no way out" |
| Log it for me when the time is up | 10 | Instead of confirming by hand |
| Full screen praised | 7 | All but one are inside a **routine**: one step at a time |
| Full screen or "immersive" view criticised | 3 | Cluttered and distracting, especially for ADHD |
| Forgot to stop it, hours logged | 6 | "I wake up with 6 hours" |
| Count down preferred / count up preferred | 17 / 17 | An even split |

### 1. People leave the app while the timer runs (113)

They read on the phone, take calls, walk, meditate with the screen off, or fast overnight:
- `8826240060` (Productive, 5★): "YOU CANT ALWAYS HAVE THE APP OPEN. COUNT DOWN SHOULD STILL WORK EVEN WHEN YOU DONT HAVE THE APP IN FOREGROUND".
- `9770248961` (Productive, 1★): the timer stops "as soon as I get out of the app… which defeats the purpose".
- `9469996753` (Habit Tracker): switched a habit from minutes to a count because "you have to stay in the app while the timer counts down".
- `4260622974` (Fabulous, 3★): "you have to keep your phone open and on the app… I have to keep my phone on charge".

**Long timers are real.** Overnight and 14–16-hour fasting timers are a steady request:
- `9466291405`, `6223780216`, `8680315160`, `505bbee3-b508-4fcd-8a52-4e9bd6411a12`, `afb84801-a555-47e9-9f2f-15db4162d7f8`, `eacfdf45-2774-42f8-bac6-6eb9b34ed496`.

So a timer for an hours-long goal is expected too, as long as it survives the app being closed.

### 2. …and want to see it from there (73)

- `9736113054` (Productive, 5★): "i want to exit app to the background and see my timer showing up on that island… i don’t need to go back to app to see how much time i have left".
- `12846167630` (Fabulous, 3★) liked it when "the timer showed in the little screen on top of the iPhone… I could look at different screens while in a routine and know what the timer says". They disliked its later picture-in-picture replacement.
- `b3e86b87-613a-4ec3-9d9e-f81068b76cba` (RoutineFlow, 5★): "the timer is still in the status bar, as a reminder to stay on task in case I get side tracked".
- `bc7e0e66-f49b-4528-8368-2414e172c841` (Disciplined, 3★) paid for premium hoping the running task would show on the Lock Screen.
- `12499700289` (Onrise, 5★) asks for "a live activity that shows the remaining time… on the iPhone lockscreen".
- `9502486128` (Routinery, 1★): "It's perfect fit for live activity".

**Inside the app too:**
- `11796900049` (Streaks, 4★): "Each task should have a small timer beneath it… see at a glance how much time is left or has passed".
- `8175263159` (Habit Tracker, 4★): "the ability to browse the app with the timer running, maybe a ribbon at the top to show the elapsed time".

This is exactly the user's complaint: ▶ turns into ⏸, and nothing else moves.

**What to avoid in that display:**
- A notification or buzz every second (12): `d6cd9993-148f-41ed-acbf-3482f6f670f9`, `2983d753-cac3-42f5-8132-2931f28c42e1` ("pinging only at percentage milestones would be more appropriate").
- A Live Activity that lingers after the timer stops: `13594271430`, `10006395781`.

### 3. One alert when the goal is reached (53)

- `8760600647`: "chime when your countdown ends".
- `5084223685` (Streaks): "I have to keep checking my phone because there is no sound when the time is up… I have to use a separate app as a timer".
- `2636319095`: "no haptic notification… makes the timer useless when meditating with your eyes closed".
- `54be408e-8830-47bf-a5b8-9be399202fee`: "I sometimes forget I've even started… it is so silent".

**One** alert, not a stream: see the per-second complaints above.

### 4. Full screen: only for routines, never forced

- **Full screen is praised inside routine players, where it shows one step at a time.**
  - `2444986703` (Fabulous, 5★): "when you press start on your routine… it will have a full screen timer… You can check it off before the timer or after".
- **For a single habit, a timer screen you're sent to is a complaint.**
  - `13090999170` (Habitify): "once in the timer for a habit there is no way out".
  - `9302040f-f9eb-4385-b4fc-b09348eaadfc` (Habitify, 1★): "I try to complete one but it then takes me to a timer that I can't turn off?"
  - `3162197368` (Productive): "I can't go to the home screen while it's counting down".
- Immersive screens read as clutter to ADHD users:
  - `7214908680` (Fabulous, 3★): "more cluttered and distracting than the list view".
  - `e0bc2095-2571-446f-b2a8-5923e8a13498` (Routinery): "forcing us to go through them one-by-one, in a full screen timer section? Timers alone adds tons of unnecessary anxiety".

**This app already matches that split.** Start on a section header opens the routine player, which is full screen (not designed yet; see Design Rules). A single habit's ▶ stays in the list.

### 5. A timer is never the only way (37 + 52)

- `11170379790` (Habit Tracker, 3★): "I don’t remember to turn on the Habit Track timer before doin the habit".
- `10114431215` (1★): "It won't let me check that I completed it, rather it wants me to sit on the app while I do it… I use headspace".
- `10107068231` (1★): "You have to press play and wait for the timer".
- `6822530665` (HabitMinder): "finish the task without the timer… a dealbreaker".
- `10507135013` (Routinery): "you are forced to start a timer and complete an entire block in one go".
- `11015642151`, `13073278557`: timers that can't be turned off cause stress and anxiety.
- `2405fef0-7eb9-4210-a601-010aceecac2b` (RoutineFlow, 5★) sums up the good version: timers where you want them "gives the feeling of being helped, not controlled".

### 6. Stopping early keeps the time; going over counts (20 + 20)

- `6395468915` (Habitify): "when you end the habit early it doesn't discard your entire session".
- `baf2c90b-ea39-4750-bdfa-721a2700c164`: "when you interrupt… 25 minutes into your 60 minute session it doesn't update your progress".
- `3640246859` (Productive): "I would like to read for 30 minutes a day but not in one sitting".
- `6753878706` (Streaks): "I would want to know if I exercised for 40 minutes even if my goal was only 30". `13207927435` (Streaks) asks to "track overage time".
- `d178c105-d555-4a91-9e07-1cb3620cf496` (RoutineFlow) likes that it "keeps counting past 0 so you can see your real time".

### 7. Count up or down? An even split, so count up, next to the goal

- 17 reviews like countdowns and 17 like stopwatches.
- ADHD reviewers describe countdowns as a race:
  - `f045b4ac-af0f-4d4f-b82d-eca7b8a3c623`: "a countdown like you're in a race… that just makes me shut down".
  - `908338e3-b358-4668-81d5-a00ddd59734c`: "Timers and alarms badly trigger my anxiety" and praises a progress bar with a gentle chime.
  - `964d4cec-acc1-4bc0-80f2-b8a0cc604165` likes that it "doesn't count down, just up".
- Counting up also keeps working past the goal (§6).

So the clock counts up, the goal sits beside it, and the row's fill shows how much is left. That gives the countdown's information without the race. *This is reasoned from first principles on top of the split.*

### 8. Start with one tap; never by itself (16 / 11)

- **Starting with one tap is wanted.**
  - `06dab344-4299-49f5-b035-e641da2e6fc5` (Habitify): "there's no one tap timer… why it's not counting as I clicked it".
  - `8182ccca-cbc9-482c-a7df-c41cee3f9d57` (HabitNow): "It requires too many steps to start the timer… I want to click on a task and start tracking".
  - `8619477877` (Habit Tracker, 5★): "I click on the habit/task, and timer starts til I am done. I really love it".
- **Starting by itself is disliked.**
  - `c50d5ae3-f205-4c79-bf9f-94eddb0ad405`: "the timer… didn't start automatically every time".
  - `9b81ebc8-af49-4cb9-8988-8f7bac612172`: tapping it "starts a count down clock (why is that even an option?)".

The app's ▶ is a separate, labelled button, so it's already one deliberate tap.

## Decision (built 28 Sep)

| Where | What happens | Basis |
|---|---|---|
| **▶ on a timed habit** | Starts the timer at once, in the list, for **any** goal length. It changes to ⏸. ⏸ stops it and **saves the time**; the next ▶ adds a new session to the same day | Users show it: one tap (16), sessions add up (20), long timers expected |
| **The row while it runs** | The second line becomes a **live clock** of today's total against the goal, ticking every second: "7:42/20 min". The row's colour fill grows with it. Past the goal it keeps counting | Users show it: "a small timer beneath it" |
| **When the row isn't on screen** (scrolled away or in a folded section) | A small **timer bar** sits at the bottom of Today: icon, name, clock, ⏸. Tapping it opens that section and scrolls to the row | Users show it: "a ribbon… to show the elapsed time". The row alone can be hidden (*reasoned*) |
| **Outside the app** | A **Live Activity** on the Lock Screen and in the Dynamic Island: the habit, a live clock and a bar filling to the goal. It ends the moment the timer stops. It never sends repeated notifications | Users show it: 73 reviews, second only to "keep running" |
| **When the goal is reached** | **One** notification: "Read: 20 min done". The timer keeps going. For a Cut down (limit) habit: "Screen time: that's your 1 h limit". No repeats | Users show it: 53 ask for an alert; 12 complain about per-second pings |
| **Tapping the row** | Still opens **Add Time**, to type time without a timer | Users show it: 37 + 52 |
| **Full screen** | Only in the routine player (Start on a section). Never for one habit's ▶ | Users show it: §4 |
| **Keep running in the background** | Already true: the start time is saved, so time is counted from the clock, not by ticking. It survives closing the app and restarting the phone | Users show it: 113 |

**Not built this round:**
- **Stop from the Lock Screen.** Asked for by `c2f31b9d-4367-4063-bed0-b94263409917`, `9aed45d9-1adb-4f6f-b9f2-fb586b8c447c` and `3666c52b-3a0b-410c-b4bd-c93ac4ea4ba3`. Tapping the Live Activity opens the app, where ⏸ is one tap.
- **A check when a forgotten timer is stopped.** Asked for by `9467496894` and `9f9cbc3c-a890-42b2-9ec3-896914293a00`. Undo Last Entry already removes a wrong session.

Both are in `iOS/Pending to Implement.md`.

**Checked (28 Sep):**
- `TimerUITests.testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime` passes on the iPhone 17 Pro simulator:
  - The row's clock ticks.
  - The bar appears when Anytime is folded.
  - Tapping the bar brings the row back.
  - ⏸ on the bar saves the time.
- `RoutineCalendarUITests.testPlayFollowsHeaderRules` still passes.
- **Not yet run on the iPhone.** Device runs failed before the first tap with an XCTest connection error, and a test that had passed earlier failed the same way. The phone was also low on battery.
  - `testLiveActivityWhileRunning` (the Dynamic Island screenshot) still has to run on the phone.
  - So does `GoalFlowUITests.testTimeWeekly`. It timed out while the freeze below was still in the build.
- **A freeze was found and fixed.** The first builds re-drew the screen nonstop and showed a blank, frozen app on the iPhone. The cause was the timed row's `TimelineView` anchor: `.now` changed on every redraw, and `.distantPast` replays every tick since year 1. The row now runs a `TimelineView` only while its timer runs, anchored at the timer's start. Idle CPU went from 86% to under 1%.
