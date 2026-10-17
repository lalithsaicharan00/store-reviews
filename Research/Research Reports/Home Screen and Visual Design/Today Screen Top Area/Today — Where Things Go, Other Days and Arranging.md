# Today — Where Things Go, Other Days and Arranging

Written by Claude (Claude Code), 16 Oct 2026, at the user's request: "it's not about what iPhone has … What's the right
thing to do? … come up with the best possible experience." Proposals for the Android Today (Figma section `1260:2`),
worked out from scratch; the iPhone follows later. **Nothing here is designed yet: the user decides first.**

**Evidence.** A fresh scan of all 1,238,784 App Store and Play Store reviews (`Today Order and Other Days Evidence/scan.py`)
for six topics, then the hits read by hand: where untimed habits sit (50 hits), quit counters' place (357), where new
habits go (226), groups and colour (122), other days (117) and arranging (944). These are **directional scans**: keyword
hits read by hand, not a coding of the whole corpus, so counts are small and labelled as such. Every review cited is in
`review_classification.py` with a fragment of its text; `verify.py` checks all 92 (0 mismatches). Where reviews say
little, the reasoning is marked **reasoned from first principles**. Android patterns are checked, never copied.

---

## 1. Anytime and Quitting: where they sit, and who decides

**What people want.** Untimed habits after the timed ones: 3 reviews (one wants "any time" things *"at the bottom of the
screen instead of at the top"* A4#7354; one wants them *"visible below the scheduled ones"*, not on a separate screen,
P49#2650); 1 wants them first (P126#38191). Quit counters: people want them **seen** (*"the first thing I see"*, A3#7508)
and **in their own order** (*"you can choose how to order the counters"*, A3#7546). Small numbers, but they split, which
is itself the finding: there is no one place everyone wants.

**Reasoned from first principles.** Timed sections have a reason for their order: the clock. Anytime and Quitting don't.
Anytime holds things done *whenever* (water, reading, steps); Quitting isn't a list of things to do at all but a live
count and a "Log a slip" (people have about two, report 48). Forcing either one place is right for some and wrong for
others, and moving a whole card is a one-off choice that can't cause the "list reshuffles itself" problem (U13).

**Proposal**
- **Default order:** Morning → Afternoon → Evening (by their times) → **Anytime → Quitting** → Paused (always last,
  folded). Untimed after timed matches the 3-to-1 reviews, and puts the things with a deadline first.
- **Anytime and Quitting can each be moved** to any place among the sections, once, in Arrange Today (§6). Timed sections
  can't be dragged: their place is their time. Paused can't move.
- **Nothing moves them by itself**: not the time of day, not everything being done. "Once everything is done you see
  them" happens naturally with the default: the done rows sink in their sections after the pause (U4, U13), and the
  untimed cards are below.
- Not proposed: a setting ("Anytime at top / bottom"). A setting hides the choice in a menu; moving the card where you
  see it is the same choice, made in place.

## 2. Where a new habit goes

**What people want (24 reviews read).** At the end, in the order they add things: **9** (*"i want them at the bottom of
the list because i am putting in things in the order of when i want to do"* A4#2421; top-insertion *"instead of at the
bottom - which would make sense for anyone creating a habit stack"* A33#3402). At the top: **4**, mostly to-do lists
(A10#26449, P126#67133). In the *right* place, which neither top nor bottom gives: **5** (*"a new habit that I intend to
do first, it is at the bottom"* A13#9511; *"you can’t ever add a step in between"* A13#10717). A top/bottom setting:
**4**, all in to-do list apps.

**Your assumption is confirmed:** a new habit goes **to the end of its time of day, in the order created**. Reminder times
never reorder it (report 27: 1 % ever asked for reminder order; 20 % complained of lists reordering themselves).

**Proposal**
- The habit form's **Time of day** picks the section; the habit lands **last in that section**. A task likewise.
- **After saving, Today scrolls to the new row and highlights it briefly**, so the person sees where it went (a section
  further down, or folded, would otherwise hide it), with a snackbar **"Added to the end of Morning"** and **Move**.
  Move opens Arrange Today with that row already lifted, for the 5 people who want it "in between". *(Reasoned: the
  moment someone notices it's in the wrong place is right after adding it.)*
- No top/bottom setting (the 4 who asked use list apps, where the newest is often the most urgent; a habit list is a
  stable routine).

## 3. New group: name and habits, no colour

**What people show.** Colour-coded categories are praised mostly in **to-do list apps** (most of the 122 hits), where an
item has no colour of its own. In **habit apps** the pattern is the other way round: people **use the habit's own colour
as a stand-in for groups** because groups are missing (6 reviews: *"I can basically do that with color"* P3#10242;
*"sort habits by group instead of just color"* P3#7230), and one complains when the category's colour replaced the
habit's (*"the categories are color coded, not the habits"* P2#3259).

**Reasoned.** In this app colour already belongs to each habit (U2). A group colour would put a second colour on the same
row and two meanings on one signal. You were right: **no colour**. And no icon: a group shows only as a filter chip,
where its name says everything.

**Proposal: New group** (a full-screen dialog from Filter's *New group*, and from the habit form's Group row)
- ✕ · **New group** · **Save**.
- **Name** (focused, keyboard up, 24 characters, U6), with a few suggestion chips under it that fill the field: *Health,
  Mind, Home, Work, Fitness* (never preset groups; a chip only types the word).
- **Habits** — every habit and task, in Today's order under small section names, each with a checkbox. A habit already
  in another group says so on its line (*"In Health"*); ticking it moves it here (one group per habit: the filter shows
  one group at a time, and a habit in two would count twice). A search field appears only once there are more than 12.
- Save with no name: the field says *"Give the group a name"*; Save is never greyed (U19's rule). With no habits ticked
  it saves an empty group (people often make the group first).
- Afterwards: back to the Filter sheet with the new group's chip **selected**, so Today shows it at once.

## 4. Back to today

**Already settled by evidence** (report *Back to Today — When and Where*, 38 reviews: one tap back, and people log on the
wrong day without noticing). **The current Android screen 4.2 is wrong in one way**: its pill is grey; it must be filled.

**Proposal**
- **Only while another day is open, past or future**: a **filled** pill, **Back to today** with the *today* calendar icon,
  centred **just above the day bar**, floating over the list (the list keeps room at its end so nothing is covered).
  Direction-free icon, because the same button returns from yesterday and from tomorrow.
- The day bar's label names the day (*Yesterday*, *Tomorrow*, *Thu 23 Oct*), so it's never in doubt which day is open.
- **The system Back gesture returns to today first**, then leaves the app on the next Back. *(Reasoned by analogy with
  Android's own navigation principle: an app has a fixed start place, and Back returns to it before exiting; with
  predictive back the person sees Today coming in.)*
- In the calendar sheet: a **Today** text button, shown only when another day is open.

## 5. Future days: preview and plan, never log

**What people show.** Asking to tick ahead: **13** — almost all **tasks and chores done early** (*"if you happen to get
something done early it’s nice to be able to check it off"* A4#2452) and one **weekly goal** done before its day
(A1#45355). Asking to **skip** ahead (a holiday): **3** (P10#12215, A76#5218). Wanting to **see** tomorrow: **5** (*"the
ability to check the habits lined up for tomorrow"* A23#2114). Against ticking ahead: **6** (*"the user should not be
able to check future dates"* P3#15515). **Ticking the wrong day by accident: 5** (*"leading you to mark tomorrow instead
of today"* P130#134). Reminders still firing after doing something early: **3** (P2#4148).

**Reasoned.** A log says something happened, and when. Nothing has happened tomorrow yet, so a log there is a fiction:
it would also put the accidental-tomorrow tap within one swipe of every person. But each real need above has a true
answer:

**Proposal**
- **A future day opens as a preview**: what's planned, in Today's order, with reminder times. **No log buttons** (the
  round button is replaced by the planned state); the top says *"Planned for Thu 23 Oct"*.
- **Tasks can be done early.** A task due later shows **Mark done today**: it's recorded *today* (true), leaves the later
  day, and **its reminder is cancelled** (the 3 reviews).
- **Week and month goals need nothing**: a log today already counts toward the week, whatever day was in mind.
- **Plan ahead, honestly:** Day details on a future day offers **Skip that day** (a holiday) and **Pause from that day**,
  and a **note** for the day. These are plans, not logs, and can be undone.
- How far ahead: any day, through the calendar (later dates lighter).

## 6. Arrange Today: what it holds

**What people show (944 hits; representative reviews read).** Reordering is the single most requested list feature
(322 keyword matches asking for it). What goes wrong around it:
- **Hidden** in settings or a separate menu (*"why reordering can’t be done via drag ‘n drop versus separate “reorder”
  menu"* A3#4873; *"Most apps like this you just long press and then drag"* P2#11379).
- **The order doesn't stay**, or changes from day to day (*"annoying to have to reorder 20 habits daily"* A13#13438;
  *"when I fix the order on one day, it messes with the order on the second day"* A4#17449). 5 reviews.
- **Within** morning/afternoon/evening (3), **between** them without editing each habit one by one (*"an easier way to
  rearrange them between morning/afternoon/evening"* A13#6565), and the **sections** themselves (A1#49737).
- **Drags that fail**: the page scrolls instead (P37#843), the item jumps to the top (P122#17777).
- A different order per weekday: 3 (A4#6772, P12#51559) — a minority.

**Proposal: one page, *Arrange Today*,** opened from Today's top bar (✏), and from a row's touch-and-hold menu
(**Arrange…**). Today itself never drags: its job is logging, and a drag there would move rows under a finger (U4).
- **Every section as a card, in Today's order**, with **every habit and task** in it (not only today's), so the order is
  set once and **is the same every day**. A row not due today says when it is (*Mon, Wed, Fri*).
- **Each row has a drag handle** (trailing); **touch and hold anywhere on the row also lifts it**. The list auto-scrolls
  at the edges; a lifted row never scrolls the page.
- **Drag a habit into another time of day** to move it there (its Time of day changes; its reminders don't). A snackbar
  says *"Read moved to Evening"* · **Undo**.
- **Anytime and Quitting cards** have a handle on their header and move among the sections (§1). **Timed sections show
  their times instead of a handle.** **Paused** is last and fixed (its habits go back to their own places when resumed).
- **Each row also has Move up / Move down / Move to…** (tapping a row opens them; they are also accessibility actions), so everything a drag does
  can be done with taps (WCAG 2.2's dragging rule, 2.5.7; TalkBack users can't drag).
- **Each card's ⋮:** *Sort by reminder time* / *A to Z* (one-off, then dragging carries on), and for a timed section
  *Edit time of day*.
- **Changes save as they're made**, each with Undo; the top bar is just ← *Arrange Today*. *(Reasoned: no Save to forget,
  no "discard changes?" question, and §7 can open from here without losing anything.)*
- **At the end: Times of Day ›** (§7).
- **Not here:** groups (a filter, ordered in Edit groups); a per-weekday order (3 reviews against the 5 whose pain was the
  order *changing* between days; one order is what makes it trustworthy).

## 7. Times of Day, from Arrange Today

**Reasoned from first principles** (no review speaks to the screen itself).
- **Times of Day ›** opens a page that shows **the whole day as one sequence**: *Morning 5 AM – 12 PM · Afternoon 12 –
  5 PM · Evening 5 PM – 5 AM*, with how many habits each holds. Back returns to Arrange Today, which then shows the new
  sections at once (nothing pending, since Arrange saves as it goes).
- **The day is always covered, never overlapped:** each time of day has a **start**; it ends where the next one starts.
  Changing a start moves the neighbour's end with it. No gaps, no overlaps, so no "this will split Morning" questions.
- **Tap one** to edit it in a sheet: **Name**, **Starts at** (the Android time picker), **Delete** (asks first: *"Its 4
  habits move to Anytime"*; nothing is ever deleted with it).
- **Add a time of day** at the end: name and start; it takes the hours from its start to the next one's.
- Tapping a timed section's times on its Arrange card opens that same sheet directly (one editor, two ways in).

---

## Summary for the user's decision

| Question | Proposal |
|---|---|
| Anytime and Quitting | Below the timed sections by default; each movable once in Arrange Today; nothing moves them by itself |
| New habit's place | Confirmed: end of its time of day, in creation order; Today scrolls to it, *Added to the end of Morning · Move* |
| New group | Name (with suggestion chips) and habits; no colour, no icon; one group per habit |
| Back to today | Filled pill above the day bar on any other day, past or future; Back gesture returns to today first |
| Future days | Preview only, no logging; tasks *Mark done today*; skip, pause and notes ahead |
| Arrange Today | Every habit, same order every day; drag handle or hold; drag between times of day; Move up/down for taps; saves as it goes with Undo |
| Times of Day | The day as one sequence of starts; edit name/start/delete; no overlaps possible |
