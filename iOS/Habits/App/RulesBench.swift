#if DEBUG
import Core
import Foundation
import Observation

/// Where a habit rule's time goes (Current Work 92, checkpoint 2): the speed runs' `rules-calls` scenario asks the same
/// questions many times, each part on its own, and times them (`perfTimed`, the bisect's timed table). Run with and
/// without `-swift-rules` in one build: the store's own Swift rules against the shared Kotlin rules, the Swift side's
/// bookkeeping (`shared`), a call into Kotlin with the habit already in hand, a trivial call (the crossing alone), and a
/// habit's year in one call (`LiveRules.days`). Each block runs outside and inside SwiftUI's observation tracking, as a
/// view's `body` asks.
enum RulesBench {
    static func run(_ store: HabitStore) {
        let habits = store.habits.filter { !$0.archived && $0.kind != .quit }
        let today = store.today()
        let days = (0..<365).map { today.adding(days: -$0, calendar: store.calendar) }
        let calls = habits.count * days.count
        MainThreadMeter.mark("# NOTE rules-calls: \(habits.count) habits × \(days.count) days = \(calls) calls a block")
        for tracked in [false, true] {
            let place = tracked ? "in a view" : "outside a view"
            func block(_ name: String, _ work: () -> Void) {
                if tracked {
                    withObservationTracking { perfTimed("Rules (\(place)): \(name)", work) } onChange: {}
                } else {
                    perfTimed("Rules (\(place)): \(name)", work)
                }
            }
            for _ in 0..<3 {
                block("isDone") { for h in habits { for d in days { _ = store.isDone(h, on: d) } } }
                block("dayMark") { for h in habits { for d in days { _ = store.dayMark(h, on: d, relativeTo: today) } } }
                block("dayProgress") { for h in habits { for d in days { _ = store.dayProgress(of: h, on: d) } } }
                block("isDue") { for h in habits { for d in days { _ = store.isDue(h, on: d) } } }
                guard let core = store.core else { continue }
                block("the Swift side only (shared)") { for h in habits { for _ in days { _ = store.shared(h) } } }
                let handles = habits.compactMap { store.ruleHabit($0, core) }
                block("Kotlin isDone, habit in hand") { for h in handles { for d in days { _ = core.isDone(h: h, day: d.n) } } }
                block("Kotlin dayGoal, habit in hand (the crossing)") { for h in handles { for _ in days { _ = core.dayGoal(h: h) } } }
                block("Kotlin days, a year in one call") {
                    for h in handles { _ = core.days(h: h, first: days.last!.n, last: today.n, reference: today.n, now: store.clock().millis) }
                }
                block("Swift reads a year's numbers back") {
                    for h in habits { _ = store.coreDays(h, in: days.last!...today, relativeTo: today) }
                }
            }
        }
    }
}
#endif
