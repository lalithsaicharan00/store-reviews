import Foundation

/// Test launches only (`-uitest`, an in-memory database, D8): `-watch-fixture <name>` builds one of the designs' states,
/// so the UI tests, the screenshot review and the speed runs open exactly what the pictures show.
/// `-clock-hour N` runs the store's clock as if it were N:30 today (T11), so "Now" is the same section on every run.
@MainActor
enum WatchFixtures {
    static func installIfAsked(_ model: WatchModel) async {
        let arguments = ProcessInfo.processInfo.arguments
        let store = model.store
        if let i = arguments.firstIndex(of: "-clock-hour"), i + 1 < arguments.count, let hour = Int(arguments[i + 1]),
           let target = Calendar.current.date(bySettingHour: hour, minute: 30, second: 0, of: .now) {
            let offset = target.timeIntervalSinceNow
            store.clock = { Date.now.addingTimeInterval(offset) }
        }
        guard let i = arguments.firstIndex(of: "-watch-fixture"), i + 1 < arguments.count else { return }
        let name = arguments[i + 1]
        if name == "first-launch" { model.setFilledForTest(false); return }
        for habit in habits(for: name, now: store.clock()) { store.add(habit) }
        await store.flush()
        await log(name, store: store)
        await store.flush()
    }

    private static let day: TimeInterval = 86_400

    private static func habits(for name: String, now: Date) -> [Habit] {
        let longAgo = now.addingTimeInterval(-60 * day)
        func make(_ name: String, _ symbol: String, _ color: HabitColor, _ kind: HabitKind, part: String, goal: Double = 1,
                  frequency: Frequency = .daily, unit: String? = nil, atMost: Bool = false, due: LocalDay? = nil,
                  dueMinute: Int? = nil, steps: [String] = [], quitSince: Date? = nil) -> Habit {
            Habit(name: name, symbol: symbol, color: color, kind: kind, parts: [part], goal: goal, frequency: frequency,
                  checkUnit: unit, atMost: atMost, dueDay: due, dueMinute: dueMinute, steps: steps.map { Step(name: $0) },
                  remind: false, quitSince: quitSince, createdAt: longAgo)
        }
        let design: [Habit] = [
            make("Vitamins", "pills.fill", .yellow, .check, part: .morning),
            make("Meditate", "timer", .purple, .duration, part: .morning, goal: 20),
            make("Stretch", "sun.max.fill", .green, .check, part: .morning),
            make("Walk", "figure.walk", .cyan, .amount(unit: "steps", increment: 500), part: .afternoon, goal: 8000),
            make("Wind down", "moon.fill", .indigo, .checklist, part: .evening, goal: 5,
                 steps: ["Phone on charge", "Lights low", "Read 10 pages", "Stretch", "Lights out"]),
            make("Water", "drop.fill", .blue, .amount(unit: "glasses", increment: 1), part: .anytime, goal: 8),
            make("Read", "book.fill", .orange, .check, part: .anytime),
            make("No smoking", "hand.raised.fill", .cyan, .quit, part: .anytime,
                 quitSince: now.addingTimeInterval(-(15 * day + 22 * 3600))),
        ]
        switch name {
        case "design", "all-done", "milestone", "skipped-paused", "logs", "running", "slip":
            return design
        case "kinds":
            return design + [
                make("Read pages", "book.pages.fill", .orange, .amount(unit: "pages", increment: 0), part: .anytime, goal: 20),
                make("Weight", "scalemass.fill", .teal, .amount(unit: "kg", increment: 0), part: .anytime, goal: 72),
            ]
        case "limits":
            return [
                make("Coffee", "cup.and.saucer.fill", .brown, .amount(unit: "cups", increment: 1), part: .anytime, goal: 2, atMost: true),
                make("Social media", "timer", .pink, .duration, part: .anytime, goal: 20, atMost: true),
            ]
        case "week":
            return [make("Call family", "phone.fill", .green, .check, part: .anytime, goal: 3, frequency: .perWeek(3))]
        case "tasks":
            let today = LocalDay(now)
            return [
                make("Pay rent", "calendar", .gray, .task, part: .afternoon, due: today, dueMinute: 14 * 60),
                make("Book dentist", "calendar", .gray, .task, part: .afternoon, due: today),
            ]
        case "nothing-planned":
            // Habits only on another weekday: nothing today (A5).
            let weekday = Calendar.current.component(.weekday, from: now)
            return [make("Swim", "figure.pool.swim", .blue, .check, part: .morning, frequency: .weekdays([weekday % 7 + 1]))]
        case "many":
            // Thirty habits for the speed runs (scrolling Today with 30 habits).
            return (0..<30).map { i in
                let kinds: [HabitKind] = [.check, .amount(unit: "glasses", increment: 1), .duration]
                let parts: [String] = [.morning, .afternoon, .evening, .anytime]
                return make("Habit \(i + 1)", "star.fill", HabitColor.allCases[i % HabitColor.allCases.count], kinds[i % 3],
                            part: parts[i % 4], goal: [1, 8, 20][i % 3])
            }
        default:
            return []
        }
    }

    /// The logs each state needs, saved through the store as taps are.
    private static func log(_ name: String, store: HabitStore) async {
        let today = store.today()
        func habit(_ name: String) -> Habit? { store.habits.first { $0.name == name } }
        let source = EntrySource.watch
        switch name {
        case "design", "logs", "running", "slip", "kinds":
            if let read = habit("Read") { store.toggleCheck(read, on: today, source: source) }
            if let meditate = habit("Meditate") { store.addProgress(meditate, value: 12, on: today, source: source) }
            if let water = habit("Water") { for _ in 0..<(name == "logs" ? 4 : 3) { store.increment(water, on: today, source: source) } }
            if let walk = habit("Walk") { store.addProgress(walk, value: 3200, on: today, source: source) }
            if let wind = habit("Wind down") { for step in wind.steps.prefix(2) { store.toggleStep(step, of: wind, on: today, source: source) } }
            if name == "running", let meditate = habit("Meditate") { store.startTimerOnWatch(meditate) }
            if name == "kinds", let pages = habit("Read pages") { store.addProgress(pages, value: 12, on: today, source: source) }
            if name == "kinds", let weight = habit("Weight") {
                store.addProgress(weight, value: 72.6, on: today.adding(days: -2, calendar: store.calendar), source: source)
            }
        case "all-done":
            for habit in store.habits where habit.kind != .quit {
                switch habit.kind {
                case .check: store.toggleCheck(habit, on: today, source: source)
                case .duration: store.addProgress(habit, value: store.goal(of: habit), on: today, source: source)
                case .amount: store.addProgress(habit, value: store.goal(of: habit), on: today, source: source)
                case .checklist: for step in habit.steps { store.toggleStep(step, of: habit, on: today, source: source) }
                default: break
                }
            }
        case "milestone":
            // 29 days in a row before today: today's tick makes 30 (H9).
            if let read = habit("Read") {
                for d in 1...29 { store.toggleCheck(read, on: today.adding(days: -d, calendar: store.calendar), source: source) }
            }
        case "skipped-paused":
            if let stretch = habit("Stretch") { store.setSkipped(stretch, on: today, true) }
            if let walk = habit("Walk") { store.pause(walk, from: today, through: today.adding(days: 3, calendar: store.calendar)) }
        case "limits":
            if let coffee = habit("Coffee") { store.increment(coffee, on: today, source: source) }
            if let social = habit("Social media") { store.addProgress(social, value: 10, on: today, source: source) }
        case "week":
            if let call = habit("Call family") { store.addProgress(call, value: 1, on: today, source: source) }
        case "tasks":
            if let dentist = habit("Book dentist") { store.toggleCheck(dentist, on: today, source: source) }
        default:
            break
        }
    }
}
