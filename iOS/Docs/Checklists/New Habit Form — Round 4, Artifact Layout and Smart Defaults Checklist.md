# New Habit Form — Round 4, Artifact Layout and Smart Defaults

Written by Claude (Claude Code), 29 September 2026, from the user's request of the same day. It changes the Round 3 build ([Round 3 Build — Copy, Days, Dates and Limits](<Round 3 Build — Copy, Days, Dates and Limits Checklist.md>)) before it is merged. The layout follows the "New Habit form" board of the [Round 3 mockups](https://claude.ai/artifact/ANKvCwMetGruSECAC2AiMY).

**Context (the user's words, tidied):** build the habit screen like the mockup. Keep the flow we have now (New → Build or maintain → how do you want to track it → the form); only the form changes. Every habit gets smart default values, so nobody faces empty fields, without defaults the user has to change every time. Say, concisely, which values are defaults and that they can be changed.

## Every point the user made

| # | Point | Done |
|---|---|---|
| F1 | The form looks like the mockup: icon and colour, then How much, then How often, then Time of day and Reminders | [ ] |
| F2 | Reminders open on a separate screen | [ ] |
| F3 | A separate Start / End section: Starts reads the word **Today** (tap it to set a start date); Ends reads **Never** (tap it to set an end date) | [ ] |
| F4 | Keep the current flow: New → Build or maintain → How do you want to track it? (Check it off · Track an amount · Time it · Checklist) → the form. Only the form screen changes | [ ] |
| F5 | Steps appear only for Checklist, not for every habit | [ ] |
| F6 | Type-specific rows such as "Each + adds 1 chapter" appear only where they apply (amounts) | [ ] |
| F7 | Smart default values for every habit type: no empty values, and not a friction the user must change every time | [ ] |
| F8 | Say, somewhere, that these are default values the user can change: concise, short, intuitive | [ ] |
| F9 | The sentence at the top and its subtitle ("built from the rows below / from what you entered") are plain English, concise and intuitive | [ ] |
| F10 | (Earlier today) Test on the simulator and on the iPhone before merging; don't merge until the user says so | [ ] |
| F11 | Single screen tried and rejected on the phone ("every time I change how much, it is changing"); back to the type screen. Check it off: no How much, no Steps; amount: How much; time: How long; Steps only in Checklist | [x] |
| F12 | A visual preview at the very top, clearly labelled, centred: how the habit will look on Today | [x] "Preview" over Today's own row |
| F13 | Below it, the text preview: name, how much, how often and time of day ("Read twice a day, morning and afternoon"), "every day" and "anytime" shown | [x] |
| F14 | That sentence on every screen the form opens (How often, Time of Day, Reminders, …) | [x] |
| F15 | Empty values show as a dash (or "Your habit"), filling in as the person types | [x] Amounts "—", name "Your habit" |
| F16 | How often defaults to every day for every habit; reminders off by default | [x] |
| F17 | Quick research: should a new habit start filled in (a "default habit")? | [x] Below |

## Quick research: defaults (29 Sep)

Scan of all 1,487,223 reviews (App Store, Play Store, native apps) for defaults, pre-filled values, presets and previews near habit or goal words (`Research/Temp/defaults/scan.py`): 71 default hits, 185 template hits, 41 preview hits, read by hand.

- **Users show dislike of defaults that switch something on for them:** "every task defaults to a notification enabled at 9AM?!" (`7565435937`); an alarm on by default "you need to manually switch off for EVERY ROUTINE" (`b1a3a5cb-0f60-4944-b13c-ff5af9fa014e`). So reminders start off.
- **Defaults that fit most people are praised:** "the default settings are pretty much spot on straight out of the gate" (`d5c05f89-976f-4135-8573-659b28286c2e`). Every day and Anytime are the most common shape ("How People Describe a Habit"), so they stay as defaults and the form says so.
- **People want to see what they're setting while naming it:** "allow to see the goal setting page first since you aren't quite sure what you will be setting" (`cb93159d-4b62-44fa-8862-66875fcbe6f3`). Supports the live preview (one review: limited evidence).
- **Preset habits to pick from are liked** ("pre-filled goal prompts are so great if you're just starting out", `9640928737`), but that is a template list, a separate feature, not a pre-filled form.
- **No review evidence either way on pre-filling an amount.** Reasoned from first principles: an amount depends on the person, a pre-filled number can be saved without being read, and "1" or "20" means nothing for most habits. So amounts start empty ("—"), and what the name suggests shows only as the field's hint ("e.g. 10000 steps").

