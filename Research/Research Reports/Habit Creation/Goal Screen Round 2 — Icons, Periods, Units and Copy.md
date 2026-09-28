Written by Claude (Claude Code), 28 September 2026.

# Goal Screen Round 2 — Icons, Periods, Units and Copy

Research for the user's round-2 feedback on the New flow's choice screens and the Goal screen. The checklist of every point is in [iOS/Goal and Choice Screens — Round 2 Checklist.md](<../../../iOS/Docs/Checklists/Goal and Choice Screens — Round 2 Checklist.md>). Each section below is one loop task, written when that task is done.

Basis rule (CLAUDE.md): every decision says whether **users show it** (review evidence) or it's **reasoned from first principles**. A competitor doing something is never the reason.

Scratch scripts and hit lists: `Research/Temp/goals/round2/`.

## T1. Icons for the choice screens (P2–P4)

**Basis: reasoned from first principles.** Reviews don't talk about icons on a creation screen, so there's no user evidence either way. The icons follow three rules:

1. **Monochrome** (the user's rule): one plain SF Symbol per row, in the label colour. No coloured tiles.
2. **The words still carry the meaning.** The icon helps people scan and recognise a row on a second visit. It must never say something the words don't.
3. **No clashes.** An icon must not already mean something else in this app or in iOS.

**Candidates** (five per row, rendered side by side: `Habit Creation Evidence/round2_icon_candidates.png`; availability checked against the system symbol set with `Research/Temp/goals/round2/symbols.swift`).

**Rejected, and why:**

| Symbol | Why not |
|---|---|
| `arrow.up.right` / `arrow.down.right` | iOS uses the up-right arrow for "open a link elsewhere" |
| `minus.circle` | This app's red ⊖ means **remove a row** (reminders, checklist items) |
| `checklist` | Already the **All habits** button on Today |
| `checkmark.circle` for tasks | It's the Check it off icon on the next screen; one icon, one meaning |
| `repeat` | Reads as the Repeat setting (a schedule), not as building a habit |
| `leaf` | A metaphor: pretty, but it takes a second to decode |
| `hourglass` for Quit | Suggests a countdown; Quit counts **up** from when you stopped |
| `smoke` | Only fits smoking |
| `ruler` / `plus.forwardslash.minus` for amounts | Ruler says length only; ± reads as maths |

**Chosen:**

| Row | Symbol | Why |
|---|---|---|
| **Build or maintain** | `chart.line.uptrend.xyaxis` | Up: more of something good. It pairs with the next row, so the two read as opposites at a glance |
| **Quit or cut down** | `chart.line.downtrend.xyaxis` | Down: less, down to none. Covers both quitting and cutting down, where `nosign` would say only "stop" |
| **Add a task** | `calendar` | A task is something for a day or a schedule. It's also the default icon a new task gets |
| **Check it off** | `checkmark.circle` | The same round ✓ as the button on Today |
| **Track an amount** | `number` | "#": a number, with no unit implied. It fits glasses, steps, km and money |
| **Time it** | `timer` | The Clock app's Timer icon |
| **Checklist** | `list.bullet.clipboard` | A clipboard list: one thing with items on it |
| **Quit** | `nosign` | Stop completely. It's also the default icon of a new Quit habit, so the choice and the habit match |
| **Cut down** | `gauge.with.dots.needle.33percent` | A gauge kept low: a **maximum**, which is what Cut down sets. Unlike the parent row's downward chart, it says "limit" |

**Checks:** all nine are different; none repeats a Today button; the pairs read as pairs (up/down; ✓ / # / timer / list); all are outline style, regular weight.

## T2. First-screen spacing and a clean layout (P1)

**Basis: reasoned from first principles**, using the layout of iOS's own lists (Settings, Health, Mail) so it feels native. Reviews say nothing about this screen's spacing.

**What's wrong now** (screenshot `Research/Temp/goals/shots/copy2/c01-…png`):
- Titles, subtexts and separators all start at the same left edge, so each row reads as one block of text. There's no anchor to scan.
- The task row's two-line subtext runs right up to the chevron.
- Rows on the two second screens are laid out the same way; all three screens should change together.

**Layout (the same row on all three choice screens):**

| Part | Choice | Why |
|---|---|---|
| Icon | T1 symbol, 22 pt, regular weight, **primary label colour**, in a fixed 30 pt column, vertically centred on the row | A fixed column lines the titles up whatever the glyph width. Centred like Settings rows with a subtitle |
| Gap icon → text | 14 pt | Close to Settings' spacing: the icon clearly belongs to its row |
| Title | Body, semibold (unchanged) | The thing people scan |
| Subtext / example | Subheadline, secondary; 2 pt between lines | Reads as one group under the title |
| Row padding | 10 pt top and bottom | More breathing room than the current 6 pt, without making the list scroll on a small phone (checked at 375 pt wide in T3) |
| Separator | Starts at the **text**, not the icon | Standard iOS inset: the icon column stays clean |
| Trailing gap before the chevron | 8 pt minimum | Keeps two-line subtexts off the chevron |
| Question header | Unchanged size; 4 pt less bottom padding, so it sits with its list | It belongs to the list below it |

Nothing else changes: the words from the copy report stay exactly as they are.

## T3. Built: icons and spacing (28 Sep)

- `ItemType.icon` holds the T1 symbols; `ChoiceLabel` draws the T2 row (icon column, full-width text, separator at the text).
- **Fixed on the first build:** a `Spacer` beside the text made SwiftUI wrap subtexts halfway across the row. The text now takes the full width.
- Screenshots: `Habit Creation Evidence/round2_c01-…`, `round2_c02-…`, `round2_c03-…png` (the three choice screens only; checked with `GoalFlowUITests/testChoiceScreensCopy`).

## T4. The period control: "Per" + Day · Week · Month · Year (P9)

**Question:** how do people name a goal's period, and what should the control say?

**Users show it.** `Research/Temp/goals/round2/period_words.py` counts goal phrases in all 1,238,784 reviews:

| How the period is attached to a number | Reviews | Share |
|---|---|---|
| "8 glasses **a day**", "3 times **a week**" | 787 | 68% |
| "… **per** day / week" | 196 | 17% |
| "… x/week", "3x/wk" | 79 | 7% |
| "… **in a** week" | 34 | 3% |
| "… **every** day" | 25 | 2% |
| "… **each** day" | 17 | 1% |

| As a kind of goal | Reviews |
|---|---|
| "**daily** goal(s)" | 1,558 |
| "weekly goal(s)" | 229 |
| "monthly goal(s)" | 123 |
| "yearly goal(s)" | 50 |
| "annual goal(s)" | 12 |

**What that means for the screen:**

1. **"Per" is the minority word** (17%) and, alone as a header, it's cryptic: "Per" what? People say "**a** day" and talk about their "**daily** goal".
2. The kind of goal is an adjective people already use: **Daily · Weekly · Monthly · Yearly**. "Yearly" beats "annual" 50 to 12.
3. The goal read back to the user should use "a": "8 glasses **a day**", "3 times **a week**", "12 books **a year**". Round 1 said "per day", against the reviews' wording.

**Decision:**

| Now | Change to | Basis |
|---|---|---|
| Header "Per" above Day · Week · Month · Year | **No header**. Segments **Daily · Weekly · Monthly · Yearly** at the top of the Goal screen | Users show it ("daily goal" 1,558) |
| Section header "Goal" above the amount | Header follows the choice: "**Daily goal**", "**Weekly goal**"… | Ties the two sections; reads as the phrase people use |
| "2k ml per day" | "2k ml **a day**", "3 times **a week**", "3 h **a week**" | Users show it (787 vs 196) |

- **Why segments stay:** four short, mutually exclusive, always-visible options is exactly what a segmented control is for. Showing them all at once also tells people weekly, monthly and yearly exist, which is the point of round 1.
- A menu would hide the options. A sentence builder ("[8] [glasses] a [day ▾]") isn't a native Form pattern and is harder with VoiceOver.
- **Width check:** "Monthly", the longest, fits a quarter of a 375 pt screen at the default text size. At the largest accessibility sizes, the segmented control truncates like every system one; the section header still names the choice in full.

## T5. The copy under the period control (P11–P13)

**Round 1 copy** (the user found it weird and confusing):
- Day: "The goal is for each day it's due. Repeat, on the form, sets which days."
- Week: "Any days you like: every tick in the week adds up. There's no daily minimum. First period: 28 Sep 2026–3 Oct 2026."

**Scan:** `Research/Temp/goals/round2/tone_scan.py` over 1,238,784 reviews. Hits: 19 "overdue + a feeling", 39 "failed/missed" labels, 155 ADHD/anxiety + guilt or judgement, 114 week-reset wording, 7 mid-week starts. All the overdue, failed/missed and mid-week hits were read, and the ADHD hits were read up to the first 60 that mention guilt, shame, failure or red.

### What users show

**1. Deadline and failure words make people feel judged, and neurodivergent users say it drives them away.**

| Review | App | What they say |
|---|---|---|
| `12184046988` | Dear Me, 2★ | A notification about an "overdue task": "That immediately stressed me out." |
| `80c57b32-4187-47b2-8c9f-6b235cbae643` | To-do list, 2★ | Overdue tasks "pile up in a big intimidating red file … boosted my anxiety". Uninstalled |
| `59685e06-a775-443b-9c4b-14a876cfb731` | Tiimo, 5★ | Praised because it "doesn't howl about overdue tasks" |
| `7064099529` | Fabulous, 1★ | A 3-days-a-week routine marked incomplete on the other days: "it looks like I'm failing when I'm not" |
| `10483508663` | everyday, 5★ | ADHD: after missing days "I would feel super guilty, and I didn't want to open the app again" |
| `11991814621` | Finch, 5★ | Neurodivergent: other apps put them off by "even something as small as marking a task 'red' for not completing it" |
| `14035312424` | Finch, 4★ | "The streak counter activated my ADHD shame" |
| `12060228726`, `13473897738`, `11574366461`, `10006170355` | Finch, 5★ | Praise for "doesn't shame me", "shame/guilt-free", "not punished for the ones you don't", "doesn't punish you for skipping" |

Some people *want* an overdue marker for **tasks** (`7532058364`, `1530935209`). That's a to-do feature and not relevant to a goal's explanation.

**2. A short first week surprises people.**
- `027db942-d0d2-46a4-bda0-e3810b8df2f3` (Fabulous, 4★): "my water goal reset bc I started on a Saturday so it took me twice as long".
- `f93e0640-769e-45dc-8a57-6086e7402794` and `6b916dce-d174-4946-b759-585ea6dfd372`: started on a Friday, but the week was counted from Monday.

What they needed was **when it starts again**, in plain words. A date range labelled "First period" isn't that.

### Rules for this copy (from the above, and first principles)

1. **Don't use** due, overdue, missed, failed, incomplete, minimum, deadline or must. Say what **counts** and when it **starts fresh**.
2. **One idea per sentence, at most two sentences.** Say what's true for this choice only.
3. **Name the reset day**, taken from the user's week start: "starts fresh every Monday", "on the 1st", "on 1 January". This answers the short-first-week surprise without a "First period" date range.
4. **Use the type's own verb:** check it off / log / time.
5. **Leave out "no daily minimum".** "On any days" already says it, and naming a minimum brings the idea of falling short back in.

### New copy

The period-control footer shows the sentence for the selected period. `{done}` is the type's verb:
- Check it off: "Every time you check it off"
- Track an amount: "Everything you log"
- Time it: "All the time you log"

| Period | Footer |
|---|---|
| **Daily** | "Starts fresh every day. Choose which days in Repeat." |
| **Weekly** | "Do it on any days. {done} from Monday to Sunday counts, then it starts fresh." *(names the user's own week start and end)* |
| **Monthly** | "Do it on any days. {done} this month counts, and it starts fresh on the 1st." |
| **Yearly** | "Do it on any days. {done} this year counts, and it starts fresh on 1 January." |

Examples:
- Weekly, Track an amount: "Do it on any days. Everything you log from Monday to Sunday counts, then it starts fresh."
- Weekly, Check it off: "Do it on any days. Every time you check it off from Sunday to Saturday counts, then it starts fresh."

The first week keeps the full goal, as decided in round 1. Saying the reset day makes that visible without a date range. Whether a short first week should get a smaller goal is left for later.

## T6. "Your goal" as a result, not a field (P10)

**Basis: reasoned from first principles**, plus how iOS itself shows a value being set. Reviews don't cover this detail.

**The problem** (screenshot `Research/Temp/goals/shots/goal2/g10-count-goal-8-glasses.png`):
1. **"Your goal" is shaped exactly like an input.** It's a white Form row, with a label on the left and a grey value on the right, just like the "Amount" and "Unit" rows above it. Anything shaped like a field is read as one. The user saw it that way.
2. **It sits at the bottom, under the keyboard.** Track an amount opens with the number keyboard up. On an iPhone the keyboard covers roughly the bottom 40% of the screen, which is where the summary is. So the read-back is hidden at the one moment it matters: while typing.
3. It's the last thing on the screen, but it's the *answer*. People should see the answer first and the controls under it.

**How iOS shows a value being set:** Fitness's Change Move Goal screen shows the goal as a **large number with its unit under it**, not a row, above the controls. The Clock timer shows the time big, above Start. A result is **big, centred and on the background**. Inputs are **rows in cards**.

**Decision:**

| Now | Change to |
|---|---|
| A "Your goal" row at the bottom | A **read-back at the top** of the Goal screen, on the screen's background: no card, no row, no chevron |
| "8 glasses per day" in grey, right-aligned | **"8 glasses"** large (title, bold, rounded digits), and **"a day"** under it in secondary text, centred. Time: **"3 h"** / "a week". Check it off: **"3 times"** / "a week" (and **"Once"** / "a day" for 1) |
| Nothing set yet: "Not set yet" | A grey "—" with "Enter a number below" |

- **Updates live** as the user types or changes the period, so the screen answers "what am I setting?" at a glance, above the keyboard.
- **VoiceOver** reads it as one static text, "Your goal: 8 glasses a day", with no button trait, so it isn't presented as something to tap.
- **The "what happens on Today" line** that sat under the old row moves under the Goal (amount) section, next to the input it describes. Its wording is T7's job.

## T7. Check it off stays Check it off, whatever the unit (P15), and the copy under Unit (P14)

**Round 1 behaviour:** choosing any unit other than "times" silently turned Check it off into a counter with a +. The footer explained it: "Keep 'times' for a tick. Choose another unit, like glasses or pages, to count an amount with +." The user's rule: **a check-off stays a check-off, whatever the unit.** People chose Check it off on purpose, and the type must not change under them.

**Users show it.** `Research/Temp/goals/round2/tick_unit_scan.py` found 10 reviews about ticking counted things one at a time:
- **Glasses:**
  - `1383039466` (Productive, 5★): "set up water for 8 glasses a day and check each glass off as you go".
  - `6748702421` (Streaks): "drinking 10 glasses of water can be checked off one glass at a time".
  - `4513fc04-bb42-4ae0-9666-a29e3c578087` (Me+, 5★): "The checking it off is part of what works … I check off each glass".
- **Losing it hurts:** `10772302280` (Me+, 2★) downgraded after an update removed "tick off every glass you drank".
- **Sets:** `11232772461` (Me+, 5★): "I really enjoyed checking off each set". Four Hevy reviews praise checking off each set or rep, e.g. `6a18b6cf-c005-4169-95d9-92dc63e2ea1d`: "for those ADHDers out there you can check mark each rep".

So a unit on a check-off is wanted. It **names what each tick is**; it doesn't change how you log.

**Decision:**

| Rule | Detail |
|---|---|
| The type never changes | Check it off always has the ✓ button, with any unit |
| One tick = one of the unit | "8 glasses a day": each ✓ counts one glass; Today shows "3/8 glasses" |
| Whole numbers only | A tick is one whole thing (numeric keypad, no decimals) |
| Units offered | Only things you do **one at a time**: times, glasses, cups, bottles, pills, sets, reps, pages, chapters, laps, meals, sessions, workouts, plus your own. **No measured units** (ml, km, kg, money): "one km per tick" isn't what anyone means; that's Track an amount |
| Storage | No schema change: the habit row already has a `unit` column; a check-off now fills it (empty = times) |
| Round 1 check habits | Unchanged: no unit means "times" |

**Copy under the Goal section** (the old "Keep 'times' for a tick…" is gone):

| Type | Footer |
|---|---|
| Check it off | "On Today, each tap on ✓ counts one. The unit just names what you're counting." |
| Track an amount, + adds 1 | "On Today, each tap on + adds 1. To add more at once, touch and hold the habit." |
| Track an amount, + asks | "On Today, + asks how much, so you can type it." |
| Time it | "On Today, ▶ starts a timer. To add time yourself, touch and hold the habit." |

These follow the T5 rules: no due, missed or minimum; one idea per sentence; the type's own verb.

## T8. The Unit screen: common units, grouping, and your own unit (P5–P8)

**Sources:**
- `Research/Temp/goals/round2/units_scan.py`: every word written right after a number in a goal or log phrase ("8 glasses a day", "a goal of 10k steps") across 1,238,784 reviews; counts in `units_counts.json`.
- `Research/Temp/goals/example_scan.py` (amount phrases).
- The round-1 report *New Habit Words and Units*.
- Currency and price words ("pounds", "euro", "usd" are almost always subscription prices) were set aside.

### What users show: the units they use, grouped by what they track

| What they track | Units, with mentions (goal phrases + amount phrases) | Total |
|---|---|---|
| **Drinking** | glasses 57 + 91 of water; cups 25 + 31; oz 4 + 33; ml 35; bottles 7; liters 7 | ≈ 290 |
| **Walking and running** | steps 22 + 113; km 3 + 68; miles 9 + 43 | ≈ 260 |
| **Reading and writing** | pages 23 + 94; books 5 + 28; words 5; chapters | ≈ 155 |
| **Exercise** | reps 32; push-ups 8 + 55; sets; workouts 10 | ≈ 105 |
| **Everyday** | meals 11 + 4; sessions 3; pills | small |
| **Cutting down** | cigarettes 5; drinks 3; coffees 4 | small |
| **Money** | $ / € / £ / ₹ in "save N a day" goals | small |
| Weight (kg, lbs) | 0 as goals: every "pounds" hit was a price | none |

**What that means:**
1. **Group by what people track, not by measurement type.** Someone setting up water thinks "water", not "volume". Round 1's groups (Count, Volume, Distance, Weight, Money) made them hunt: glasses under Count, litres under Volume.
2. **Most-used first in each group.** Show metric or imperial first by the phone's measurement system (`Locale.measurementSystem`): oz and miles first in the US, ml and km elsewhere. Keep both.
3. **Drop the Weight group** (no goal uses). Add **words, sets, workouts, meals, sessions, pills, bottles**. **Cigarettes, drinks and coffees** go under Cutting down, shown for Cut down habits only.
4. **Money** shows the phone's own currency first.

### Your own unit: making it obvious (P8)

**Round 1:** a bare text field at the top, "Your own unit, e.g. chapters", with a footer "Any word works". The user found it doesn't say you can **create** a unit. A text field on a list screen reads as search, or as nothing at all.

**Basis: reasoned from first principles, plus this app's own pattern.** Everywhere else in the form, making something new is a **green ⊕ row** ("Add Reminder", "Add Item", "New Time of Day"). Using that same row here says "create" in the app's own language.

| Part | Design |
|---|---|
| First section, **"Your own"** | A green ⊕ row, **"Create Your Own Unit"**. Tapping it swaps the row for a text field with the keyboard up ("e.g. prayers") and a **Done** button. Units you've made before are listed under it, most recent first |
| Footer | "Anything you count: prayers, chapters, glasses of juice." |
| Then the groups | Drinking · Walking and running · Reading and writing · Exercise · Everyday · Money *(Cutting down for Cut down only)* |
| Selected unit | A ✓ on its row; tapping a row picks it and goes back |
| **Check it off** (T7) | Shows only the one-at-a-time units: Everyday (times first), Drinking (glasses, cups, bottles), Exercise (reps, sets, push-ups, workouts, laps), Reading (pages, chapters, books) and your own. No ml, km, oz, miles or money |
| **Time it** | No Unit row at all (unchanged) |

- **Why not `.searchable`:** the list is about 30 short rows in six groups. That's scannable. A search bar would be one more thing to explain, and it would compete with the "Create" row for attention.
- **Why the field appears only after the tap:** an always-open field says "type here" before the user has decided to type. The ⊕ row says what will happen, and then shows the field.

## T9. Built: the Goal and Unit screens (28 Sep)

| Change | Where |
|---|---|
| Read-back at the top ("8 glasses" big, "a day" under it); VoiceOver reads "Your goal: 8 glasses a day" | `GoalReadBack` in `GoalEditor.swift` |
| Segments **Daily · Weekly · Monthly · Yearly**, no "Per" header; the next section is titled "Daily goal", "Weekly goal"… | `GoalPeriod.label`, `GoalEditor` |
| Summaries say "a day" / "a week" ("Once a day", "3 h a week"); "per day" is gone | `GoalPeriod.suffix`, `GoalDraft.summary` |
| Period copy from T5, with the user's own week start and end days; no "due", "no daily minimum" or "First period" | `GoalEditor.periodNote` |
| Footer under the amount says what Today does (T7). Validation text replaces it only when the number can't be used | `GoalEditor.todayNote`, `entryError` |
| **Check it off keeps ✓ with any unit**; whole numbers only; the unit is stored in the habit's existing unit column (`Habit.checkUnit`) and shown on Today as "3/8 glasses" | `GoalDraft.apply`, `RecordMapping`, `goalLine` |
| Unit screen: "Your own" first, with a green ⊕ **Create Your Own Unit** row that opens the field; groups by what people track; metric or imperial first by the phone's region; the phone's currency first; Check it off gets only one-at-a-time units; Cut down gets "Cutting down" | `UnitPicker` (`mode: .tick / .amount / .limit`) |
| The old `periodRangeForGoal` ("First period: …") helper is removed | `HabitStore` |

## T10. Checked and documented (28 Sep)

- **Goal flow only** (`HabitsUITests/GoalFlowUITests`, 8 tests on the iPhone 17 Pro simulator): all pass, including the two new tests, Check it off with glasses and the period copy.
- The full UI suite was **not** run; `NewFlowUITests` still uses round-1 labels and the old Goal stepper.
- **Fixed during the check:** the first version of the read-back pushed the Unit row under the number keyboard. It's now compact, and the amount and unit stay above the keyboard.
- **Screenshots:** `Habit Creation Evidence/round2_*.png`.
- **Spec updated:** `iOS/Docs/Specs/New Habit Goal and Time of Day.md` §3, "Round 2 changes".
