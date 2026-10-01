# Ticking Off, Folding and Small Settings — What People Need

Written by Claude (Claude Code), 1 October 2026. Build Plan #58 (completion animation), #59 (section open and close animation) and part of #61 (settings: theme, day start, week start, and the small settings people need). Checklist: `iOS/Docs/Checklists/Animations and Settings.md`.

## Answer in one screen

**Ticking off (#58)**

1. **People love feedback they can feel when they tick, and leave apps whose animations slow them down.** Of 140 reviews about animation size and speed (all read), 103 in 28 apps complain that animations are too long, too many or can't be skipped (mean 2.11★). Seven praise an app *for not having* them (mean 4.86★). The complaints come from people who tick many things a day: "Whenever I check off a habit, the animation takes forever to complete and wastes time" (Fabulous, `6632438113`).
2. **The tick itself should be quick and physical:** the button fills, the ✓ pops, the row's colour sweeps across, and the phone gives a light tap. This happens where the finger is, at once, and never blocks the next tap. No confetti, no full-screen celebration (users show: "too much confetti!!! It actually feels a bit patronizing", Finch, `13619815550`).
3. **Haptics on, with a switch; sound off, with a switch.** 80 reviews in 33 apps praise the haptic click (mean 4.17★); 35 in 17 apps complain they can't turn haptics off (2.80★): "No way to turn off haptics so the app is completely unusable and overstimulating for me" (Me+, `d05395bc-9ba9-4387-a9ee-730e9392f0af`). 174 in 45 apps love a completion sound (4.34★), but 75 in 24 apps find app sounds loud or interrupting (3.20★). Haptics are private, so they start on; sound is public, so it starts off.
4. **Done rows should go below the rest, but never while the person is still tapping.** Of 243 reviews about rows moving after a tick (all read), 90 want done items to sink to the bottom (3.87★), and many complained when an update stopped it. But 10 describe the list moving under their finger or before they could see what they tapped (2.50★): "As I go down my list of reminders to cancel completed tasks they move around trying to get me to cancel reminders I haven't completed" (Reminders, `13993339317`); "moving it out of view before I even get a chance to see what it was" (Microsoft To Do, `8010183083`). Seven want rows to stay where they are ("I have them lined up in a color pattern I like", Habit Tracker, `6483121788`), and 9 ask for a setting.
5. **So:** the row finishes its fill and ✓ in place. Done rows settle to the bottom together once the person pauses (about 1.5 s after the last tap), in one smooth move. A section that becomes all done folds at the same moment, not under the finger. A setting, **Done Habits: Move to Bottom / Stay in Place**, covers the people who want order kept.

**Folding (#59)**

6. No review describes how a fold should *look*; people ask for folding itself (which Today has) and complain when a list jumps as sections open (Reminders, `14139122211`). Reasoned from first principles: the rows should unfold from under the header (the header stays still, the chevron turns with the rows), in one short spring, with Reduce Motion turning it into a plain fade. Opening one section must redraw only that section.

**Settings (#61)**

7. **Theme: Automatic (follow the iPhone), Light or Dark,** free. Feature Ledger C080 (37 apps): dark mode is asked for as an accessibility need, and paying for it is resented. Reviews ask to follow the system: "it would be good for dark mode to follow the system theme so I don't have to change it manually every evening" (Habitify, `2b78a916-ad67-48e9-972f-39acdb7ed1dd`); a forced dark screen is a complaint too (Productive, `9219070734`).
8. **New day starts at: Midnight by default, any hour up to noon,** and it must apply *everywhere*. Ledger C170 (21 apps) and the reviews: night-shift workers and late sleepers ("As someone who's day ends at 7 am it's frustrating that the app resets at midnight", Streaks, `3876447319`). The worst reviews are about settings that don't take: "the app automatically resets at midnight even if you change it to 5 am" (Habit Tracker, `11560519826`); "if I say 'my day starts at 3am' that doesn't actually seem to be the case" (Done, `9532238765`).
9. **Week starts on: Automatic (the iPhone's region) by default, or any day.** 192 keyword hits; "I just wish I could make my week start on Monday, rather than the default Sunday" (Productive, `2094615925`); "Please respect the system setting for 'Start Week On'" (Productive, `1338735180`). Weekly goals and week views follow it.
10. **12- or 24-hour clock: no setting; follow the iPhone's own 24-Hour Time switch everywhere.** The complaints are about apps that force one format ("Please give a 12-hour clock option for those of us who do not use a 24-hour clock", Habit Tracker, `12085437711`; "You have to use am/pm time setting, thats a no go for me", Me+, `c63c5582-9b6f-46c2-9596-818a16cc1ebf`), or show one format and set another ("Set times are in military time, but setting them is in reg time", Habit Tracker, `8717140663`). iOS already has the switch the person chose, so the app follows it on every screen.
11. **Daylight saving and time zones: no setting; they must just work.** Every review is a failure report: reminders an hour off after the change (Habit Tracker, `9260758261`; Reminders, `9266489071`), "it keeps thinking today is yesterday" (Habit Tracker, `9708123607`), streaks broken by travel (Done, `11377557606`). One app charges for the daylight-saving shift and is resented for it (My Study Life, `71526af0-9cf1-427a-bb2c-659f2b47487d`). The app keeps each log on the calendar day it was made, keeps reminders at the clock time chosen, and works out the "new day" hour on the wall clock (see §5).
12. **Small settings worth building now:** Haptics and Sound (point 3) and Done Habits (point 5). Considered and left for later: the app-icon badge (C226, needs the Reminders work on the `sidebar` branch), an in-app language picker (C255; iOS has a per-app language setting and the app is English only), a text-size setting (C171; Dynamic Type already follows the iPhone), and hiding done habits (it would hide what "N left" counts down from).

## How the evidence was gathered

- **Scan:** all 1,487,223 reviews (App Store and Play Store habit apps and 11 native apps) with 20 patterns in English and some German, French, Spanish and Portuguese (`Research/Temp/anim_settings/scan.py`, hits in `hits/`).
- **Read in full:** the 140 reviews about animation size and speed; the 243 reviews about rows moving after a tick (narrowed from 1,389 to those with a tick word near a movement word). Hand-coded lists: `cls_animation.json`, `cls_rows.json`.
- **Read in part, with counts from narrower patterns:** haptics and sound (596 hits, sorted into liked and complained by phrase), 12/24-hour (663 hits, 106 about formats; most other hits are "24 hours" in billing), daylight saving (100 hits, almost all read), time zones (630 hits, the travel and time-zone ones sampled), week start (192), day boundary (439, the night-shift and midnight ones sampled), theme (3,664; the follow-system ones read), section folding (311).
- **Ledger cards:** C069 (check-off sound and haptic), C229 (a deliberate completion), C080 (themes and dark mode), C170 (configurable day boundary), C038 (dates correct across week starts, DST and time zones), C171 (accessibility), C149 (Reduce Motion), C226, C255.
- Counts are floors and keyword-based outside the two fully read sets. No usability test has been run.

## 1. Ticking off: what people like and what they complain about

| Group | Reviews | Apps | Mean ★ | Read |
|---|---|---|---|---|
| Animations too long, too many or can't be skipped | 103 | 28 | 2.11 | all 140 |
| Praise for having no distracting animation | 7 | 7 | 4.86 | all 140 |
| Love the haptic click | 80 | 33 | 4.17 | phrase-sorted |
| Haptics can't be turned off, or too much | 35 | 17 | 2.80 | phrase-sorted |
| Love the completion sound | 174 | 45 | 4.34 | phrase-sorted |
| App sounds loud, annoying or interrupting | 75 | 24 | 3.20 | phrase-sorted |

- **Feedback people praise is small and physical:** "Cleanly laid out and gives haptic feedback which is very satisfying" (Productive, `4540757430`); "I love the haptic feedback and the micro animations" (Habit Tracker, `8180458210`); "very visual and immediately satisfying when you click the button. Great dopamine hit" (Habit Tracker, `10039382969`). Missed when absent: "I do miss having haptics feedabck [sic] when ticking a habit" (Habit Tracker, `8811202814`).
- **Sound is loved by some and is a reason to leave for others:** "the sound when you check something off is SO satisfying and motivating" (Habitify, `3905644213`); "every button you press in the app has some sort of magical twinkling sound or over the top animation" (Fabulous, `9b7b5d48-2eb5-4e29-8704-5fe1c75fd262`).
- **A switch is praised where it exists:** "If you don't like the haptics you can turn them off" (Finch, `11788185999`).
- **Animation that holds up the next tap is the complaint:** "Too many long animations make this app very annoying to use if you want to log something quickly" (Fabulous, `a416fdcc-b8b6-49f0-888d-186153e3501b`); "Is there a way to switch off the confetti animation?" (Loop, `dfbe8fdd-0ac5-49bf-a193-276c928ed0dc`); a motion-sensitive user: "Despite reduce motion being ON this makes reminders SWOOP around … MIGRAINE TRIGGER" (Reminders, `14036391719`).

**Decisions (reasoned from first principles on this evidence):**

- The tick is answered in the button within one frame: it fills with the habit's colour and the ✓ pops with a short bounce. The row's colour sweeps across in about a third of a second. Nothing covers the screen and nothing waits for the animation.
- Haptics: a light tap for each step towards the goal ("+1", a checklist step), a "success" when the habit becomes done. Fired by the tap itself, never by a redraw: moving to another day where the habit is done must not buzz (the app's current `sensoryFeedback(trigger: done)` does exactly that, and is replaced).
- Sound: one short, soft chime when a habit becomes done, off by default. It plays as a system sound, so it follows the silent switch and mixes with music instead of stopping it.
- Reduce Motion: no bounce and no sweep; the fill and ✓ change at once, and rows settle with a fade.
- Repeated goals (the last of three ticks): each tick grows the fill by a third with a light tap; the last fills it and gives the success haptic. The row stays put throughout (next section).

## 2. When a done row moves

| Group (243 read) | Reviews | Mean ★ |
|---|---|---|
| Want done items to go to the bottom (praise, request, or complaint when an update stopped it) | 90 | 3.87 |
| The list moved under the finger or before they saw what they tapped | 10 | 2.50 |
| Want rows to stay where they are | 7 | 3.71 |
| Ask for it to be a setting | 9 | 3.67 |

- **Sinking is wanted:** "Bring back the thing where you mark the task and it goes to the bottom of the list. I can no longer see easily my pending tasks" (Me+, `10808819172`); "the option to have completed tasks move automatically to the bottom of the list, so you can glance at the top to see what to do next" (Awesome Habits, `7305149420`).
- **Moving at the wrong moment causes mistakes:** "the closed task moves into Completed at the bottom of the page, and if you didn't happen to see what you tapped before it disappeared, you have to sort through the list" (Microsoft To Do, `10280024444`); "When you check a bullet in your list, it jumps up and down the list and won't stay at the point" (Notes, `13753029502`). One person kept tapping because nothing seemed to happen: "It looked like nothing happened, so I kept clicking" (Reminders, `10495128157`).
- **Some want their own order kept:** "I would like the habits to remain in the place I have them instead of jumping to the bottom when completed" (Habit Tracker, `6483121788`); "Have an option in settings for the habits to not go down to the bottom once completed" (Habitify, `10676491515`).

**What Today does now (read from the code, 1 Oct):** done rows sink at once, except the row just logged, which is held while it offers "Add note". That row then jumps down **at the moment the person taps the next row**, so the list shifts under the finger in the middle of a run of ticks: the exact failure above. A section whose last habit is ticked also folds at once, cutting off the fill and ✓ it just started.

**Decisions:**

- **Nothing moves within a run of taps.** After any log on Today, the order and the open sections are held as they are. About 1.5 s after the last tap, done rows sink together in one spring animation, and finished sections fold. The row offering "Add note" keeps its place until the offer goes (Design Rules, Notes), as before.
- **Done Habits** setting: *Move to Bottom* (default, what most reviews want) or *Stay in Place*.
- Logging from a sheet (Log amount manually, Log time) counts as a tap: the row settles after the sheet closes and the pause.

## 3. Folding a section

No review describes the motion. Reasoned from first principles:

- The header stays still; the rows come out from under it and go back under it, with the rows below moving to make room. The chevron turns in the same spring. Folded icons fade in as the rows go.
- About 0.3 s, a spring with no bounce, the same for opening and closing. Reduce Motion: a plain fade.
- **Speed:** each section reads only its own open state, so opening one redraws that section, not every row of Today.

## 4. Theme, day start and week start

- **Theme** (C080, 37 apps): Automatic, Light, Dark. Applied to the whole window, sheets and alerts included, so no screen is left in the other mode.
- **New day starts at** (C170, 21 apps): Midnight, or 1 AM to noon on the hour. Logs made before that hour count for the day before. It applies to Today, the day bar, streaks, Progress, the routine player, reminders' "Remind Again" window and Times of Day order. Logs already saved keep their day. The setting says so in one line. *Limit:* a day ending after noon (some night-shift patterns) needs Times of Day reworked and is left for later.
- **Week starts on** (C038, C170): Automatic (the iPhone's region) or any of the seven days. Weekly goals, week streaks, the calendar sheet and Progress use it; the page says that past weeks are counted the new way too.

## 5. Clock format, daylight saving and time zones

- **12/24-hour:** the app formats every time with the iPhone's locale, so the iPhone's 24-Hour Time switch decides it everywhere, the pickers included. No in-app setting: a second switch could disagree with the first (the "set in one format, shown in another" complaint).
- **Daylight saving:** found in the code: "today" was worked out by subtracting the day-end hours from the current moment, so on the two nights a year the clocks change, the new day began an hour early or late. Now it's worked out on the wall clock (the hour as the clock shows it). Reminders keep their clock time across the change (the `sidebar` branch's reminder work covers the scheduling side).
- **Time zones:** every log is stored with its calendar day, so a flight doesn't move past logs; "today" is the day where the phone is now.

## Limits

- Counts outside the two fully read groups come from narrower patterns, not a full read. No participant has tried the settle timing; 1.5 s is reasoned (long enough for a run of ticks, short enough that the list tidies while the person is still looking). It's one constant to change.
- Which chime sounds best hasn't been tested with people.
