# Groups — What to Build

Written by Claude (Claude Code), 30 September 2026. Build Plan #68 (tags or grouping, C045) and the group stats left over from #60g. Checklist: [Groups](<../Checklists/Groups.md>).

**Where the evidence comes from.** No new review mining was needed: the existing reports already cover groups in depth, and this plan puts them together.

- [Habit Tracker — Day Structure Explained in Plain English](<../../../Research/Research Reports/Day Structure and Organization/Habit Tracker — Day Structure Explained in Plain English.md>), Part 2: **2,228 group reviews** hand-coded (asks, praise, friction, filter vs tabs vs headers, group stats), and Part 6's build checklist.
- [Organization and Notes Deep Dive](<../../../Research/Research Reports/Day Structure and Organization/Habit Tracker — Organization and Notes Deep Dive.md>) §3: what "a group" means and the free scope.
- [Day Sections, Categories and Routines Decision](<../../../Research/Research Reports/Day Structure and Organization/Habit Tracker — Day Sections, Categories and Routines Decision.md>): groups are an optional filter, one per habit, never a replacement for day sections.
- Today top-area reports [13](<../../../Research/Research Reports/Home Screen and Visual Design/Today Screen Top Area/13. The Filter Sheet — Time of Day, Group, Completed and Editing.md>), [17](<../../../Research/Research Reports/Home Screen and Visual Design/Today Screen Top Area/17. The View Sheet — Filter, Edit and Add in One Place.md>), [18](<../../../Research/Research Reports/Home Screen and Visual Design/Today Screen Top Area/18. Counts, Empty Groups and Habits Not Due Today.md>), [24](<../../../Research/Research Reports/Home Screen and Visual Design/Today Screen Top Area/24. Group Order — Manual or Automatic.md>): the Filter sheet, chip counts, empty groups, group order.
- [Navigation, Round 3](<../../../Research/Research Reports/Home Screen and Visual Design/Navigation Pattern/Navigation, Round 3 — The Menu, Filter and Two Ways In.md>): groups live in Filter; one editor screen however many ways in.
- [The Progress Page](<../../../Research/Research Reports/Progress and Statistics/The Progress Page — What People Need, and How to Build It.md>) §15: group stats on Progress.

## 1. What people expect, praise and complain about

**What a group is.** A named bucket for habits by area of life: Health, Work, Study, Home, Medicines. Personal organisation, not a social group, not a parent habit, not a routine. It answers *what area*; day sections already answer *when* (57 reviews ask for exactly that split).

**Asks (933 reviews, 41.9%).** Named buckets, mainly because the list gets long and cluttered (73 say so); 95 already fake groups with colours. Loop, which has no groups, supplies 344 of the asks.

**Praise (668, 30.0%).** Tidiness, and making your own groups.

**Complaints (474 friction reviews, 22% of them 1–2★, 28 said they were leaving):**

| Complaint | n | So we |
|---|---|---|
| Can't edit, rename or delete a group | 110 | Full edit: rename, recolour, reorder, delete |
| Too few colours or icons | 83 | The 13 habit colours |
| Group order: alphabetical or random, "Before bed" above "Morning" | 70 | A–Z by default, drag for your own order, one order everywhere |
| Paywall or caps ("only 2 categories free") | 70 | No cap, free |
| Bugs: a group made but not shown | 66 | UI tests for create, filter, edit, delete |
| Forced preset categories, mandatory group | 48 | No presets, never required, nothing shows until you make one |

**Two risks (few reviews, severe):** hidden habits (untagged habits couldn't be found, "All" didn't show everything) and forced categorisation. Rules: All shows everything, habits with no group are always in All, an active filter is always obvious, groups are optional and invisible until the first one exists.

**How to look at one group (260 reviews):** filter 93, separate lists 81, tabs 71. Headers on the list (158) mostly ask for folding (51), which sections already do; group headers under section headers would be two levels of headings. **So: a filter, not tabs or headers.**

**Group stats (174 reviews):** filter the stats to one group 48, a % per group 37, compare groups 31, a trend per group 24, an overall number 20, a target per group 16 (later).

## 2. Where groups live, and how each place works

Groups show up in five places. **Each place does one job, and all of them edit the same data through one editor** (Navigation Round 3's rule 2: never a second editor for the same thing).

| Place | Job | How it works |
|---|---|---|
| **Today → Filter (the button beside +)** | Look at one group; the home of groups | A sheet: **Groups** heading with **Edit**; chips **All · ● Health 5 · ● Mind 0 · ○ Reading – · + New Group**. The number is how many habits the chip shows on the day open on Today. Before any group exists: "Group habits by area, like Health or Work, then filter by them here." and **+ New Group** |
| **Today's list while filtered** | Make the filter obvious and easy to leave | The Filter icon fills; a chip row at the top of the list, "● Health ✕", clears it. Sections, Quitting and Paused show only that group; Start plays only what's shown. Nothing from the group that day → "Nothing from Mind on this day" with **Show All** |
| **Groups editor** (Filter → Edit) | The inventory: every group with its total ("4 habits") | Tap to edit (name, colour, habits, Pause These Habits…, Delete). Drag to reorder (→ "Your order"), **Sort A to Z** to go back. Swipe to delete: "Its habits stay, without a group" |
| **New / Edit Habit form** | Put this habit in a group | A **Group** row (None · Health …) beside Time of Day, shown once a group exists (so nothing new appears for people who never use groups). Its screen lists None, the groups in order, and **New Group** |
| **Habits page** (≡ → Habits) | See habits by area | With groups, the Habits list is one section per group in group order, then **No Group**; drag reorders within a section |
| **Progress** (≡ → Progress) | Group stats | A chip row under the range control: **All · Health · Mind …** filters the overview, the numbers, the rows and the Day sheet. With All: a **Groups** card, one bar per group with "24 of 30 · 80%" in group order (never ranked, so nothing is named worst), and the Habits card split by group with each group's done-of-planned in its heading. The overall number is All |

**Not in the ≡ menu.** The menu doesn't repeat Filter (rule 4: only the most-used places get a second way in).

**Decisions made for this build (reasoned from first principles where the reports leave it open):**

- **One group per habit** (the reports' v1; several per habit complicates filters and stats; 18 reviews ask).
- **One group at a time in the filter** (the reports' v1: multi-select is later).
- **The filter is remembered** when the app reopens (Navigation Round 3); the chip row keeps it obvious. A deleted group falls back to All.
- **The day bar still counts the whole day.** It agrees with the calendar and Progress; section headers' "N left" count what's shown.
- **Today and Progress keep their own group choice.** Today is for doing, Progress for looking; changing one shouldn't move the other.
- **Group names up to 24 characters** (the habit-name limit); two groups can't share a name.
- **Tasks can be in groups** too (they're on Today); quit habits can.
- **Pause a group** is "Pause These Habits…" in the group's editor, the same Pause sheet as for several habits (Part 6's "pause a group" for holidays).

**Later, not now:** time-of-day chips and "Show completed" in the same Filter sheet, the "Not due today (n)" row, several groups at once, a colour dot on Today's rows (rows already carry the habit's own colour), group targets, time per group, group widgets.

## 3. Data

No database change: groups live in the settings table, like notes, pauses and costs.

- `groups` → JSON `[HabitGroup]`, in the saved order: `id`, `name`, `color`, `habits: [UUID]` (the members, so one write changes a group).
- `groups_order` → `"manual"` once the person drags; absent means A to Z.
- The store keeps `groups` (in display order) and `groupOf: [habit: group]`, rebuilt only when groups change, so every lookup is one dictionary read.
- One group per habit is kept by the store: putting a habit in a group takes it out of any other.
- Deleting a habit leaves its ID in the list; every read ignores IDs with no habit. Deleting a group keeps its habits and their history.

## 4. Speed

- Today filters with one dictionary lookup per habit; chip counts are worked out only while the Filter sheet is open.
- Progress's snapshot takes the group; its cache key includes it, and day scores are kept per group, so switching chips back and forth reuses work. Group bars reuse the same day-score cache.
- `-perf-many` gets four groups, and `PerformanceUITests.testProgress` switches group chips as well as ranges.

## 5. Tests

- `-progresscheck` gains group cases: a group's day score and tally equal the sum over its habits; All equals every group plus No Group; membership stays one per habit.
- `GroupsUITests`: first group from Filter (helper line → New Group → name, colour, habits); filter Today and clear it with the chip; the empty-day state; rename and delete from Edit; Group row in the habit form; Progress chips and the Groups card.
