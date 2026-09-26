# Today-screen top area — hand codes (one line per candidate in codes/<batch>.txt: idx<TAB>CODES<TAB>note)
A review can carry several codes. X = not relevant. Codes named Q<n> flag a review as evidence for another question.

## Q1 — title row (heading, date, time, header space)
| Code | Meaning |
|---|---|
| DATEW | Wants the current date / weekday shown on the main screen (or praises it) |
| DAYCONF | Confused about which day the screen shows (e.g. after midnight) |
| WRONGDAY | Logged a habit on the wrong day by mistake |
| SELDATE | When viewing another day, the header must show that day's date (not "Today") |
| OPENTODAY | App should open on today, not a stale date |
| STRIPDATE | Date strip lacks dates / month / year, or should stay pinned |
| STATUSBAR | App hides the phone's status bar clock; wants the time visible |
| ROWTIME / ROWTIME- | Wants each habit's set time on its row / finds per-row times cluttering |
| HEADSP | Header / top area wastes space (big titles, illustrations, bars) |
| TOPCLUT | Non-habit things at the top (quotes, avatar, challenges, journal) clutter it |
| BANNER | Promotional / rating / ad banner at the top of Home |
| TOPCONTENT | Wants habits to be the first thing at the top (or praises it) |
| NOHEADTEXT | Says the "Today" label, date and time-of-day are not needed |
| HEADWANT | Wants something added to the header (page title, counter, bigger date headers) |
| HEADDESIGN | Dislikes the look of the header |
| ROLL / ROLL+ | Day rolls over at midnight: wrong-day logging, wants custom day start / praises it |
| ICON | (Native Google Calendar) wants today's date on the app icon — outside the app, counted separately |
| DAYGLANCE | (Native Calendar) uses an app just to see what day it is |
| MINIMAL+ | Praises no wasted space / no decoration |
| REACH | Controls at the very top are hard to reach one-handed |
| ADDBTN | Comment on where the add (+) button sits |
| STRIP+ / STRIP- | Likes / dislikes the day strip at the top (detail coded under Q3) |

## Q2 — overall progress display (ring vs number, duplication with the day strip)
| Code | Meaning |
|---|---|
| DAYPROG+ | Wants / likes an overall "how am I doing today" indicator on Home |
| DAYPROG- | Overall daily progress unwanted: pressure, clutter, or better kept on the stats page |
| RING+ / RING- | Likes / dislikes a ring or circle as the progress display |
| NUM+ | Wants / likes the number itself (3/5, 60%, "2 left") |
| BOTH+ | Wants ring (or bar) and number together |
| BAR+ | Prefers a progress bar |
| LEFT+ | Wants "what's left today" (remaining count) rather than a percentage |
| PARTIAL | Partial progress must be visible (not only full / empty) |
| PCTPRESS | Percentages or 0% feel demotivating / judgemental |
| REDUND | Complains that the same information is shown twice |
| CATPROG | Wants progress per group / category |
| STRIPPROG | Wants per-day progress in the week strip / calendar (evidence for Q3) |
| RINGFIT | (Native Apple Fitness / Health) closing rings as a motivator |
| HABITBAR+ | Praises a per-habit progress bar / fill on the row (not overall daily progress) |
| PCTCONF | Percentage unclear (how is it calculated? of what?) |
| MINIMAL | Praises a display with no redundant text or decoration |
| NUM- | A number replaced a visual mark and made the screen harder to scan |

## Q3 — the date strip (need it? fixed or movable? which days?)
| Code | Meaning |
|---|---|
| STRIP+ / STRIP- | Likes / dislikes a day strip at the top of Home |
| NAVPAST | Wants to go back to earlier days to see or log (backfill), or complains it's impossible |
| NAVSWIPE | Wants to swipe between days / weeks (or praises it) |
| NAVTAP | Wants to tap a day in the strip to open it (or praises it) |
| NAVFAR | Wants to jump far back / to any date (calendar picker, month) rather than day-by-day |
| NAVSLOW | Moving between days is slow / tedious / too many taps / arrows too small |
| BACKTODAY | Needs an obvious way back to today |
| FUTURE | Wants to see or plan upcoming days (tomorrow, next week) |
| FUTURE- | Does not want future days / only today matters |
| WEEKSTART | Wants the strip to follow the calendar week / choose first weekday |
| LAST7 | Prefers the last 7 days ending today (or praises it) |
| EDITGUARD | Wants protection against changing past days by accident |
| STRIPPROG | Wants per-day progress shown in the strip / calendar |

## Q4/Q5 — view switcher placement; what is always visible (views, group chips)
| Code | Meaning |
|---|---|
| VPREF_LIST / _WEEK / _MONTH / _YEAR | Says which view they use most / want as default |
| VSWITCH+ | Likes switching views with one tap |
| VDEFAULT | Wants to choose or have the app remember the default view |
| VHIDDEN | View switch hard to find / buried / too many taps |
| VCONF | Confused by views, or by what changes when switching |
| VTOOMANY | Too many views / modes / tabs |
| FILT+ | Uses or praises a category / group filter on Home |
| FILTW | Wants to filter or group habits by category |
| FILT- | Filter hid habits, is confusing, or its tabs/chips take space |
| FILTREM | Wants the filter remembered / always open on All |
| GROUPHDR | Prefers group headers in one list over filter tabs |
| CLUT | Home cluttered by too many controls, buttons, icons |
| CLUTOPT | Wants to hide or choose what Home shows |
| MINIMAL+ | Praises a simple Home with few controls |
| VWANT | Wants an additional view (list, calendar, week, month, year) on Home |

## Q6 — the "Now" button (show only what is due in the current part of the day)
| Code | Meaning |
|---|---|
| NOW+ | Likes / wants a view showing only what is due now (current time of day) |
| NOW- | Dislikes being shown only the current period (auto-switch, hidden habits, empty screen) |
| AUTOSWITCH- | App switches to the current period by itself — complaint |
| ALLDAY | Wants the whole day visible / "All day" as default |
| HIDEDONE+ / HIDEDONE- | Wants completed habits hidden or moved down / dislikes them vanishing |
| NEXTUP | Wants the app to show the next thing to do |

## Q7 — the list ⇄ cards (grid) button
| Code | Meaning |
|---|---|
| DENS_COMPACT | Wants / praises a compact list (more habits per screen, less scrolling) |
| DENS_BIG | Wants / praises big cards, tiles or circles |
| DENS_TOGGLE | Wants / praises being able to switch layout or density |
| DENS_SET | Says they set the layout once / wants it as a setting or default |
| SCROLL- | Too much scrolling to see all habits |
| TAPSIZE | Targets too small / too big to tap |

## Q8 — reaching section / day-structure editing from Home
| Code | Meaning |
|---|---|
| SECEDIT | Wants to edit / add / rename / retime day sections (time of day), or day start |
| SECFIND | Couldn't find where to edit sections, times of day or day start |
| EDITFIND | Couldn't find how to edit / delete / reorder habits (general findability of edit actions) |
| EDITDIRECT | Wants to edit directly from Home (tap/long-press the item or header), not via deep settings |
| EDITMODE+ / EDITMODE- | Likes / dislikes an explicit Edit mode or button |
| LONGPRESS+ / LONGPRESS- | Likes a long-press / press-and-hold / finds it undiscoverable or annoying |
| ACCIDENT | Edits / deletes / ticks by accident (need for guarded editing) |
| REORDERW | Wants to reorder habits or sections by hand |

## Q9 — what to call the screen and the tab
Vocabulary codes (what the reviewer calls the app's main habit screen; phone home screen = X):
| Code | Meaning |
|---|---|
| VTODAY | Calls it the Today view / tab / screen / page |
| VHOME | Calls it the home screen / home page / home tab (the app's own) |
| VMAIN | Main screen / page / view / list / menu |
| VDASH | Dashboard |
| VDAILY | Daily view / daily tab / daily screen |
| VHABIT | Habits tab / page / screen / view |
| VOTHER | Summary / journal / overview / checklist / tracker page |
Judgement codes:
| LBLMISMATCH | A "Today" label/header shows another day or period, or "today" is ambiguous (midnight, week view) |
| TODAYFOCUS+ | Values a screen focused on just today's habits |
| ALLHABITS | Wants to see all habits, not only today's (a non-day list) |
| MULTIVIEW | Wants week / month / history on the main screen next to today |

## Round 2 (R2) — view frequency, strip value, filter vocabulary, group-filter frequency, date wording
| Code | Meaning |
|---|---|
| VSTICK | Uses one view mostly / wants to set the view the app opens on (implies rare switching) |
| VREMEMBER | Wants the app to remember the last view or filter |
| VSWITCHOFT | Switches between views often / wants switching fast |
| VOPENTODAY | Wants the app to open on today's list |
| STRIPVAL+ | Values the day strip (progress per day, glance at the week) |
| STRIPNAV | Uses / wants the strip to move between days |
| STRIPCLUT | Strip wastes space / redundant / wants to hide it |
| GFILT+ | Uses a group filter routinely / praises it |
| GFILT- | Group filter tedious (switching each time, hides habits) |
| GRARE | Rarely or never uses groups or filters |
| HIDEDONE | Wants completed habits hidden (words used noted) |
| SHOWDONE | Wants completed habits kept visible |
| FILTERBY | Wants to filter / view by category, tag, group, area |
| SORTBY | Wants to sort / order by time, name, priority |
| ONLYDUE | Wants to see only what is due / left today |
| DATE_THISWEEK | Prefers the calendar week ("this week") |
| DATE_LAST7 | Prefers the last 7 days |
| DATE_WHICH | Unsure which date / week / period is shown |
| DATE_TOP | Wants the date or period shown at the top |

## Round 3 (R3) — add/edit groups & sections, counts, empty, not-due access, day start, layout
| Code | Meaning |
|---|---|
| ADDFIND | Can't find how to create a group/category/section, or wants creation easier/in context |
| ADDCTX+ | Praises or wants creating a group/section right where it is used (filter bar, "+ new", while making a habit) |
| GRPEDIT | Wants to edit/rename/delete groups or sections from where they appear |
| GRPCOUNT | Wants to see how many habits are in a group/section, or per-group counts |
| EMPTYVIS | Empty group/section shown or hidden — complaint or wish |
| NOTDUEACC | Wants to see / reach habits not due today (all habits list, upcoming, not-due row) |
| NOTDUEHIDE | Wants habits not due today kept off the list |
| DS_WANT | Wants to set when the day starts / ends (rollover) |
| DS_WORD | Uses specific wording for it (noted: start of day / day starts / reset / rollover / end of day) |
| DS_CONF | Confused which day a late-night tick counts for, or by the setting |
| DS_PRAISE | Praises a day-start setting |
| LAY_PREF | Prefers/uses a particular layout (list, grid, calendar, cards) |
| LAY_SWITCH | Wants to switch layouts / toggle praised; notes where |
| LAY_FIND | Couldn't find the layout switch |
