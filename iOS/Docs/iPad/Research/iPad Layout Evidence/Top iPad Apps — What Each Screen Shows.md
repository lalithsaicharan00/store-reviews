# Top iPad Apps — What Each Screen Shows

Written by Claude (Claude Code), 11 October 2026, for [The iPad Layout](<../The iPad Layout — Familiar Like the iPhone, Native to the iPad.md>) §6. The current App Store iPad
screenshots of 14 apps, read one by one (each app's page at `apps.apple.com/…?platform=ipad`, 11 Oct 2026). The images
themselves are not kept in the repository (Rulebook D11: no other apps' images in git); they were saved to
`Research/Temp/ipad-layout/shots/` for the work. Marketing screenshots show each app at its best, not every state.

- **Reminders, Today (landscape, 13-inch class):** sidebar on the left (≈ 330 pt): smart-list tiles in a 2 × 3 grid,
  each with a big **count** (Today 6, Scheduled 16, All 64…), then My Lists with counts, then Tags. Toolbar: sidebar
  button at the sidebar's top right; undo/redo leading in content; ⋯ and Search trailing. Content: large title "Today",
  then **one full-width column** split into **Morning / Afternoon / Tonight** sections (grey section headers, rows with a
  round checkbox on the LEFT, title, one secondary line: list · time · repeat). An empty "add" row at the end of each
  section. Floating + at bottom right. Lots of white space on the right of rows: rows run the full width.
- **Reminders, Columns (same size):** the list's sections become **columns left to right in section order**
  (Alexandra | Connie | Mia), each ≈ 290 pt wide, rows as rounded cards, each column scrolls with the page; sidebar
  still shown. Columns is a per-list view option (List / Columns).
- **Things 3 (landscape):** sidebar with counts (Today shows a red badge 1 and a grey 7); content is **one column at a
  readable width (≈ 700 pt), centred**, with wide margins even on a 13-inch; "This Evening" section; calendar events in
  a box at the top of Today; floating + bottom right. **Item detail opens inline**: the row expands into a card in place.
  With the sidebar hidden, content stays centred at the same width (Upcoming).
- **Todoist:** sidebar (Inbox, Today, Upcoming, Filters, projects); a task opens as a card/sheet over the content with
  the sidebar dimmed; board and calendar views exist (marketing art, little layout detail).
- **TickTick (landscape):** icon rail + list sidebar with counts; content one column of **grouped day sections, each
  header with a count on the right** ("THU, TODAY 5"); calendar month view with tasks written in.
- **Fantastical:** sidebar = mini month + agenda list of today and tomorrow; main area = calendar; "Today" button and
  Day/Week/Month/Quarter/Year switcher at the top.
- **Apple Calendar (iPadOS 26):** top bar: icon buttons leading (calendars, inbox, list, +), **Day | Week | Month | Year
  segmented in the centre**, Search trailing; "Today" red text button at the content's top right; sidebar of calendars
  (hideable). Month view writes every event into each day.
- **Notes / Mail:** classic two- and three-column split views (sidebar · list · detail); detail is a column, not a sheet.
- **Health (11-inch landscape):** sidebar (Summary, Sharing, Browse, Health Categories with a disclosure); Summary is a
  **grid of cards, three across, flowing in rows** (Pinned), then Trends; tapping a card **pushes** a detail page into
  the content area with a back chevron.
- **Home:** sidebar; **status chips across the top** (Climate 73–80°, Lights 5 On, Security No Alerts…) = an at-a-glance
  summary; then sections (Cameras, Scenes, rooms) with tiles 2–3 across; content width capped (≈ 800 pt).
- **Habitify (portrait 12.9):** sidebar (All Habits, a time of day "Afternoon", Areas, Progress, Settings); content one
  full-width list, each row: icon, name, "21 / 30 min" line, action button at the far right (Timer, Log, Done, +1);
  sections "Habit to Break", "This Week".
- **Streaks (portrait 13):** two big circles per row, paged.
- **Structured:** marketing art only.

**Patterns:** a day's to-do list = one column everywhere (Reminders, Things, TickTick, Habitify); multi-column only as
an optional Columns/board view (Reminders, Todoist) or for dashboards (Health, Home); counts beside Today in the sidebar
(Reminders, Things, TickTick, Notes); details as a popover (Calendar: HIG cites the event popover; Reminders' details
pop up beside the row, `N1#7979`), inline (Things) or a pushed column (Notes, Mail, Health); date/view controls at the top
centre (Calendar, Fantastical, TickTick); productivity apps use a sidebar, not the top tab bar (Reminders, Notes, Mail,
Calendar, Health, Home, Things, TickTick, Habitify).
