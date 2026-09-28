Written by Claude (Claude Code), 28 September 2026.

# Logging a Count — One Tap or Type

**The user's question (28 Sep):** some count habits add 1 when + is tapped and others open the number entry, which feels inconsistent. Loop Habit Tracker (Android) always opens the input. Should every count habit open the input straight away, even as a full-screen form, to keep things simple?

**Answer, in short:** make it consistent and visible, but not by always opening the input.
- The **button says what it does**: "+1" adds one; "+" asks how much.
- **Tapping the row always opens Add Amount**, for every count habit: the input the user wanted, in one predictable place.
- The input stays a **compact sheet, not full screen.**

## What users show

**Loop's own users.** `Research/Temp/count-input/loop_scan.py` read 27,196 Loop reviews; 83 are about entering numbers for measurable habits (`loop_narrow.txt`), all read.

**1. Always opening the input is Loop's most repeated complaint for counting.** 13 reviews ask for one-tap +1 instead:

| Review | What they say |
|---|---|
| `0bace547-8e8f-47c3-a6ef-d06b6c43af70` (5★) | "I do wish when I pressed a 'counting' habit that it could just add +1, instead it brings up a text box and I have to delete the old number and type a new one" |
| `edeab694-bd9b-4261-8ecc-c6d53664d62f` (4★) | "It's kinda annoying for counting throughout the day to have my keyboard and the window pop up" |
| `e03207c3-2b9e-4b40-9062-518a769e09c0` (4★) | "a '+1' type of button for habits like drinking 10 glass water … so we manually don't have to write it 10 times a day" |
| `2dab69a9-3a59-497f-bad0-d1eff820bae7` (4★) | "automatically be '1' with a short press and then a long press to add/edit number. It is tedious as it is." |
| `f7e702af-64fd-4e97-bf9e-52f2e4a9ff20` (5★) | +1 on long press "instead of entering the menu to change the number" |
| `ca8eb444-bdaf-4693-aa8d-cea1f82b3bdf` (5★) | increment buttons "will make the input process quicker" |
| `efbcbfce-52b9-43ab-9de5-d91568a2d440`, `d5bd1fe9-f152-4346-86ad-ad6d730fced5`, `dd214ec4-7c02-4a5c-92fb-d0189702b18f`, `3c29dafd-ccf9-49b8-926e-1b412a29ddfa`, `362d46d9-6496-4b51-9cd3-a3c8646958e2`, `fad49beb-faff-4eda-b7fe-db15772a37c9`, `7dc5c2d8-a26c-40be-bb30-1aedbbf11dd4` | the same request, mostly for the widget: "just click once … instead of going through a scroll wheel every time" |

`c4c14097-1651-4354-9c35-aa38a542d6e3` (4★) adds the other side: "Typing numbers manually is tedious … tapping a +1 button 80 times for an 80m run is exhausting". So big amounts need typing, and small counts need one tap.

**2. Full screen is worse than a small dialog.**
- `0bab690c-e1c8-481f-b267-90550bd4cbd7` (4★) lost a star when Loop's number entry became "a dialog box but also the app itself full screen … you also have to close the app".
- Four more complain that entering a number now opens the app instead of a quick dialog: `c073edef-cffb-45b2-8a36-baa4fc2a7280`, `584031f9-bf67-4f1c-98a3-a1b8931a6b44`, `11930352-054b-4f87-bc1c-7a3213494950`, `97456881-d11d-402b-b3c5-43e71f91cf6e`.

**3. When the input does open, make it fast.**
- **Number pad by default:** `aca3f814-6f20-47ac-ab42-0ab3f3e28d34`, `90eb77eb-8004-433c-89d0-58583e028041`, `2f5ecfb4-7a92-49ad-8937-7d137a57b82b`.
- **Last value ready:** `1a29c730-b259-4af3-a588-1b6d267ca5d9` (4★): "if I did 20 minutes workout yesterday, tapping on today's cell could have 20 already entered so I could just hit Save".

**Across all apps** (from the earlier goals research, `Goals — Periods, Entry and What + Adds.md`):
- Big counts tapped one at a time are hated: `3678644474` (Do Habits, "tap 65 times"), `13510993353` (Finch, "hit the + button 100 times").
- Small counts tapped are liked: `91ce824d-0119-4e65-a03c-2bc645bc5faa` (HelloHabit, "easily tapping to record").

**So the user's assumption was half right.** The logging does need one simple, consistent rule. But opening the input every time, and full screen, is what Loop's users complain about most.

## Decision (built 28 Sep)

| Where | What it does | Basis |
|---|---|---|
| **The round button, quick counts** (small whole goals, or things done one at a time) | Shows **"+1"** and adds one. The glyph *is* the rule, so nothing is hidden | Users show it: 13 Loop reviews |
| **The round button, everything else** (steps, ml, km, 50 push-ups…) | Shows **"+"** and opens Add Amount | Users show it: "tapping +1 80 times" |
| **Tapping the habit's row** (name, icon, progress) | **Always opens Add Amount / Add Time**, for every count or timed habit | Reasoned from first principles: one place to type a number, the same for every habit. It was only on touch-and-hold before, and touch-and-hold still works |
| **Add Amount itself** | A **sheet** over Today, not a full-screen page. The number pad is up at once. **"Add 250 ml again"** repeats the last amount in one tap. It adds to the day; it never replaces it | Users show it: full screen, number pad, last value |

The + rule itself (which habits get "+1") is unchanged; see *Goals — Periods, Entry and What + Adds*, §3.

**Checked** on the iPhone 16 with `GoalFlowUITests`:
- `testRowOpensAddAmountAndButtonSaysPlusOne`: "+1" adds one; tapping the row opens Add Amount; typed 3 → 4/8.
- `testCountMeasuredAsksHowMuch`: 2,000 ml asks, then "Add 250 ml again".
- `testCountSmallAddsOne`.
