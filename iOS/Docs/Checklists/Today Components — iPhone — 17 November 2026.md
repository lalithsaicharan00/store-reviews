# Today Components — iPhone — 17 November 2026

Written by Claude (Claude Code), 17 November 2026. The user's points, from Figma's *today components* (`759:31713`,
file "IOS app"), one part per loop tick. Branch `ios-update`.

The user: "implement this. Already I think you have these components … update them, or if anything needs to be added
new, implement them. And you have the milestone as well as all of the basically milestones, graphics, motion basically
animation. So implement that also perfectly."

## The parts

- [x] **Menu · open** (`622:9343`): Often Enough at the top; Today, Habits & Tasks (with its count); Plus, Settings;
      Contact Us, Send Feedback.
- [x] **Today** (`728:7985`), its states:
  - [x] Default: routine cards, a routine's Start, rows with streaks and round buttons, the day bar.
  - [x] A checklist row opened, its steps under it.
  - [x] Another day (8 Nov), with Back to Today.
  - [x] A day ahead (10 Nov): "Planned for …", routines collapsed with "N planned", a task row.
  - [x] Nothing Planned Today.
  - [x] A notice card at the top (Backup Is Paused, Manage Storage).
  - [x] Large text.
- [x] **Edit Today** (`827:39487`): Default, Dragging a habit, Empty routine ("Drag a habit here", Add Routine),
      Dragging a section. Rows lift with a touch and hold, as in Reminders (not the list's edit mode, whose handles
      showed on the rows that only hold a place); a habit drops into another routine or an empty one; a drop that
      changes nothing (into or out of Quitting) goes back.
- [x] **Milestone · Motion** (`853:45982`): the banner, the row's milestone band ("30 days in a row"), the milestone
      sheet (Your first milestone, the next one, All Milestones), and their motion. The row plays Figma's Row band:
      the round button's pop (0.86 → 1.12 → 1), a burst ring and eight dots from it (`MilestoneBurst`), the band
      growing in, the medal turning in, the words, two sparkles and the sheen (`MilestoneBandMotion`), once per tap
      and at rest on a redraw. The bar rises 0.3 s after the taps stop (0.25 s, emphasized decelerate), and the pop-up's
      card reads "Next · 4 to go · now 3". Checked from a screen recording on the Simulator ("Lunch, no phone" 2 → 3).

## Then

- [x] Each part checked on the Simulator.
- [x] Commit and push to `ios-update`.
