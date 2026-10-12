#if DEBUG
import Core
import Foundation

/// Records what today's iPhone code answers for the shared habit rules' golden cases (Current Work 92, `Core/fixtures/`).
/// Each input file holds cases: the database rows (as `Core`'s records and backup file name them), the time zone, a fixed
/// "now", the days to ask about and some moments to place. For each case a fresh in-memory store loads exactly those rows
/// and answers every rule (`Core/spec/`) for every habit and day, through the store's own functions, so the fixtures are
/// what people see today. The shared Kotlin rules must give the same answers (`Core/src/jvmTest/.../GoldenTest.kt`).
///
/// `-golden-record` (with `-uitest`): reads `tmp/golden/in/*.json` in the app's container, writes `tmp/golden/out/`, and
/// ends `tmp/golden/done.txt` with "# DONE". Run by `.github/workflows/core-fixtures.yml` (`iOS/Tools/golden/record.sh`).
enum GoldenRecorder {
    struct InputFile: Decodable { let cases: [Case] }

    struct Case: Decodable {
        let name: String
        let timeZone: String
        let nowMs: Int64
        let window: [String]
        var probes: [Int64]? = nil
        /// "full" also records Progress, the habit page, Over Time and the widgets; "rules" only the rules.
        var detail: String? = nil
        /// Also loads the rows as the Apple Watch does (its last 400 days) and records its streaks (U34).
        var watch: Bool? = nil
        let snapshot: Rows
    }

    struct Rows: Decodable {
        var habits: [HabitRow] = []
        var steps: [StepRow]? = nil
        var reminders: [ReminderRow]? = nil
        var entries: [EntryRow]? = nil
        var settings: [SettingRow]? = nil
    }

    struct HabitRow: Decodable {
        let id: String
        var name: String? = nil
        var symbol: String? = nil
        var color: String? = nil
        let kind: String
        var unit: String? = nil
        var increment: Double? = nil
        var part: String? = nil
        var goal: Double? = nil
        var frequency: String? = nil
        var dueDay: String? = nil
        var dueMinute: Int? = nil
        var atMost: Bool? = nil
        var quitSince: Int64? = nil
        var position: Int? = nil
        let createdAt: Int64
        var archivedAt: Int64? = nil
        var startsOn: String? = nil
        var endsOn: String? = nil
    }

    struct StepRow: Decodable { let id: String; let habitId: String; var name: String? = nil; let position: Int }
    struct ReminderRow: Decodable { let id: String; let habitId: String; let hour: Int; let minute: Int }
    struct EntryRow: Decodable {
        let id: String
        let habitId: String
        var stepId: String? = nil
        let day: String
        let value: Double
        let createdAt: Int64
        let timeZone: String
        var slot: String? = nil
        var source: String? = nil
    }
    struct SettingRow: Decodable { let key: String; let value: String }

    static func run() async -> String {
        let fm = FileManager.default
        let base = fm.temporaryDirectory.appendingPathComponent("golden", isDirectory: true)
        let input = base.appendingPathComponent("in", isDirectory: true)
        let output = base.appendingPathComponent("out", isDirectory: true)
        let done = base.appendingPathComponent("done.txt")
        try? fm.createDirectory(at: output, withIntermediateDirectories: true)
        var log: [String] = []
        let files = ((try? fm.contentsOfDirectory(at: input, includingPropertiesForKeys: nil)) ?? [])
            .filter { $0.pathExtension == "json" }.sorted { $0.lastPathComponent < $1.lastPathComponent }
        var total = 0
        log.append("started: \(files.map(\.lastPathComponent).joined(separator: ", "))")
        try? (log.joined(separator: "\n") + "\n").write(to: done, atomically: true, encoding: .utf8)
        for file in files {
            let began = Date()
            do {
                let cases = try JSONDecoder().decode(InputFile.self, from: Data(contentsOf: file)).cases
                var results: [Any] = []
                for c in cases {
                    // A big case can take minutes: say which one is being worked on, so the script sees progress.
                    if (c.snapshot.entries?.count ?? 0) > 1000 {
                        try? (log.joined(separator: "\n") + "\n… working on \(c.name)\n").write(to: done, atomically: true, encoding: .utf8)
                    }
                    results.append(await record(c))
                    total += 1
                    if total % 10 == 0 {
                        try? (log.joined(separator: "\n") + "\n… \(total) cases (\(c.name))\n").write(to: done, atomically: true, encoding: .utf8)
                    }
                    await Task.yield()
                }
                let data = try JSONSerialization.data(withJSONObject: ["cases": finite(results)], options: [.sortedKeys])
                try data.write(to: output.appendingPathComponent(file.lastPathComponent))
                log.append("\(file.lastPathComponent): \(cases.count) cases in \(Int(Date().timeIntervalSince(began)))s")
            } catch {
                log.append("\(file.lastPathComponent): FAILED \(error)")
            }
            try? (log.joined(separator: "\n") + "\n").write(to: done, atomically: true, encoding: .utf8)
        }
        log.append("# DONE \(total) cases")
        try? (log.joined(separator: "\n") + "\n").write(to: done, atomically: true, encoding: .utf8)
        return "Golden: recorded \(total) cases"
    }

    // MARK: One case

    static func snapshot(of rows: Rows) -> Snapshot {
        let habits = rows.habits.enumerated().map { i, h in
            HabitRecord(
                id: h.id, name: h.name ?? "Habit \(i + 1)", symbol: h.symbol ?? "circle", color: h.color ?? "blue", kind: h.kind,
                unit: h.unit, increment: h.increment ?? 1, part: h.part ?? "anytime", goal: h.goal ?? 1, period: "day",
                scheduleDays: nil, frequency: h.frequency ?? "daily", dueDay: h.dueDay,
                dueMinute: h.dueMinute.map { KotlinInt(value: Int32($0)) }, atMost: h.atMost ?? false,
                quitSince: h.quitSince.map { KotlinLong(value: $0) }, position: Int32(h.position ?? i), createdAt: h.createdAt,
                updatedAt: h.createdAt, archivedAt: h.archivedAt.map { KotlinLong(value: $0) }, deletedAt: nil, remind: true,
                alert: "notification", followUpMinutes: nil, startsOn: h.startsOn, endsOn: h.endsOn, reminderText: nil)
        }
        let steps = (rows.steps ?? []).map { StepRecord(id: $0.id, habitId: $0.habitId, name: $0.name ?? "Step", position: Int32($0.position), deletedAt: nil) }
        let reminders = (rows.reminders ?? []).map { ReminderRecord(id: $0.id, habitId: $0.habitId, hour: Int32($0.hour), minute: Int32($0.minute), deletedAt: nil) }
        let entries = (rows.entries ?? []).map {
            EntryRecord(id: $0.id, habitId: $0.habitId, stepId: $0.stepId, day: $0.day, value: $0.value, createdAt: $0.createdAt,
                        timeZone: $0.timeZone, deletedAt: nil, slot: $0.slot, source: $0.source ?? "today")
        }
        // The one-time order upgrade is marked done, so loading never rewrites the order (`keepShownOrder`).
        var settings = (rows.settings ?? []).map { SettingRecord(key: $0.key, value: $0.value) }
        if !settings.contains(where: { $0.key == "order_v1" }) { settings.append(SettingRecord(key: "order_v1", value: "1")) }
        return Snapshot(habits: habits, steps: steps, reminders: reminders, entries: entries, settings: settings)
    }

    static func store(_ c: Case, window: Int = 0) async -> (HabitStore, Persistence) {
        let persistence = Persistence.inMemory()
        try? await persistence.repository.importAll(snapshot: snapshot(of: c.snapshot))
        let store = HabitStore(repository: persistence.repository)
        store.fixedTimeZone = TimeZone(identifier: c.timeZone)
        let now = Date(millis: c.nowMs)
        store.clock = { now }
        store.historyWindowDays = window
        await store.load()
        return (store, persistence)
    }

    static func record(_ c: Case) async -> [String: Any] {
        let (s, persistence) = await store(c)
        defer { _ = persistence }
        let now = Date(millis: c.nowMs)
        let today = s.today()
        var out: [String: Any] = ["name": c.name, "today": today.key]
        guard c.window.count == 2, let from = LocalDay(key: c.window[0]), let through = LocalDay(key: c.window[1]) else {
            out["error"] = "bad window"
            return out
        }
        var days: [LocalDay] = []
        var d = from
        while d <= through { days.append(d); d = d.adding(days: 1, calendar: s.calendar) }

        // The day: which day a moment belongs to, and where days begin and end.
        out["probes"] = (c.probes ?? []).map { ms -> [Any] in [ms, s.today(now: Date(millis: ms)).key] }
        out["bounds"] = [from, today, through].map { day -> [Any] in
            let b = s.dayBounds(day)
            return [day.key, b.lowerBound.millis, b.upperBound.millis]
        }
        out["periods"] = [from, today, through].map { day -> [Any] in
            var row: [Any] = [day.key]
            for kind in [HabitStore.PeriodKind.week, .month, .year] {
                let p = s.period(kind, containing: day)
                row.append([p.lowerBound.key, p.upperBound.key])
            }
            return row
        }
        out["weekdays"] = days.prefix(7).map { $0.weekday(calendar: s.calendar) }
        out["cards"] = s.todayCards
        out["members"] = s.cardMembers().mapValues { $0.map(\.id.uuidString) }
        out["sections"] = s.timedSections.map { t -> [Any] in [t.section.id, t.section.start ?? -1, t.end] }

        // Each habit, each day.
        var habits: [[String: Any]] = []
        for habit in s.habits {
            var h: [String: Any] = ["id": habit.id.uuidString, "start": s.startDay(of: habit).key]
            h["placements"] = s.placements(of: habit).map { p -> [Any] in [p.section, orNull(p.slot), p.times.map(\.minuteOfDay)] }
            h["slots"] = s.slots(of: habit)
            h["periodKind"] = s.periodKind(habit).rawValue
            h["isTotal"] = s.isTotal(habit)
            h["canSkip"] = s.canSkip(habit)
            h["canPause"] = s.canPause(habit)
            h["runs"] = s.runs(of: habit).map { r -> [Any] in [r.start.key, r.end.key, r.length, r.isCurrent] }
            h["best"] = s.bestStreak(of: habit)
            h["streakUnit"] = "\(habit.frequency.streakUnit)"
            if habit.kind == .quit {
                let runs = s.quitRuns(of: habit, now: now)
                h["quit"] = [
                    "current": runs.current, "best": runs.best,
                    "slips": s.slips(of: habit, now: now).map(\.millis),
                    "history": s.quitHistory(of: habit, now: now).map { r -> [Any] in
                        [r.start.millis, orNull(r.end?.millis), "\(r.endedBy)"]
                    },
                    "startDay": s.quitStartDay(of: habit).key,
                ] as [String: Any]
            }
            h["days"] = days.map { day -> [Any] in dayRow(s, habit, day, now: now) }
            habits.append(h)
        }
        out["habits"] = habits
        out["scores"] = days.map { day -> [Any] in
            let score = s.todayScore(on: day)
            let summary = s.daySummary(on: day)
            return [day.key, score.done, score.part, score.partCount, score.planned, summary.done, summary.total]
        }

        if c.name.hasPrefix("ST-7") {
            var ladders: [String: Any] = [:]
            for unit in [StreakUnit.days, .times, .weeks, .months, .years] {
                ladders["\(unit)"] = [
                    "milestones": unit.milestones(upTo: 3000),
                    "next": [0, 1, 2, 3, 29, 30, 104, 105, 365, 730, 731, 1094, 1095].map { unit.nextMilestone(after: $0) },
                ]
            }
            for period in GoalPeriod.allCases { ladders["total." + period.rawValue] = TotalMilestones.ladder(for: period) }
            out["milestones"] = ladders
        }
        if c.detail == "full" {
            out["full"] = full(s, today: today, now: now)
        }
        if c.watch == true {
            let (w, wp) = await store(c, window: 400)
            defer { _ = wp }
            out["watch"] = w.habits.map { habit -> [Any] in
                [habit.id.uuidString, w.streak(of: habit, asOf: today), w.bestStreak(of: habit), w.historyBeforeWindow.contains(habit.id)]
            }
        }
        return out
    }

    /// One habit on one day: every rule's answer, in a fixed order (`Core/fixtures/README.md` names each column).
    static func dayRow(_ s: HabitStore, _ habit: Habit, _ day: LocalDay, now: Date) -> [Any] {
        let rule = s.rule(habit, on: day)
        let range = s.periodRange(rule, containing: day)
        let outcome: [Any]
        switch s.outcome(habit, on: day) {
        case .done: outcome = ["done", 1]
        case .part(let share): outcome = ["part", share]
        case .notDone: outcome = ["notDone", 0]
        case .open: outcome = ["open", 0]
        case .neutral: outcome = ["neutral", 0]
        }
        return [
            day.key,
            s.isDue(habit, on: day, now: now),
            s.isDue(habit, on: day, now: now, countingSkips: false),
            s.dayGoal(of: rule),
            s.dayProgress(of: habit, on: day, now: now),
            s.isDayMet(habit, on: day),
            s.progress(of: habit, on: day, now: now),
            s.goal(of: rule),
            s.isDone(habit, on: day),
            s.flexibleProgress(habit, on: day) ?? -1,
            s.isComplete(habit, on: day),
            s.isSatisfied(habit, on: day),
            s.isPeriodMet(habit, on: day),
            outcome[0], outcome[1],
            "\(s.dayMark(habit, on: day))",
            s.streak(of: habit, asOf: day),
            s.countsUp(habit, on: day),
            s.dayFraction(habit, on: day),
            orNull(range.map { [$0.lowerBound.key, $0.upperBound.key] }),
            s.isSkipped(habit, on: day),
            s.isPaused(habit, on: day),
            s.isArchived(habit, on: day),
        ]
    }

    /// The screens built on the rules: Progress (Week, Month, Year, with and without the cards), the habit page's record,
    /// Over Time and quit statistics, and the widgets' snapshot. Recorded whole, so the switch to the shared rules can be
    /// checked to change nothing people see.
    static func full(_ s: HabitStore, today: LocalDay, now: Date) -> [String: Any] {
        var out: [String: Any] = [:]
        for range in ProgressRange.allCases {
            let snap = s.progressSnapshot(range, containing: today)
            out["progress." + range.rawValue] = [
                "title": snap.title, "tally": reflect(snap.tally), "goals": reflect(snap.goals as Any),
                "previous": orNull(snap.previous.map { [$0.title, reflect($0.tally)] as [Any] }),
                "rows": reflect(snap.rows), "archived": reflect(snap.archived), "quitting": reflect(snap.quitting),
                "days": reflect(snap.days), "yearDots": reflect(snap.yearDots as Any),
            ] as [String: Any]
            let cards = s.progressSnapshot(range, containing: today, weekCards: true)
            out["cards." + range.rawValue] = ["cards": reflect(cards.cards), "archived": reflect(cards.archivedCards),
                                             "caption": orNull(cards.caption)] as [String: Any]
        }
        var pages: [String: Any] = [:]
        for habit in s.habits {
            var page: [String: Any] = [:]
            if habit.kind == .quit {
                page["stats"] = reflect(s.quitStats(of: habit, in: s.period(.month, containing: today), now: now))
            } else if habit.kind != .task {
                page["record"] = reflect(s.habitRecord(of: habit, today: today))
                page["totalLine"] = orNull(s.totalLine(of: habit, today: today))
                page["month"] = reflect(s.overTime(habit, range: .month, anchor: today, today: today))
                page["weekday"] = reflect(s.byWeekday(habit, in: s.period(.year, containing: today), today: today))
            }
            pages[habit.id.uuidString] = page
        }
        out["pages"] = pages
        let widgets = s.widgetSnapshot(now: now)
        if let data = try? JSONEncoder().encode(widgets), let json = try? JSONSerialization.jsonObject(with: data) {
            out["widgets"] = withoutTokens(json)
        }
        return out
    }

    static func orNull(_ value: Any?) -> Any { value ?? NSNull() }

    /// JSON has no infinity or NaN: such a number is written as text, so it's seen rather than crashing the recorder.
    static func finite(_ value: Any) -> Any {
        if let v = value as? Double, !v.isFinite { return "\(v)" }
        if let dict = value as? [String: Any] { return dict.mapValues(finite) }
        if let list = value as? [Any] { return list.map(finite) }
        return value
    }

    /// Widget tokens are new on every snapshot (Current Work 66), so they're left out.
    static func withoutTokens(_ value: Any) -> Any {
        if let dict = value as? [String: Any] {
            var copy: [String: Any] = [:]
            for (key, v) in dict where key != "token" && key != "generated" { copy[key] = withoutTokens(v) }
            return copy
        }
        if let list = value as? [Any] { return list.map(withoutTokens) }
        return value
    }

    /// Any value as JSON, by reflection: a habit by its ID, a day by its key, a moment in milliseconds.
    static func reflect(_ value: Any) -> Any {
        switch value {
        case let v as String: return v
        case let v as Bool: return v
        case let v as Int: return v
        case let v as Int32: return Int(v)
        case let v as Int64: return v
        case let v as Double: return v.isFinite ? v : "\(v)"
        case let v as Date: return v.millis
        case let v as LocalDay: return v.key
        case let v as UUID: return v.uuidString
        case let v as Habit: return ["habit": v.id.uuidString]
        case let v as HabitGroup: return ["group": v.id.uuidString]
        case let v as URL: return v.absoluteString
        default: break
        }
        let mirror = Mirror(reflecting: value)
        switch mirror.displayStyle {
        case .optional:
            return mirror.children.first.map { reflect($0.value) } ?? NSNull()
        case .collection:
            return mirror.children.map { reflect($0.value) }
        case .set:
            return mirror.children.map { reflect($0.value) }.sorted { "\($0)" < "\($1)" }
        case .dictionary:
            var dict: [String: Any] = [:]
            for child in mirror.children {
                let pair = Mirror(reflecting: child.value).children.map(\.value)
                if pair.count == 2 { dict["\(reflect(pair[0]))"] = reflect(pair[1]) }
            }
            return dict
        case .enum:
            guard let payload = mirror.children.first else { return "\(value)" }
            return [payload.label ?? "\(value)": reflect(payload.value)]
        case .tuple:
            return mirror.children.map { reflect($0.value) }
        case .struct, .class:
            var dict: [String: Any] = [:]
            for child in mirror.children {
                guard let label = child.label, !label.contains("$") else { continue }
                dict[label.hasPrefix("_") ? String(label.dropFirst()) : label] = reflect(child.value)
            }
            return dict
        default:
            return "\(value)"
        }
    }
}
#endif
