import AppIntents
import Foundation

/// Siri, Shortcuts, Spotlight and the Action button (report "Siri and Shortcuts — Log by Voice and Automation", 30 Sep;
/// Feature Ledger C046). Free, like the widget. They run in the app's own process (iOS starts it in the background),
/// so they use the one store and write the same way a tap on Today does.
///
/// Built so a shortcut someone sets up keeps working: each habit is found by its ID, never its name, so renaming a
/// habit doesn't break an automation, and these intents' names and parameters are never removed or renamed.

/// A habit, as Siri and Shortcuts see it.
nonisolated struct HabitEntity: AppEntity {
    static let typeDisplayRepresentation: TypeDisplayRepresentation = "Habit"
    static let defaultQuery = HabitQuery()

    var id: UUID
    var name: String
    var symbol: String

    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(name)", image: .init(systemName: symbol))
    }
}

/// Finds habits by ID (a saved shortcut), by name (typed or said), and suggests today's first, in Today's order.
nonisolated struct HabitQuery: EntityStringQuery {
    @MainActor func entities(for identifiers: [UUID]) async throws -> [HabitEntity] {
        let store = await HabitShortcuts.loadedStore()
        return identifiers.compactMap { id in store.habits.first { $0.id == id } }.map(HabitShortcuts.entity)
    }

    @MainActor func entities(matching string: String) async throws -> [HabitEntity] {
        let store = await HabitShortcuts.loadedStore()
        return store.habits.filter { !$0.archived && $0.name.localizedStandardContains(string) }.map(HabitShortcuts.entity)
    }

    @MainActor func suggestedEntities() async throws -> [HabitEntity] {
        let store = await HabitShortcuts.loadedStore()
        let today = WidgetBridge.day(store.today(), store: store).rows.map(\.id)
        let active = store.habits.filter { !$0.archived }
        let first = today.compactMap { id in active.first { $0.id.uuidString == id } }
        let rest = active.filter { habit in !first.contains { $0.id == habit.id } }
        return (first + rest).map(HabitShortcuts.entity)
    }
}

/// "Log Water in Habits": one step today, the same as a notification's Done. Only ever adds (a wrong one is removed on
/// the habit's page). Works from an automation too: an NFC tag, a time, arriving somewhere.
struct LogHabitIntent: AppIntent {
    static let title: LocalizedStringResource = "Log a Habit"
    static let description = IntentDescription("Logs one step of a habit for today: a tick, one more, or an amount. It only adds, and a tick already done stays as it is.")

    @Parameter(title: "Habit") var habit: HabitEntity
    @Parameter(title: "Amount", description: "An amount, or minutes for a timed habit. Leave it empty to add one step.")
    var amount: Double?

    static var parameterSummary: some ParameterSummary {
        Summary("Log \(\.$habit)") { \.$amount }
    }

    nonisolated init() {}

    func perform() async throws -> some IntentResult & ReturnsValue<String> & ProvidesDialog {
        let model = AppModel.shared
        await model.ensureLoaded()
        let store = model.store
        guard let found = store.habits.first(where: { $0.id == habit.id }) else {
            throw HabitShortcuts.Problem.habitGone
        }
        let day = store.today()
        let text: String
        switch store.logFromShortcut(found, amount: amount, on: day) {
        case .needsAmount:
            let ask: IntentDialog = found.kind == .duration ? "How many minutes?" : "How much?"
            throw $amount.needsValueError(ask)
        case .openApp:
            text = found.kind == .quit ? "Log a slip for \(found.name) in Habits." : "Tick \(found.name)'s steps in Habits."
        case .paused:
            text = "\(found.name) is paused."
        case .alreadyDone:
            text = HabitShortcuts.status(found, store: store, day: day)
        case .logged:
            await store.flush()
            guard store.problem == nil else { throw HabitShortcuts.Problem.notSaved }
            // Straight away, in case iOS suspends the app: the widget redraws and the row's reminders stop.
            WidgetBridge.publish(store)
            await model.scheduler.reconcile(store)
            text = HabitShortcuts.status(found, store: store, day: day)
        }
        return .result(value: text, dialog: "\(text)")
    }
}

/// "What's left in Habits": how many are done, and what's still to do, in Today's order.
struct WhatsLeftIntent: AppIntent {
    static let title: LocalizedStringResource = "What's Left Today"
    static let description = IntentDescription("Says how many of today's habits are done and which are still to do.")

    nonisolated init() {}

    func perform() async throws -> some IntentResult & ReturnsValue<String> & ProvidesDialog {
        let store = await HabitShortcuts.loadedStore()
        let day = WidgetBridge.day(store.today(), store: store)
        let left = day.rows.filter { !$0.done && !$0.isLimit }.map(\.name)
        let text: String
        if day.total == 0 {
            text = "Nothing planned today."
        } else if left.isEmpty {
            text = day.total == 1 ? "Done for today." : "All \(day.total) done today."
        } else {
            let names = left.count > 6 ? Array(left.prefix(5)) + ["\(left.count - 5) more"] : left
            let list = ListFormatter.localizedString(byJoining: names)
            text = "\(day.done) of \(day.total) done. Still to do: \(list)."
        }
        return .result(value: text, dialog: "\(text)")
    }
}

/// "How's Water going in Habits": today's progress and the streak.
struct HabitProgressIntent: AppIntent {
    static let title: LocalizedStringResource = "Get Habit Progress"
    static let description = IntentDescription("Says how far along a habit is today, and its streak.")

    @Parameter(title: "Habit") var habit: HabitEntity

    static var parameterSummary: some ParameterSummary {
        Summary("Get progress of \(\.$habit)")
    }

    nonisolated init() {}

    func perform() async throws -> some IntentResult & ReturnsValue<String> & ProvidesDialog {
        let store = await HabitShortcuts.loadedStore()
        guard let found = store.habits.first(where: { $0.id == habit.id }) else {
            throw HabitShortcuts.Problem.habitGone
        }
        let text = HabitShortcuts.status(found, store: store, day: store.today())
        return .result(value: text, dialog: "\(text)")
    }
}

/// "Open Water in Habits": its page, with its calendar, notes and numbers.
struct OpenHabitIntent: OpenIntent {
    static let title: LocalizedStringResource = "Open a Habit"
    static let description = IntentDescription("Opens a habit's page.")

    @Parameter(title: "Habit") var target: HabitEntity

    nonisolated init() {}

    func perform() async throws -> some IntentResult {
        AppModel.shared.router.openHabit = target.id
        return .result()
    }
}

/// The phrases Siri knows without any setup, also shown in Shortcuts, Spotlight and for the Action button.
nonisolated struct HabitShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(intent: LogHabitIntent(), phrases: [
            "Log \(\.$habit) in \(.applicationName)",
            "Mark \(\.$habit) done in \(.applicationName)",
            "Log a habit in \(.applicationName)",
        ], shortTitle: "Log a Habit", systemImageName: "checkmark.circle")
        AppShortcut(intent: WhatsLeftIntent(), phrases: [
            "What's left in \(.applicationName)",
            "What's left today in \(.applicationName)",
            "What habits are left in \(.applicationName)",
        ], shortTitle: "What's Left Today", systemImageName: "checklist")
        AppShortcut(intent: HabitProgressIntent(), phrases: [
            "How's \(\.$habit) going in \(.applicationName)",
            "Check \(\.$habit) in \(.applicationName)",
        ], shortTitle: "Habit Progress", systemImageName: "chart.bar")
        AppShortcut(intent: OpenHabitIntent(), phrases: [
            "Open \(\.$habit) in \(.applicationName)",
        ], shortTitle: "Open a Habit", systemImageName: "arrow.up.forward.app")
    }

    nonisolated enum Problem: Error, CustomLocalizedStringResourceConvertible {
        case habitGone
        case notSaved

        var localizedStringResource: LocalizedStringResource {
            switch self {
            case .habitGone: "That habit isn't in Habits any more."
            case .notSaved: "That couldn't be saved. Open Habits and try again."
            }
        }
    }

    @MainActor static func loadedStore() async -> HabitStore {
        await AppModel.shared.ensureLoaded()
        return AppModel.shared.store
    }

    @MainActor static func entity(_ habit: Habit) -> HabitEntity {
        HabitEntity(id: habit.id, name: habit.name, symbol: habit.symbol)
    }

    /// "Water: 3 of 8 glasses today. 5 in a row." / "Stretch is done today." Streaks only if Today shows them.
    @MainActor static func status(_ habit: Habit, store: HabitStore, day: LocalDay) -> String {
        if habit.kind == .quit {
            return "\(habit.name): log slips in Habits."
        }
        let row = WidgetBridge.row(habit, on: day, store: store)
        var text: String
        if row.showsCount {
            let rule = store.rule(habit, on: day)
            let when = rule.frequency.isDayBased ? " today" : ""
            if rule.kind == .duration {
                // Minutes as on Today: "12 min of 20 min", never "12.35".
                text = "\(habit.name): \(Format.minutes(row.progress)) of \(Format.minutes(row.goal))\(row.suffix.dropFirst(" min".count))\(when)."
            } else {
                let number = WidgetDay.Row.number
                text = "\(habit.name): \(number(row.progress)) of \(number(row.goal))\(row.suffix)\(when)."
            }
            if row.done { text += " Done." }
        } else {
            text = row.done ? "\(habit.name) is done today." : "\(habit.name) isn't done yet today."
        }
        if store.isPaused(habit, on: day) { text += " It's paused." }
        let streak = store.streak(of: habit, asOf: day)
        if store.settings.showStreaks && streak > 1 { text += " \(streak) in a row." }
        return text
    }

    /// Siri's phrases name each habit; they're refreshed when a habit is added, renamed or archived.
    @MainActor private static var names: [String] = []

    @MainActor static func habitsChanged(_ store: HabitStore) {
        let now = store.habits.filter { !$0.archived }.map { $0.id.uuidString + $0.name }
        guard now != names else { return }
        names = now
        updateAppShortcutParameters()
    }
}
