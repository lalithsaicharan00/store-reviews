Supplied by the user on 28 September 2026: an external deep-research report on the New flow's copy, answering the prompt in [Habit Flow Copy — Deep Research Prompt](<Habit Flow Copy — Deep Research Prompt.md>) with the [Evidence Pack](<Habit Flow Copy — Evidence Pack.md>). Saved by Claude (Claude Code), 28 September 2026. The report's text below is unchanged except that its inline citation markers (unreadable tool tokens) were removed; its sources are listed in its own appendix.

## Read this before writing any copy for the New flow

The first copy (27 Sep) made these mistakes. Don't repeat them:

| Mistake | Why it's wrong | Rule |
|---|---|---|
| "What do you want to **create**?" → "A **bad** habit" | Nobody creates a bad habit; they want to stop or reduce one | Screen 1 names the user's **intent** as a verb: Build or maintain · Quit or cut down · Add a task |
| "Good" / "bad" as the labels | A moral label that doesn't say whether it means quit or reduce | Label the action, not a judgement |
| Examples that tie an activity to a type ("Take vitamins" = tick, "Drink water" = count, "Read" = time) | The same activity can be ticked, counted or timed. It depends on what the user wants to record | Examples name **what gets recorded**: "Check off each walk", "Log pages as you read", "Record minutes spent reading" |
| "Count it" for anything with a number | Amounts include decimals and units (2.5 km, 1.5 L), which aren't counts | "Track an amount" |
| "How long, with a timer" | Hides manual time entry | Time copy must allow a timer *or* typing the time |
| "Tasks don't have progress or stats" | Can read as "a task can't be marked done" | "No **habit** progress, streaks or stats" |
| A checklist example that sounds like a routine ("Morning routine") | Routines are a separate feature (several habits) | Checklist = **one habit** with items: "Clean kitchen — dishes, sink, floor" |
| Examples on Screen 1 | The labels already say what each branch does | No examples on Screen 1 |

**What was built (28 Sep, the user's decision):**
- **Screen 1:** heading, titles and subtexts exactly as the report proposes.
- **Build screen:** the report's titles ("Track an amount" replaces "Count it") and its checklist example. **The subtexts were kept as they were**, at the user's instruction.
- **Build-screen examples, redone the same day:** the user found "Check off each walk", "Log pages as you read" and "Record minutes spent reading" unintuitive. They read as instructions, not habits. They are now **Make your bed · Drink 8 glasses of water · Meditate for 10 minutes**: common habits (review counts: make my bed 192, glasses of water 91, meditate with minutes 26) that can each be recorded **only one way**. That keeps the report's point (don't imply an activity belongs to one type) without instruction-style phrasing. Avoid activities reviewers track several ways, like reading (pages 94, minutes 72) or walking (steps, minutes, times).
- **Quit screen:** the report's subtexts and examples. The titles were unchanged anyway.
- **Form placeholders:** as the report proposes.

The two labels the report flags for comprehension testing are **Build or maintain** and **Track an amount**. Its test protocol is below.

---

# Habit-creation flow: evidence-backed UX copy recommendation

## Diagnosis and recommendation

The current flow has a **routing problem before it has a wording problem**. The first screen asks “What do you want to create?” and then offers “A bad habit”. That is logically backwards for the second branch: the user is trying to stop or reduce that behaviour, not create it. “Good” and “bad” are also doing taxonomy work that the interface does not need. The supplied brief and screenshots confirm that the actual product distinction is behavioural intent—do/maintain, quit/reduce, or complete a task—not moral classification.

There is genuine user language behind phrases such as **build habits**, **bad habit**, **break a habit**, **quit**, **check off**, **count**, and **timer**. But the research does **not** support simply taking the most common-looking phrase and turning it into a label. For example, a Ritualix reviewer naturally wrote that the app helped them “build and maintain habits”, which is useful evidence that *build* is familiar but also that people can distinguish building from maintaining. A HelloHabit reviewer likewise talked separately about habits they were “trying to build” and maintaining existing habits.

The same issue appears one level down. Users readily say “check off” or “tick off” habits, but that does not prove that a particular activity belongs to a completion method. One HelloHabit reviewer explicitly wanted a 30-minute exercise goal while still being able to “check it off just once”. In other words, **duration and completion can describe the same real-world activity depending on what the user wants to record**. This strongly supports the owner's requirement to make examples describe the *recording interaction*, rather than pretending “reading = timer” or “water = counter”.

My preferred system is therefore:

> **What do you want to do?**  
> **Build or maintain** — A habit you want to start or keep doing.  
> **Quit or cut down** — A habit you want to stop or do less.  
> **Add a task** — Something to get done, once or on repeat. No habit progress, streaks or stats.

This is less compact than “Good habit / Bad habit / Task”, but it is substantially more predictive. The first two labels name the user's intent, and their subtext removes the two key boundary errors: *existing habits are allowed* and *reducing does not mean quitting*. This also follows W3C cognitive-accessibility guidance to use familiar words in labels and to put the information needed to make a choice at the step where that choice is made, rather than expecting people to infer an internal category.

The most important second-screen changes are to replace **“Count it” with “Track an amount”**, clarify that **Time** supports both timer and manual entry, make **Checklist** explicitly one habit containing items, and rewrite examples around what is recorded. “Track an amount” is the one recommendation I would regard as most test-sensitive: users demonstrably say “count”, “counts” and “how many times”, but the product also accepts decimals and units such as distance, for which *count* is an incomplete description.

There are several specific weaknesses in the existing second screens. “Done or not done” sounds binary even though completion can record more than one occurrence in a period; “How long, with a timer” omits manual time entry; “A short list to tick off” does not establish that the checklist is **one habit**, rather than a routine containing several habits; and “At most 2 coffees a day” demonstrates a target but not the fact that the user logs consumption against that maximum. Those are product-copy mismatches rather than stylistic preferences.

Finally, I would remove “good” and “bad” **without claiming that users dislike those words**. Some users spontaneously use “bad habit”, and one reviewer explicitly described wanting to “break annoying habits”; another described creating a “bad habit to track”. The case for removing the labels is narrower and stronger: they are unnecessary judgements for routing, “create a bad habit” is semantically contradictory, and they do not tell a first-time user whether the branch means quitting, reducing, or both.

## Evidence base and research method

This research used four evidence classes and keeps them separate:

| Evidence class | What it can establish | What it cannot establish |
|---|---|---|
| **User-authored reviews** | Vocabulary users spontaneously use; misunderstandings; how they conceptualise logging | Population preference for one UI label |
| **User communities** | Category confusion, natural explanations, competing mental models | Generalisable usability rates |
| **Competitor documentation** | What a term means in another product; whether similar mechanics exist | User comprehension or preference |
| **Accessibility / UX guidance** | General principles for clear labels and low cognitive load | Which exact habit-app label will win a comprehension test |

I manually inspected accessible user-authored App Store material across multiple habit and planning products, including HelloHabit, Habitify, HabitKit, Grit, Ritualix, Bad Habit Tracker, Sober and Habit Hub, as well as the supplied HabitNow/HabitKit excerpts and relevant Reddit discussions. I also checked current competitor help material where it was useful to verify mechanics. I did **not** convert this purposive sample into phrase-frequency percentages: it is not a random or exhaustive corpus, storefronts expose different reviews, and search retrieval itself biases what becomes visible. Presenting a percentage such as “X% of users prefer *check off*” from this material would therefore be misleading.

The full local review corpus referred to in the brief was **not attached**. I have the four embedded excerpts/IDs in the supplied research prompt, but not the source dataset from which earlier regex counts were calculated. I also could not independently reopen the supplied HabitNow Google Play review IDs through the available web interface. I therefore treat those items as **owner-supplied verified evidence**, rather than falsely claiming that I independently reproduced the local review analysis.

This matters particularly for “yes/no” versus “counting”. The supplied HabitNow review, ID `055c4f61-b461-47f1-a18d-abd3d9dc4165`, says “i can choose beetween yes/no or counting”. That is useful evidence that a user recognises those concepts; it is not a controlled comparison showing that **Yes/No** is the clearest creation-screen label. The other supplied HabitNow examples—walking first as yes/no and later recording steps, and first marking an activity as happened then later timing it—are even more valuable because they demonstrate that **the activity does not determine its tracking method**.

Independent public evidence points the same way. A HelloHabit reviewer conceived “exercising for 30 min” as something that should nevertheless be checked off once. A Habitify reviewer discussed a `+1` interaction and then a replacement dialog asking how many times an activity was done. A Grit reviewer described habits in terms of “timers, counts” and metrics such as minutes, counts and other units. Together these examples are strong evidence against activity-topic examples such as “vitamins = check-off, water = counting, reading = time” being self-explanatory.

Category confusion is not hypothetical either. In a recent Habitica discussion, a first-time user said Habits and Dailies felt very similar and asked where cold showers, meditation and reading belonged; commenters then offered multiple, partly different interpretations, including one saying the categories were “named weird”. Habitica's mechanics differ from this product, so this is not evidence to copy its taxonomy. It is evidence that **familiar nouns do not rescue overlapping categories when users cannot predict the downstream behaviour**.

The UX principle is consistent with that observation. W3C recommends common words used in their common meanings for labels and navigation, and specifically warns against processes that require users to remember or infer categories rather than having enough information at the point of choice.

## Language evidence matrix

The table below deliberately separates **familiarity** from **fitness as this product's label**. Confidence is qualitative because no controlled comprehension study has yet been run.

| Candidate | Actual user evidence and meaning in context | Strength for this UI | Risk / limitation | Confidence and disposition |
|---|---|---|---|---|
| **Build a habit** | Ritualix reviewer: “build and maintain habits”; HelloHabit reviewer distinguishes habits being built from habits being maintained. | Very natural wording for forming a new behaviour. | *Build* alone can sound new-only; the user review itself distinguishes building from maintaining. | **High familiarity, moderate coverage.** Use as part of **Build or maintain**, not alone. |
| **Form a habit** | “Form” appears in habit-product language and occasional user language, but public evidence inspected here is thinner than for *build*. HabitKit itself markets “form new habits”. | Semantically precise for establishing something new. | Even more clearly excludes an existing habit being maintained; somewhat less conversational. | **Low-to-moderate for this branch. Rejected.** |
| **Track a habit** | Users frequently describe apps as habit trackers and say they “track” habits or progress; Habitify reviewers use “check off habits and track progress”. | Broad, neutral, includes existing habits. | Too broad as a routing label: quit and cut-down behaviours are also being tracked. | **High familiarity, poor discrimination. Rejected for Screen 1.** |
| **Build or maintain** | Exact user phrasing “build and maintain habits” exists, while HelloHabit users separately discuss building and maintaining. | Truthfully includes both new and existing positive-direction habits. | *Maintain* is more formal than *keep doing*, especially for some non-native speakers. | **Preferred.** Adjacent subtext translates it into “start or keep doing”. Must be comprehension-tested. |
| **Break a habit** | Bad Habit Tracker reviewer: wanted to “break annoying habits”. | Familiar and concise for stopping an unwanted behaviour. | Strongly suggests ending the behaviour; weak coverage of deliberate reduction. | **High familiarity for quitting, inadequate for the whole branch. Rejected as Screen-1 umbrella.** |
| **Bad habit** | Users do spontaneously use the phrase; Sober review says “bad habit to track”, and the supplied corpus contains it. | Recognisable category. | It is evaluative, says nothing about quit versus reduce, and conflicts with “What do you want to create?”. | **Familiar but structurally weak. Remove.** |
| **Quit** | HelloHabit reviewer praises being able to “track quitting a bad habit”. Quit-tracker reviews describe elapsed counters down to days/seconds or a “streak/time counter”. | Very strong match to completely stopping and elapsed-time tracking. | Without subtext, some users could expect a general cessation tracker rather than specifically time-since. | **High. Keep**, with explicit elapsed-time subtext. |
| **Cut down** | Public user conversations naturally contrast cutting down with quitting; HelloHabit reviewers also describe wanting habits they can “reduce”. | Everyday English and directly contrasts with Quit. | Does not by itself communicate *log an amount against a daily maximum*. | **Moderate-to-high. Keep**, with mechanics in subtext. |
| **Task** | Users and products distinguish habits from tasks/to-dos; one Habit Hub reviewer described an app combining “recurring habits and to do tasks”. Habitica users also use “To-Do” for discrete things to get done. | Matches the product's existing concept and comfortably supports “task” as a repeatable item. | User evidence does not establish that *task* is universally clearer than *to-do*. | **Moderate. Prefer Task** because it avoids implying one-time-only and matches the product model. |
| **To-do** | Habitica users naturally use “To-Do's” for discrete forthcoming actions. | Familiar productivity vocabulary. | In that very discussion, examples are one-off actions; that mental model could work against this product's recurring-task support. | **Familiar but no demonstrated advantage. Do not rename the branch.** |
| **Check it off** | Habitify user describes “ticking habits off the list” and “check off habits”; other users similarly describe checking off goals. | Strongly communicates a discrete completion interaction. | Also used generically for completing goals and tasks; not uniquely a habit method. Can sound once-per-period unless subtext handles repetitions. | **High familiarity, moderate discrimination. Keep**, change subtext. |
| **Yes / no** | Supplied HabitNow reviewer explicitly says “yes/no or counting”. | Extremely simple binary concept. | Product completion can support several occurrences in a chosen period; a binary label can falsely imply one daily result. | **Evidence-backed vocabulary, feature-misaligned. Reject as title.** |
| **Count it** | Supplied HabitNow user says “counting”; Habitify users talk about `+1` and “how many times”; Grit user says “counts”. | Familiar for repetitions, pages, steps and glasses. | Literal *counting* fits discrete quantities better than `2.5 km`, `1.25 L`, or other decimal/custom units. | **High for discrete counts, only moderate for full capability. Replace with Track an amount.** |
| **Track an amount** | Direct spontaneous user evidence for this exact phrase is weaker; users more often talk about counts, metrics, values or “how many”. Official Habitify behaviour distinguishes a one-tap count from logging arbitrary values such as kilometres. | Covers how many **and** how much, including decimals and custom units. | Less idiomatic than “Count it”; could be confused with duration because time is technically an amount. | **Moderate and test-sensitive. Preferred on semantic accuracy.** |
| **Time it** | Grit reviewer explicitly discusses timers and minutes; Habitify documentation reserves its timer for duration-based goals measured in minutes/hours. | Short, concrete and strongly signals duration. | Current subtext “with a timer” incorrectly hides manual time entry. | **High. Keep**, fix subtext. |
| **Checklist** | The supplied HabitKit review asks for multiple sub-items within one habit; Habitify's current implementation likewise defines a checklist as smaller steps belonging to a habit. | Familiar model for several tickable items inside a parent. | Competitors often use examples such as “Morning Routine”, which would conflict with this app's separate Routine feature. | **Moderate-to-high. Keep**, explicitly say “One habit”. |

A particularly important result is that **“check off”, “count”, “timer” and “checklist” describe interactions more reliably than they describe activities**. Habitify itself exposes separate quick controls for `Done`, repeated `✓1`, `Timer`, and a more general `Log`, and its arbitrary-value logging can add `3 km` onto an existing `2 km`. That is product documentation rather than user-language evidence, but it verifies that the conceptual split between discrete occurrences, numerical accumulation and duration is not artificial.

Similarly, time should not silently mean daily. A HelloHabit reviewer explicitly discusses weekly, monthly and yearly habit goals, while its current product documentation offers broader goal periods; this is consistent with your requirement that positive-habit goals need not be daily.

## Implementation-ready copy

The following is the preferred set. I would ship this copy into a comprehension test as a **single coherent system**, not independently A/B-test isolated words before checking whether users can route scenarios end to end.

| Stable key | Current | Proposed |
|---|---|---|
| `new.nav_title` | New | **New** |
| `new.question` | What do you want to create? | **What do you want to do?** |
| `new.build.title` | A good habit | **Build or maintain** |
| `new.build.subtext` | Something you want to do regularly. | **A habit you want to start or keep doing.** |
| `new.quit_or_reduce.title` | A bad habit | **Quit or cut down** |
| `new.quit_or_reduce.subtext` | Something you want to stop, or do less. | **A habit you want to stop or do less.** |
| `new.task.title` | A task | **Add a task** |
| `new.task.subtext` | Something to get done, once or on repeat. Tasks don't have progress or stats. | **Something to get done, once or on repeat. No habit progress, streaks or stats.** |
| `new.cancel` | Cancel | **Cancel** |
| `new.free_footer` | [N] of 5 free habits used. Tasks are always free. | **[N] of 5 free habits used. Tasks are always free.** |

The first-screen labels deliberately use verbs because the heading now asks for an action. “Build or maintain” is paired with a plain-language gloss—“start or keep doing”—so users do not have to know *maintain*. “Quit or cut down” mirrors the exact two choices they will encounter next. “Add a task” is an action rather than a category noun and keeps recurring tasks inside the branch. The task disclosure names **habit** progress explicitly, so it does not accidentally suggest that a task cannot be marked complete. The distinction between task completion and habit analytics is part of the supplied product model.

**No examples appear on Screen 1.**

| Stable key | Current | Proposed |
|---|---|---|
| `build.nav_title` | A good habit | **Build or maintain** |
| `build.question` | How do you want to track it? | **How do you want to track it?** |
| `build.completion.title` | Check it off | **Check it off** |
| `build.completion.subtext` | Done or not done. | **Record each time you do it.** |
| `build.completion.example` | Example: Take vitamins | **Example: Check off each walk** |
| `build.amount.title` | Count it | **Track an amount** |
| `build.amount.subtext` | How many or how much. | **Record how many or how much.** |
| `build.amount.example` | Example: Drink 8 glasses of water | **Example: Log pages as you read** |
| `build.time.title` | Time it | **Time it** |
| `build.time.subtext` | How long, with a timer. | **Use a timer or enter the time.** |
| `build.time.example` | Example: Read for 20 minutes | **Example: Record minutes spent reading** |
| `build.checklist.title` | Checklist | **Checklist** |
| `build.checklist.subtext` | A short list to tick off. | **One habit with items to tick.** |
| `build.checklist.example` | Example: Push-ups, squats, plank | **Example: Clean kitchen — dishes, sink, floor** |

This set intentionally **does not make the examples mutually exclusive in the real world**, because that would be false. A walk can be counted, timed or measured by distance. Reading can be checked off, measured in pages or timed. What changes is the phrase around the activity: *check off each*, *log pages*, *record minutes*. That is the part the user is selecting.

“Check it off” survives because real users repeatedly use *check off* and *tick off* to describe discrete completion. The replacement subtext matters more than the label: “Record each time you do it” removes the current once-only/binary implication while still fitting a habit whose target is one occurrence.

“Track an amount” is the deliberate departure from spontaneous vocabulary. A Grit reviewer naturally distinguishes metrics such as minutes, count and “other units”, and Habitify's actual progress model distinguishes one-step count buttons from arbitrary numeric logs such as kilometres. Since this product accepts decimals and custom units, *amount* is more truthful than *count*, even though “Count it” has somewhat stronger direct user-language support. This should be the first method label challenged in usability testing.

“Time it” stays because both users and competing systems strongly associate timer language with duration. The subtext is changed because your product accepts manual duration as well; competitor documentation also shows duration tracking tied specifically to minutes/hours, which is consistent with the supplied capability.

“Checklist” stays, but its definition becomes architectural: **one habit with items**. Habitify's help documentation similarly defines a checklist as smaller steps attached to a habit, but uses “Morning Routine” among its examples. I would explicitly avoid that example in this app because your separate Routines feature groups habits rather than checklist items.

The quit/reduction branch becomes:

| Stable key | Current | Proposed |
|---|---|---|
| `quit_or_reduce.nav_title` | A bad habit | **Quit or cut down** |
| `quit_or_reduce.question` | What do you want to do? | **What do you want to do?** |
| `quit.title` | Quit | **Quit** |
| `quit.subtext` | Stop completely. It counts the time since. | **Stop completely. Track time since you stopped.** |
| `quit.example` | Example: Smoking | **Example: Time since you last smoked** |
| `cut_down.title` | Cut down | **Cut down** |
| `cut_down.subtext` | Do it less, with a daily limit. | **Set a daily maximum and log how much.** |
| `cut_down.example` | Example: At most 2 coffees a day | **Example: Log coffees, up to 2 a day** |

“Quit” is particularly well supported. A HelloHabit reviewer explicitly praises the ability to “track quitting a bad habit”; reviews of dedicated quit trackers describe counters showing elapsed days down to seconds and a “streak/time counter”. The current “It counts the time since” points in the correct direction, but the proposed **“Track time since you stopped”** states the object of the counter and separates it from Screen 2A's session timer.

“Cut down” should also remain. Users do talk about habits they want to “reduce”, while everyday quit/reduction discussions naturally distinguish cutting down from quitting. The important copy change is mechanical: *set a daily maximum and log how much*. That tells a user that this is not merely a motivational target saying “drink ≤2”; there is an amount to record against a ceiling. It also stays within the only period currently verified for this feature: **daily**.

The connected form titles and placeholders should be aligned as follows:

| Stable key | Current | Proposed |
|---|---|---|
| `form.completion.title` | Check it off | **Check it off** |
| `form.completion.name_placeholder` | e.g. Take vitamins | **e.g. Walk** |
| `form.amount.title` | Count it | **Track an amount** |
| `form.amount.name_placeholder` | e.g. Drink water | **e.g. Read** |
| `form.time.title` | Time it | **Time it** |
| `form.time.name_placeholder` | e.g. Read | **e.g. Practise piano** |
| `form.checklist.title` | Checklist | **Checklist** |
| `form.checklist.name_placeholder` | e.g. Workout | **e.g. Clean kitchen** |
| `form.quit.title` | Quit | **Quit** |
| `form.quit.name_placeholder` | e.g. Smoking | **e.g. Smoking** |
| `form.cut_down.title` | Cut down | **Cut down** |
| `form.cut_down.name_placeholder` | e.g. Coffee | **e.g. Coffee** |
| `form.task.title` | Task | **Task** |
| `form.task.name_placeholder` | e.g. Pay the rent | **e.g. Pay the rent** |

The placeholders no longer need to teach the tracking model: by the time a user sees them, they have already selected a method. Their job is simply to demonstrate a natural habit or task name. It is therefore acceptable that “Read” could theoretically be tracked in several ways; at that point the method has already been chosen.

I would **not** add a second full copy set at this stage. The evidence does not reveal two equally defensible overall systems. It reveals two strings worth targeted validation—**Build or maintain** and **Track an amount**—inside an otherwise coherent preferred set.

## Example-confusion and consistency checks

The proposed examples are designed around **what is entered into the app**, not around supposedly exclusive activity categories.

| Proposed example | What gets logged | Why the intended method is clearer | Nearest competing interpretation | How the wording mitigates it |
|---|---|---|---|---|
| **Check off each walk** | One discrete occurrence for each walk | “Check off each” names the interaction, not merely the activity. | A user could count walks, measure distance or time each walk. | It does not pretend walking belongs uniquely here; it tells users this option is for recording each occurrence. |
| **Log pages as you read** | A numeric amount of pages, potentially accumulated over the goal period | The unit being recorded is explicitly *pages*. “As you read” suggests progress can accumulate rather than being one final yes/no result. | A user could check off a reading session or time it. | The example names the recorded value rather than “Read 20 pages”, which could sound like a binary target. |
| **Record minutes spent reading** | Duration in minutes | “Minutes spent” explicitly names a duration value. | The user could still decide that finishing a 20-minute session should be a one-tap completion. | This ambiguity is real and should not be hidden; the time option explains *how the app records it*. A HelloHabit review demonstrates this exact overlap between 30-minute duration and one-tap completion. |
| **Clean kitchen — dishes, sink, floor** | Three tickable sub-items belonging to one parent habit | Parent → component formatting visually demonstrates a contained list. | The items could be separate habits in a routine, or “Clean kitchen” could be a task. | The adjacent subtext “One habit with items to tick” supplies the defining rule. The example avoids the explicit word *routine*. |
| **Time since you last smoked** | Elapsed time from a stopping point | “Time since” is the standard semantic contrast to timing an activity. | A user might otherwise think Quit is a daily “didn't smoke” checkbox. | The example shows an upward-running elapsed counter; quit-tracker users also describe these products in terms of elapsed days/time counters. |
| **Log coffees, up to 2 a day** | Consumption amount against a maximum of two per day | “Log coffees” supplies the missing recording action; “up to 2” supplies the ceiling. | The user could simply check off whether they stayed under two. | It combines logging and limit in one line instead of presenting only the goal state. |

The inability to make the first three examples perfectly exclusive is **not a copy failure**. It is a property of the product model. The same activity can validly be represented as an occurrence, an amount, or a duration depending on the user's question. Public review evidence makes that especially clear: one user explicitly wanted a duration goal to work as one check-off, and another described a tracker in terms of counts, minutes and other units. The correct UX goal is therefore *predictability of the recording interaction*, not fictional exclusivity of examples.

The full consistency check is:

| Product distinction | Proposed copy | Check |
|---|---|---|
| **Building vs maintaining** | “Build or maintain” + “start or keep doing” | **Pass.** Existing habits are explicitly included rather than treated as newly formed. User language distinguishes building and maintaining, supporting the need for both concepts. |
| **Quitting vs reducing** | Screen 1 “Quit or cut down”; Screen 2 “Quit” / “Cut down” | **Pass.** The parent label exactly previews its two children rather than using “Break” or “Stop” as an umbrella that sounds quit-only. |
| **Recurring task vs habit** | “Something to get done, once or on repeat. No habit progress, streaks or stats.” | **Pass.** Recurrence is not used as the distinction. The distinction is product treatment: task completion without habit analytics. |
| **Completion vs numeric progress** | “Record each time you do it” vs “Record how many or how much” | **Pass with test risk.** The interaction boundary is explicit; “Track an amount” still needs empirical comprehension testing. |
| **Elapsed time since quitting vs session timer** | “Track time since you stopped” vs “Use a timer or enter the time” | **Pass.** *Since* signals elapsed abstinence; timer/manual entry signals duration of an activity. Quit-tracker reviews support the elapsed-counter mental model. |
| **Checklist vs routine** | “One habit with items to tick” | **Pass provisionally.** It states containment directly. This remains a high-priority test because competing products often use “routine” as a checklist example. |
| **Daily vs longer goal periods** | No positive-habit copy says daily; completion says “each time”; amount/time are period-neutral | **Pass.** This preserves Day/Week/Month/Year support. Users of other habit apps also discuss weekly, monthly and yearly habit goals. |
| **Cut-down period** | “daily maximum” | **Pass.** It does not extrapolate unsupported weekly/monthly limits. |
| **Checklist completion** | “One habit with items to tick” plus existing form explanation that the habit completes when every item is ticked | **Pass.** Nothing implies the items are separate habits. |
| **Tasks can be completed** | “Something to get done” plus disclosure limited to “No habit progress, streaks or stats” | **Pass.** It does not say “tasks have no progress” in a way that could be mistaken for “tasks cannot be marked done”. |

One subtle change deserves emphasis: **“No habit progress, streaks or stats”** is preferable to simply “Tasks don't have progress or stats.” The latter is technically intended to mean habit-style progress tracking, but ordinary English can make “no progress” sound as though task completion itself is not represented. Qualifying *progress* with *habit* preserves the product distinction.

## Comprehension test protocol

This recommendation should now be tested for **first-choice comprehension**, not preference. Asking “Which wording do you like?” would answer the wrong question. The target measure is whether a first-time user predicts the right branch and the right logging behaviour without being taught the taxonomy. That approach is consistent with the broader accessibility principle that labels should let users proceed from information available at the current step.

Run two iterative rounds of roughly **8–10 first-time participants per round**, with at least half of each round being non-native English speakers and with several different first languages represented. That sample size is a pragmatic qualitative design choice, not a claim of statistical representativeness. Do not recruit only existing power users of habit trackers, because familiarity with a competitor's categories can mask first-time wording problems.

Participants should see the actual compact text-first list, without icons, explanations from the moderator, or training screens. Randomise scenario order sufficiently that later tasks do not teach the earlier taxonomy.

Use neutral scenarios that do not copy the UI examples:

| Scenario | Expected first choice | Follow-up question |
|---|---|---|
| “You already go swimming every Saturday. You want to keep tracking that habit.” | **Build or maintain** | “Why did you choose this even though the habit already exists?” |
| “You want to start stretching three times a week.” | **Build or maintain** | “What do you expect the next screen to ask?” |
| “You stopped vaping yesterday and mainly want to see how long it has been.” | **Quit or cut down → Quit** | “Would you expect to press Done every day, or see time counting from when you stopped?” |
| “You still drink coffee but want to stay at no more than two cups a day and record what you drink.” | **Quit or cut down → Cut down** | “What would you enter during the day?” |
| “You need to renew your passport once.” | **Add a task** | “Would you expect habit streaks or statistics?” |
| “You need to pay a bill every month. You want it to come back monthly, but you do not care about a streak.” | **Add a task** | “Does the fact that it repeats make it a habit here?” |
| “You want to record each time you phone a family member. You only care that each call happened.” | **Check it off** | “What would one tap mean?” |
| “You read throughout the week and want to add the number of pages you read each time.” | **Track an amount** | “What number or unit would the app store?” |
| “You practise guitar and want the app to record how many minutes you practise, using a timer sometimes and typing the time other times.” | **Time it** | “What would be different from Track an amount?” |
| “Every Sunday, ‘Check the car’ means tyres, lights and washer fluid. You want one habit completed only after all three are ticked.” | **Checklist** | “Would those three items become three habits?” |

For each scenario, record **first tap before discussion**, the participant's paraphrase of the chosen label, expected next screen, and expected stored data. A correct first tap with a wrong explanation is not a full success. For example, someone who chooses Quit but expects a daily “I didn't smoke” checkbox has not understood the mode.

For non-native speakers, the most useful probing is lexical rather than motivational: ask them to explain **maintain**, **cut down**, **amount**, **check it off**, **on repeat**, **streak**, and **checklist** in their own words. Do not explain those terms before the first choice. After the task, ask which word caused hesitation. W3C specifically recommends common meanings and warns that uncommon or specialised terms in labels can make otherwise usable controls difficult to understand.

As a project acceptance rule—not a universal UX benchmark—I would aim for **at least 85% correct first choices for each scenario after pooling the two rounds**, with no persistent systematic confusion between these three critical pairs:

**Build/maintain vs task**, **Quit vs cut down**, and **Check off vs amount/time**.

More important than the aggregate percentage is the error pattern. A repeatable error among two or three participants is more actionable than isolated hesitation.

The recommendation should change under these conditions:

| Observed failure | Interpretation | Copy change to test next |
|---|---|---|
| Non-native speakers repeatedly cannot explain **maintain** | Semantically complete label is lexically too difficult | Test **Build a habit** with subtext “Start or keep doing something regularly”, versus **Start or keep a habit**. |
| Existing-habit users avoid **Build or maintain** despite understanding maintain | The compound label itself feels like a new-habit path | Test a more neutral umbrella such as **Do a habit**, but only if task/quit overlap can be controlled. |
| Users put distance, litres or decimal values under **Count it** when shown the old version, but understand **Track an amount** in the new version | Confirms benefit of the change | Keep **Track an amount**. |
| Users interpret **Track an amount** as duration because minutes are an amount | Amount/time distinction is not strong enough | Test **Count or measure** against **Track an amount**, retaining the explanatory subtext. |
| Users think **Check it off** means once per day | Familiar phrase is over-associated with a binary daily habit | Change subtext to **“Check it off each time it happens.”** before changing the title. |
| Users choose **Checklist** but describe its items as separate habits | The checklist/routine boundary is still hidden | Strengthen to **“One habit, several items to tick.”** and test again. |
| Users send a monthly bill to the habit branch solely because it repeats | Recurrence is overpowering the task distinction | Front-load task copy: **“A task to get done, once or on repeat. No habit streaks or stats.”** |
| Quit users expect to time smoking/cravings rather than abstinence | “Time since” still not prominent enough | Test **“Time since stopping”** as the example and **“Track how long since you stopped.”** as subtext. |
| Cut-down users expect only a pass/fail daily goal | Logging mechanic is underexplained | Test **“Log how much you do, with a daily maximum.”** |

The test should compare **comprehension**, not click speed alone. A fast wrong choice is worse than a slower correct choice, and a participant repeating the UI wording verbatim is weaker evidence than being able to describe what the app will store.

## Source appendix and remaining uncertainties

The evidence below is intentionally auditable. Citation links lead to the public source pages; where the supplied brief provided a review ID, the ID is included. Short excerpts are kept short because the point is language evidence, not reproducing reviews.

| Product / source | Date | Short user wording | Interpretation | Limitation |
|---|---|---|---|---|
| **HabitNow, Google Play**, review ID `055c4f61-b461-47f1-a18d-abd3d9dc4165` | 11 Nov 2025 | “yes/no or counting” | User recognises a binary-vs-quantity distinction. | Supplied local evidence; I could not independently reopen the review ID. Does not establish preferred UI labels. |
| **HabitNow, Google Play**, ID `7affe8d1-b7c5-43f5-a70b-995b5adf4c6b` | 16 May 2025 | Supplied paraphrase: walking first tracked yes/no, later steps | Strong evidence that an activity can change tracking method. | Supplied paraphrase, not independently revalidated. |
| **HabitNow, Google Play**, ID `80a1fa00-7e4b-470f-ae05-e1caa90cde10` | 14 Aug 2024 | Supplied paraphrase: first checked activity, later timed it | Same activity can be completion or duration. | Supplied paraphrase. |
| **HabitKit, App Store**, review ID `11526306665` | 23 Jul 2024 | Supplied paraphrase: several sub-items under one habit | Supports checklist-as-contained-items mental model. | User called their example a morning routine, which conflicts with this product's separate Routine concept. |
| **HelloHabit, App Store** | 5 May; storefront page does not show year in the review heading | “habits you’re trying to build”; “track quitting a bad habit” | User recognises building and quitting as distinct intents and also talks about maintaining habits. | One enthusiastic review, not controlled comprehension. |
| **HelloHabit, App Store** | 1 Sep 2025 | “check it off just once” for a 30-minute exercise goal | Direct evidence that duration does not uniquely determine method. | Describes another app's mechanics and desired interaction. |
| **HelloHabit, App Store** | 19 Sep 2025 | Habits the user wants to “reduce” | Supports reduction as a user-recognised intent separate from ordinary positive habits. | Does not compare *reduce* with *cut down* as labels. |
| **Habitify, App Store** | 12 Jul 2025 | “ticking habits off the list”; “check off habits” | Strong spontaneous evidence for check/tick-off completion language. | Does not prove the phrase uniquely distinguishes a tracking method. |
| **Habitify, App Store** | 29 May 2025 | User discusses a `+1` indicator and being asked “how many times” | Supports discrete incremental-count mental model. | Product implementation differs from this app. |
| **Grit, App Store** | 25 Apr 2025 | “timers, counts”; “minutes, count, or other units” | User spontaneously distinguishes timer, count and other metric units. | One technically engaged reviewer; likely more knowledgeable than a first-time novice. |
| **Ritualix, App Store** | 14 Aug 2025 | “build and maintain habits” | Natural evidence that *build* and *maintain* are related but not identical concepts. | One review; not evidence that a compound UI label is automatically understandable. |
| **Bad Habit Tracker, App Store** | 20 Jun 2025 | “break annoying habits” | Shows *break a habit* is natural user vocabulary. | Break strongly fits cessation and gives little evidence for reduction. |
| **Bad Habit Tracker, App Store** | 27 Aug 2023 | User says it tracks elapsed days “right down to the seconds” | Supports elapsed-time mental model for quitting. | Dedicated quit product; users arriving there already know its purpose. |
| **Sober, App Store** | Accessible review text | “bad habit to track”; “streak/time counter” | Users can conceptualise quitting through an elapsed counter. | Specialised abstinence app; not evidence for the first routing label. |
| **HelloHabit, UK App Store** | 12 Dec 2025 | “weekly, monthly and yearly goals” discussed by reviewer | Evidence that users conceptualise habit completion beyond daily periods. | Other product's implementation. |
| **Habit Hub, App Store** | 19 Nov 2025 | “recurring habits and to do tasks” | Both *habit* and *to-do task* are recognisable product concepts. | Does not establish whether “task” or “to-do” is the better label for recurring tasks in this app. |
| **Reddit r/habitica** | Page displayed as approximately six months old at access | User says Habits and Dailies “feel very similar”; commenter: categories “named weird” | Strong qualitative warning that category names can fail to predict mechanics even when words are familiar. | Habitica has materially different mechanics and incentives. |
| **Finch Reddit discussion** | 16 Jun 2025 | Users talk about checking off goals/tasks and distinctions between “to do list stuff and routine stuff” | Reinforces that check-off vocabulary spans tasks, goals and routines rather than uniquely identifying one habit type. | Thread is mainly about a product/reward redesign, not creation-screen terminology. |
| **Habitify Help — Progress** | Current help content accessed Sep 2026 | `Done`, repeated `✓1`, `Timer`, and `Log` are mechanically separate | Verifies that occurrence, repeated counts, duration and arbitrary numeric values can be separate interaction models. | Vendor documentation, not user-language evidence. |
| **Habitify Help — Timer** | Current help content accessed Sep 2026 | Timer is for duration in minutes/hours and “how long” an activity is performed | Very close mechanical analogue to this product's Time option. | Vendor terminology does not prove user comprehension. |
| **Habitify Help — Checklist** | 9 Oct 2025 | Checklist consists of smaller steps attached to one habit | Supports the architectural meaning of Checklist. | Their examples include “Morning Routine”, which should not be copied because this app has a separate Routine object. |
| **W3C WAI — Use Clear Words** | Current W3C page | Recommends common words with common meanings in headings, labels and navigation | Supports plain labels and avoiding internal taxonomy. | General accessibility guidance, not habit-app evidence. |
| **W3C WAI — Do Not Rely on Memorising Information** | Current W3C page | Each step should contain information needed to proceed | Supports explanatory subtext at the decision point rather than expecting category learning. | General design guidance. |

The largest remaining uncertainty is **not “which phrase occurs most often?”** It is whether the compound first-screen labels and the amount label are understood quickly enough by actual first-time users.

**“Build or maintain”** has strong semantic coverage and direct user-language support, but *maintain* may be less accessible to some non-native English speakers. The proposed subtext deliberately translates it into the simpler “start or keep doing”. Until tested, that is a reason for caution, not a reason to retreat automatically to the narrower “Build a habit”.

**“Track an amount”** is the highest-uncertainty recommendation. Direct user language is richer for *count*, *how many times*, `+1`, *metrics* and *units* than for the exact phrase *track an amount*. The reason to prefer it is capability coverage: *count* is excellent for 7 glasses or 4 repetitions but less literal for 2.75 kilometres or 1.5 litres. That is a **writing judgement based on the verified feature model**, not a finding that users have already demonstrated a preference for “Track an amount”.

**Checklist versus Routine** is the other important unresolved boundary. There is good evidence that people want sub-items under one habit, and competitor systems use Checklist for that construct. But everyday users can also call a set of repeated steps a routine. Because this product assigns *Routine* a separate structural meaning—several habits—the distinction must be verified with “what gets created next?” testing rather than assumed from vocabulary.

There is **no evidence in this research that the words “good habit” or “bad habit” are inherently unusable or universally perceived as judgemental**. In fact, users sometimes use *bad habit* themselves. The recommendation to remove them rests instead on stronger product-writing grounds: they do not identify the user's intended operation, the negative label conflicts with “create”, and the same routing can be expressed more directly through *build/maintain* and *quit/cut down*.

The resulting copy system is therefore intentionally conservative where the current wording already works—**Check it off, Time it, Checklist, Quit, Cut down, Task**—and changes language only where the current text misstates capability, hides an important branch distinction, or makes the user infer internal categories. That is the strongest conclusion supported by the combined review evidence, community discussions, competitor mechanics and accessibility guidance; the remaining questions are now appropriate for comprehension testing rather than more synonym mining.