# Day Details on iPhone — The Sheet, the Buttons and the Note

Written by Claude (Claude Code), 6 November 2026.

On 6 November 2026 the user reviewed the Day details sheet in the iPhone Figma file ("IOS app", set `669:234`). They raised four points:

1. Would a native iOS sheet put the drag handle that high?
2. Splitting *This day* from *Add a note* with a gap is Android's way. They belong together, done the iOS way.
3. The *+1* and *Log* buttons were "very, very weird", and so were *Skip today* and *Mark done*.
4. The checklist's dividers ran under the last step too, and looked out of line.

Nobody writes reviews about any of this, so the answers come from Apple's guidance and from a test app built on the iPhone 17 Simulator (iOS 26). The test app was a real SwiftUI `Form` in a sheet, tried in every version described below (`Research/Temp/ios-day/`, git-ignored).

## 1. The sheet and its handle

**What iOS does.** A sheet shows its grabber only when it can be dragged between two heights. Apple's [Sheets](https://developer.apple.com/design/human-interface-guidelines/sheets) guidance says to include one in a resizable sheet, and SwiftUI shows it by default only when there is more than one detent. I measured both cases on the Simulator:

- **A Large sheet** starts at the top of the safe area.
- **With two heights,** the handle sits 5 pt from the sheet's top and is 5 pt tall.
- **The ✕ and ⋯ glass buttons** sit 16 pt from the sheet's top, whether or not there is a handle. The handle doesn't push them down.

**Day details has one height (Large)**, as the app had (`.presentationDetents([.large])`). So it has no handle.

**What changed:**

- The handle is gone from all four variants. The ✕ and ⋯ now sit 16 pt from the top, as in the Sheet component's *Close, Large* variant (`4141:4170`).
- In the flows, the sheet starts at the foot of the status bar (y 54) instead of tucking under the Dynamic Island (y 48 or 58). That's 144 copies on six pages.
- The *drag down to close* and *scrolled* frames keep their own positions.

## 2. The buttons

**The first answer was wrong.** I first turned the actions into list rows (*Add 1 Glass*, *Log an Amount…*). The user rejected that the same day:

> "Why we had the buttons one after the other is very simple reason. Because it saves space … We are just doing plus one button and then log, that's it."

So they are buttons again, side by side, with Android's words.

**Then the buttons themselves looked wrong.** The user asked whether that was simply how native iOS buttons look. It wasn't. Figma drew them 34 pt tall in Body Semibold; the Semibold came from the old app's code, not from iOS. I tried these on the Simulator, side by side (`sim-ta_*`):

| Version | What it looked like | Kept? |
|---|---|---|
| Regular size, Semibold (Figma's first try) | Squeezed and heavy | No |
| `.glassProminent` and `.glass` inside the white card | Log disappears into the card; +1 washes out to a lighter grey | No |
| `.bordered` tinted grey | Log looks switched off | No |
| **`.borderedProminent` and `.bordered`, `.controlSize(.large)`, 17 Regular** | Clean, and what iOS draws by itself | **Yes** |

**What it is now:**

- **Large, 50 pt on the phone** (the Simulator reads 54), equal widths, 8 apart.
- **Body Regular.** This changed in the design system, so every Regular and Large Button in the file changed with it.
- **Prominent for what the goal asks, Bordered for the rest**, by Android's `dayActions`. A limit, a slip and Undo Done are never Prominent. A skipped day's buttons are Disabled.

| Android | iPhone |
|---|---|
| +1, +20 | **+1**, **+20** (VoiceOver: "Add 1 glass") |
| Log | **Log** |
| Start timer / Pause | **Start Timer** / **Pause** |
| Log time | **Log Time** |
| Mark done / Undo done | **Mark Done** / **Undo Done** |
| Add a check | **Add a Check** |
| Log a slip / Log another slip | **Log a Slip** / **Log Another Slip** |
| Resume habit | **Resume Habit** |

Title case, as iOS writes a button's label. No "…": the user asked for nothing extra.

**Two Android Figma copies disagree with the Android code.** Figma's *Log a slip* and the large-text *Undo done* are Filled; the code makes both Tonal. The iPhone follows the code.

## 3. The note and Skip

**Add a Note is its own row, below This day, with a chevron.** The user's words: "Keep it in a separate row with a chevron indicating that you can go into another page." It's a List item, Single, with the Ink `note.text` symbol, and it opens the Note page. A written note shows *Note* over two lines of it, then …, as on Android.

Before that, I tried three other places. The user's review settled it, so these are history:

| Version | Why it went |
|---|---|
| A row inside the This day section | Replaced when the user asked for a separate row |
| A field typed into in place, as in Reminders and Calendar | Built in Figma, then replaced: the user wants a row that goes to another page |
| An icon button beside +1 and Log | Never built: a symbol alone hides what it does |

**Skip Today is a full-width grey button, its word centred:** Button, Bordered, Large, the same button as Log. It also says *Undo Skip* and *Skip This Day*. The user chose this one and pointed at Log as the style.

| Version | What it looked like | Kept? |
|---|---|---|
| Left-aligned row | The user: "very weird"; doesn't read as something to act on | No |
| Centred row in a white section | Looks like a label in a box: Apple's centred rows rely on a tinted word, and our chrome is neutral | No |
| Plain text, centred | Doesn't read as a button | No |
| Centred glass capsule | I chose this first. The user: it was "standing out of everything" | No |
| **Bordered, Large, full width** | One family with +1 and Log, and it fills the row | **Yes** |

## 4. The checklist's separators

**What iOS does.** A separator starts at the row's text and stops 16 pt before the edge, and the last row of a section has none. The test app's `Form` draws it this way.

**What was wrong:**

- The Day details copies set each step's left padding to 0 inside the padded *This day* frame, so the text moved 16 pt left of its separator.
- The steps' text (60) didn't line up with a list row's text (56).

**What changed:**

- **First, the Step row component in the design system** (`575:136`): a 24 pt tick column and a 16 pt gap. Its text and separator now start at 56, as a List item's do, and the separator stretches to 16 pt before the edge.
- **Then, in Day details,** the steps are full-width rows of the section, with no override. The last step has no separator, because the section ends there.

## 5. Found on the way, and fixed

- **The iPhone copies had lost their own button words:** all 109 on the day details page read "+1 / Log". Each copy's words were read back from the Android file by node id.
- **Every progress bar read 60 %,** whatever its count said. Each now matches its reading, to the nearest 10 % (the Progress bar component's steps).
- **A day with one log still had a separator under it,** and a day with two logs had no rounded end. The visible logs now take First, Middle, Last or Single.
- **The large-text (200 %) copies kept Android's line heights,** which were shorter than the text, so letters were clipped. Their rows now use `iOS/Accessibility 1/Body` (28/34).
- **Captions and frame names on the page used Android's words** (+1, snackbar, "side by side", "tonal"). They now use the buttons' words, and *banner* for snack bar.

## Left for the user

- **A step row is 44 pt tall and a list row 52 pt.** iOS's `Form` makes both the same height. Changing the Step row also changes Today's open steps and the routine player, so it was left alone.
