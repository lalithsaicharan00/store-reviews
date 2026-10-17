Written by Claude (Claude Code), 16 October 2026.

# Swipe on a Row — Act When You Let Go, or Show Buttons

**The user's question (16 Oct):** "what is the expected behavior from the users? … The reason in the iPhone I said we
shouldn't have that kind of way is because in the swipe there were so many options and within that only one option
was actually getting … acted when we swipe more than half." And: "right now we only have one option. So maybe it might
be good UX or it might not be … see what users like and what they don't like … the best possible UX."

This settles the one open question in [Swipe on a Today Row — the Android Way](<Swipe on a Today Row — the Android Way.md>):
does a swipe act when the finger lets go past halfway, or does it only show a button to tap? The iPhone's answer
([Swipe Actions — Reveal, Never Act](<Swipe Actions — Reveal, Never Act.md>), 4 Oct) was made for two or three buttons
behind one swipe.

## Answer, in short

- **With one action a side, the swipe acts when you let go past halfway.** What the row shows behind it is exactly
  what will happen, so showing a button and asking for a second tap only adds a step. That extra step is what people
  complain about when an app adds it: *"I now have to swipe and then also click a button to check it off"*.
- **The iPhone's reason still holds, and it's about something else.** Swipes go wrong when several things share one
  swipe and a longer drag silently picks the edge one. All 7 reviews of that kind describe it (*"If I swipe too far,
  it'll automatically say I completed all instances instead of just one"*). One action a side removes that case.
- **Accidents still happen with a swipe that acts, and each has a known cause.** The swipe shares its sideways motion
  with changing pages (15), fires while scrolling (9), goes the wrong way (5), or has no way back (12). The design has a
  guard for each one (below). Whatever the accident, it's recoverable: Skip has Undo, and Add note or Log a slip only
  opens a screen.

## How this was researched

- `Swipe Act or Reveal Evidence/scan.py` read **all 1,487,223 reviews** (App Store, Play Store and the native apps).
  **1,491** mention a swipe and **922** are about acting on an item. All 922 were read by hand. Reviews about swiping
  between pages, months or apps, or about notifications, were set aside.
- `review_classification.py` holds the themes. `verify.py` checks all **145** quotes against their reviews (0
  mismatches). The counts are **directional**: each counts reviews that say it plainly, not a coding of the corpus. The
  praise for swiping is under-counted: about 80 reviews say it, and 51 are quoted.
- **The natural experiment is Productive** (App Store 13): swipe right is Done, swipe left is Skip, acting on release,
  one action a side. That's our Android design, with Done where we have Add note. Habit Tracker (App Store 1) and
  Strides (48) work the same way. Most accidental deletes come from to-do apps (Tasks, Microsoft To Do).
- These principles are judged against the reviews:
  - **user control and freedom**, and **error prevention** (Nielsen's heuristics);
  - **undo instead of a warning** (Raskin);
  - **WCAG 2.5.2, Pointer Cancellation**: an action happens when the finger lifts, and moving away before lifting
    cancels it;
  - **WCAG 2.5.1, Pointer Gestures**: anything done by a swipe can also be done with a plain tap;
  - **Hick's law**: with one choice there's nothing to choose between.

## What users like, and what they don't

| Theme | Reviews | What they say |
|---|---|---|
| **A swipe that acts, liked** | **51 quoted** (~80 read) | *"Just a swipe and it's done"* (A1#52870); *"too quick a swipe to right and it's done"* (A13#7400); *"Easy swipe to done or skip"* (A13#18675); *"swiping left completes tasks. This feels intuitive"* (P49#402) |
| **Asked for, in apps without one** | 16 | *"Swipe Right Complete And Swipe Left To Skip"* (P36#129); *"Swipe to complete is a better way to tick off tasks"* than taps that fire by accident (N10#10032) |
| **A tap added after the swipe, disliked** | 9 | *"I now have to swipe and then also click a button to check it off"* (A13#13733); *"It used to be "swipe. Done""* (A13#13670); *"you need to swipe it then select "Skip it" or "Done""* (A53#793); *"the item disappears before I can choose my swiped option"* (A43#585) |
| **Several things on one swipe: the drag picks the wrong one** | 7 | *"If I swipe too far, it'll automatically say I completed all instances instead of just one"* (P98#958); *"they all use the same swipe function"* (A13#15362); *"It needs to have a swipe left and a swipe right- one for skipped and one for done"* (A43#411, who deleted the app) |
| **The row swipe is also the page swipe** | 15 | *"when navigating between Morning -> evening I'm constantly skipping tasks by mistake"* (A13#1731); *"the remove swipe is also the swipe to go to another category"* (P84#11229) |
| **Fires while scrolling, or on a slight touch** | 9 | *"I'm always accidentally swiping habits left or right when I'm just scrolling through them"* (A13#12283); *"Too easy to accidentally complete tasks by swiping on them slightly"* (N10#842) |
| **The wrong direction** | 5 | *"the swiping was opposite of I thought it would be so I kept skipping"* (A13#12990) |
| **No way back** | 12 | *"You can't go back and uncheck or in-skip if you accidentally do this"* (A13#15362); *"If u swipe wrong there is no way to undo"* (A48#1859) |
| **With Undo it's fine; a question first is disliked** | 6 | *"It's not a huge deal since you can easily undo things"* (P84#12109); a confirmation after the swipe *"feels excessive"* (N10#19886) |
| **Rather tap a button than swipe** | 8 | *"press a button to immediately mark an activity as done instead of swiping"* (A1#1932); *"I had a really hard time finding out how to check"* (A13#2754) |
| **Wants a slower swipe, or a question** | 5 | *"I'd prefer to click on the action … rather than it happening automatically"* (A13#229); the other four are about **deleting** |
| **A floating Undo in the way** | 2 | the "task deleted" message *"covers the task entry bar"* (P84#15338) |

**Reading it:**
- People like a swipe that acts, by a wide margin. When an app took it away, or added a tap after it, people noticed
  and complained.
- The complaints aren't about acting on release. They're about the conditions around it:
  - a sideways motion with two meanings;
  - a threshold low enough that scrolling crosses it;
  - several results behind one drag;
  - no Undo.
- The one review that asks to tap the action instead (A13#229) says why in the same sentence: *"it's not obvious how
  to undo"*.

## Why showing a button is worse when there's one action

- **It's a confirmation in disguise.** With one action, the revealed button can only say the same thing the swipe
  already showed. People call confirmations excessive (6), and undo is better than a question (Raskin; N10#22353:
  *"There's such a thing as 'undo'"*).
- **It's two steps for one decision**, the step people complain about (9).
- **The button can slide away before it's tapped**, or needs a careful partial swipe (A43#585, A43#411).
- **What the iPhone rule protected against isn't here.** The iPhone hid two buttons on a side, so a long swipe did
  whichever sat at the edge. A single labelled action that fills and ticks at the halfway point can't surprise anyone.

## The design, and the guard for each failure

| Failure in reviews | Guard in our design |
|---|---|
| A drag picks one of several results (7) | **One action a side.** Its icon and a short word (*Skip*, *Note*) show behind the row from the first pixel, and the full words (*Skip today*, *Add note*) as it fills at halfway, so the habit's name stays mostly readable while dragging (the user, 16 Oct: never an icon alone) |
| Done or +1 does "the whole thing" (P98#958, P98#544, A1#54718, A1#45835, P108#3) | **Never Done or + on a swipe.** Done is the round button, one tap. A swipe can't say "+1" or "all of it" |
| Fires while scrolling (9) | A swipe starts only once the finger moves **clearly more sideways than up or down**. Otherwise the list scrolls and the row doesn't move |
| A slight touch acts (N10#842) | It acts only **past halfway**. Past that point the action fills with colour and the phone ticks once. Let go short of it and the row springs back |
| Changed my mind mid-swipe | **Drag back under halfway before lifting** and nothing happens (WCAG 2.5.2) |
| Row swipe = page swipe (15) | **The list never pages sideways.** Days change on the day bar (‹ ›, a swipe along the bar, Today ▾). No swipe starts at the screen's edges, which belong to Android's back gesture (N10#14320) |
| Wrong direction (5) | The name shows before the finger lifts. The two sides are very different (one skips, one opens a note), and Skip is undone with one tap |
| No way back (12) | **Only safe actions on a swipe.** Skip has Undo. Add note and Log a slip only open their screen, and nothing is saved until Add or Save. Delete and Pause are never on a swipe |
| Can't find it, or would rather tap (8 + 5 hidden, 16 Oct report) | **Everything a swipe does is also a tap away** (the long-press menu, Day details) (WCAG 2.5.1) |

## One change this suggests: Undo skip on the row, not in a snackbar

7.10 shows *Skipped today* with a snackbar's Undo at the bottom of the screen. The same day's research on what happens
after a log ([After a Log — Should Undo and Add Note Stay or Go](<After a Log — Should Undo and Add Note Stay or Go.md>))
found the floating, timed Undo is what people trip over (9 there, 2 more here). It put Undo on the row instead, with no
timer.

So for one way of undoing everywhere: after a swipe skips a day, the row reads *Skipped today* with **Undo skip** under
it, in the after-log place, and no snackbar. A second left swipe is still Undo skip (7.11).

**Decided and drawn, 16 Oct** (the user: "act on release is confirmed. Draw Undo skip on the row in place of the 7.10 snackbar"): 7.10 now shows *Undo · + Note* on the row, the same buttons as after a slip (7.13).

## The iPhone

The Rulebook keeps one design across platforms (the user, 11 Oct). The iPhone's swipe is:
- left: Skip and Note, revealed;
- right: a named Undo.

Undo now also sits on the row after every log, so the right swipe repeats it. The same reasoning would give the iPhone
one action a side, acting on release: left Skip, right Add note.

That changes **U14** ("swipes reveal and never act, however far they go"), and a product rule changes only with the
user's say-so. **Not changed; still the user's call.**

## Limits

- The counts are directional and come mostly from one app (Productive supplies most of the praise and many of the
  accidents). The to-do apps supply most of the accidental deletes.
- The halfway point, the tick and "sideways before it moves" are reasoned from the reviews and Android's own apps, not
  tested with people. Check the feel on a phone (U9).
