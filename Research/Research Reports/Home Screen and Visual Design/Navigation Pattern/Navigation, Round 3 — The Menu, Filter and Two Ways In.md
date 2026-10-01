# Navigation, Round 3 — The ≡ Menu, Filter and Two Ways In

> **Written by Claude (Claude Code)**, 30 September 2026. Authorship of every report is listed in the [Research Reports index](<../../README.md>).

**Status: research, not a decision.** It follows [Round 2](<Navigation, Round 2 — No Tab Bar, No Hamburger.md>) (26 Sep) and the Today top-area reports [8](<../Today Screen Top Area/8. Editing Day Sections — Where to Reach It.md>), [17](<../Today Screen Top Area/17. The View Sheet — Filter, Edit and Add in One Place.md>) and [20](<../Today Screen Top Area/20. Round 3, Put Together.md>).

**What changed.** The user has decided (30 Sep) that the top-left button is a **≡ menu** instead of the avatar. It holds everything that isn't used daily, including all of Settings.

**The questions.**
1. What goes in the ≡ menu, and in what order?
2. Progress and All Habits already have icons in Today's top bar. Should they also be in the menu? Will two ways to the same place confuse people?
3. Filter (beside +) does nothing yet. The plan is for it to edit and reorder day sections and filter by groups. Is that right? Does it double up with the menu and Settings?
4. Is the swipe-to-open side menu in ChatGPT and Claude native iOS, and what should ≡ open?

**Basis.**
- **New scan** of every review in the repository (App Store, Google Play and the native-app corpora, 1,487,223 reviews) for four sets of wording:
  - the same thing in two places ("redundant", "two places to", "same button in both");
  - menu and settings organisation ("buried in the menu", "couldn't find it in settings", "settings are a mess");
  - the ≡ icon ("three lines", "hamburger icon");
  - the filter button ("filter by", "filter button").
- **614 reviews matched. All were read.** 120 are about the question; the rest are about other things ("duplicate a habit", "charged twice", "setting up a habit", "three lines of text", workout filters in Apple Fitness, spreadsheet filters).
- **Reused:** the 24 Sep navigation study (1,791 reviews read), Round 2, and report 8 (672 editing reviews read).
- **External:** Apple's Human Interface Guidelines for Menus, Sidebars, Settings, Toolbars and Pull-down buttons (fetched 30 Sep 2026), and NN/g's study of duplicate links.

---

## The answer

1. **≡ opens one list of everything that isn't daily.** Places first, then settings grouped by topic, then Plus and Help (the menu below).
2. **Progress stays in the top bar and is also first in the menu. All Habits leaves the top bar and lives in the menu.** Two ways to the same place don't confuse people, as long as the four rules below hold. What does confuse people is clutter, and two ways in that behave differently.
3. **Filter is right for day sections, groups, "hide completed" and reordering.** Apple's guidance says exactly this: showing, hiding, filtering and reordering belong on the screen they change, not in Settings.
   - **The menu doesn't repeat Filter's controls.** It has one "Your Day" row, and that opens the same "Your Day" screen as Filter's **Edit** button.
4. **The side drawer is not native on iPhone.** ChatGPT and Claude build their own. The native choice is for ≡ to open a **sheet**, the way the avatar opens the account page in Apple's App Store and Health apps.
5. **Change the Filter icon.** Today it is `line.3.horizontal.decrease`, which is nearly the same three lines as ≡. Use Apple Mail's filter symbol, `line.3.horizontal.decrease.circle`.

```
Today, now                                         Today, suggested
┌──────────────────────────────────────┐          ┌──────────────────────────────────────┐
│ (●)            📊  ☑︎    ≡⌄  +        │          │ ≡              📊        ⊜   +        │
│ avatar    Progress AllHabits Filter Add│         │ menu        Progress     Filter Add   │
└──────────────────────────────────────┘          └──────────────────────────────────────┘
 5 buttons, 3 groups                                4 buttons, 3 groups
```

### The ≡ menu

Apple's rules for menus and sidebars apply:
- list the most important or most-used items first;
- group related items, with a gap between groups;
- show no more than two levels;
- keep the list short.

Each row opens its own screen, and nothing goes deeper than that screen.

| Group | Rows | What the row opens |
|---|---|---|
| **Places** | **Progress** (same icon and label as the top-bar button) | Progress |
| | **All Habits** | Habits · Quitting · Tasks · Archived, with pause, archive, delete and reorder |
| **Your day** | **Your Day** | Times of Day (add, rename, times), Day starts at, Week starts on, all on one screen |
| | **Reminders** | Whether notifications and alarms are allowed, with Open Settings when they're off |
| | **Appearance** | Light / Dark / System, App Icon, Completion feel (haptic and sound) |
| **Your data** | **Backup & Export** | Status ("Saved on this phone · today 09:14"), Snapshots, Export a copy, Import, Move to a new phone |
| | **Privacy** | Lock with Face ID, Erase all my data (and Delete account / Turn off sync for Plus) |
| **Plus** | **Plus**, with a quiet status line: "3 of 5 free habits", or "Plus · Lifetime" | Get Plus or Plus status, **Restore Purchases**, Plus Family, Account (Plus only) |
| **Help** | **Help & Feedback** | FAQ, Contact us (attaches diagnostics), Rate the app |
| | **About** | Version, privacy policy, terms |

That is 10 rows in 5 groups, and it fits on one screen of an iPhone SE.

**Why this order:**
- **Places come first** because they are used most.
- **Plus sits near the bottom as a status line,** not a banner. The ledger rules apply: no upsell nagging (C093), and the paywall appears at the moment of need (C137).
- **Restore Purchases lives inside Plus.** That's where people look for it, and failing to find it is a top complaint (C033).
- **Help is last** because it is the last resort, as in Apple's own apps.

### Filter (the button beside +)

It opens one sheet, as designed in report 17:

- **Times of Day:** chips to show one or several, with **Edit** on the heading line. Edit opens the **Your Day** screen.
- **Groups** (when built): chips, with **+ New group** and **Edit** on the heading line.
- **Show completed:** on or off.
- **Reorder habits:** opens the same reorder list as All Habits.

The filter is **remembered** when the app reopens. When a filter is on, the button fills and shows a count.

### The four rules for two ways in

A second way to reach something is fine when **all four** hold:

1. **Same name and same icon.** "Progress" with 📊 in the top bar is "Progress" with 📊 in the menu. Never "Stats" in one place and "Progress" in the other.
2. **It opens the same screen.** Never build a second editor for the same thing. Filter's **Edit**, the menu's **Your Day** and Today's bottom "Edit Times of Day" all open the one Your Day screen.
3. **The two are never on screen together.** The menu sheet covers the top bar, so the two Progress buttons are never side by side.
4. **Only the most-used places get a second way in.** Progress does. Everything else has one home, plus the in-context doors Apple asks for (Filter for filtering and reordering; a long-press on a row for editing that habit).

---

## Key findings

**1. Two ways to the same place is a small complaint. Clutter and inconsistency are the real problems.**
- **Only 13 reviews complain about the same thing being in two places,** out of 1.49 million screened. **7 of them are Fabulous,** an app reviewers already call cluttered (the 24 Sep study found 333 Fabulous "hard to navigate" reviews).
- **What they describe is overload, not the doubling itself:**
  - "there’s multiple different ways to do the same action which gets confusing and a bit overwhelming" `A10#56067` (Finch, 4★);
  - "too many ways to do a task too many ways to plan a day. It is simply overwhelming" `A24#26879` (2★);
  - "a lot of pop ups and redundant buttons that all collect the same information" `A24#32800`.
- **The sharpest failure is two ways in that behave differently** (2, both Fabulous):
  - "there are multiple ways to access the same things and it doesn’t check off one way if you access it via another way" `A24#37242`;
  - routines open "from button on the home page, and from a pop-up on the same page"; one shows yesterday's routine, the other is "somewhat more reliable" `A24#32854`.
  - **Rule 2 exists because of this.**
- **The one direct doubling complaint is about wasted space:** "Categories option at the bottom menu seems redundant as the option is available already in the top left menu. So the bottom menu space can be used for something else" `P2#5440` (HabitNow, 4★). **Rule 4 exists because of this:** a scarce top-bar slot shouldn't go to something the menu already holds, unless it is used often.
- **3 reviews like having more than one way in:** "multiple ways to do something so you’ll find your favorite way of organizing your habit" `A1#51697` (5★). Another asks for a button "on main screen (it’s not only in logbook)" `A59#12429`.

**2. The opposite failure is bigger: things kept only in a menu or Settings get lost.**
- **8 reviews want something moved back up front from a menu or Settings:**
  - Finch's first aid was "front and center… on the front page. It’s now buried in the menu" `A10#20221`;
  - "rearrange order and archive habits but it's a bit hidden in the settings menu" `A1#2380`;
  - "took me a while to figure out that the features I was looking for were hidden in settings" `P2#11332`.
- **9 more couldn't find a setting at all:** sync, notification sound, language, deleting a habit.
- **Earlier evidence says the same:**
  - the 24 Sep study: drawers hide things (17) and add a tap on every switch (13);
  - report 8: 174 of 286 reviews couldn't find how to edit, delete or rearrange;
  - Round 2: people who "only stumbled on the charts in the profile section by accident" `A86#765`.
- **So Progress must stay visible.** It is the one place people are meant to visit often, and it is the one that suffers most when hidden.

**3. Settings that are split up confuse people. A complete settings list is praised.**
- **5 reviews complain that one kind of setting is spread across places:**
  - "You should be able to access all settings by just pressing settings, not having to check which state the icon is in" `A23#2164` (Streaks, 2★);
  - notification settings "are spread all over the place and it's not clear which setting controls a notification" `P4#3964`;
  - "list settings is split into 3 places" `P84#15258`.
- **12 praise a settings area that is complete but calm:** "a variety of options that can be further adjusted by going into the advanced settings below the basic settings. Not overwhelming" `A31#2514`; "Really lots of options without being cluttered" `P84#11617`.
- **2 say rarely used things belong in Settings, not in the main bar:** "tabs at the bottom that are not useful… feedback. You could have just provided it under setting and not have a tab for it" `A43#135`.
- **So the ≡ menu should hold every setting, each kind in one place.** Day start, week start and the times of day sit together on **Your Day**, as report 8 proposed, and every way in leads there.

**4. Filter is where people expect to filter, arrange and see their groups.**
- **38 reviews from habit and to-do apps are about what a filter should do:**
  - 22 filter by tag, category or group: "I can tag each habit and filter it by tag which my type A brain loves" `A1#54362`;
  - 5 filter by time of day or day: "The ability to set and filter by time of day makes the app clean and easy to see what should be completed next" `A33#3588` (Habitify);
  - 5 filter by what's still to do;
  - 5 want **sorting or arranging next to the filter:** "a filter option to sort them by specific time, type of habit or importance or to be able to drag the habit bubbles to be in a custom desired order" `A54#295`.
- **4 want groups shown as sections, not only as a filter:** "I don’t find the filtering useful because I want to see all the goals at once" `A31#4696`. Filter is a way to narrow the list; it doesn't replace the sections on Today.
- **2 complain that the filter resets when the app reopens** `A1#55065`, `P8#13267`. So remember it.
- **Apple says the same:** "if people can adjust things like showing or hiding parts of the current view, reordering a collection of items, or filtering a list, make these options available in the screens they affect… Putting this type of option in a separate settings area disconnects it from its context" (HIG, Settings).
  - Apple's rule for the settings area is the other half: "Put general, infrequently changed settings in your custom settings area" (HIG, Settings).
  - Day start and week start are general and rarely changed, so they belong in the menu. Choosing which times of day to show today is a filter.

**5. The icons must not look alike.**
- "The 'settings' icon looks like a 'filter' icon, so that confused me at first" `P49#3684`.
- **Today's Filter icon is three lines** (`line.3.horizontal.decrease`). With ≡ in the same bar, the two are nearly identical.
- **The fix:** use `line.3.horizontal.decrease.circle`, the filter symbol Apple uses in Mail. Its circle and tapering lines tell it apart from ≡, and the two sit at opposite ends of the bar.
- This replaces round 3's **sliders** icon (report 20). Sliders often read as "settings", which the ≡ menu now holds.

**6. The swipe-open drawer is custom code. People who see ≡ expect a swipe.**
- **Apple:** there is no side drawer on iPhone. Sidebars are for iPad and Mac, and on iPhone Apple says "Consider using a tab bar first" (HIG, Sidebars). The native edge swipe on iPhone means **Back**.
- **ChatGPT and Claude** draw their own drawer: one screen plus an endless list of chats (24 Sep study, external notes).
- **2 reviews expect a swipe once they see ≡:**
  - "when i swipe right to open the left panel it doesn't slide, i need to touch the top left 3 lines" `P97#3628`;
  - "The hamburger menu button should be accessible by a gesture swipe from the left side of the screen" `N6#6260`.
- **8 more repeat the drawer complaints from the 24 Sep study:** reach, "outdated", an extra tap to switch views.
- **No review says people didn't recognise the ≡ icon.**
- **Two ways to build it:**
  - **(A, recommended) ≡ opens a sheet.** Fully native, with no gesture to fight. The sheet covers the top bar, which keeps rule 3.
  - **(B) A slide-in drawer like ChatGPT.** It needs custom gesture and animation code, which breaks the "native components only" rule in the repo's CLAUDE.md. It must open with a left-edge swipe only on Today, the one screen with nothing to go back to. It also needs its own VoiceOver focus handling.

---

## How this changes earlier research

| Earlier | Now |
|---|---|
| Round 2: avatar at the top left for the profile | **≡ menu** (the user's decision, 30 Sep). It holds everything the profile would have, plus All Habits |
| Round 2: All Habits in the title menu, or merged into Progress (addendum) | All Habits in the ≡ menu. If the Progress research (running now) makes Progress list every habit, the menu row can open Progress scrolled to its list, with no separate screen |
| Report 8: four ways in to edit day sections, including "Me → Settings → Your day" | Same four ways in, now "≡ → Your Day". All open **one** screen |
| Report 20: Filter ("View") uses a sliders icon | `line.3.horizontal.decrease.circle`, so it doesn't look like ≡ or like settings |

---

**Limits.**
- **Small counts.** Direct complaints about doubled ways in are few (13), and more than half come from one app (Fabulous, 7). Treat the four rules as reasoned from that evidence plus NN/g and Apple, not as measured.
- **English wording only** for the new scan.
- **NN/g's duplicate-link study is about web pages:** duplicates cost attention, are acceptable only for "a few critical links", and should never be visible together ([NN/g](https://www.nngroup.com/articles/duplicate-links/)). An app's menu sheet is a close match, not the same thing.
- **Not tested with people.** Before Figma, check that first-time users can:
  - find Restore Purchases, Backup and Day start in the menu;
  - tell ≡ and Filter apart;
  - understand that Filter's Edit and the menu's Your Day are the same screen.

**Evidence:** [Navigation Evidence/Round 3](<Navigation Evidence/Round 3/>):
- `scan.py`, the four match files (`DUP.tsv`, `ORG.tsv`, `ICON.tsv`, `FILT.tsv`, 614 reviews);
- `nav3-classification.py`, with the hand codes for the 120 relevant reviews (0 unknown IDs, 0 duplicates);
- the Apple guideline text (`hig-*.txt`, fetched 30 Sep 2026).

---

## Addendum (30 Sep 2026): the user's final decision

**Final. This replaces the suggestions above where they differ; the report itself is left as it was.**

- **Progress, Habits (All Habits) and Tasks all go in the ≡ menu,** and leave Today's top bar. The user's reasoning: a menu is not hiding, people will find them, and the most used places sit at the very top of the menu.
- **Tasks get their own row** (every task the user has made), beside Habits.
- **≡ slides in from the left over Today** (a side menu), rather than opening a sheet, built from native parts and motion.
- **Kept from this report:** Filter holds times of day, groups, show completed and reorder; its icon changes so it doesn't look like ≡; one screen per thing however many ways in; settings grouped by topic, with Plus and Help at the bottom.
- Built on the `sidebar` branch: `iOS/Docs/Checklists/Sidebar Menu.md`.
