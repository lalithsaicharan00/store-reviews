# Details Pages Flows — iPhone Review

Written by Claude (Claude Code), 10 November 2026, at the user's request.

The user, 10 November 2026: "check each and every flow, go through each and every flow step by step … if you find any
mistakes or anything in any flow, go through like each flow one at a time and then each screen, check is everything
okay … here also we have pause, screen, so as you know, we have updated it everywhere. So yeah, just check it
everywhere."

Figma: the iOS app file, page **details pages** (`298:2`), flows 191–214.

## The user's points

- [x] 1. Go through every flow, one at a time, every screen.
- [x] 2. Fix any mistake found.
- [x] 3. Check the Pause sheet everywhere it appears.

## Flow by flow

- [x] **191 · Open Habit details.**
  - Screen 1 showed no Water card: the Habits page variant *Scrolled to Water* (`1140:91792`) was scrolled past it. Its
    list moved down 321, so Water's card now sits 8 under Habits | Tasks. This flow is the only one that uses that variant.
  - The Year card's title was "Year in pixels" while the notes say Year in Pixels. It's title case now, in both of the
    card's mains (`1015:37`, `1226:1994`), so all 54 copies changed.
  - The other screens and the notes agree with each other: today is Fri 23 Oct, not yet done; 23 days in a row; 44 of 51 days; 392 glasses.
- [x] **192 · A habit's description: two lines, More, Less.** Right as it is.
- [x] **193 · Habit details' ⋯: Pause…, and Delete.**
  - The Pause sheet matches the one on Today and Habits & Tasks (✕, handle, four choices, Confirm). Its dates read
    "Back on Fri, 30 Oct"; they're "Back on Fri 30 Oct" and "Back on Fri 6 Nov" now.
  - On Habits & Tasks after Delete, "Water deleted · Undo" lay on the bottom bar. It's 8 above it now (y 674).
  - Every banner on the page is named *Banner*, not *Snackbar* (Android's word). The ones with no bar under them end at 758.
- [x] **194 · See All Streaks.** The runs add up (2–10 Sep, 14–25 Sep, 30 Sep to today: 9 + 12 + 23 = the 44 days
  reached). "See All streaks" in the header, the screen names and the note is "See All Streaks" now.
- [x] **195 · Milestones.**
  - **200 glasses in total was missing.** The in-total ladder is 10, 25, 50 … × the day's goal (80, 200, 400 glasses),
    but Water showed 80 reached on 29 Sep and 400 as next. At 392 glasses, 200 was reached around 29 Sep, and 80 around
    11 Sep. Fixed in the Milestones card main (`1007:24`): Earlier is 7 in a row (6 Oct), 3 in a row (2 Oct), 200 glasses
    (29 Sep), newest first, as the lists are. Also fixed in All milestones (`1036:98`): 200 glasses (29 Sep), then
    80 glasses (11 Sep). It's 5 reached and See All 5 on every Water copy (47). The page grew 72 to keep How Milestones
    Work on it, and the notes under it moved down.
  - The row "How milestones work" is "How Milestones Work", like the page it opens (both mains, and the flows' labels).
  - The milestone pop-up's button "All milestones" is "All Milestones", in the design system's main (`853:45880`).
  - Quit and cut-down milestone cards are left for their own flows (208–210).
- [x] **196 · What the squares mean.** Right as it is.
- [x] **197 · Month: an earlier month, a day, and logging it.**
  - **September didn't match Water's record.** It said 25 of 29 days and 212 glasses, while History, the streaks,
    Year in Pixels and October's comparison all say 22 of 29 and 204. History holds every day's count, and it adds up
    (September 204, October 188, best day 10 on 3 Oct, 392 in all). The card follows it now: 11, 12, 26, 27 and 28 Sep
    ✕ (2 or 3 glasses), 13 Sep (5) and 29 Sep (6) part done, the rest reached. It says "Reached on 22 of 29 days ·
    204 glasses in September" (`1142:261899`).
  - Its "Recorded each day" chart was October's bars. A copy can't change a bar's height, so in the design system each
    bar of the month card (`978:651`) is now a frame whose height is its top padding (with an empty 0.01 child, as an
    empty frame doesn't hug), which a copy can set. Every copy's own bar colours (11 copies, 260 bars) were put back.
    September's bars now show History's amounts.
  - The day in the story was 19 Sep, ✕ in the grid, yet Day details showed 3 of 8. 19 Sep is a reached day. The story
    is now **Sun 13 Sep**, part done with 5 of 8: Day details shows the two latest logs and All 5 logs; +1 makes 6 of 8,
    All 6 logs and 205 glasses, and 13 Sep's bar grows. Day details was titled "Today" for a September day: it's
    "13 Sep" now (A119).
  - Notes: days before the habit started are left blank (they were called outlines); the sheet note no longer claims a note.
- [x] **198 · Month for other kinds of goal.**
  - Gym's and Read's Year in Pixels were Water's ("44 of 51 days · 392 glasses", Water's squares in their colours).
    Gym is now Mon/Wed/Fri sessions from Sun 6 Sep, "Met 6 of 6 weeks so far · 20 sessions this year". Read follows its
    October, "Reached on 41 of 51 days so far · 18 h 15 min this year".
  - Read's October said 17 of 22 days; its squares show 16. It says 16 now.
  - Read is a time habit, and its screen shows squares, not the minutes under each day. The header says "a week goal,
    a time", and the screen's name and note say what it shows.
- [x] **199 · Year in Pixels: a square, its day.** Day details for 14 Sep was titled "Today": it's "14 Sep". The flow
  said 14 Sep has a note, and History does show one ("Hot day; kept the big bottle on the desk."), but the sheet said
  Add a Note: it shows the note as a Note row now. No square has a dot, so the note no longer says a dot marks notes, and
  days before the habit started are "blank", not outlines. Every arrow label on the page was named "Label · Tap Water";
  each is named by its words now.
- [x] **200 · History: every day, and one day opened.** History itself is right. Day details for Sat 26 Sep was titled
  "Today", and its note ("Felt thirsty after the run …", shown under the day in History) was missing: the sheet said Add
  a Note. It's titled "26 Sep" and shows the note as a Note row, as in the Day details flows.
- [x] **201 · History: With Notes and search.** The notes still described Android's chips and search bar: With Notes is
  one button that toggles, "Tap With Notes again" turns it off, and search takes the top of the page with a ✕ to close,
  as iOS's search does.
- [x] **202 · History: Go to Date….**
  - The calendars on this page had 21 Oct as today; today is Fri 23 Oct. All three October calendars changed (today
    Ink, 24 Oct on grey).
  - iOS's calendar has no OK and no pencil: a tap on a day picks it and the calendar closes by itself. The step "OK" is
    "(it closes)", and the notes say so; "the third chip" and "All or With Notes" are gone (there are two buttons, and
    All went).
- [x] **203 · History: Add, for any day.**
  - **The day in the story didn't match Water's record.** Tue 8 Sep was "nothing logged", but History has 8 of 8 that
    day; since 2 Sep every day has logs. The story is now **Fri 11 Sep**, 2 glasses (✕): Day details shows its two
    logs; +1 makes 3 of 8 with three logs, and the banner says "1 glass added to Fri 11 Sep". It's still under half, so
    its square stays ✕.
  - Day details was titled "Today" for 8 Sep: it's "11 Sep" (A119). Its progress bar was Ink at 2 of 8: it's Water's blue.
  - The notes described a dialog with an Open button that names the day. iOS's calendar has neither: a tap picks the day
    and that day opens. The notes and steps say so.
  - Seven screens had five arrows, and the labels sat one step early ("‹ · tap 8" before the screen where 8 is tapped).
    Each step has its arrow now: Add, ‹, Tap 11, (it opens), +1, ✕.
- [x] **204 · History: Add a note to any day.**
  - After Add, Day details still said Add a Note: the note shows there now, as a Note row.
  - Day details was titled "Today" for 20 Sep: it's "20 Sep".
  - History has 9 glasses on 20 Sep; the flow said 8 of 8. Day details says 9 of 8 (3 + 3 + 3), and History's row 9/8.
  - Add Note's button is Add, so the step is Add, not Save; "Add a note…" is "Add a Note"; the calendar's notes say a
    tap picks the day and opens it.
- [x] **205 · Edit Habit: Starts moved earlier.** Edit Habit's button said Add, and Starts still read 23 Oct 2026 while
  the flow moves it to 25 Aug: it's Save and 25 Aug 2026 now. The form calls the row Starts, so the header, names and
  notes do too ("Started" was nowhere on screen); the note says August reads 0 of 7 days and September 22 of 30, as
  History shows. Not changed: the habit form's main (`Create new form`, on its own page) is 814 tall where every screen
  here is 800.
- [x] **206 · An archived habit.** The note says the current streak becomes Streak when archived, but the screens still
  said Current streak: they say Streak when archived now (it wraps to two lines and the card grows, as text should). The
  archived ⋯ menu had an empty divider above Restore: it's hidden.
- [x] **207 · A new habit: its first days.** The numbers agree (8 + 8 + 3 = 19 glasses, 2 of 2 days, First day on Wed
  21). Two drawing faults: "None yet. The first comes at 3 days in a row." lost its first letters to the Milestones
  card's clipping (fixed in the main, `1007:24`: Latest and its Text no longer clip), and Wed 21's tick in History was
  squashed to 12 wide (its copy's leading cell was set to fill). It's 24 again, and no other row on the page (2,393
  checked) has it.
- [x] **208 · A quit habit's Progress.** Smoking's numbers agree with each other (quitting since 27 Sep, one slip on
  3 Oct: 26 of 27 days, a 19-day run, 25 clean days in total reached 22 Oct, 5 reached, 1 year in 339 days). Two fixes:
  - October said 21 of 22 days while Week and Year in Pixels count today (6 of 6, 26 of 27): it's 22 of 23, in the
    month card and its comparison.
  - Earlier milestones were out of order (7 days clean 10 Oct, 10 clean days 7 Oct, 14 days clean 17 Oct): newest first
    now, 14, 7, then 10, as All Milestones lists them.
- [x] **209 · A cut-down habit's Progress: an amount.** Coffee's page agrees with itself (since 14 Sep, over on 19 Sep,
  2 Oct and 15 Oct: 36 of 39 days, a 12-day run 20 Sep to 1 Oct, 7 now), but **its All Milestones page was Smoking's**:
  30 days clean, 14 days clean on 17 Oct, 26 so far, 1 year on 27 Sep 2027. It's Coffee's now: 14 days within the
  limit next (7 to go), 7 reached 26 Sep, 3 reached 16 Sep; 50 days in total next (14 to go, 36 so far), 25 reached
  10 Oct, 10 reached 24 Sep; 1 year on 14 Sep 2027, 326 days to go. That's 4 reached, so the card's See All 5 is
  See All 4, and its earlier milestones are newest first (7 in a row, 10 in total, 3 in a row).
- [x] **210 · A cut-down habit's Progress: time.** Social media's page agrees with itself (since 28 Sep, over on 4 and
  11 Oct: 23 of 25 days, 11 in a row since 12 Oct), but **its All Milestones page was Smoking's too**. It's its own now:
  14 days within the limit next (3 to go), 7 reached 18 Oct, 3 reached 30 Sep; 25 days in total next (2 to go, 23 so
  far), 10 reached 8 Oct; 1 year on 28 Sep 2027, 340 days to go. The card said See All 5 for 3 reached: it's See All 3,
  with 10 in total (8 Oct) before 3 in a row (30 Sep).
- [x] **The Next rings in the Milestones cards (the user, 10 Nov 2026: "why the blue color … and why there is a fill.
  The progress things should be like this, circular").** On Smoking, Coffee, Social media, Gym and Read, the habit's
  colour had been put in the ring's *fill* (a tinted disc, plus a coloured inner circle) while the ring itself stayed
  Water's blue. All 16 rings are now as Water's are: the habit's colour on the ring (System Gray, Brown, Purple, Green,
  Orange), the grey track, nothing inside. The All Milestones pages had the same blue rings: they're each habit's
  colour now. Coffee's and Social media's pages also had Smoking's grey medals and Smoking's ring amounts: their medals
  are brown and purple, and each ring shows its own share (7 of 14, 36 of 50; 11 of 14, 23 of 25; the year so far).
  The last row in each shortened group keeps its rounded corners and has no line under it.
- [x] **211 · Larger text, and loading.** The words were Android's (200 %, sp, Font size, chips): it's Larger Text and
  Accessibility 1, as on the iPhone. With Notes, Go to Date… and Add were still their normal size at Accessibility 1
  while the note says they grow: they use the Accessibility 1 Subheadline styles now and wrap onto two lines. A page-wide
  search finds no other Android word in the notes or names.
- [x] **212 · Task details: a one-time task.**
  - Screen 1 says tap Car service, but Car service sat under the Habits | Tasks bar. In the Tasks page main (`999:350`,
    One-time · end of the list) the list moved down 66, so Car service shows and the end of the list is still there.
  - "Move to another day…" in the task's ⋯ is "Move to Another Day…" (title case), in the Task details main.
- [x] **213 · Task details: a repeating task.**
  - On the two full-length Tasks screens (1,226 tall), One-time | Repeating floated in the middle of the list: in the
    Tasks page main, it and its scroll edge were pinned to the top. All 12 variants pin them to the bottom now, so a
    taller copy keeps the bar at its foot.
  - The water filter is every 2 months, from the last time: done 13 Apr, so due 13 Jun; done 11 Jun. Its note said
    "Two days late": it's "Two days early" (in the Task details main too). The dates and Next Wed 9 Dec agree.
- [x] **214 · History: a skipped day.**
  - The Day details sheet was titled Today on a past day: it's **8 Sep** on all three sheets (A119).
  - Screen 5 says the note shows on the skipped day, but the sheet still read Add a Note: the row is now **Note**, with
    "Fasting for a blood test this morning." under it, as History shows on the last screen.
  - The arrows say Skip This Day, Add a Note and **Add** (the note page's button is Add, not Save); the notes say Undo
    Skip and "+1 and Log"; "Tue, 8 Sep" lost its comma.
  - This flow starts from a History where Tue 8 Sep has nothing logged, so it can be skipped; in the other flows' record
    8 Sep has 8 glasses. It's left as this flow's own starting point.
- [x] **The Pause sheet, everywhere on the page (point 3).** It appears in 193 (the sheet, then the paused card with
  Resume and the "Water paused until Fri 30 Oct · Undo" banner). The dates agree (today Fri 23 Oct: 1 week is Fri 30 Oct,
  2 weeks Fri 6 Nov), and so do the record's numbers while paused (Goal met 44 of 51). The other mentions of pausing
  (Streaks, How milestones work, the history key, the Habits & Tasks card) say the same thing: paused days never count
  and never break a run.
- [x] **Apostrophes.** The sheet's "it's", the Habits & Tasks card's "don't", "Habit details' ⋯" and "'missed'" used
  straight quotes: they're ’ and ‘ ’ now. No straight quote is left in any visible text on the page.
