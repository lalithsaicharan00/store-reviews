# Round 3 Build — Copy, Days, Dates and Limits

Written by Claude (Claude Code), 29 September 2026, from the user's request of the same day: build the Round 3 design ([Creating a Habit — Round 3, The User's Own Words](<../../../Research/Research Reports/Habit Creation/Creating a Habit — Round 3, The User's Own Words.md>)) and get the copy right everywhere.

**Context (the user's words, tidied):** the copy is the value. Whatever someone picks (days, dates, units, how often) must read the way a person would say it, on Today and on the New Habit screen: "Every Monday and Wednesday"; Sunday to Thursday reads as a range. Test every habit shape, plus extreme edge cases of my own, not just the implementation.

## Every point the user made

| # | Point | Done |
|---|---|---|
| B1 | Build the Round 3 design | [x] Built 29 Sep: one form, How much, Each + adds, How often, Steps, Cut down's limit (Round 3 report §7). Not yet compiled: no Swift in the cloud session |
| B2 | What's picked (unit, how often, days) reads like a person says it on the main habit screen (Today): "Every Monday and Wednesday" | [x] Today shows how often for rules that name days: "Every Mon and Wed", "Every Sun to Thu", "On the 1st of every month" (`HabitCopy.todayCaption`) |
| B3 | Consecutive days read as a range: Sun, Mon, Tue, Wed, Thu → "Sunday to Thursday" | [x] One unbroken run of 3 or more days is a range, across the week's end too ("every Friday to Monday"); mixed sets name every day |
| B4 | Several days or several dates of the month must work and read meaningfully | [x] Any set of weekdays or dates reads naturally: all 127 day sets, odd/even dates, runs ("the 1st to 5th"), many dates ("on 7 dates each month"), "every day except the 31st" |
| B5 | The New Habit screen shows the habit the same way, as people read it | [x] The form reads the habit back as one sentence at the top ("Read 2 chapters a week"); every How often choice is written with the person's amount |
| B6 | Test each and every habit shape and check the copy is right, not just that the code runs | [x] Every case checked in Python (`iOS/Tools/copy_oracle`: print-outs reviewed) and turned into `CopyCheck` for the phone. **Still to do: run `testCopyChecks` on the phone** |
| B7 | Add my own extreme edge cases (many dates, odd combinations) and test them | [x] Edge cases: 6-day and 5-day sets, wraps across the week start, 30/31 dates and short months, 29 Feb, fifth weekday, 28+ dates, all 31, 1 glass, $, 10,000, the longest name and unit, empty names |
| B8 | Keep icon and colour selection | [x] Kept: Icon and Colour row, both pop-ups (test extended to pick a colour) |
| B9 | Unit selection must be intuitive | [x] Units: optional; Time first ("Hours and minutes" → ▶); grouped lists; ⊕ Create Your Own Unit; + says its step |
| B10 | Name limit around 20, unit limit around 12, or whatever is best; no long names | [x] Kept names 24, units 12 (evidence: 20 is the limit reviewers complained about; names get shorter now the goal isn't in them). Recorded in the Design Rules |
| B11 | Time of day must be intuitive: Anytime can't be combined with Morning or other sections; Anytime is the default; check it holds everywhere | [x] Anytime is the default and never combines: a part clears it, it clears the parts, unticking the last part returns to it (`testAnytimeNeverCombines`); the row reads "Morning and Evening" |
| B12 | Check that everything is intuitive | [x] No type screen, no pop-ups or confirmations, one rule for +, the sentence at the top, and the Today line say what will happen |
