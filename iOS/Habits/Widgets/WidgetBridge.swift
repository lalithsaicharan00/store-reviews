import Foundation
import WidgetKit

/// Keeps the Today widget in step with the app (report "Widgets — Tick Without Opening the App", 30 Sep; Feature
/// Ledger C040: a widget must never go blank, stale or disagree with the app).
///
/// After every change the app writes today's and tomorrow's rows to the App Group, so the widget turns over at the
/// start of the day by itself. Taps on the widget wait as files until the app runs, then are added here before anything
/// is shown, reminders are planned or the widget is redrawn.
enum WidgetBridge {
    /// Writes the widget's rows and asks it to redraw.
    static func publish(_ store: HabitStore, now: Date = .now) {
        guard store.isLoaded, WidgetShared.snapshotURL != nil else { return }
        let today = store.today(now: now)
        let file = WidgetFile(days: [day(today, store: store), day(today.adding(days: 1, calendar: store.calendar), store: store)])
        file.write()
        WidgetCenter.shared.reloadTimelines(ofKind: WidgetShared.kind)
    }

    /// Adds every waiting widget tap to the database, once each, then removes their files.
    static func applyPendingTaps(_ store: HabitStore) async {
        let pending = WidgetTap.pending()
        guard !pending.isEmpty, store.isLoaded else { return }
        for (tap, _) in pending {
            guard let entryID = UUID(uuidString: tap.entryID), let habitID = UUID(uuidString: tap.habitID),
                  let day = LocalDay(key: tap.day) else { continue }
            store.applyWidgetTap(entryID: entryID, habitID: habitID, day: day, value: tap.value, at: tap.at)
        }
        await store.flush()
        // Only once they're saved: a failed save leaves them to be tried again (and a repeat counts once).
        guard store.problem == nil else { return }
        for (_, file) in pending { try? FileManager.default.removeItem(at: file) }
    }

    // MARK: Rows

    /// One day of Today: its habits in Today's order, unfinished first.
    static func day(_ day: LocalDay, store: HabitStore) -> WidgetDay {
        let calendar = store.calendar
        let order = store.sections.map(\.id)
        let habits = store.habits.enumerated().filter { _, habit in
            !habit.archived && habit.kind != .quit && store.startDay(of: habit) <= day && store.isDue(habit, on: day)
        }.sorted { a, b in
            let pa = store.placements(of: a.element).first, pb = store.placements(of: b.element).first
            let sa = order.firstIndex(of: pa?.section ?? .anytime) ?? 0, sb = order.firstIndex(of: pb?.section ?? .anytime) ?? 0
            if sa != sb { return sa < sb }
            let ta = pa?.times.first.map { store.dayMinute($0.minuteOfDay) } ?? .max
            let tb = pb?.times.first.map { store.dayMinute($0.minuteOfDay) } ?? .max
            return ta != tb ? ta < tb : a.offset < b.offset
        }.map(\.element)
        let rows = habits.map { row($0, on: day, store: store) }
        let starts = calendar.startOfDay(for: day.date(calendar: calendar))
            .addingTimeInterval(Double(store.settings.dayEndHour) * 3600)
        return WidgetDay(day: day.key, starts: starts, rows: rows.filter { !$0.done } + rows.filter(\.done))
    }

    private static func row(_ habit: Habit, on day: LocalDay, store: HabitStore) -> WidgetDay.Row {
        let rule = store.rule(habit, on: day)
        let goal = store.goal(of: rule)
        let period = switch rule.frequency {
        case .perWeek: " this week"
        case .perMonth: " this month"
        case .perYear: " this year"
        default: ""
        }
        let unit: String = switch rule.kind {
        case .amount(let unit, _): unit
        case .duration: "min"
        case .checklist: "steps"
        case .check: rule.checkUnit ?? ""
        default: ""
        }
        let step: (value: Double, label: String)? = switch rule.kind {
        case .check: (value: 1, label: rule.frequency.isDayBased && goal <= 1 ? "✓" : "+1")
        case .task: (value: 1, label: "✓")
        case .amount: rule.quickIncrement.map { (value: $0, label: "+" + Format.amount($0)) }
        default: nil
        }
        return WidgetDay.Row(
            id: habit.id.uuidString, name: habit.name, symbol: habit.symbol, color: habit.color.rawValue,
            progress: store.progress(of: habit, on: day), goal: goal,
            suffix: (unit.isEmpty ? "" : " " + unit) + period + (habit.atMost ? " max" : ""),
            showsCount: !(rule.kind == .task || rule.kind == .check && rule.frequency.isDayBased && goal <= 1),
            step: step?.value, stepLabel: step?.label ?? "", isLimit: habit.atMost,
            done: !habit.atMost && store.isSatisfied(habit, on: day))
    }
}
