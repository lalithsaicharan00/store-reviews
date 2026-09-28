Written by Codex, 28 September 2026.

# Habit Flow Copy — Evidence Pack

Preparation for deep research, not a completed copy recommendation. Exact UI strings are in the companion [prompt](<Habit Flow Copy — Deep Research Prompt.md>). Screens were inspected through source; no screenshots were created. Source snapshot: `iOS/Habits/AddHabit/NewHabitView.swift`, ItemType, NewItemView, ChoiceLabel, taskSection and checklistSection.

## Verified review excerpts

These purposively selected records were read in full. They show relevant language and mental models, not population preference.

- **Habit Tracker - HabitKit · 2024-07-23 · 5★ · `11526306665`**
  > once you check off all three of those things, it will complete that habit for the day.

  [Original record](</Users/lalith/Desktop/store reviews/Research/App Store Reviews/7. Habit Tracker - HabitKit - Streaks & Accountability/reviews.jsonl:829>)

- **HabitNow Daily Routine Planner · 2026-07-08 · 5★ · `eef88a65-de00-402d-8d29-9cc1e06e94e5`**
  > simple yes/no, to specific number like 5 L of water or 6 Eggs

  [Original record](</Users/lalith/Desktop/store reviews/Research/Play Store Reviews/2. HabitNow Daily Routine Planner/reviews.jsonl:1164>)

- **HabitNow Daily Routine Planner · 2025-11-11 · 5★ · `055c4f61-b461-47f1-a18d-abd3d9dc4165`**
  > i can choose beetween yes/no or counting

  [Original record](</Users/lalith/Desktop/store reviews/Research/Play Store Reviews/2. HabitNow Daily Routine Planner/reviews.jsonl:2188>)

- **HabitNow Daily Routine Planner · 2025-05-16 · 5★ · `7affe8d1-b7c5-43f5-a70b-995b5adf4c6b`**
  > Like I used to track my 'Walking' with yes or no, but later i wanted to track it by steps walked.

  [Original record](</Users/lalith/Desktop/store reviews/Research/Play Store Reviews/2. HabitNow Daily Routine Planner/reviews.jsonl:2902>)

- **HabitNow Daily Routine Planner · 2024-08-14 · 5★ · `80a1fa00-7e4b-470f-ae05-e1caa90cde10`**
  > When I start building a habit, I just like to make sure I get it done in a day.

  [Original record](</Users/lalith/Desktop/store reviews/Research/Play Store Reviews/2. HabitNow Daily Routine Planner/reviews.jsonl:4405>)


## Existing phrase-count caveats

[New Habit Words and Units](<New Habit Words and Units.md>) reports 1,048,400 reviews with Latin text. Its `count_words.py` filter checks for an a–z character, which is not English-language identification. [Time of Day and Reminders](<Time of Day and Reminders — What Users Want.md>) addendum 6 reports 246,230 English habit-context reviews; `Habit Creation Evidence/newflow_plain_words.py` uses the words the/and/is/it as a heuristic, and matches either habit-related text or a habit-named app. Patterns differ between the studies. These are keyword-hit counts over different scopes, not directly comparable preference or comprehension measures. Neither prior study supplies Reddit evidence for those choices. Do not reuse their ratios as proof that a UI label is best.

Potential false positives: quitting an app versus quitting a behavior; “count” about bugs or statistics; physical steps versus checklist items; task check-off versus habit-mode naming. The use of familiar nouns “good habit” and “bad habit” does not resolve the sentence-level problem of pairing them with “create.”

## Reddit source leads

Retrieved as indexed thread content on 28 Sep 2026; direct-page availability may vary. User posts support qualitative confusion examples; commenters' explanations are not authoritative specifications.

- [Habitica category confusion, Jan 2026](https://www.reddit.com/r/habitica/comments/1q5xwne/difference_between_habits_and_dailies_need_advice/): cold showers, meditation and reading are difficult for the poster to classify. App-specific taxonomy; do not copy it.
- [Habitica duplicate setup, Sep 2025](https://www.reddit.com/r/habitica/comments/1num53e/): a newcomer puts the same activities into both categories because the difference is unclear.
- [TickTick checklist request, Apr 2024](https://www.reddit.com/r/ticktick/comments/1cg9kv1/): the original poster specifically wants multiple sub-items, not a set of separate habits.
- [Break a bad habit, Dec 2023](https://www.reddit.com/r/getdisciplined/comments/18i7o9v/): spontaneous wording in an original request. Only wording is relevant; no behavioral-science claims adopted.

Many other initial results were developer promotions, so they were excluded from independent user-language evidence. These leads do not constitute the requested deep research; the prompt requires broader retrieval, context coding, competing hypotheses and a proposed comprehension test.

## Scope and handoff

The earlier implementation was stopped at the user's request. Existing code edits remain in the shared workspace and were not reverted. Its build-for-testing process had exited with code 65; changes are unverified and should be reconciled by the agent now handling implementation. This copy-preparation task made no further app-code changes.
