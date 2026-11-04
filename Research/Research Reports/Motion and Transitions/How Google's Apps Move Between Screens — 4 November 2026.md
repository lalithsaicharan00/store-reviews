# How Google's Apps Move Between Screens, and What Often Enough Does Now

Written by Claude (Claude Code), 4 November 2026, at the user's request: "do some research, how the production apps do when it comes to the animations … take heavy inspiration from Google products … Everywhere throughout the app … performance … you don't need to implement something that is very costly."

The decision this led to is Android A110 in [Android/Docs/README.md](<../../../Android/Docs/README.md>); the rule is in the [Rulebook](<../../../RULEBOOK.md>), "Starting again"; the code is `ui/theme/Motion.kt`.

## In short

1. **Before:** moving between pages was the Navigation library's default fade, because the app never set a transition. Pages inside a flow (the habit form's pages, the choices before it, All milestones, Streaks, Restore's steps) had no motion at all: they jumped. Sheets closed from inside vanished in one frame.
2. **Google's apps use a small set of patterns, and they are quick.** A new page is Android's own transition: a 96 dp slide with a very short fade, visually settled in about 350 ms. Moving between the menu's own places, or into content in Gmail and Drive, is a fade through of about 200 ms. Tabs are 50–100 ms. The drawer is 250–310 ms. Nothing bounces, and nothing has a hero animation.
3. **We now do the same**, with one set of numbers for every screen, read from this phone's Android system files and checked against recordings. Only offset, alpha and scale move.

## How this was measured

- **Phone:** moto g54 5G, Android 15, 1080 × 2400, 120 Hz, three-button navigation. Animation scales 1×.
- **Primary source:** the transition files in the phone's own `framework-res.apk`, read with `aapt2`.
- **Recordings:** `screenrecord` at 540 × 1200, decoded straight through (T11), so each frame keeps its own time. Durations are from the first changed frame to the last. Movement is phase correlation against the settled frame, in pixels of the 540-wide video.
- **A limit on these numbers:** "settled" means the last frame that visibly changed. The 450 ms curve has a long tail, so it reads about 330–375 ms. Recording also costs the phone some frames. Numbers are good to about ±30 ms.
- **Not measured:** Google Pay (locked, as the user said); Maps, Meet, Docs and Photos beyond opening them (the patterns had stopped changing by then). Predictive back could not be measured in Google's apps on this phone, because three-button navigation has no back swipe; our own preview was checked on a Pixel 10 Pro emulator with gesture navigation.
- **Privacy:** recordings and frames show real email and contacts, so they stayed in the ignored `Research/Temp/motion/` and none is committed (D11). This report has numbers only.

## What Android itself does (framework-res, Android 15)

| File | What it does |
|---|---|
| `activity_open_enter` | Slides in from +96 dp to 0 over 450 ms; alpha 0 → 1 over **83 ms, after 50 ms** |
| `activity_open_exit` | Slides 0 → −96 dp over 450 ms; stays fully opaque |
| `activity_close_enter` | Slides −96 dp → 0 over 450 ms; stays opaque |
| `activity_close_exit` | Slides 0 → +96 dp over 450 ms; alpha 1 → 0 over **83 ms, after 35 ms** |
| `fast_out_extra_slow_in` | The curve for all of them: `M 0,0 C 0.05,0, 0.133333,0.06, 0.166666,0.4 C 0.208333,0.82, 0.25,1, 1,1` |
| `dialog_enter`, `dialog_exit` | Scale 0.9 ↔ 1 over 220 ms; alpha over 150 ms |

Both pages move together, by only 96 dp, and the curve covers most of that in the first 150 ms. It looks like a page settling into place rather than travelling across the screen.

## What Google's apps do (measured)

| App and action | Pattern | Visually settled |
|---|---|---|
| Android Settings, opening a page | System page transition. First frames at about 98 video px, then the curve | 333 ms |
| Android Settings, back | The same, reversed | 374 ms |
| Clock, its Settings page, open and back | The same | 358 ms, 330 ms |
| Files, Downloads, open and back | The same | About 180 ms before the content loads, 375 ms |
| Gmail, Compose from a mail | The same (it's its own activity), then the keyboard | 471 ms with the keyboard |
| Gmail, opening a mail | Fade through: the page clears, the mail comes in with a very small move. No sideways slide | 120–240 ms |
| Gmail, back to the list | Mail fades out, list fades in | 165–200 ms |
| Gmail, drawer → a folder | Drawer keeps sliding shut for about 245 ms while the list under it changes | 245 ms |
| Drive, opening a folder | Fade through of the content; the bottom bar stays still | About 200 ms |
| Drive, back | The same | 146 ms |
| Clock, bottom tabs | A very short fade | 49–93 ms |
| Play Store, bottom tabs | A very short fade | 80–100 ms |
| Drawers (Gmail, Drive, Calendar), opening | Slide, scrim fading in | 250–310 ms |
| Calendar, + menu | Small buttons rising and fading | 100–220 ms |
| Calendar, new event | Appears almost at once, then the keyboard pushes it up | About 20 ms |

**What this shows**

- **No app uses a slow fade between pages.** The longest step anywhere is about 470 ms, and that includes a keyboard.
- **Two families, by how the app is built.** Screens that are separate activities get the system's slide. Screens inside one activity (Gmail's list and mail, Drive's folders) get fade through. Google's own apps differ here. Often Enough is one activity, so either was open to us, and we chose by what each move means (below).
- **Nothing here is expensive.** No app used a shared-element transition in the paths recorded. Gmail's mail and Drive's folders don't morph from the row; they change in place.
- **Speed comes from the curve, not a short duration.** The system's 450 ms is 80 % done by about 60 ms in the recording.

## What people say (machine scan, then excerpts read)

Scanned: 1,238,784 stored reviews, App Store and Play Store, for animation and lag words. 1,910 match (0.15 %), and most of those are about a character's animation in Fabulous, Finch or Habitica, not about moving between screens. This is a machine inventory; 26 excerpts about screens were read by hand, so these are signals and not counts of an opinion.

- **Users show that a long or forced animation annoys.** A Productive review (`3909096675`, 2★, French) calls its animations long, with everything moving; an Atoms review (`11024968852`, 1★) objects to being taken to another screen for a 10-second animation on every habit; a Finch review (`11813385063`, 5★) asks for the chest animation to be shorter.
- **Users show that good motion is noticed kindly.** "Nice transitions and easy to use and navigate" (`1268937273`, 5★).

So reviews support keeping it short and never making anyone wait. They don't choose between a slide and a fade. That choice is reasoned from first principles and from what the phone's own apps do, which is the setting the user asked to match.

## What Often Enough does now

| The move | Pattern | Numbers | Why |
|---|---|---|---|
| A page, and back from it (Habit details, Edit, Add log, every Settings page, the timer, the player, New habit) | Android's page transition | 96 dp, 450 ms, the emphasized curve, the fade timings above | It's what every other page on the phone does. The app's other activities (licences, widget setup) already get exactly this from the system, so nothing looks different across that boundary |
| Pages a screen opens inside itself (the form's How often and Time of day, What do you want to do?, All milestones, Streaks, Restore's steps) | The same, through `PageSwitch` | The same | To someone using the app these are pages. They used to jump |
| The menu's own places (Today, Habits & Tasks, Settings), either way | Fade through | Out 90 ms; in 210 ms from 92 % | Same as Gmail's folders. These places have no order, so a slide would suggest a false one. Plus keeps its ← and so is a page |
| The drawer | Material's own, now one drawer over every page | Unchanged | The user likes it. It now keeps sliding while the page under it changes, as Gmail's does |
| A tab, another day, another period | The new content arrives (`arrival`) | 200 ms; 24 dp in the day's direction | Google's tabs are this quick, and this draws one copy, not two |
| A bottom sheet closed from inside | Slides away, as a swipe would | Material's own | It used to vanish in one frame |
| A page opened from Day details | The sheet goes down as the page comes in; it rises again on return | Together | The sheet used to sit over the page until the transition ended |
| Back to today / Back to this week | Comes and goes | Fade + 90 % scale, 200 ms in, 100 ms out | It used to pop in |
| Rows folded on Today | Rows fade, what's under slides up | 300 ms; off during a change of day | They used to jump |
| Dialogs and menus | Android's and Material's own | Unchanged | Already Google's own motion |
| A back swipe (gesture navigation) | The page shrinks to 90 % and follows the finger, the page under comes in | Follows the finger | Android's predictive back. Android 13 to 15 need the manifest's opt-in, which the app didn't have |

### Performance

- Only offset, alpha and scale change, all on the GPU layer. Nothing is laid out again during a transition.
- A tab or a day never composes two lists: `arrival` changes only the draw.
- Pages keep their own scroll state. The leaving page stops being placed once it has faded (see below), and the NavHost then drops it, as before.

### Problems found while building, each now a rule

1. **A page leaving on top keeps taking touches.** After its fade (118 ms) it was invisible but still on top for 330 ms more, so a quick tap hit a page you couldn't see. It's now no longer placed once it has faded (`stepsAside`).
2. **A tap on an empty part of a page coming in reached the page under it.** Every page now takes every touch on it.
3. **A second Back while a page left could pop Today and leave a blank screen.** Back never pops the bottom page now (`pop`).
4. **A `BackHandler` that only pops turns off the back swipe's preview.** Removed from every page the NavHost can take back by itself. Pages that may need to ask first keep theirs.
5. **The keyboard stayed up for the whole transition**, because the leaving page kept its focus. A leaving page now lets go of focus at the start.
6. **Predictive back needed `android:enableOnBackInvokedCallback="true"`.** On this Android 15 phone the system default doesn't apply. Added to the manifest.

### Debug and optimised builds

- The first time a page opens in a debug build, Compose can take 100–400 ms to draw it. The clock has already started, so the page can land almost finished and the slide is lost. This is the debug build's cost.
- In the optimised build the slide plays in full. **Judge motion on an optimised build.** On this phone that means `assembleRelease` signed with the debug key; a test launch still works there.

## Results on the phone

Optimised build, same phone, same method, demo data (a test launch, D8).

| Move | Often Enough | Google's equivalent |
|---|---|---|
| Page open, Settings › Theme | 355 ms | Settings › Network: 333 ms |
| Page back | 313–334 ms | Settings: 374 ms; Clock: 330 ms |
| Habit details open, back | 343 ms, 325 ms | |
| Form steps | 334–385 ms | |
| Day details open | 385 ms | |

Frame times over these runs: median 7–12 ms; 95th percentile 13–44 ms; 99th percentile 25–105 ms. The slowest frames are a page's first opening.

## Tests

- **Full instrumented suite (115 tests), Pixel 10 Pro emulator, Android 16:** 26 fail. **The same 26 fail on a clean checkout of `main`**, run the same day on the same emulator, so this work added none. They were already out of date, for example `ScreensTest.progressShowsTheWeek` opens a menu row that no longer exists. They were not loosened or skipped (T2) and still need fixing.
- **Final run of that suite, with the new streak tests (122 tests), same emulator:** the same 26 fail, nothing new.
- **After the last fix, on the phone:** the Today and streak tests, 18 tests. 17 pass, including `rowsKeepTheirGap`; the one failure, `TodayTest.milestonesTakeThePopUpThenTheBarThenTheRow`, is one of the 26.
- **A regression this work caused and fixed the same day:** the row animation's wrapper stacked each row on its 2 dp gap, which took every gap off Today. The user spotted it on the phone; the screenshots and the new test now cover it.
- **The back swipe:** held half way on the emulator with `input motionevent`, then released. The page shrinks and follows the finger, the page under it comes in, and release finishes the move.
- **Edge cases on the phone:** three quick Backs land on Today, never a blank screen. The keyboard stays up from the form to How much, whose field takes over the focus.

