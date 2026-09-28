# Schedule and Goal — Round 2, Make It Intuitive

Written by Claude (Claude Code), 28 September 2026, from the user's request of the same day. Research and the decided design go in
[Schedule and Goal — Round 2, Making It Intuitive](<../../../Research/Research Reports/Habit Creation/Schedule and Goal — Round 2, Making It Intuitive.md>).
The earlier supplied report, [Schedule and Goal — One Coherent System](<../../../Research/Research Reports/Habit Creation/Schedule and Goal — One Coherent System.md>), is input, **not** a rule: the user said not to follow it where it's wrong or unintuitive.

**Context (the user's words, tidied):** creating a habit is the core of the app. If setting it up confuses the person who built the app, it's wrong. People want weekly, monthly and yearly goals as well as daily ones, but the current Schedule plus Goal combination is confusing.

## Every point the user made

| # | Point | Research? | Done |
|---|---|---|---|
| P1 | Arrange the iOS app's own docs into folders and keep them usable (followed without being re-read every time); keep them separate from the store-review research | No | [x] `iOS/Docs/` with index |
| P2 | Schedule: **do we need "specific dates of the month" at all?** Decide it from evidence | Yes | [x] §3.7: keep, nested under Every month |
| P3 | Make Schedule and Goal **very intuitive**, together | Yes | [x] D1–D11 |
| P4 | Bug/confusion: Schedule = "A number of days" (e.g. 3 days a week), then Goal "counts over" → A week shows a pop-up **"Use 1 day a week? One check-off in a period is one successful day. Schedule will count that day, with a goal of once a day."** Nobody can tell what Schedule vs Goal means here | Yes | [x] D1–D3: "3 times a week" is only a weekly goal; no pop-ups |
| P5 | The Goal screen says **"Once / a day"** while Schedule says **"Every 2 days"**. The two contradict each other at a glance | Yes | [x] D6: Goal line 2 from Schedule when daily |
| P6 | Schedule's top copy (the big read-back and its sentence) is weird; **Every day** is fine but can be better | Copy | [x] §6 |
| P7 | **Specific days:** Sun–Thu reads "Sun, Mon, Tue, Wed and Thu", and the sentence repeats it ("On Sunday, Monday, …"). It isn't dynamic and says nothing new. Runs should read as ranges (Sunday to Thursday) | Copy | [x] §6.2 ranges |
| P8 | **Every…:** "Every 2 days, starting Mon 28 Sep" is good, but **"Next: Mon 28 Sep"** repeats the start date. Remove it or make it mean something | Copy | [x] D8: Coming up |
| P9 | **Flexible days:** "3 days a week" is good; the sentence "Reach the goal on any 12 different days each year" is OK but should be better | Copy | [x] §6.2 |
| P10 | Confusion starts only when Goal is **not** "a day": fix that | Yes | [x] D5: senseless combinations greyed with a reason |
| P11 | Research thoroughly from the whole review corpus, not just the supplied report | Yes | [x] §2, §3 |
| P12 | Write a **detailed report**: how to make it intuitive, plus the copy | Deliverable | [x] report written |
| P13 | (Follow-up) The first version removed week, month and year goals from Check it off. **Earlier reports show people want to check it off *and* have daily, weekly, monthly and yearly goals.** Read them all and settle Schedule vs Goal once and for all, with no more back and forth | Yes | [x] Revised: one rule (Schedule = which days; Goal = what counts and over what period), every type keeps all four periods, §3.10 and §7 |

**Next:** the design is a proposal. Building it needs the user's go-ahead and a Mac with Xcode (report §8).
