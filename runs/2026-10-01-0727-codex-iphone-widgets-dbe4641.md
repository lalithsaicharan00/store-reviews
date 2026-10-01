# codex/iphone-widgets @ dbe4641

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36829562946 · 2026-10-01 07:27 UTC
Commit: Implement iPhone widget snapshots, additive actions and families [ios-ci] [ios-widgets-build]

- Core storage and migrations: success
- Build: failure
- UI tests (none): skipped
- Speed tests: skipped
- Speed tests through XCTest: skipped

## Build errors
```
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Intents/HabitIntents.swift:101:20: error: expression is 'async' but is not marked with 'await'
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Intents/HabitIntents.swift:134:33: error: main actor-isolated property 'habits' cannot be accessed from outside of the actor
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Intents/HabitIntents.swift:137:20: error: expression is 'async' but is not marked with 'await'
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Intents/HabitIntents.swift:152:18: error: main actor-isolated static property 'shared' can not be mutated from a nonisolated context
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Intents/HabitIntents.swift:152:32: error: main actor-isolated property 'openHabit' can not be mutated from a nonisolated context
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Intents/HabitIntents.swift:175:21: error: cannot convert value of type 'KeyPath<Root, Value>' to expected argument type 'AppShortcutPhraseToken'
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Intents/HabitIntents.swift:175:21: error: cannot infer key path type from context; consider explicitly specifying a root type
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Intents/HabitIntents.swift:63:30: error: main actor-isolated static property 'shared' cannot be accessed from outside of the actor
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Intents/HabitIntents.swift:66:33: error: main actor-isolated property 'habits' cannot be accessed from outside of the actor
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Intents/HabitIntents.swift:69:25: error: main actor-isolated instance method 'today(now:)' cannot be called from outside of the actor
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Intents/HabitIntents.swift:71:22: error: main actor-isolated instance method 'logFromShortcut(_:amount:on:)' cannot be called from outside of the actor
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Intents/HabitIntents.swift:73:48: error: main actor-isolated conformance of 'HabitKind' to 'Equatable' cannot be used in caller isolation inheriting-isolated context
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Intents/HabitIntents.swift:76:31: error: main actor-isolated conformance of 'HabitKind' to 'Equatable' cannot be used in caller isolation inheriting-isolated context
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Intents/HabitIntents.swift:80:26: error: main actor-isolated instance method 'shortcutStatus(_:on:)' cannot be called from outside of the actor
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Intents/HabitIntents.swift:83:25: error: main actor-isolated property 'problem' cannot be accessed from outside of the actor
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Intents/HabitIntents.swift:86:26: error: main actor-isolated instance method 'shortcutStatus(_:on:)' cannot be called from outside of the actor
```
