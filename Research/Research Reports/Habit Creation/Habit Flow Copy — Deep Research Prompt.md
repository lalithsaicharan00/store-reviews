# Habit Flow Copy — Deep Research Prompt

You are a senior UX writer and qualitative product researcher. Research and recommend plain-English copy for the first two screens of a native habit-tracking app. This is a research and copywriting task, not an implementation task. Do not create screenshots or mockups, change code, or redesign the navigation.

The objective is accurate first-time understanding: users should know which option to choose without learning our internal categories. Ground the language in what actual users say, but do not confuse common vocabulary with demonstrated comprehension of a UI label.

## Product context and constraints

The flow is:
- Tap + → choose between building/maintaining a habit, stopping/reducing a habit, or a task.
- Building/maintaining → choose a tracking method: completion, amount, time, or checklist → configuration form.
- Stopping/reducing → choose quitting completely or doing less → configuration form.
- Task → configuration form directly.

These are fixed capabilities, not proposed copy:
- Completion: record that an action happened. Can support one or several occurrences within a chosen period. Do not describe this as exclusively once a day.
- Amount: record how many or how much, including decimals and custom units. Examples of supported measurements include steps, distance, pages and glasses.
- Time: record duration using a timer or manual time entry. Only hours/minutes; not other units.
- Checklist: one habit containing several items; complete the habit by checking its items. The app separately has routines that group several habits. Do not blur those concepts.
- Quit: track elapsed time since stopping, not a daily completion checkbox.
- Cut down: log an amount against a maximum. The existing copy describes a daily limit. Do not promise additional limit periods unless verified.
- Tasks: something to get done once or on a repeating schedule. They can be marked done but have no habit progress tracking, streaks, or statistics. Do not label the entire task branch “one-time,” imply recurring tasks are habits, or imply tasks cannot be completed.
- Good-habit goals support choosing Day, Week, Month or Year without requiring a daily goal. A separate implementation is in progress; this research must not depend on its final UI details.
- Native, compact text-first lists; no decorative icons needed. All final UI copy must be plain English, accessible to non-native English speakers.

## Exact current copy, extracted from source on 28 September 2026

Screen 1 — entry screen:
Navigation title: “New”
Question heading: “What do you want to create?”

Option 1:
Title: “A good habit”
Subtext: “Something you want to do regularly.”
Example: “Example: Read every day”
Destination: Screen 2A.

Option 2:
Title: “A bad habit”
Subtext: “Something you want to stop, or do less.”
Example: “Example: Smoking, coffee”
Destination: Screen 2B.

Option 3:
Title: “A task”
Subtext: “Something to get done, once or on repeat. Tasks don't have progress or stats.”
Example: “Example: Pay the rent”
Destination: task form directly.

Toolbar: “Cancel”
Free-plan footer: “[N] of 5 free habits used. Tasks are always free.”

Screen 2A — currently reached through “A good habit”:
Navigation title: “A good habit”
Question heading: “How do you want to track it?”

1. “Check it off”
   Subtext: “Done or not done.”
   Example: “Example: Take vitamins”
2. “Count it”
   Subtext: “How many or how much.”
   Example: “Example: Drink 8 glasses of water”
3. “Time it”
   Subtext: “How long, with a timer.”
   Example: “Example: Read for 20 minutes”
4. “Checklist”
   Subtext: “A short list to tick off.”
   Example: “Example: Push-ups, squats, plank”

Screen 2B — currently reached through “A bad habit”:
Navigation title: “A bad habit”
Question heading: “What do you want to do?”

1. “Quit”
   Subtext: “Stop completely. It counts the time since.”
   Example: “Example: Smoking”
2. “Cut down”
   Subtext: “Do it less, with a daily limit.”
   Example: “Example: At most 2 coffees a day”

Connected form titles and name placeholders, included for consistency:
- “Check it off” → “e.g. Take vitamins”
- “Count it” → “e.g. Drink water”
- “Time it” → “e.g. Read”
- “Checklist” → “e.g. Workout”
- “Quit” → “e.g. Smoking”
- “Cut down” → “e.g. Coffee”
- “Task” → “e.g. Pay the rent”

Related explanatory copy:
- Checklist form: “One habit with a few items to tick. They reset each time it's due, and the habit is done when every item is ticked.”
- Quit form: “The counter runs from here. It shows at the top of Today under Quitting, counting up.”
- Task Repeat choices: “Never” / “On a schedule”.
- One-time task footer: “If it isn't done, it moves forward to today until it is. Tasks don't have progress or stats.”
- Repeating task footer: “It comes back on the days you pick below. Tasks don't have progress or stats.”

## Required changes and research questions

1. Remove all examples from Screen 1. Keep a concise heading, three option labels and useful subtext. Screen 2A and 2B should retain one example per option.
2. Fix the semantic mismatch in “What do you want to create?” followed by “A bad habit.” Users want to stop or reduce that behavior. Evaluate the heading and choices together as one system.
3. Investigate action wording such as build/form/start/track a habit, break/change/stop a habit, and add/do a task. These are hypotheses, not predetermined winners. Does the build label include maintaining an existing habit? Does the negative-habit label include reducing as well as quitting?
4. Make task subtext convey both its job and its lack of habit progress/streaks/stats, without implying it is only one-time. Compare “task” and “to-do” in context. Preserve the product distinction without an unnecessarily long disclaimer.
5. Verify whether “Check it off,” “Count it,” “Time it” and “Checklist” are understandable and reflect user language. Compare alternatives only where evidence suggests a meaningful improvement. “Check off” being frequent does not prove that it uniquely communicates a tracking method.
6. Replace ambiguous examples. The owner rejects “Take vitamins” and “Drink 8 glasses of water” as the preferred demonstration pair because either activity can be tracked in multiple ways. The workout list also needs a clearer checklist example. Find a set that communicates the tracking interaction, not merely different activity topics.
7. Do not pretend any real-world activity inherently belongs to only one tracking method. Investigate whether phrasing the example around what is recorded solves ambiguity. Evaluate each proposed example against all four tracking methods; if it remains ambiguous, explain why. A numeric target alone may still sound like a yes/no achievement; make incremental progress understandable. Avoid forced or unusual examples solely to manufacture exclusivity.
8. Make quit versus cut-down easy to predict. Does “Quit” express elapsed-time tracking clearly? Does “Cut down” express recording consumption against a maximum? Evaluate judgmental language such as “bad,” without assuming either that all users reject it or that frequency makes it appropriate.
9. Align destination navigation titles and form name placeholders with the chosen copy. Do not accidentally promise unsupported features or daily-only tracking.

## Research requirements

Use actual App Store/Google Play review text, Reddit user questions and discussions, and other accessible user communities. Use competitor help pages/screens only to verify behavior and wording; vendor marketing is not user-language evidence. Prefer original user posts over developer announcements or promotional replies. Record product, date, source URL or review ID, exact short excerpt, interpretation, and limitations.

Search broadly across products and communities, using synonyms and counterexamples rather than only searching the labels you already prefer. Inspect surrounding context. Distinguish words users spontaneously use from words they quote from an app. In particular, check whether “quit” means quitting a habit or abandoning an app; “count” means an amount rather than a complaint; “steps” means physical steps or checklist items; and “check off” concerns tasks rather than this habit mode.

Use an auditable evidence table, grouped by concept, not a collection of links. If reporting counts, state denominator, time range, source scope, deduplication, language filtering, query/matching method and whether meanings were manually verified. Do not present keyword hits, search-result totals, votes, or convenience samples as population preferences. Clearly separate user evidence, product documentation, first-principles inference, and hypotheses needing testing. Do not invent quotes, access, counts, participants, or usability results.

Prior internal reports used differing review subsets and regex definitions. One counted Latin-character reviews; another used common English words as a language heuristic. Their phrase rankings are leads, not verified English-language preference statistics. Revalidate before reusing them. Do not mechanically choose the most frequent phrase.

If the local review corpus or attached files are unavailable, state that explicitly. Use the embedded evidence and independently accessible sources without claiming to have read our full corpus. Report inaccessible sources and resulting gaps.

## Starting evidence, not predetermined conclusions

Verified local review excerpts:
- HabitNow, Google Play, 11 Nov 2025, ID `055c4f61-b461-47f1-a18d-abd3d9dc4165`: “i can choose beetween yes/no or counting”. Evidence that these terms are used; not proof they are the best labels.
- HabitNow, 16 May 2025, ID `7affe8d1-b7c5-43f5-a70b-995b5adf4c6b`: user describes tracking walking with yes/no, later wanting to record steps. Paraphrase; evidence that the activity itself does not uniquely determine the method.
- HabitNow, 14 Aug 2024, ID `80a1fa00-7e4b-470f-ae05-e1caa90cde10`: user describes first checking that an activity happened, later timing the effort. Paraphrase.
- HabitKit, App Store, 23 Jul 2024, ID `11526306665`: user asks for several sub-items under one habit, all checked before the habit is completed. Paraphrase. Their example calls it a morning routine; assess conflict with our separate routines feature.

Reddit leads retrieved during preparation; open and verify before using:
- https://www.reddit.com/r/habitica/comments/1q5xwne/difference_between_habits_and_dailies_need_advice/ — users struggle to map familiar activities to similar-sounding categories. Habitica's mechanics differ from ours.
- https://www.reddit.com/r/habitica/comments/1num53e/ — a user duplicates the same activities under habits and dailies because they do not understand the distinction.
- https://www.reddit.com/r/ticktick/comments/1cg9kv1/ — a user asks for a recurring checklist with sub-items and rejects answers that overlook those requirements.
- https://www.reddit.com/r/getdisciplined/comments/18i7o9v/ — original user uses “break a bad habit.” Vocabulary evidence only; do not import commenters' unsupported psychology claims.

These are starting points, not a sufficient research sample or reasons to copy another app's taxonomy.

## Required output

1. A short diagnosis of the current copy, including semantic contradictions and choice ambiguity.
2. An evidence matrix comparing candidate language: actual wording used by users, source, meaning in context, strengths, risks, confidence, and rejected alternatives. Do not fabricate numerical confidence scores.
3. One recommended, coherent, implementation-ready copy set: screen navigation titles, question headings, option labels, subtext, second-screen examples, and affected name placeholders. No examples on Screen 1. Include the task disclosure. Present current → proposed mappings with stable keys.
4. At most two complete alternative sets only if a real unresolved tradeoff justifies them. Choose a preferred set; do not leave me with a large synonym list.
5. An example-confusion matrix: for each second-screen example, explain what gets logged, why its intended method is clear, the nearest competing interpretation, and how the wording mitigates it.
6. A consistency check: building versus maintaining, quitting versus reducing, recurring tasks versus habits, completion versus numeric progress, elapsed time since quitting versus a session timer, checklist versus routine, daily versus longer periods.
7. A practical comprehension-test protocol for first-time users, including non-native English speakers: neutral scenarios, first-choice tasks, “what would happen next?” questions, success criteria, and signals that would change the recommendation. Propose the test; do not pretend it has run.
8. Source appendix and explicit remaining uncertainties. Distinguish evidence-backed findings from writing judgment.

Writing constraints: plain, concise, natural English; familiar words; short sentences; consistent grammatical structure; no jargon, hype, moralizing, or motivational filler. Aim for labels of 2–4 words, short subtext, and a single short example, but prioritize truthful comprehension over rigid word limits. The final recommendation should read as one connected flow, not separately optimized fragments.
