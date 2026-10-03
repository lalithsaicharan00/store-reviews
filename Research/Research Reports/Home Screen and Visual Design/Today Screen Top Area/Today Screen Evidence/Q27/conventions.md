# Filtering and Arranging Today: iPhone Conventions and What People Expect

Written by Claude (Claude Code), 3 October 2026. These are working notes in `Research/Temp/` and are not a report yet.

**Question.** On Today, people need to (1) filter what shows by group, which is temporary and never changes data, and (2) arrange the day: add, rename and remove times of day, and order the habits inside each one. Both should be obvious without a tutorial and without clutter. What default order should a section use?

**How this was done.** Every claim below comes from a page I read in full on 3 October 2026.

- **Apple's design guidance:** the Human Interface Guidelines (HIG), read through Apple's own JSON feed of each page.
- **Apple's support guides:** these now serve the iOS 27 iPhone User Guide by default. Where only the Mac guide states a behaviour, I say so.
- **Usability research:** Nielsen Norman Group (NN/g) and Baymard.
- **Two WWDC session transcripts.**
- **Official help pages** of the habit and to-do apps.

**What I couldn't confirm:**

- Streaks' help site (streaks.app/support, streaksapp.com/faq) returned 503 or reset the connection. Its App Store page says nothing about ordering, so Streaks isn't covered.
- The current iPhone Music guide page came back empty. The Music finding uses Apple's iOS 15 page.
- Apple's iPhone guide doesn't say where a **new** reminder lands in a manually ordered list. Someone has to check that on the phone.

The repository's rule applies throughout: other apps are evidence of **what people are used to**, never a reason to copy.

---

## 1. Apple Human Interface Guidelines

**Menus, and the pull-down buttons that open them**

- **People already know how menus work.** "Menus are ubiquitous in apps and games, so most people already know how to use them … people understand that opening a menu reveals one or more menu items, each of which represents a command, option, or state that affects the current selection or context." https://developer.apple.com/design/human-interface-guidelines/menus
- **Put the most-used items first and keep groups together.** "Prefer listing important or frequently used menu items first." The guidelines also say to group related items and separate the groups with a separator. https://developer.apple.com/design/human-interface-guidelines/menus
- **Sorting is Apple's own example of a submenu.** "Instead of offering separate menu items for Sort by Date, Sort by Score, and Sort by Time, a game could present a menu item that uses a submenu … use the repeated term — in this case, Sort by — in the menu item's label." https://developer.apple.com/design/human-interface-guidelines/menus
- **A checkmark shows what's on, and one item can clear everything.** "Consider using a checkmark to show that an attribute is currently in effect." Also: "Consider offering a menu item that makes it easy to remove multiple toggled attributes." https://developer.apple.com/design/human-interface-guidelines/menus
- **A Sort button is a textbook pull-down button.** "A Sort button could use a menu to let people select an attribute on which to sort." https://developer.apple.com/design/human-interface-guidelines/pull-down-buttons
- **Don't hide a screen's main actions in one menu.** "Avoid putting all of a view's actions in one pull-down button. A view's primary actions need to be easily discoverable, so you don't want to hide them in a pull-down button that people have to open before they can do anything." https://developer.apple.com/design/human-interface-guidelines/pull-down-buttons
- **A "More" (…) button costs discoverability.** "A More button … can also hinder discoverability. Although people generally understand that a More button offers additional functionality related to the current context, the ellipsis icon doesn't necessarily help them predict its contents." https://developer.apple.com/design/human-interface-guidelines/pull-down-buttons
- **A menu needs at least three items to be worth opening.** "Listing a minimum of three items can help the interaction feel worthwhile. If you need to list only one or two items, consider using alternative components … such as buttons to perform actions and toggles or switches to present selections." https://developer.apple.com/design/human-interface-guidelines/pull-down-buttons
- **A choice of one option among several is a pop-up button, and it needs a good default.** Use one "to present a flat list of mutually exclusive options or states", and "Provide a useful default selection … make the default selection an item that most people are likely to want." https://developer.apple.com/design/human-interface-guidelines/pop-up-buttons

**Context menus (touch and hold)**

- **People may not know a context menu is there.** "Although a context menu provides convenient access to frequently used items, it's hidden by default, so people might not know it's there." https://developer.apple.com/design/human-interface-guidelines/context-menus
- **Everything in it must also be in the main interface.** "Always make context menu items available in the main interface, too." https://developer.apple.com/design/human-interface-guidelines/context-menus
- **Offer it everywhere or nowhere.** "Support context menus consistently throughout your app. If you provide context menus for items in some places but not in others, people won't know where they can use the feature and may think there's a problem." https://developer.apple.com/design/human-interface-guidelines/context-menus
- **Hide items that don't apply, and put destructive ones last.** "Hide unavailable menu items, don't dim them." Destructive items such as Delete or Remove go "at the end of the menu". https://developer.apple.com/design/human-interface-guidelines/context-menus

**Lists, edit mode and toolbars**

- **People like reordering, and on iPhone it goes with an edit mode.** "People appreciate being able to reorder a list, even if they can't add or remove items. In iOS and iPadOS, people must enter an edit mode before they can select table items." https://developer.apple.com/design/human-interface-guidelines/lists-and-tables
- **Edit is the one action that should be a word, not a symbol.** "Prefer simple, recognizable symbols for items instead of text, except for actions like edit that aren't well-represented by symbols." https://developer.apple.com/design/human-interface-guidelines/toolbars
- **On iPhone, the toolbar holds only the essentials.** "Prioritize only the most important items for inclusion in the main toolbar area … Create a More menu to include additional items." But: "Try to include all actions in the toolbar if possible, and only add this menu if you really need it." Also, "In general, aim for a maximum of three" groups. https://developer.apple.com/design/human-interface-guidelines/toolbars

**Gestures and drag and drop**

- **The standard meanings are fixed.** In Apple's gesture tables, touch and hold means "Open a contextual menu", touch and drag means "Move an object to a new location", and swipe means "Reveal actions and controls". https://developer.apple.com/design/human-interface-guidelines/gestures
- **A gesture is a shortcut, never the only way.** "Use shortcut gestures to supplement standard gestures, not replace them … people also need simple, familiar ways to navigate and perform actions, even if it means an extra tap or two." https://developer.apple.com/design/human-interface-guidelines/gestures
- **A gesture that does nothing must say so.** "Indicate when a gesture isn't available … people might think your app has frozen." https://developer.apple.com/design/human-interface-guidelines/gestures
- **Dragging needs continuous feedback.** "To help people feel in control the process, it's crucial to provide clear and continuous feedback throughout." Also: "Scroll the contents of a destination when necessary." https://developer.apple.com/design/human-interface-guidelines/drag-and-drop

**Filtering and search**

- **A local search can act as a filter, and the scope must be visible.** "Search acts as a filter on the current view when searching your songs and albums in the iOS Music app." And: "Clearly display the current scope of a search." https://developer.apple.com/design/human-interface-guidelines/searching

**Sheets**

- **A sheet is for a short task.** A sheet suits "presenting a simple task that they can complete before returning to the parent view". "Keep sheet interactions brief and occasional." https://developer.apple.com/design/human-interface-guidelines/sheets
- **Done always comes with a way out.** "If you provide a Done button, always pair it with a Cancel button." Cancel goes on the leading edge and Done on the trailing edge. https://developer.apple.com/design/human-interface-guidelines/sheets
- **The half-height sheet suits progressive disclosure.** "In an iPhone app, consider supporting the medium detent to allow progressive disclosure of the sheet's content." https://developer.apple.com/design/human-interface-guidelines/sheets

**Onboarding and tips (TipKit)**

- **Ideally, no tutorial.** "Ideally, people can understand your app or game simply by experiencing it." "Consider providing a collection of context-specific tips instead of a single onboarding flow." "Provide reasonable default settings so most people can immediately start interacting." https://developer.apple.com/design/human-interface-guidelines/onboarding
- **Tips are for simple, less obvious features.** "Tips are a great way to teach people about new or less obvious features." "Use tips for simple features … If a feature requires more than three actions, it's probably too complicated for a tip." https://developer.apple.com/design/human-interface-guidelines/offering-help
- **Show a tip only to people it helps, and not too often.** "People who've already used a feature won't appreciate viewing a tip that describes it." Apple suggests a cadence such as "once every 24 hours". https://developer.apple.com/design/human-interface-guidelines/offering-help

**WWDC sessions**

- **Design with iOS pickers, menus and actions (WWDC20).** Menus serve "disambiguation, navigation, selection, and showing secondary options." "Menus used for selection receive check marks." The Sort button in Music and in Podcasts is the session's example. A warning: "Hiding all actions in a menu is definitely not an approach we encourage. It hides primary actions behind an additional tap, and it doesn't give you a good understanding of what this view can do for you." https://developer.apple.com/videos/play/wwdc2020/10205/
- **Make features discoverable with TipKit (WWDC23).** TipKit can "help with discovery of a hidden feature, or show a faster way to accomplish a task." The session's example tip appears only after a person "has gone to the Backyard Detail View at least three times". The tip is withdrawn once the person does the action (`.userPerformedAction`) or after a set number of showings (`maxDisplayCount`). https://developer.apple.com/videos/play/wwdc2023/10229/

---

## 2. How Apple's own iPhone apps handle these jobs (iOS 27 guide unless noted)

**Reminders, inside one list.** Everything that arranges a list sits behind one More (…) button.

- **What the More button holds.** Apple: "While viewing a list, tap [the More button], then do any of the following". The items are Show List Info; Select Reminders; "Sort items by due date, creation date, priority, or title … Tap Sort By"; and Delete List. https://support.apple.com/guide/iphone/edit-and-organize-a-list-iph82596cb20/ios
- **Sections are made from the same menu.** "Create a new section: Tap [More], tap New Section, then enter a name." The same menu holds View as Columns and Auto-Categorize. https://support.apple.com/guide/iphone/edit-and-organize-a-list-iph82596cb20/ios
- **Every other section edit happens directly on the list.** "Rename section: Tap the section name, then enter a new name." "Move a section: Touch and hold the section, then drag it to a new position." "Remove a section: Swipe left on the section, then tap Delete. Note: Removing a section will also delete the section's reminders." "You can't move the Others section." https://support.apple.com/guide/iphone/edit-and-organize-a-list-iph82596cb20/ios
- **Items are reordered by dragging, with no edit mode.** "While viewing a list, touch and hold an item you want to move, then drag it to a new location." https://support.apple.com/guide/iphone/edit-and-organize-a-list-iph82596cb20/ios
- **Hiding completed items is a toggle in the same menu.** "Completed items are hidden on your list. To unhide completed items, tap [More], then tap Show Completed." https://support.apple.com/guide/iphone/complete-items-iph3fb74d597/ios

**Reminders: how a manual order and a sort work together.** The Mac guide is the only one that states this.

- "You can also sort lists manually by dragging them into the order you want."
- Under an automatic sort, "The existing reminders are sorted immediately, and any new reminders you add to the list are sorted automatically."
- "**If you drag a reminder in a list that's sorted automatically, the sort option for the list changes to Manual.**"
- "If you sort a list manually and subsequently change the sort option to Automatic, you can choose View > Sort By > Manual to return the list to the previous manual sort order."

In short, the manual order is kept, and dragging returns the list to it. Source: https://support.apple.com/guide/reminders/sort-reminders-in-lists-remn922d0b42/mac

**Reminders' Today list already has time-of-day sections.** It shows Morning, Afternoon and Tonight, and moving an item between them changes its time. "If you drag a reminder in the Today Smart List from one section to another, the reminder's time is updated." (Mac guide) https://support.apple.com/guide/reminders/move-reminders-remnda262a43/mac

A review of iOS 16 described it this way: "reminders are now grouped by morning, afternoon, or evening tasks automatically based on their due time … Morning is 9 AM, afternoon is 3 PM, and Tonight is 6 PM." That is a reviewer's account, not Apple's. https://www.macstories.net/stories/ios-16-the-macstories-review/12/

**Reminders: arranging the lists themselves uses the classic edit mode.**

- "Tap [More], tap Edit Lists, then … Rearrange lists and groups: Drag [the Reorder button] a list or group to a new location." This is a separate screen with handles and a Done button.
- Smart Lists turn on and off on the same Edit Lists screen.
- Source: https://support.apple.com/guide/iphone/organize-multiple-lists-iph2c6cf708e/ios

**Reminders: lasting filters are Smart Lists and tags.**

- "You can easily filter items across all your lists using Smart Lists … Tap Edit Filters, choose one or more filters." https://support.apple.com/guide/iphone/use-smart-lists-iphe882772ed/ios
- "Tap one or more tag buttons in the Tags section to view tagged reminders across all of your lists." https://support.apple.com/en-us/119953

**Notes.** Sorting and viewing live in a Folder Actions (…) menu.

- "Tap [the Folder Actions button] … Choose View as Gallery or View as List. Sort the notes by title or date: Tap Sort By."
- "By default, the notes are grouped by date. To turn this off, tap [Folder Actions], tap Group By Date."
- A default sort for all folders is set in Settings → Apps → Notes. Pinning uses touch and hold or a swipe.
- Source: https://support.apple.com/guide/iphone/organize-in-folders-ipha61270292/ios

**Files.** The More menu holds view and sort, and arranging uses edit mode.

- View and sort: "From an open location or folder, tap [the More button]. Choose an option: Name, Kind, Date, Size, or Tags." https://support.apple.com/guide/iphone/find-and-view-files-and-folders-iphe4bff8827/ios
- Arranging the Browse screen: "tap [the More button], tap Edit … Change the order of an item: Touch and hold [the Reorder button], then drag it." https://support.apple.com/guide/iphone/view-files-and-folders-iphc61044c11/ios

**Mail.** Filtering has its own one-tap toggle and a visible label.

- "Tap [the Toggle Filtering button] in a mailbox list. Tap 'Filtered by,' then select or turn on the criteria … To turn off all filters, tap [the Toggle Filtering button]."
- Sorting isn't offered at all.
- Source: https://support.apple.com/guide/iphone/filter-emails-iph057d5e515/ios

**Photos.** Sort and filter share one button. Sort sits at the top and filters below, with a way out.

- "Tap [the Sort and Filter button], then tap one of the following options at the top of the list: Added … Captured."
- "You can apply multiple filters at the same time … To remove the filters and return to the full library, tap Remove Filters."
- Source: https://support.apple.com/guide/iphone/sort-and-filter-the-photo-library-iph2e66e2f2c/ios

**Health.** Arranging is an Edit button beside the section it changes.

- "Tap Summary, then tap Edit next to Pinned … Reorder the health categories in your Pinned list: Drag [the Reorder button] … When you're finished, tap [the Done button]."
- Source: https://support.apple.com/guide/iphone/view-your-health-data-iphe3d379c32/ios

**Music (iOS 15 guide).** Sort is a labelled button above the list, and Edit changes which categories show.

- "Tap Sort, then choose a sorting method, such as title, artist, recently added, or recently played."
- "To change the list of categories, tap Edit."
- Source: https://support.apple.com/guide/iphone/view-albums-playlists-and-more-iphbddea0e5e/15.0/ios/15.0

**Patterns across Apple's apps**

1. **Filter is a separate, visible control whose state shows.** Mail has a toggle plus a "Filtered by" label. Photos has a "Remove Filters" item. No Apple app puts its filter inside an edit mode.
2. **Sort is a menu choice with a checkmark,** found under a More (…) or Sort button. It isn't a mode you enter.
3. **Arranging appears two ways.** Some apps use direct manipulation: touch and hold, then drag, as in Reminders items and sections. Others use an explicit **Edit → ≡ handles → Done** screen, as in Reminders' Edit Lists, Files' Browse and Health's Pinned. **Rename**, where documented, is a tap on the name (Reminders sections) or a context-menu item (Notes folders).
4. **Making a new section** goes through the More menu ("New Section").
5. **A manual order is a first-class sort option** (Reminders), and dragging switches the list back to it.
6. **Where a new item lands** isn't documented for iPhone. Under an automatic sort, new items are sorted in (Mac guide).

---

## 3. Usability research on mental models and these patterns

**Mental models**

- **What a mental model is, and why designs that break it fail.** "A mental model is what the user believes about the system … Mismatched mental models are common, especially with designs that try something new." On Jakob's Law: "Users spend most of their time on websites other than yours … People expect websites to act alike." (NN/g, Megan Chan, 2024, updated from Jakob Nielsen's 2010 article) https://www.nngroup.com/articles/mental-models/
- **People keep the defaults.** "People tend to stick to the defaults … they rarely utilize fancy customization features, making it important to optimize the default user experience, since that's what most users stick to." (Nielsen, 2005) https://www.nngroup.com/articles/the-power-of-defaults/

**Do people find long-press menus and other hidden gestures? Mostly no.**

- **Long press is hidden, and a tip doesn't fix that.** "Because the default view of a contextual menu is usually hidden, users may not know it is available." Also: "these gestures are not discoverable and have still not become standard. Make sure to include other ways to perform the actions … Even if your app uses an initial tip to disclose gestures … it is unlikely that people will naturally remember to use it later on in the app." (NN/g, Anna Kaley, 2019) https://www.nngroup.com/articles/contextual-menus/
- **Swipe has the same problem.** "Lack of signifiers makes it unclear where the contextual swipe can be used … even those who have learned it may occasionally forget to perform it." The advice is to keep swipe for destructive actions. (NN/g, Angie Li, 2017) https://www.nngroup.com/articles/contextual-swipe/
- **Hiding things roughly halves how often they're found.** "Discoverability is cut almost in half by hiding a website's main navigation." That figure comes from 179 participants on phones and desktops. (NN/g, Pernice and Budiu, 2016) https://www.nngroup.com/articles/hamburger-menus/
- **Shortcuts should be "readily available, yet easy to ignore".** Teach a shortcut "after a user performs the action in the standard way. Just-in-time help … makes it more likely that users will attend to the tip." (NN/g, Krause and Harley, 2024) https://www.nngroup.com/articles/ui-accelerators/

**Dragging to reorder on a phone**

- Drag and drop is "particularly useful for grouping, reordering, moving".
- On touchscreens, use it only when "you have clear evidence … that your users expect drag–and–drop to be available, and there is no reasonable alternative with lower interaction cost (such as … a menu-driven interaction)". On mobile, "using menus to move a file to a different folder can be less error-prone".
- When reordering, "show the background objects moving out of the way", use a haptic "bump" on grab, and keep it accessible.
- Source: NN/g, Page Laubheimer, 2020. https://www.nngroup.com/articles/drag-drop/

**Teaching without a tutorial**

- **Progressive disclosure:** "Initially, show users only a few of the most important options. Offer a larger set of specialized options upon request." The worry that this leaves people with a limited picture is "groundless". (Nielsen, 2006) https://www.nngroup.com/articles/progressive-disclosure/
- **Empty states and in-context cues beat up-front tutorials.** "In-context learning cues … [are] generally more successful than forced tutorials shown to the user at initial use." (NN/g, Kate Kaplan, 2021) https://www.nngroup.com/articles/empty-state-interface-design/
- **Coach marks get dismissed.** "Users tend to dismiss them quickly and do not read thoroughly." "Avoid chains of tips." (NN/g, Aurora Harley, 2014) https://www.nngroup.com/articles/mobile-instructional-overlay/
- **Skip onboarding where possible.** "Skip onboarding whenever possible … build on existing mental models." Deck-of-cards tutorials "didn't improve task performance." (NN/g, Alita Kendrick, 2020) https://www.nngroup.com/articles/mobile-app-onboarding/

**Do people tell filtering apart from arranging? They mix up the words but react differently to each.**

- **The words get swapped.** "Many users mix up the terminology or use the terms interchangeably … Filters set the criteria for whether a given product is in- or excluded … (i.e. what is displayed) whereas Sorting determines the sequence … (i.e. how it is displayed)." (Baymard, 2015) https://baymard.com/blog/category-specific-sorting
- **Same finding in testing.** "Users often conceptually mix sorting and filtering (during testing users often referred to filtering as 'sorting', and vice versa)." (Baymard, 2014) https://baymard.com/blog/faceted-sorting
- **A filtered list must say it's filtered.** Without an overview of applied filters, people get "no obvious and immediate confirmation that filters have been applied" and "not having a quick way to remove filters". 28% of sites have no overview. (Baymard, 2020) https://baymard.com/blog/how-to-design-applied-filters
- **What a filter is.** "Filter means anything that analyzes a set of content and excludes some items." A simple filter "can often be easier to understand and faster to use" than faceted navigation. (NN/g, Kathryn Whitenton, 2014) https://www.nngroup.com/articles/filters-vs-facets/
- **Instant filtering is fine when results are instant.** "If you expect the queries to be instantaneous … interactive filtering will be less offensive." (NN/g, Katie Sherwin, 2016) https://www.nngroup.com/articles/applying-filters/

**What default order do people expect in a personal list?**

- **A to Z rarely matches how people think.** "Ordinal sequences, logical structuring, time lines, or prioritization by importance or frequency are usually better than A-Z listings." Also: "People Rarely Think A–Z … the items have an inherent logic that dictates a different sort order, which makes A–Z listings directly harmful because they hide that logic." A to Z helps mainly when people know the name they're looking for. (Nielsen, 2010) https://www.nngroup.com/articles/alphabetical-sorting-must-mostly-die/
- **No direct study found.** I found no published study comparing insertion order with alphabetical order for a *personal* list. The evidence that exists is about what apps make people used to (section 4): Todoist projects keep the order things were added, Things has no A to Z sort at all, and Reminders keeps a manual order and offers creation date as a sort.
- **A list that reorders itself is hard to learn.** "Microsoft Office experimented with adaptive menus that reordered themselves based on recency. People hated them because nothing stayed where you left it." (NN/g, Raluca Budiu, 2025) https://www.nngroup.com/articles/liquid-glass/ This bears on sorting by reminder time: rows would move whenever a time is added or changed.

**How do people expect a custom order to work with a sort?**

- **Apple Reminders: the custom order is one of the sort options, and dragging returns to it.** Choosing another sort keeps the custom order, which comes back intact. https://support.apple.com/guide/reminders/sort-reminders-in-lists-remn922d0b42/mac
- **Todoist: grouping turns dragging off, and sorting applies inside each section.** "If a grouping option is applied … you can't drag or manually reorder your tasks." "Tasks are sorted within their own sections." https://www.todoist.com/help/todoist/features/sort-or-group-tasks-in-todoist-WFWD0hrb
- **Separate orders per view add complexity.** Habitify keeps separate orders for All Habits, for each Time of Day and for each Area, and documents three different places to set them (section 4). That is evidence of how complicated it gets, not of what people want.

---

## 4. Habit and to-do apps, from their official help pages (what people are used to, not a model to copy)

**Things 3**

- **Manual order only.** "It's not possible to sort content alphabetically in Things. You can always manually re-arrange to-dos or your own lists in to any order you prefer by dragging and dropping." https://culturedcode.com/things/support/articles/2967034/
- **Today is ordered by hand, with an optional evening section.** "Drag and drop to-dos into the order you'll most likely tackle them." "If something needs to be handled later in the day, assign it to This Evening. These to-dos will move into their own section at the bottom." Grouping Today by project or area is a setting. https://culturedcode.com/things/support/articles/4001304/
- **Headings and new items are placed by dragging.** "Drag the Magic Plus Button anywhere you'd like in a list, and your new to-do will be inserted where you drop it." A heading is added by dragging the button to the left edge, and moved by "Tap and hold on a heading to grab it." https://culturedcode.com/things/support/articles/2803582/
- **The tag filter sits behind More.** "At the top of the list, tap More → Filter by Tag … Tap ✗ to clear the filter." https://culturedcode.com/things/support/articles/2803581/

**Todoist**

- **One view menu holds sort, group and filter.** Tap "the view icon at the top-right". Sort options are "Manual, Name, Date, Date added, Deadline, Priority". "Manual means you set the order yourself." https://www.todoist.com/help/todoist/features/sort-or-group-tasks-in-todoist-WFWD0hrb
- **Filtering is in the same menu.** "You can also filter them … filter out tasks" by assignee, date, deadline, priority or label. https://www.todoist.com/help/articles/customize-views-in-todoist-AoHhBxFdZ
- **Projects keep the order things were added.** "In projects, tasks are shown in the order in which they were added … sorted within each section." Today and Upcoming are "Smart sorted by default: Date and time … → Priority → Deadline → Manual ordering → Task creation date". https://www.todoist.com/help/articles/default-sorting-order-in-todoist-mqmgerY7

**TickTick**

- **Sections and sorting live behind the "…" menu.** Sections: "tap '...' in the upper-right corner, then select Manage Section → Add Section." Sorting: "tap '...' in the upper-right corner, and select Group & Sort." "Sorting controls the order of tasks within each group." https://help.ticktick.com/articles/7056594711640801280
- **Habits are grouped by time of day and ordered by dragging.** "On the habit editing page, habits are grouped by time periods such as 'morning/afternoon/evening/other' … simply long-pressing and dragging them." https://help.ticktick.com/articles/7055781805944733696

**Habitify**

- **A sort button offers three orders.** "Alphabetical", "Reminder Time" and "My Habits Order". Its "Reorder Habits" item opens a list where you drag the "3-line icon". https://intercom.help/habitify-app/en/articles/9727843-manage-habit-order-in-journal-view
- **Time of Day is a filter edited in Settings.** It is "a dynamic filter for your daily habit list" and "automatically switches to the current time block". Blocks are edited in Settings → Time of Day ("+ Add more…", swipe to delete, at least one must remain). Each block keeps its own order. https://intercom.help/habitify-app/en/articles/7990118-manage-the-time-of-day

**Structured**

- **The timeline is ordered by time; untimed items sit apart.** "All-day tasks … appear at the top of your timeline." "Simply drag and drop the tasks horizontally into your preferred order." Undated tasks go to an Inbox. https://help.structured.app/en/articles/325186 and https://help.structured.app/en/articles/380546

**Streaks**

- Not verified: the help site was unreachable (see "What I couldn't confirm" at the top).

**Apple Reminders**

- See section 2. It is the closest built-in match: a More menu with Sort By and New Section, sections renamed and moved on the list itself, and Morning, Afternoon and Tonight sections in Today.

---

## What this says about the user's mental model

- **"Show me less" and "change my list" are different acts on an iPhone,** even though people swap the words "sort" and "filter".
  - Filtering is a quick, reversible view choice: a button near the list that fills or shows a "Filtered by …" label, with one tap to undo it (Mail, Photos).
  - Arranging changes the list itself. It happens through dragging, or through an explicit Edit screen that ends with Done (Reminders, Files, Health).
- **Sorting is a menu choice with a checkmark, not a place you go.** People expect their own order to be one of the choices and to survive trying another one, as in Reminders.
- **"…" and "Edit" are where iPhone people look for anything that changes structure.** Examples are New Section, Edit Lists and Edit next to Pinned. Touch and hold and drag is familiar to experienced users but hidden from many. Treat it as a shortcut.
- **In a personal list, people expect things to stay where they put them.** The research gives no support for A to Z as a natural order, and lists that reorder themselves are disliked. For new items, the habit apps lean towards keeping the order they were added (Todoist projects) or a hand-made order (Things, Reminders, Habitify's "My Habits Order").
- **Time-of-day sections are already familiar.** Reminders' Today has Morning, Afternoon and Tonight, and Things has This Evening. People expect a section to mean "when I'll do it", and they expect moving an item between sections to change its time of day.

## Implications for the design (simplest first)

1. **Keep the filter as its own visible toolbar control,** never mixed with arranging. A tap gives one choice with a checkmark. While it's on, the icon fills and the list shows "Health ✕". One tap returns to All. This matches Mail and Photos, and the "Never hide a habit without saying so" rule already in Design Rules.
2. **Put arranging where iPhone people look for it.** That is an "Edit" (text, not an icon) that opens one arrange screen in edit mode. On that screen, times of day are listed with ≡ handles, rename is a tap on the name, Add Time of Day is a row, delete is a swipe or the red minus, habits are dragged within and between sections, and Done (with Cancel) closes it. This is the Reminders Edit Lists, Files Browse and Health Pinned pattern.
3. **Make touch and hold, then drag, on Today a shortcut only,** with exactly the same results as the Edit screen. Any context-menu item must also exist in the main interface (HIG). Never let a drag on Today be the only way to reorder.
4. **Default order inside a section: the person's own order, starting from the order habits were added (new habits at the end), not reminder time.** Most habits have no reminder, and a time sort would move rows whenever a time changes.
   - This conflicts with today's rule in Design Rules ("A to Z until the person drags"). NN/g's A-to-Z findings and the habit apps lean towards insertion order.
   - That rule changes only with the user's say-so, so raise it with them rather than change it.
5. **If sorting is offered, make it a one-time action or a checkmarked choice that keeps "Your order".** Examples are "Sort A to Z" or "Sort by Time". Dragging should put the list back on "Your order", as in Reminders. Sort only inside a section, never across sections (Todoist).
6. **Label things by what they do.** For example "Show: All / Health" for the filter, and "Edit Times of Day" or "Arrange Today" for arranging. Keep the word "sort" out of the filter, since people mix the two up.
7. **Teach with at most one contextual tip and the empty state, not a tutorial.**
   - For example, after someone adds a second habit to a section, or opens Today several times, a single TipKit popover could point at Edit: "Reorder habits and change times of day here." It is withdrawn once they use it.
   - An empty time of day can carry its own cue to add habits.
8. **Keep menus short and honest.**
   - A "…" menu needs at least three items, otherwise use plain buttons.
   - Hide context-menu items that don't apply rather than dimming them, and put Delete last.
   - Deleting a time of day must never delete its habits, unlike deleting a Reminders section. Say where the habits go: "Moves its 3 habits to Anytime".
