# New Habit Screen — A Native iOS Design

> **Superseded in part by [round 2](<New Habit Screen, Round 2 — Types, Frequency, One-Time Tasks.md>)** (types, frequency, checklists, one-time tasks, numbers, reminders, icons).
>
> **Written by Claude (Claude Code)**, 27 September 2026. Build-plan task 2 ([iOS/Product Roadmap.md](<../../../iOS/Product Roadmap.md>)). Authorship of every report is listed in the [Research Reports index](<../README.md>).

**The question.** What should the screen behind **+** look like, so it feels like Apple's own apps (Reminders, Calendar, Health) while covering our habit types, icons, colours and reminders?

**Basis.**
- **Our evidence:** the Feature Ledger cards on reminders (C008, C014, C039, C123), frequency (C043), units and partial progress (C048), quit mode (C019), steps (C173) and free icons and colours (C009). Also Today reports 33 (fixed places), 35–36 (quit habits) and Showing Non-Scheduled Days.
- **Apple's patterns:** the Reminders "New List" sheet, Calendar's "New Event" alerts, and Health's Medications schedule.
- **Product rules:** free is 5 habits on one phone with no account; the 6th habit shows one calm Plus screen.

---

## The short answer

1. **A sheet with Cancel and Add**, like Calendar's "New Event". Add is disabled until the habit has a name. Swiping the sheet down with unsaved changes asks "Discard Changes?", as Reminders and Calendar do.
2. **The name and appearance come first**, like Reminders' "New List" sheet: a large icon preview, the name field, then a row of colour circles and the icon grid.
3. **The type is one segmented control: Check · Count · Timer · Quit.** Every other section adapts to it.
4. **Steps are part of Check, not a fifth type.** "Add Step" works like subtasks in Reminders. A habit with steps is done when every step is done, and the card shows "1/4 steps".
5. **Cutting back is a Count with "At most"**, not a Quit habit (report 36). Quit habits are live counters with a start date and no goal.
6. **Repeat reads like Calendar and Health:** Every Day, On Specific Days (weekday chips), or a number of times per week.
7. **Reminders are a list of times with "Add Reminder"**, like Health's "Add a Time". There is no cap, and reminders are free (C008). Calendar stops at two alerts; our evidence says several reminders is praised when free (C014).
8. **Part of day** decides the card the habit sits in on Today: Anytime, Morning, Afternoon or Evening.

---

## 1. Why this layout (users show / first principles)

| Decision | Backing |
|---|---|
| Sheet, Cancel/Add, discard confirmation | *First principles* plus Apple's own create flows: creation is a self-contained task that can be abandoned without side effects |
| Appearance at the top | *Apple pattern:* Reminders lists put the preview, name, 12 colours and the icon grid on one sheet. Icons and colours are free (C009, "free-praised") |
| One type control | *Users show:* 30 reviewers find quit and zero-goal habits confusing when mixed with normal goals (C019). A single, visible type choice keeps each form short |
| Steps inside Check | *Users show:* sub-tasks are what heavy users ask for after categories (C173, 12 apps). *Apple pattern:* subtasks in Reminders. Keeping the same card format ("1/4 steps") follows our one-mental-model rule |
| "At most" for cutting back | *Users show:* report 36 (145 reviews on cutting back) separates a max-count habit from quitting |
| Specific days and times per week | *Users show:* the #1 unmet functional need (C043, 53 apps). Off days are neutral, never failures (Showing Non-Scheduled Days) |
| Several reminders, free | *Users show:* praised when free (C014), and reminders must fire reliably, once (C039). The first reminder is never paid (C008) |
| Part of day | *Product decision:* Today is organised by parts of the day (Figma 193:6) |

## 2. The screen, section by section

**Header card**
- A 64 pt icon preview in the chosen colour.
- The name field, large and centred: "Habit name".
- Colour: 13 system colours as circles. They adapt to dark mode because they are system colours.
- Icon: a "Choose Icon" row opens a grid of about 70 SF Symbols, grouped into Health, Fitness, Mind, Home, Work, Food and Other, with search. SF Symbols only, no emoji (decided 26 Sep).

**Type:** Check · Count · Timer · Quit (segmented).

| Type | Goal | Repeat | Steps | Part of day | Reminders |
|---|---|---|---|---|---|
| **Check** | "1× a day", Stepper 1–20 | yes | yes | yes | yes |
| **Count** | number + unit ("8 glasses"), "At least" or "At most"; the +1 button adds this increment | yes | – | yes | yes |
| **Timer** | minutes ("20 min") | yes | – | yes | yes |
| **Quit** | – ("Started" date and time, default now) | – | – | – (goes in Quitting) | – |

**Repeat** (Check, Count, Timer)
- A menu with three choices: Every Day, On Specific Days, or N Times a Week.
- On Specific Days shows seven weekday toggles, starting from the user's week start.
- N Times a Week turns the goal into a weekly one ("2/3 this week").

**Reminders**
- One row per time, each a compact time picker.
- The "Add Reminder" row has a green plus button, as in Health.
- Swipe to delete. Reminders fire only on the days the habit is due, and never after the habit is done that day (C039). Scheduling is built with local storage.

**Plus gate**
- At the 6th habit on the free plan, + opens one calm Plus screen instead of the form (decided 29 Sep).
- Below the limit, the form footer shows "3 of 5 free habits" quietly.

## 3. What is left out on purpose

- **Emoji icons:** dropped on 26 Sep, because they are illegible on the fill.
- **A custom colour picker:** 13 system colours keep contrast right in light and dark mode. Plus may add more later (C167).
- **Notes, categories and templates:** not in the first version of the form. Templates belong to the Library inside Add (navigation round 2).
- **Health-linked goals:** Plus, in the first update after launch (decided 28 Sep).

## 4. How it stays native (implementation rules)

The whole screen is built from stock SwiftUI controls, so it looks and behaves like Apple's apps and picks up every iOS update (Liquid Glass on iOS 26, Dynamic Type, dark mode, VoiceOver) for free. *First principles.*

| Need | Native control | Where Apple uses it |
|---|---|---|
| The page | `Form` (inset-grouped) inside a sheet with an inline title | Calendar "New Event", Reminders details |
| Cancel / Add | toolbar `cancellationAction` / `confirmationAction`; Add is bold and disabled until valid | Calendar, Contacts |
| Unsaved changes | `interactiveDismissDisabled` + a `confirmationDialog` ("Discard Changes") | Calendar, Mail |
| Type | segmented `Picker` | Health "Show All Data" filters, Clock |
| Choices in a row | menu-style `Picker` (Repeat, Part of Day, At Least / At Most) | Calendar Repeat and Alert rows |
| Numbers | `Stepper` + `LabeledContent`; number pad for amounts | Settings, Health |
| Times | compact `DatePicker(.hourAndMinute)` rows + an "Add" row with a green ⊕ | Health Medications "Add a Time", Clock |
| Colours and icons | circles and a grid with a selection ring, SF Symbols only; the icon grid is a pushed page with search | Reminders "Name & Appearance" |
| Lists you build | `ForEach` with swipe-to-delete and drag to reorder | Reminders subtasks |

**Never:** custom fonts, custom navigation bars, hand-drawn toggles, or colours outside the system palette (the app's own ink colour aside). Every control has a VoiceOver label and a 44 pt target.

## Sources

- Apple: [Reminders list colours and icons](https://www.macrumors.com/how-to/customize-look-of-reminders-lists-ios/) (12 colours, icon grid on one sheet); [Calendar allows two alerts](https://discussions.apple.com/thread/251855496) (Alert, then Second Alert appears).
- Our ledger: [Feature Ledger](<../Feature Ledger.md>) cards C008, C009, C014, C019, C039, C043, C048, C123, C173.
- [36. Quit Habits — A Live Counter, and Why Cutting Back Is Different](<../Home Screen and Visual Design/Today Screen Habit Cards/36. Quit Habits — A Live Counter, and Why Cutting Back Is Different.md>)
- [Showing Non-Scheduled Days](<../Home Screen and Visual Design/Non-Scheduled Days/Showing Non-Scheduled Days.md>)
