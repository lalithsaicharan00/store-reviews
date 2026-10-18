Written by Claude (Claude Code), 16 October 2026.

# Hiding How Was Today — Where It Goes and How It Comes Back

**The user's question (16 Oct):** what is the best, most intuitive way to hide and bring back the *How was today?*
card? The options: the ✏ edit at the top of Today; an option on the card itself; or treating it as a habit, with a
"show on Today" option on the Habits page. Research only, no design changes.

## Answer, in short

- **Hide it from the card itself:** ⋮ › *Hide from Today*, as drawn in M.1.6. People act on a thing where they see
  it.
- **Confirm with a snackbar that says how to bring it back,** with Undo: *How was today? is hidden. Show it again
  from ✏ Arrange Today.* · *Undo*. Hiding without saying where it went is how features get lost (3 reviews).
- **Bring it back in two places people already look:**
  - **✏ Arrange Today:** the card has a row there, *How was today?* with a **Show on Today** switch. That page is
    where everything about what Today shows is set.
  - **Settings › General › How was today?** (M.2.4), for people who look in Settings. One reviewer: *"most apps
    have a button right on the settings page"* (A3#7582).
  - Both switches are the same setting.
- ~~**Not on the Habits page, and not as a habit's option.**~~ Superseded (A18): it's in Habits, and its details page's ⋮ shows or hides it. It isn't a habit (the 16 Oct mood report). It has no
  goal, streak or place in "4/13". Listing it among the habits would suggest it counts like one.
- **Hiding keeps everything:** every mood and note stays. Whether Progress keeps showing "How your days felt" while
  the card is hidden is your call: the history is still yours to see.

## What users show

`Hide a Card Evidence/scan.py` read every App Store and Play Store review for hiding, removing or bringing back a
card, section or feature on the main screen. 84 matched and all were read by hand, and 12 quotes are verified (0
mismatches). The counts are directional.

| Theme | Reviews | What they say |
|---|---|---|
| **Let me hide what I don't use** | 9 | *"You can show/hide tabs"* (A1#703, praised as "so customisable"); *"If there is a feature you don't like, chances are there is a way to disable it"* (A10#24483); mood specifically: *"not something I can turn off"* (A28#704), *"a setting to get rid of the mood tracker"* (A4#547) |
| **Hidden too far, so it's lost** | 3 | *"Now you have to go searching for it"* (A10#9262); mood *"hidden on main screen, and you have to do gazillion clicks to log your mood"* (A10#27967); *"that feature is very hidden, most apps have a button right on the settings page"* (A3#7582) |

The 16 Oct mood report already found that "can't turn it off" is the most common complaint about mood check-ins, and
that people forget to log once a check-in is out of sight (Finch, A10#687).

## The principles behind it

- **Act where the thing is** (direct manipulation): the ⋮ on the card, not a trip to a settings page.
- **Show the way back** (visibility of system status; recognition over recall): the snackbar names the place, so
  nobody has to remember it.
- **Undo, not a question** (error recovery): hiding is harmless and reversible, so no confirmation dialog.
- **One home for "what's on Today"** (consistency): Arrange Today already decides what Today shows and in what order.
  The card's switch belongs there, with Settings as a second way in.
- ~~**Keep the model honest:** it isn't a habit, so it doesn't appear among the habits.~~ Superseded the same day: the user made it a habit that comes with the app, listed first in Habits, and it never counts in Today's totals (Android decision A18).

## Limits

- The evidence is small: 12 reviews.
- The Arrange Today row is reasoned from where Today's layout is already edited, not from reviews.
- The snackbar's two lines should be checked at the largest font size (U9).

## Added the same day: the card on a new user's empty Today

**Question (the user):** should a first-time, empty Today show *How was today?*, and if so with a small introduction?

**Answer: yes, as a visible card, never a pop-up, with one line of introduction until the first mood.** Evidence
(`Mood First Day Evidence/`: 197 reviews scanned, 8 quotes verified):

- **Seeing it on opening helps people remember:** when Finch stopped asking on opening, *"i never log the mood anymore
  because i forget"* (A10#23841).
- **New users take to it:** *"This is my first day! … And it even asks for my mood"* (A4#8227).
- **What's disliked is being forced or blocked:** *"why am I suddenly required to track how I'm feeling … why isn't
  there an x to close it?"* (A4#12820); *"When I open the app I just want to go to my list immediately"* (A10#16566).
  Ours is a card, never a pop-up. Today stays usable around it, and it hides in one tap.

**Drawn:**
- *5 · No habits yet* has the card on top, with *"New: one tap to note how your day felt. Only you see it, and you can
  hide it anytime."* until the first mood is logged. The empty state with *New habit* stays below it, centred.
- *6 · Nothing planned today* shows the card too: the day still happened.

**And a way to its details page from Today:** the card's title is a link (*How was today? ›*), and its ⋮ starts with
*See all days*. Both open its details page (M.4). The › keeps the header apart from the faces, so it isn't tapped by
accident.

