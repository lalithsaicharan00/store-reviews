# New Habit Words and Units

> **Updated by [Round 4](<New Habit Round 4 — Checklists, Streaks and Times a Day.md>)**: the checklist example is now a workout, its contents are "items", "Times each day" is replaced by several day sections, and amounts can be weekly or monthly totals.
>
> **Written by Claude (Claude Code)**, 27 September 2026. Round 2 fixes, items 6–10 ([iOS/Product Roadmap.md](<../../../iOS/Product Roadmap.md>)). Authorship of every report is listed in the [Research Reports index](<../README.md>).

**The questions.**
1. What do people call each kind of habit? The "New" list should use their words, not ours ("Do it", "Reach an amount").
2. Do people need their own units?
3. Should a new day section be addable from the habit form, not only from Today?
4. Are all the frequencies people ask for covered, and does "times a day" read naturally with each?

**Basis.**
- **Counted:** every English-language phrase for each kind of habit, across 1,048,400 habit-app reviews (App Store + Play) with Latin text. Script: `Habit Creation Evidence/count_words.py`.
- **Unit requests:** 67 reviews in 23 apps mention choosing, changing or making units.
- **Reddit:** I tried to check Reddit, but the browser pane blocks reddit.com and the fetch tool can't reach it. General web search didn't surface Reddit threads either, so this report rests on the reviews.

---

## The short answer

**1. The "New" list, in people's words, with every example marked "Example":**

| Section | Row title | Line under it |
|---|---|---|
| Build a habit | **Check it off** | Done or not done. Example: Take vitamins |
| | **Count an amount** | How many or how much. Example: Water, 8 glasses |
| | **Time it** | Minutes, with a timer. Example: Read, 20 min |
| | **Checklist** | A few parts, each ticked. Example: Skincare: cleanser, serum, SPF |
| Break a bad habit | **Set a limit** | No more than an amount a day. Example: Coffee, 2 cups |
| | **Quit** | The time since you stopped. Example: Smoking |
| Just once | **To-do** | Once, on a day, with no streak. Example: Book the dentist |

**2. No example values are pre-filled.** The form fields start empty, with grey placeholders ("e.g. Take vitamins", "8", "glasses"). A placeholder is visibly a hint, and nothing is saved that the user didn't type.

**3. Units are the user's own.** The Unit row opens a list:
- a **"Your own unit"** field at the top;
- the units people name most, grouped: Count (times, glasses, cups, pages, steps, reps, push-ups), Time (minutes, hours), Volume (ml, oz, litres), Distance (km, miles), Weight (kg, lbs), Money ($).

---

## 1. The words people use

| Kind | Most common words (reviews · apps) | Chosen |
|---|---|---|
| Done or not | **check off 3,301 · 120**; tick off 779 · 80; mark as done 605 · 81; yes/no 397 · 39; binary 147 · 22 | "Check it off" |
| An amount | **amount 3,422 · 117**; count / counter 1,355 · 84; target 624 · 67; units 261 · 43; quantity 141; measurable 128 · 18 | "Count an amount". The row says "how many or how much", because "count" alone confuses (“What does “count” mean?”, round 2 evidence) |
| Time | **timer 3,343 · 108**; minutes 2,869 · 107; duration 354; timed 282 | "Time it" |
| Parts | **checklist 2,159 · 96**; subtasks 1,060 · 61; steps 177; sub-habits 39 | "Checklist" |
| Doing less | **bad habits 2,717 · 87**; reduce 492 · 74; limit 217 · 59; negative habits 182; cut down 73; cut back 33 | Section "Break a bad habit"; row "Set a limit" |
| Stopping | **quit 1,713 · 77**; break a habit 518 · 48; sober 516 · 25; days since (quitting sense) 150 · 8 | "Quit" |
| Once | **to-do 7,110 · 122**; task list 601 · 51; one-time task 171 · 40; one-off 65 · 22 | "To-do" |

**Two cautions:**
- Counts are phrase matches, not hand-coded meanings.
- The first "to-do" and "days since" patterns also caught the Portuguese and Spanish word *todos* and phrases like "a few days since I downloaded it". Both were re-run with stricter patterns; the table shows the strict counts.

**Why "Check it off" and not "Yes/No":** "check off" is used eight times as often as "yes/no". It also names what the person does, not how the app stores it. People who ask for yes/no describe the same thing: “Please add Yes or No in habit measurement units. For some habits we just need to do once.” (`A1#46759`).

**Why "Checklist" is not a routine:** on Today, day sections and the Start button already make routines. A checklist is **one habit with a few parts** (skincare, a stretch, packing a bag), so its example avoids "Morning routine".

---

## 2. Units

- **People praise making their own:** “you can create your own units so you can measure something however you desire” (`A1#54362`); “the ability to define your own units” (`A1#54692`).
- **Fixed units frustrate:** “I can’t change the unit for the habit “walking” from “steps” to “minutes” ???” (`A1#44385`). A unit people wanted was missing: “add “gallon” to the unit of measure for water” (`A23#4890`).
- **Units named with a number in habit reviews:** times 382, minutes 343, hours 232, dollars 64, glasses 56, pages 45, steps 37, cups 27, oz 24, lbs 24, miles 23, km 20, push-ups 17, ml 15, kg 15, reps 13, words 11.

**So:** a free-text unit is kept, and moved to the top of the unit list so it's obvious. The common units sit below as one-tap choices. A unit typed once appears in the list next time.

---

## 3. Day sections from the form

**Yes, a section can be made from the form.** This is reasoned from first principles; no review asks for it directly.
- **What the person is doing:** they are placing a new habit ("Stretch, before work"). If the section they want doesn't exist, the only other route is to cancel, go to Today, make the section, and start the habit again. That loses what they typed.
- **So:** the Day Section menu lists the user's own sections, each with its hours, and ends with **New Section…**. That opens the same editor used from Today. Saving it picks the new section for the habit.
- **One editor, two doors:** Today (end of the list, or a section header's long-press menu) and the form both open the same editor, so the rules are identical: a name, a start time, and an end only for the latest section. Times follow the phone's own format (7:00 AM or 07:00), the same as the system time pickers.

## 4. Frequencies

**What the evidence asks for** (round 2 and ledger card C043, 53 apps): N times a week on any days, specific weekdays, every N days, and monthly. A few reviews ask for once a month or once a year (`P49#2817`).

**Covered now, as eight rules in two groups:**

| On fixed days | On any days |
|---|---|
| Every Day | A Few Times a Week |
| On Certain Days (weekdays) | A Few Times a Month |
| Every Few Days | A Few Times a Year |
| Every Few Weeks (on today's weekday) | |
| On Dates of the Month (29–31 move to the month's last day) | |

**Still later**, because they are the rare tail of C043 and each adds a new idea to the menu: end dates and "until done" challenges, and the Nth weekday of the month ("first Monday").

**"Times a day" with other rules.** It felt odd because the goal sat **above** How Often and appeared or vanished when the rule below it changed. Now, reasoned from first principles:
- **How Often comes first** for every type; everything it controls sits below it.
- **Times each day** shows only for fixed-day rules ("every 3 days, twice that day" makes sense).
- For any-day rules, each tick counts toward the week, month or year. "3 a week" already says how many, so a daily count would ask the same question twice.
- The footer states the choice in one sentence, e.g. "Due every 3 days from today, 2 times each day."

## 5. Form order

The same slots in the same order for every type:
1. icon, name and colour;
2. How Often;
3. the type's own part (daily goal, amount and unit, minutes, checklist parts, date for a to-do);
4. Day Section;
5. Reminders.

Quit leaves out 2, 4 and 5; a to-do leaves out 2 and 5 and carries its own date and reminder.
