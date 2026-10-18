Written by Claude (Claude Code), 16 October 2026.

# Mood and a Note for the Day — Should a Habit Tracker Have Them?

**The user's questions (16 Oct, brainstorming, nothing fixed):** (1) do we need a mood tracker; (2) do we need a note
for the whole day; if yes, how; (3) should the two be combined, and how; (4) check the idea: **one built-in habit,
which people can't create, edit or delete, for the day's mood (emojis) and the day's note, with its own stats and a
Year in Pixels.** Research first; designed afterwards at the user's request (16 Oct): Figma section *How was today: mood and the
day's note*, Current Work 123.

## Answers in short

1. **Mood: yes**, as an **optional daily check-in**: one tap, never a pop-up, easy to hide, with a Year in Pixels.
2. **A note for the day: yes** (already shown by the 29 Sep notes research), small and optional.
3. **Combined: yes.** One **"How was today?"** place holds the day's mood and its note. Either one can exist alone.
4. **The idea: keep its parts, change its form.** Built in, emojis, notes together, its own stats and Year in Pixels
   are all supported. But **making it a habit** and **making it impossible to remove** are both contradicted by the
   evidence and by how the rest of the app works. It should be a **day-level check-in that sits above the habits**,
   not a habit among them, and it must be possible to hide.

## How this was researched

- `Mood and Day Note Evidence/scan.py` read **1,487,223** reviews (every App Store, Play Store and native-app corpus).
  2,283 mention mood; **757** are about *tracking* mood (Finch alone 336), all read by hand by theme, with the Daylio
  (31), Year in Pixels (14) and anti-bloat (746, 5 about mood or journals) hits. **51 quotes** are in
  `review_classification.py`; `verify.py` checks every one (0 mismatches). Counts are **directional** (themes read by
  hand, not a full coding).
- Earlier work: [Habit Notes and Day Notes — What People Ask For](<Habit Notes and Day Notes — What People Ask For.md>)
  (28 reviews in 17 apps want a note for the whole day); Feature Ledger card C049 *Mood tracker* (Strong, 12 apps,
  mixed: praised where shipped; disliked when forced or paywalled).
- The leading mood app's model (Daylio: five moods from *awful* to *rad*, optional activities and note, a Year in
  Pixels), the Year in Pixels' origin (a 2015 bullet-journal spread: one square a day, coloured by the day's overall
  mood), and a 2021 interview study of mood-tracking users (Schueller et al., *JMIR Mental Health*): tracking helped
  people notice patterns and look back; some avoided logging bad moods; they wanted help reading their data.

## 1. Should a habit tracker track mood?

**Users show yes, with conditions.**

| What people say | Reviews | Examples |
|---|---|---|
| **Asked for in habit apps that don't have it** (Loop, HabitNow, HabitKit, Onrise, Streaks…) | ≈17 | *"Please add emotion/mood tracker in relation to habits"* (P2#8315); *"so you can correlate your success with your mood"* (A23#3400) |
| **The reason: habits and mood together** | ≈8 | *"I used Daylio, but habits is not moods! If I can connects boths informations it should be amazing!"* (A46#160); *"see how my new habits affect my happiness"* (A86#1242) |
| **Praised where it exists, as a side feature** | 166 (keyword) | *"nicely complements without interfering with the goal of habit building"* (A1#52286); *"Love the mood tracker which I didn't expect"* (A1#45397) |
| **Used with a therapist** | 117 (keyword, mental-health terms) | *"it gives my therapist a quick snapshot"* (A1#51634) |
| **Against: clutter, or forced** | 3 + ≥6 | *"annoying habits suggestions, mood trackers etc."* (P36#495); *"PLEASE MAKE THE MOOD TRACKER OPTIONAL"* (A4#11858); *"forced me to register my mood in one emoji everyday"* (P145#582) |

The complaints aren't about mood existing, but about it **being forced** (a pop-up every time the app opens, no way
to turn it off) or **adding clutter**. The same people who hated Finch's check-ins on opening asked for **a toggle**,
and those who loved them stopped logging when they went: *"i never log the mood anymore because i forget, please at
least make it an optional toggle"* (A10#23841); *"my whole November was not tracked"* (A10#687).

**So:** mood, yes; **visible without interrupting** (no pop-up), **one tap to log**, **one tap to hide**, and an
**optional reminder** for the people who forget.

## 2. Should there be a note for the whole day?

**Yes, small** (29 Sep research: 28 reviews in 17 apps; *"add notes for a day without being able to assign them to a
task or habit"*). Today it exists only as a row at the end of the list, which people would rarely reach (see the 16 Oct
review of 1.10). One reviewer asks for it in exactly the mood tracker's terms: *"una funzione, proprio come il mood
tracker, di annotazione per fare qualche commento generale relativo alle singole giornate"* (A1#47435).

## 3. Together? Yes.

- **Mood with an optional line is the shape people praise:** *"I loved how you can write why"* (A4#7090); *"a mood
  tracker with notes to briefly journal your day"* (A1#51883); *"I can track my mood across time in 2 taps and
  optionally add a short"* note (Habitify, A33#2732).
- **Questions after the mood are disliked:** *"it asked me so many questions about why I choose that mood"*
  (A4#13355). So the note is offered, never asked for.
- **Daylio, the app people name when they want this (31 mentions), is exactly this pair:** a mood, then an optional
  note.

So one **day check-in**: tap a mood; a line under it offers *Add a note*. A note without a mood, or a mood without a
note, is fine.

## 4. The idea, checked

| Part of the idea | Verdict | Why |
|---|---|---|
| Built in, not made by the person | **Keep** | Nobody should have to set it up; it's the same for everyone |
| Emojis | **Keep** — five faces with words | Daylio's five; Finch's ☹️🙁😐🙂😀; each with a word for TalkBack and clarity (*Awful, Bad, Okay, Good, Great*) |
| Notes in the same place | **Keep** | §3 |
| Its own stats, Year in Pixels | **Keep** | *"The year in pixels completely sold me"* (A34#17); *"make a year review"* of moods (A1#1098); plus mood beside habits, the reason it belongs in a habit app |
| **As a habit, in the list of habits** | **Change** | A mood is a state, not something done. As a habit it would count in the day bar's 4/13, a time of day's "N left", Start, swipes (Skip a mood?), sinking when done, streaks. Each needs an exception, breaking one model for every row. A mood streak would push people to log, and people already avoid logging bad moods (Schueller et al.); a streak makes "Great" the easy lie. *"habits is not moods"* (A46#160). The one reviewer who tracked mood *as* a habit did it because nothing else existed (P9#602) |
| **Can't be edited or deleted** | **Change** | "Can't remove it" is the top mood complaint (≥6: *"not something I can turn off"*, A28#704). It must hide in one tap and come back, its data kept (D6) |
| Can't be renamed | Keep | Nothing to rename; the faces' words are fixed |

**What the idea becomes:** a **"How was today?" card at the top of Today**, above the times of day, below a notice
when there is one. Five faces in one row; after a tap, the chosen face and *Add a note* (or the note's first line).
It belongs to the day shown, so any past day can be filled in from the day bar (*"Cant track yesterday's mood"*,
A4#10462; *"after midnight"*, A4#4179: the day follows the day-start setting).

## How it should work (for when it's designed)

- **Never counts against anyone (U3):** no streak, no "missed", not in the day bar's count, no "N left".
- **No pop-up, ever.** An **optional reminder** (*How was today?*, evening), off by default, for those who forget.
- **One mood a day,** changeable all day, shown in the Year in Pixels. **Several a day** (3 ask; 1 says check-ins were
  excessive) can come later as an option, the day's square showing the latest.
- **Hide in one tap** (its ⋮ › *Hide mood*, and Settings); hiding keeps every entry; turning it back on shows them.
- **Colours:** one ordered scale people read at a glance, never red for a bad day (U3). A reviewer was lost by an
  unordered palette: *"Why bad mood is blue and violet, neutral mood is green and good mood is yellow and orange?"*
  (A1#43756).
- **Stats (Progress › Mood):** Year in Pixels, the month, how often each mood, and **mood beside habits** in plain
  words once there's enough data ("On days you walked, your days were mostly Good"), never claiming cause.
- **Private by default:** not on widgets unless chosen; App Lock covers it; included in backups and exports
  (people take it to therapy); never lost (*"they randomly deleted my mood tracker data"*, N4#7873).
- **Free** (D10): it's the person's own record.

## Limits

Directional counts; Finch and Me+ dominate the mood reviews, and they are self-care apps where mood is central. The
requests from habit-only apps are fewer (≈17), but they are the ones that ask for mood *with* habits, which is what
this would add. The five-face scale and the evening reminder are reasoned from Daylio's and Finch's practice, not tested
with people. Several moods a day and custom feelings are left for later.
