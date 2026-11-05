# iOS Design Loop — Progress

Written by Claude (Claude Code), 6 November 2026 (IST), at the user's request: carry the iPhone design in the Figma
file "IOS app" (`zLgBjb7M7Fp6UN0pg7J3a8`) screen by screen, native to iOS, with Android's mental model. Design only:
no app code. Branch: `claude/nice-hopper-dhgw5r` (docs). Scratch branch for Simulator probes:
`claude/nice-hopper-dhgw5r-probe` (**safe to delete**, W3; screenshots are workflow artifacts only, D11).

How each screen is done (the brief's loop): look → ask (job, what's wrong, what's Android's, iOS's way) → research
(HIG, Apple's apps on the Simulator, reviews) → try 2–5 versions on the Simulator → fix the design system first →
update every copy on every page → correct captions, arrows and frame names → check by eye (incl. 200 % text) →
write it down (report, doc section, Rulebook, this file) → commit and push.

## Note on missing references (6 Nov 2026)

The brief names eleven `iOS/Docs/… — iOS Native.md` docs and two reviews (Today's notice card; Day details on
iPhone) from 5–6 Nov. **None of them is in git on any branch** (checked `main`, `ios-rebuild`, every remote branch
and all history on 6 Nov, 01:10 IST); they seem to be on another machine, unpushed. This loop therefore takes the
decided rules from the brief's §3, the finished Figma screens (Menu, Today, Edit Today, Day details 669:234) and
the design system page (493:2). Where a doc section would go, it is written in
[iOS Native — Design Loop Notes](<../iOS Native — Design Loop Notes.md>) under the doc's name, ready to move into
that doc when the docs are pushed (so nothing clashes with the unpushed files).

## Status

| | Screen | Figma | Status | What changed | Report |
|---|---|---|---|---|---|
| — | Menu, Today, Edit Today, Day details | 669:234 … | Finished before this loop (reference) | — | — |
| A | Timer screens | 705:7745 | In progress | | |
| B | Log screens (Add log, Log view, Edit log, Delete log) | 687:829 | Not started | | |
| C | Time picker · Date picker (every copy, every page) | 703:602 · 705:1025 | Not started | | |
| D | Note screens | 765:1087 | Not started | | |
| E | Routine player | 906:89513 | Not started | | |
| F | Your routine sheet | 907:29174 | Not started | | |
| G | Habits page | 986:150825 | Not started | | |
| H | Archived habits · Search | 988:7736 · 991:8050 | Not started | | |
| I | Tasks page | 999:1061 | Not started | | |
| J | Archived tasks · Completed tasks | 1001:178 · 1002:230 | Not started | | |
| K | Habit details | 1020:4052 | Not started | | |
| L | Streaks · All milestones | 1034:74 · 1036:235 | Not started | | |
| M | Search (details pages) | 1053:9079 | Not started | | |
| N | Task details | 1136:9271 | Not started | | |
| O | The page at 1142:29063 | 1142:29063 | Not started | | |
| P | Create new (components 1061:2015, page 381:2) | 381:2 | Not started | | |
| Q | Settings | 804:79 · 781:34017 | Not started | | |
| R | Plus | 1204:175 | Not started | | |
| + | Open from Today's review: History's Back to this week/month (Prominent); Android-only notices on Today | — | Not started | | |

## Left for the user

(Decisions of taste, with frame links, collected as screens are done.)

## Next

Screen A, Timer screens.
