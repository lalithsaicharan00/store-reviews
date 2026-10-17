Written by Claude (Claude Code), 16 October 2026.

# How Was Today Widget — What a 2×2 Mood Widget Should Do

**The user's request (16 Oct):** a small (2×2) widget for *How was today?*. It is its own widget: adding it shows it
straight away, with no habit to choose. Its job is to log the day's mood and, if wanted, a note; tapping to add a note
opens the app's Add note screen. Android first; do thorough research.

## Second pass, the same day: one layout in every state

The user found the logged states hard to follow: "even as a creator, I was not able to understand it". The question
was whether the widget matches how people think about logging a mood.

- **People think of it as one question with five answers, and an optional line.** *"I can track my mood across time
  in 2 taps and optionally add a short"* note (A33#2732); *"I loved how you can write why"* (A4#7090). Questions
  after the mood are disliked: *"it asked me so many questions about why I choose that mood"* (A4#13355). So the note
  is offered (+ Note), never asked for.
- **A tap has to show at once, where it was made.** *"tap works, but display doesn't show it live, so I tap over &
  over"* (A1#52402). Switching to a different layout after a tap makes people look for what happened.
- **The Today card already works this way** (M.1.1): the chosen face is outlined, the others step back.
  Consistency means one thing to learn.

**So every state uses the same layout:**
- ① the question, the date, five faces and + Note;
- ② the tapped face marked in place, and tapping another changes it;
- ③ the note's first line in the date line, and ✎ Note.

That replaces the panel designs below (*Tap to change*, the week row, the note beside a panel). The date reads
*Thursday, 16 October* so the day is clear at a glance (the user).

## Update, the same day: medium, not small

The user pointed out that this 2×2 layout won't carry over to the iPhone. An iPhone small widget is a square of about
155–170 pt, so it can't fit five faces and a Note button at Apple's 44 pt minimum without misclicks. Apple also treats
a small widget as essentially one tap target, though buttons have been allowed since iOS 17.

**Decided:** at launch, *How was today?* has **only a medium (4×2) widget**. It has five 52 dp faces in one row with
their words, Note apart at the top right, and the week shown after logging (A1#404, A1#51672). The design is in the
handoff (decision A20). The answer below is the first, small version, kept for the record.

Sources on sizes and taps:
- [uxdesign.cc](https://uxdesign.cc/designing-widgets-for-ios-macos-and-ipados-the-ultimate-guide-737fb284a9df)
- [SAP Fiori widgets](https://www.sap.com/design-system/fiori-design-ios/v24-12/components/widgets/usage)
- [Apple Developer Forums](https://developer.apple.com/forums/thread/671621)
- [uxcel (44 pt)](https://app.uxcel.com/lessons/ios-app-design-712)

## Answer, in short (first version, small, superseded)

- **One tap on a face logs the mood, without opening the app.** That's the one thing people ask a mood widget for, and
  what the Android mood widgets that do it well offer.
- **Five emoji in two rows (3 + 2), 40 dp each,** in the card's 124 dp inner width, with **+ Note** under them across
  the width. Note opens the app at today's Add note (M.1.2), with the day's mood already shown.
- **After logging, the widget shows the answer:** the emoji large with its word (*🙂 Good*) and *Tap to change*. The
  change has to show at once, or people tap again (A1#52402).
- **With a note:** the emoji and word, then the note's first lines; ✎ Note opens it in the app.
- **The same states as every widget:** *Content hidden* (Hide names outside the app, or App lock) and *Couldn't save*.
  A new day starts it over. Hiding the card from Today doesn't affect the widget.
- **No colours, no reminders:** emoji on neutral circles, the chosen one outlined in ink, as in the app (A17, A18).

## How this was researched

- **Reviews:** `Mood Widget Evidence/scan.py` read every App Store and Play Store review for *widget* within 100
  characters of mood, emoji, feeling, journal or check-in words. 282 matched, and the ones about a mood widget were read
  by hand. `verify.py` checks all 8 quotes (0 mismatches). The counts are small and directional.
- **Other apps (web, 16 Oct):**
  - **Mini Moods** (Android, open source): its widget lets people *"view, modify or add today's mood from your desktop
    without the need to open an app"*
    ([GitHub](https://github.com/CampbellMG/MiniMoods)).
  - Several iPhone mood apps put five emoji buttons on a small widget to log with one tap: Mood Easy, and the Mood
    Tracker Lockscreen Widget, which writes to Apple Health's State of Mind
    ([App Store](https://apps.apple.com/app/id6759265580); [App Store](https://apps.apple.com/us/app/-/id6752544239)).
  - **Daylio's** widget appears to show only the last mood and open the app to log. A user on its subreddit describes it
    as a mirror ([r/Daylio](https://redlib.ssps.io/r/Daylio/comments/1j3116c/how_do_you_use_daylio)). That's a single
    report, not confirmed.
  - **Google's guidance** for widgets (Glance, I/O 2024): *"users should be able to get something valuable from your
    widget without having to open your app"*
    ([summary](https://en.androidayuda.com/applications/Tutorials/Complete-guide-to-creating-interactive-widgets-with-Jetpack-Glance/)).

## What users show

| Theme | Reviews | What they say |
|---|---|---|
| **Log the mood from the widget** | 2 | *"I wish we could rate how we're feeling from the Home Screen widget without loading in the app"* (A10#58055); *"I use the widget to check in everyday"* (A5#2508) |
| **See moods on the home screen** | 3 | *"I can stack a habit overview and weekly mood"* (A1#404); *"a widget that shows me my moods for the week"* (A1#51672) |
| **The widget keeps it from being forgotten** | 2 | *"if its not right there ill forget i even have the app"* (A10#64083) |
| **A tap must show at once** | 1 | *"tap works, but display doesn't show it live, so I tap over & over"* (A1#52402) |

## Choices and why

| Choice | Why |
|---|---|
| Faces log directly; Note opens the app | Logging is one tap and the widget's value (users, Google's guidance); writing needs the keyboard and the full note screen |
| 3 + 2 faces, 40 dp, no words under them | Five 48 dp targets don't fit 124 dp. Emoji faces are read without words, and TalkBack names each one (*Awful … Great*). The chosen word shows after logging |
| A large emoji and its word after logging | People see that it worked (A1#52402), and the widget doubles as today's mood at a glance (A1#404) |
| No week view in the 2×2 | It doesn't fit with the faces. A bigger mood widget showing the week is a later option (A1#404, A1#51672) |
| Its own widget, no habit picker | It isn't one of the person's habits to choose; adding it is enough (the user) |

## Limits

- The evidence is small: 8 reviews and a handful of other apps' descriptions, unverified on devices.
- The 40 dp faces are below Material's 48 dp touch target. Check them on a phone (U9).
