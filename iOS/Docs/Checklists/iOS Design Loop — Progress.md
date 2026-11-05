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
| A | Timer screens | 705:7745 | **Done** 6 Nov | Large sheet; Timer ring + Clock buttons replace cookie, wave, chip and capsule pair; ✕, name over the day, Day Details word; Paused / Goal met / Over the limit; 13 copies (Day details 4, Today 3, routine player 7) restored; captions on 3 pages; 200 % frame 4230:447235; DS: Clock button 4228:2548, Timer ring 4228:2551, Navigation bar actions capsule | [Timer on iPhone](<../../../Research/Research Reports/Day Structure and Organization/The Timer on iPhone — Clock's Ring and Round Buttons.md>) |
| B | Log screens (Add log, Log view, Edit log, Delete log) | 687:829 | Next | | |
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

**A · Timer** ([705:7745](https://www.figma.com/design/zLgBjb7M7Fp6UN0pg7J3a8/IOS-app?node-id=705-7745)):
1. ✕ (as every sheet) or a glass ⌄ ("put away, the clock keeps going") at the top left.
2. Day Details as a word in the bar (chosen) or inside ⋯ (hides it).
3. Should the ring's clock (SF Pro Light 64) become a text style, and what's its name?

## Next

Screen B, the log screens (687:829): research DatePicker styles (compact, graphical, wheels) and Apple's
view/edit screens (Contacts, Calendar event) on the Simulator, with each Apple app in its own test (Clock isn't on
the Simulator; one failed launch stopped the rest).

## How the probes work

`claude/nice-hopper-dhgw5r-probe` holds a SwiftUI app (`Probe/`) whose screens are variants (`-variant name`) and a
UI test that screenshots them (`Shots.swift`). Pushing runs `.github/workflows/ios-probe.yml` on `macos-26`
(iPhone 17, iOS 26, 9:41). Our own screenshots come back on `claude/nice-hopper-dhgw5r-shots` (both branches safe to
delete); a cloud session can't download artifacts. Apple's apps come back as element trees (text) only; their
screenshots stay in the run's artifact (D11).
