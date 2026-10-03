# Habit Details Page — Build

Written by Claude (Claude Code), 3 October 2026, at the user's request ("note down the prompt exactly that I gave you
so that before submitting or saying everything is completed, check have you completed everything … each and every
detail is important"). Branch: **`claude/progress-week-cards`**. Research: `Research/Research Reports/Habit Details
Research/` (start with its README).

**Before saying anything is finished, read the prompt below again, line by line, and tick every point in the table.**

## The user's prompt, word for word (3 Oct 2026)

> Okay, so earlier you have worked before creating this temporary merge branch, merging it into the main. Earlier you have created a, a branch for working on the visuals of the progress page, right? So work on in the same branch. So in the main branch, you will find a detailed document about a research, even including images. It is the latest commit. Uh, about how a habit details page should be. You will find that. So what you need to do is if you go through those files, first of all get that thing into your branch. So it includes research reports as well as some images to give you like a good idea of a layout but don't consider most important thing is don't consider those layouts as a final I mean some of them are kind of a final but a majority of them are not so I'm just informing you in advance so right now what you need to do is obviously implement the improve the habit details page as well as implement everything according to the research So let me give you overall idea before you even explore them. So the very first thing is we have divided the habit details page into three sections. One is history, history logs. Then the second one is notes. Then the second, the third one is progress. History includes logs of all of the past. You will, you can see even the mockups, layouts, all of that. So it will be like a, each day whenever scheduled and whenever they log something that particular day will have a row. So it will be like a September and within September whenever they log each day will have a row. And how it should be implemented? Number one, month should be collapsible like they should be able to collapse the month. And most importantly, also make sure they should be able to navigate to a specific date if they want to. But yeah, right now in the mockups, everything kept up front, like they are not good in terms of design, right? So yeah, a month should be collapsible. So like each month will get a card. Of its dedicated card like October will be card and within everything will be a row and everything should be collapsible and if they want to they should be able to go to any specific date and if they want to add an entry for today they should be able to add an entry Right now for adding entry we don't have any screen to be honest but in the research you can find that but we do have edit entry screen so I think you can create an add entry screen by yourself using all of the research data but make sure add entry screen might be changing depending upon the habit type because we have different habits and yeah different types so yeah just make sure of, of that and add entry screen should be overall like aligning with everything I mean for adding an entry the mental model from any habit page should be same so just remember that so yeah then we have inspect one day page and change one particular value like edit entry and then an unlogged past day how it looks so we have all of that and then we have notes these are like the notes that they add on a habit individual habit so yeah all of that Then we have progress. So in the progress, we have first overall record. Then we have overall statistics in about week, then month, then year in pixels. So yeah, just implement that progress page. So yeah, go through all of that and implement everything perfectly. And before implementing, do research on your end, like how in a native, since this app is completely trying to create a native-like feel for you iPhone users, so how a native application might be implementing it. So the placement of things, for example, like add a note, edit note, like all of that, So those mockups and images will give you a basic idea, but the placement of things in terms of user experience, in terms of for a native device perspective, where they should be, how they should be, you have to decide them and you have to implement them. And then the most important thing is the statistics for depending upon the habit type, they change and implement those logic and everything as well. So yeah, you need to take care of like different logic and logic for different types of habits and milestones sections, I want you to improve this milestones the way we have it in the mockup is not at all looking good. Milestones should be like a something like a card or a, I mean not a gamified way but it should look good basically. A milestone should look good. That's the whole point. A milestone just text, it doesn't feel like a milestone. So do some research, improve the milestone design. Okay. Milestones should be presented like the ones that you achieved and as well as the ones that is about to come. And do some research about milestones as well. Like what milestones we need to have in the first launch and yeah the way you present them on the screen they should be they should look really good and coming to the progress sections like keep them like for example milestones keep them as a one section like a card okay and week keep it like a one section in card because everything related to week in one section in card same thing for year and month year is really important it is a beautiful thing and it is kind of a core of the product so yeah it I don't say core of the product but yeah it is really important thing good thing and yeah In the mock-up everything is implemented a little bit different like a check mark colors and all of that but yeah you already know you have implemented the progress page so you know how to implement each box It has included the dates, but yeah, follow our style like so that everything is consistent in the overall app for monthly as well as yearly as well as weekly. So yeah, improve the milestones. section design so everything looks good so yeah implement it thoroughly test it for different types of habit whether the statistics are showing perfectly for different each type of habit so test all of that and implement everything right now focus heavily on improving the user experience as well as the UI should look good and very clean so yeah use some spacing rules hierarchy rules so that UI really looks good use some proper spacing as well as hierarchy so that UI looks good again and again I'm repeating because it is really important and test everything like for different habit types how everything is looking have you implemented it correctly different types and goals and then once everything regarding the implementation and how things are looking everything is done then work on like testing performance and all of that but yeah during implementation itself follow the main necessary rules from rule book main things from the rule book during implementation also so that later we have to do less tests so yeah so it's a huge thing complete it Again, I'm repeating, use some spacing, hierarchy. The overall design should, progress page should look really good. So in main you can find like habit details research. You will find it. So yeah, in main you will find all of that. Habit details research. This just now it has been pushed. So yeah, take that up and continue implementing it, testing it. So yeah, once everything is done, give me the screenshots like for each different type of habits, how things are looking, different types of habits I want to see. Yeah, so give me the screenshots. Specifically, I am interested in progress as well as everything basically. But yeah, implement it step by step. First, overall layout, then the history tab, then the notes, then the progress. Step by step, one after the other. Don't rush. Implement everything steadily. Again, I'm repeating. When implementing something, think about the proper hierarchy, spacing, all of that. Because they are really important. That's why I'm repeating. I have repeated it like three or four times till now. Overall design, overall information architecture and hierarchy, spacing rules, everything. These things make everything look good. So visually, things should look good. So yeah, continue and complete this slowly and steadily complete the task.

And then (3 Oct 2026): "note down the prompt exactly that I gave you so that before submitting or saying everything is
completed, check have you completed everything. So yeah, you are creating your own internal to-dos, that's fine, but
yeah, in overall, take care of that prompt really well. Each and every detail is important."

## Every point, to tick

| # | Point (from the prompt) | Done |
|---|---|---|
| H1 | Work on the same branch as the Progress visuals (`claude/progress-week-cards`) | [x] |
| H2 | Bring main's Habit Details research (reports and images) into this branch | [x] merged 3 Oct |
| H3 | Read every research file; treat the mockups as a basic idea, not final (some are near final, most are not) | [x] README, IA, History, Notes, Progress original + revised, milestones; mockups used as ideas only (decisions below) |
| H4 | Before building: research how a native iPhone app would do it; decide placement (add note, edit note, add entry…) for native UX | [x] decisions N1–N12 below |
| H5 | The habit page has three sections: **History** (logs), **Notes**, **Progress** | [ ] |
| H6 | Steps in order, not rushed: overall layout → History → Notes → Progress | [ ] |
| H7 | History: logs of all the past; a row for each day that was scheduled or had something logged | [ ] |
| H8 | History: each month is its own card (October a card, September a card…), days as rows inside | [ ] |
| H9 | History: every month card is collapsible (the mockups keep everything open up front: not good) | [ ] |
| H10 | History: go to any specific date | [ ] |
| H11 | History: add an entry for today (and other days) | [ ] |
| H12 | A new **Add Entry** screen, built from the research and the existing Edit Entry screen | [ ] |
| H13 | Add Entry changes with the habit type (check, count, amount, time, checklist, quit, limit…) | [ ] |
| H14 | Add Entry has one mental model from any habit page, aligned with everything else | [ ] |
| H15 | Inspect one day | [ ] |
| H16 | Change one particular value (edit an entry) | [ ] |
| H17 | An unlogged past day: how it looks and what it offers | [ ] |
| H18 | Notes: the notes added on one habit (browse, read, add, edit), placed natively | [ ] |
| H19 | Progress: first the overall record | [ ] |
| H20 | Progress: statistics for the week, the month, and Year in Pixels | [ ] |
| H21 | Progress: each of Week, Month, Year and Milestones is one section, one card ("everything related to week in one section in card") | [ ] |
| H22 | Year matters a lot ("a beautiful thing"): make it really good | [ ] |
| H23 | Squares follow our heat-map style (signs, ✓ only on goal met, grey for due days…), consistent across the app for week, month and year; not the mockups' checkmark colours | [ ] |
| H24 | Statistics change with the habit type: implement each type's logic and goals correctly | [ ] |
| H25 | Milestones: research what milestones to have at first launch | [x] report "Milestones on the Habit Page — What to Mark and How to Show It" (3 Oct): 3, 7, 14, 30, 50, 100, 200, 365, 500, 1,000 in a row + In total 10–1,000 |
| H26 | Milestones: redesigned, card-like, look good, not gamified, not just text | [ ] |
| H27 | Milestones: show the ones achieved and the ones about to come | [ ] |
| H28 | UX first; UI clean; proper spacing rules and hierarchy everywhere (said many times: it's what makes it look good) | [ ] |
| H29 | Overall information architecture and hierarchy are right | [ ] |
| H30 | Follow the Rulebook's main rules while building (speed, data safety, design), so less testing later | [ ] |
| H31 | Test every habit type and goal: statistics correct, everything looks right | [ ] |
| H32 | After the build: performance tests and the rest of testing | [ ] |
| H33 | Screenshots for each habit type, Progress especially, and everything else | [ ] |
| H34 | Complete the whole task, slowly and steadily | [ ] |

## Decisions and progress

**Native placement (H4), reasoned from Apple's Human Interface Guidelines and the conventions of the iPhone's own apps
(Health's per-type data lists and Add Data, Notes' read-then-edit, Fitness' awards), checked against the research.
Never "an app does it, so we do": each is here because it fits what the person is doing.**

| # | Decision | Why |
|---|---|---|
| N1 | **Header, then a segmented control: History · Notes · Progress.** The control pins under the navigation bar while the page scrolls (as Progress's dates bar does) | HIG: a segmented control switches between closely related views of one thing. Pinned, so switching never needs a scroll back up |
| N2 | **Header: icon, the goal in words, and a paused banner if paused.** The name is the navigation title. No numbers in the header | Research IA: keep the shared context small; numbers belong to Progress |
| N3 | **Top-right ⋯ menu** (`ellipsis.circle`): Edit Habit, Pause/Resume, Archive/Restore, Delete (destructive, confirmed). It replaces the Edit button and the Pause/Archive/Delete rows at the page's foot | HIG: secondary, less frequent actions go in a menu; research IA: management in the top-right menu |
| N4 | **History opens by default.** Opened from Progress, the page opens on Progress | Research IA: preserve the destination's intent |
| N5 | **History: Add Entry and Go to Date as two buttons at the top of the tab**, always visible, then one card per month, newest first | Research History: keep both visible; HIG: primary actions where the person's eye already is. Not hidden in a toolbar that changes per tab |
| N6 | **Month cards fold:** the header row (month, its summary, chevron down/up) folds or opens it. This month and last month open; older ones folded; the choice is kept while the page is open | The user (3 Oct): every month a card, collapsible. Research: never hide last month just because a month began |
| N7 | **A day row: its heat square (the app's own square), the date, what was recorded, and a note icon.** Tapping opens the Day sheet. A row for every scheduled day up to today and every day with an entry, a skip or a note | The user (3 Oct): a row whenever scheduled or logged. Research: no invented "missed"; an unlogged scheduled day reads "Nothing logged", neutral (Rulebook U3) |
| N8 | **Go to Date: a sheet with the graphical date picker** (from the habit's start to today); choosing a date opens that day, logged or not | Research History D: any valid date, including one with no record. HIG: the graphical style for picking one exact day |
| N9 | **Add Entry: one screen for every habit, the same shape everywhere:** a Date row (today by default, or the day it came from), then the value control for the type, Add in the top-right. Amount → number + unit; time → hours and minutes; several times a day → times; once a day → Done; checklist → its steps; quit → slip time; limit → amount | The user (3 Oct): one mental model from any habit page, changing only with the type |
| N10 | **The Day sheet (Inspect one day): its result, Add Entry for that day, its entries (each opens Edit Entry), its note; ‹ › for the day before or after in the bottom bar.** An unlogged past day says "No entries recorded" with Add Entry and Add Note | Research History B/D; HIG: a bottom toolbar for actions on the content in view |
| N11 | **Notes: a search field and Add Note at the top, then notes by month, newest first, two-line previews. A note opens a reader (pushed): its date, the full text, Edit in the top-right, View Day, Delete Note.** Editing is a sheet with the large native editor and a date row | Research Notes A–C; Notes app pattern: read first, edit explicitly. Reading never changes progress |
| N12 | **Progress: cards in order: Overall record, Milestones, Week, Month, Year in Pixels.** Week/Month/Year each have ‹ › in their own heading; every card shows its facts, its squares and its comparison with the period before | Research Progress revised; the user (3 Oct): each section one card |

**Visual rules for the page (H28, H29)**
- One spacing scale, the one Progress uses (`WeekSpacing`): 2 inside a label, 4 between a headline and its detail, 8
  inside a group, 16 card padding and between cards, 24 between the controls and the first card.
- Hierarchy inside every card, top to bottom: title (headline) with its scope (subheadline, secondary) → the main fact
  (title 2 or title 3, semibold, monospaced digits) → one supporting line (subheadline, secondary) → the squares or
  chart → the comparison (footnote) → actions (borderless buttons, accent colour).
- Squares are `HeatDraw`'s, never below 24 pt: Week 40, Month 32, Year in Pixels 24.
- Colour only for the habit (squares, milestone fills); everything else monochrome (Rulebook U2).

**Year in Pixels (H22):** twelve month columns by 31 day rows, 24-pt squares (the research's portrait study, which shows
the whole year at once: the thing reviews praise most). The gap between squares adjusts so the twelve columns fit the
card on every iPhone. Tap a square to see that day's date, value and goal under the grid, with Open Day. Its own
"What the squares mean".

**What the old page showed, and where it goes (Rulebook U5):** streak/best/done-this-month numbers → Overall record and
Milestones; total line → Overall record; the round month calendar → History's month cards and Progress's Month card;
Over Time (period totals, goal reached, best day, the bar chart) → the Week, Month and Year cards' facts and the Month
card's bar chart; "By weekday" chart and the five longest runs → dropped (the research: not needed on this page; the best
run stays in Milestones); Year dots → Year in Pixels; notes (three latest) → the Notes tab; Pause/Archive/Delete rows →
the ⋯ menu.
