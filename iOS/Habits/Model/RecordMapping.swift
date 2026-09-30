import Core
import Foundation

// Converts between the app's model and the database rows in Core.

extension LocalDay {
    nonisolated var key: String { String(format: "%04d-%02d-%02d", year, month, day) }

    nonisolated init?(key: String) {
        let parts = key.split(separator: "-", omittingEmptySubsequences: false)
        guard parts.count == 3, parts.allSatisfy({ !$0.isEmpty && $0.utf8.allSatisfy { (48...57).contains($0) } }), let year = Int(parts[0]), let month = Int(parts[1]), let day = Int(parts[2]),
              (1...9999).contains(year), (1...12).contains(month) else { return nil }
        let leap = year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)
        let days = [31, leap ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        guard (1...days[month - 1]).contains(day) else { return nil }
        self.init(year: year, month: month, day: day)
    }
}

extension Date {
    var millis: Int64 { Int64((timeIntervalSince1970 * 1000).rounded()) }
    init(millis: Int64) { self.init(timeIntervalSince1970: Double(millis) / 1000) }
}

extension Habit {
    func record(position: Int, now: Date = .now, deleted: Bool = false) -> HabitRecord {
        let kindName: String
        var unit: String?
        var increment = 1.0
        switch kind {
        case .check: kindName = "check"; unit = checkUnit
        case .amount(let u, let inc): kindName = "amount"; unit = u; increment = inc
        case .duration: kindName = "duration"
        case .checklist: kindName = "checklist"
        case .quit: kindName = "quit"
        case .task: kindName = "task"
        }
        return HabitRecord(
            id: id.uuidString, name: name, symbol: symbol, color: color.rawValue, kind: kindName,
            unit: unit, increment: increment, part: parts.joined(separator: ","), goal: goal, period: "day",
            scheduleDays: nil, frequency: frequency.storageKey, dueDay: dueDay?.key,
            dueMinute: dueMinute.map { KotlinInt(value: Int32($0)) },
            atMost: atMost, quitSince: quitSince.map { KotlinLong(value: $0.millis) },
            position: Int32(position), createdAt: createdAt.millis, updatedAt: now.millis,
            archivedAt: archived ? KotlinLong(value: now.millis) : nil, deletedAt: deleted ? KotlinLong(value: now.millis) : nil,
            remind: remind, alert: alert.rawValue, followUpMinutes: followUpMinutes.map { KotlinInt(value: Int32($0)) },
            startsOn: startsOn?.key, endsOn: endsOn?.key)
    }

    func stepRecords() -> [StepRecord] {
        steps.enumerated().map { StepRecord(id: $1.id.uuidString, habitId: id.uuidString, name: $1.name, position: Int32($0), deletedAt: nil) }
    }

    func reminderRecords() -> [ReminderRecord] {
        reminders.map { ReminderRecord(id: $0.id.uuidString, habitId: id.uuidString, hour: Int32($0.hour), minute: Int32($0.minute), deletedAt: nil) }
    }

    /// Nil for a row this version can't read, so it is skipped rather than guessed at.
    init?(record r: HabitRecord, steps: [StepRecord], reminders: [ReminderRecord]) {
        guard let id = UUID(uuidString: r.id),
              let color = HabitColor(rawValue: r.color),
              let frequency = Frequency(storageKey: r.frequency) else { return nil }
        let kind: HabitKind
        switch r.kind {
        case "check": kind = .check
        case "amount": kind = .amount(unit: r.unit ?? "", increment: r.increment)
        case "duration": kind = .duration
        case "checklist": kind = .checklist
        case "quit": kind = .quit
        case "task": kind = .task
        default: return nil
        }
        self.init(id: id, name: r.name, symbol: r.symbol, color: color, kind: kind, parts: Habit.parts(from: r.part), goal: r.goal, frequency: frequency)
        if kind == .check, let u = r.unit, !u.isEmpty, u != "times" { checkUnit = u }
        dueDay = r.dueDay.flatMap(LocalDay.init(key:))
        dueMinute = r.dueMinute.map { Int($0.int32Value) }
        atMost = r.atMost
        // Before Round 3 (29 Sep 2026) every amount was saved with a step of 1, and + ignored it for measured
        // units and big goals (it asked how much). + now always adds the saved step, so those habits get the
        // step the form would suggest: 2,000 ml → +250 ml, not +1 ml. Only habits saved before Round 3 existed
        // (29 Sep 2026, 03:00 UTC), so a step of 1 chosen on the new form is kept.
        if case .amount(let unit, let increment) = kind, increment == 1, !r.atMost, r.createdAt < 1_790_650_800_000,
           Habit.legacyAskedHowMuch(goal: r.goal, unit: unit) {
            let often: HowOften = if case .flexible = frequency { .days(.week, 1) } else { .everyDay }
            self.kind = .amount(unit: unit, increment: HabitPlan.suggestedStep(amount: r.goal, unit: unit, often: often))
        }
        quitSince = r.quitSince.map { Date(millis: $0.int64Value) }
        createdAt = Date(millis: r.createdAt)
        archived = r.archivedAt != nil
        remind = r.remind
        alert = AlertStyle(rawValue: r.alert) ?? .notification
        followUpMinutes = r.followUpMinutes.map { Int($0.int32Value) }
        startsOn = r.startsOn.flatMap(LocalDay.init(key:))
        endsOn = r.endsOn.flatMap(LocalDay.init(key:))
        self.steps = steps.filter { $0.habitId == r.id }.sorted { $0.position < $1.position }
            .compactMap { s in UUID(uuidString: s.id).map { Step(id: $0, name: s.name) } }
        self.reminders = reminders.filter { $0.habitId == r.id }
            .compactMap { m in UUID(uuidString: m.id).map { ReminderTime(id: $0, hour: Int(m.hour), minute: Int(m.minute)) } }
    }
}

extension Habit {
    /// The goal-size rule + followed before Round 3: true where + asked how much instead of adding the saved 1.
    static func legacyAskedHowMuch(goal: Double, unit: String) -> Bool {
        let measured: Set<String> = ["km", "miles", "mi", "m", "ml", "oz", "litres", "liters", "l", "cl",
                                     "kg", "lbs", "lb", "g", "grams", "$", "€", "£", "₹", "calories", "kcal"]
        let oneAtATime: Set<String> = ["times", "glasses", "cups", "bottles", "books", "chapters", "meals",
                                       "servings", "workouts", "sessions", "classes", "lessons", "pills"]
        let unit = unit.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !measured.contains(unit), goal.rounded() == goal, goal >= 1 else { return true }
        return !(goal <= 10 || oneAtATime.contains(unit))
    }

    /// The database keeps the section IDs in one column, comma-separated ("morning,evening").
    static func parts(from column: String) -> [String] {
        let ids = column.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }.filter { !$0.isEmpty }
        return ids.isEmpty ? [.anytime] : ids
    }
}

extension Entry {
    var record: EntryRecord {
        EntryRecord(id: id.uuidString, habitId: habitID.uuidString, stepId: stepID?.uuidString, day: day.key,
                    value: value, createdAt: createdAt.millis, timeZone: timeZone, deletedAt: nil, slot: slot)
    }

    init?(record r: EntryRecord) {
        guard let id = UUID(uuidString: r.id), let habit = UUID(uuidString: r.habitId), let day = LocalDay(key: r.day) else { return nil }
        self.init(id: id, habitID: habit, stepID: r.stepId.flatMap(UUID.init(uuidString:)), day: day,
                  value: r.value, createdAt: Date(millis: r.createdAt), timeZone: r.timeZone, slot: r.slot)
    }
}

extension Frequency {
    /// The database form: `daily`, `weekdays:2,4,6`, `every:3`, `weeks:2`, `dates:1,15`, `week:3`, `month:4`, `year:6`.
    var storageKey: String {
        switch self {
        case .calendar, .flexible, .afterCompletion:
            "v2:" + (try! JSONEncoder().encode(self)).base64EncodedString()
        case .daily: "daily"
        case .weekdays(let days): "weekdays:" + days.sorted().map(String.init).joined(separator: ",")
        case .everyNDays(let n): "every:\(n)"
        case .everyNWeeks(let n): "weeks:\(n)"
        case .monthDates(let dates): "dates:" + dates.sorted().map(String.init).joined(separator: ",")
        case .perWeek(let n): "week:\(n)"
        case .perMonth(let n): "month:\(n)"
        case .perYear(let n): "year:\(n)"
        }
    }

    init?(storageKey: String) {
        if storageKey.hasPrefix("v2:") {
            guard let data = Data(base64Encoded: String(storageKey.dropFirst(3))),
                  let decoded = try? JSONDecoder().decode(Frequency.self, from: data) else { return nil }
            self = decoded
            return
        }
        guard !storageKey.isEmpty else { return nil }
        let parts = storageKey.split(separator: ":", maxSplits: 1).map(String.init)
        let value = parts.count > 1 ? parts[1] : ""
        switch parts[0] {
        case "daily": self = .daily
        case "weekdays": self = .weekdays(Set(value.split(separator: ",").compactMap { Int($0) }))
        case "every": guard let n = Int(value), n > 0 else { return nil }; self = .everyNDays(n)
        case "weeks": guard let n = Int(value), n > 0 else { return nil }; self = .everyNWeeks(n)
        case "dates": self = .monthDates(Set(value.split(separator: ",").compactMap { Int($0) }))
        case "year": guard let n = Int(value), n > 0 else { return nil }; self = .perYear(n)
        case "week": guard let n = Int(value), n > 0 else { return nil }; self = .perWeek(n)
        case "month": guard let n = Int(value), n > 0 else { return nil }; self = .perMonth(n)
        default: return nil
        }
    }
}
