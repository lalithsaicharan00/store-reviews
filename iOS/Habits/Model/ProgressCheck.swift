#if DEBUG
import Core
import Foundation

/// The golden cases for Progress and the fixes it needs (Build Plan #60a–#60c, #60e; report §25.2), run in the app
/// against a real in-memory store with a fixed "now": Friday 25 September 2026, 12:00 (the report said 26, a Saturday), weeks from Monday, days ending
/// at midnight unless a case says otherwise. `-progresscheck` shows "Progress: all checks passed" or what differs;
/// `ProgressUITests.testProgressChecks` reads it.
enum ProgressCheck {
    static func run() async -> [String] {
        var failures: [String] = []
        func expect(_ ok: Bool, _ name: String) { if !ok { failures.append(name) } }
        func same<T: Equatable>(_ got: T, _ want: T, _ name: String) { if got != want { failures.append("\(name): got \(got), want \(want)") } }

        func day(_ d: Int, _ m: Int = 9, _ y: Int = 2026) -> LocalDay { LocalDay(year: y, month: m, day: d) }
        func moment(_ d: LocalDay, hour: Int = 12, minute: Int = 0) -> Date {
            Calendar.current.date(from: DateComponents(year: d.year, month: d.month, day: d.day, hour: hour, minute: minute))!
        }
        let friday = day(25), monday = day(21)

        /// A fresh store for one case, with the fixed now.
        func store(weekStart: Int = 2, now: Date? = nil) async -> (HabitStore, Persistence) {
            let persistence = Persistence.inMemory()
            let store = HabitStore(repository: persistence.repository)
            await store.load()
            store.settings.weekStart = weekStart
            let fixed = now ?? moment(friday)
            store.clock = { fixed }
            return (store, persistence)
        }
        func add(_ store: HabitStore, _ habit: Habit) async { store.add(habit); await store.flush() }
        func log(_ store: HabitStore, _ habit: Habit, _ value: Double, on d: LocalDay) async {
            store.addProgress(habit, value: value, on: d); await store.flush()
        }
        func tick(_ store: HabitStore, _ habit: Habit, on d: LocalDay) async {
            store.toggleCheck(habit, on: d); await store.flush()
        }
        func row(_ s: HabitStore, _ h: Habit, _ range: ProgressRange = .week, anchor: LocalDay? = nil) -> ProgressHabitRow? {
            let snapshot = s.progressSnapshot(range, containing: anchor ?? friday)
            return (snapshot.rows + snapshot.archived).first { $0.habit.id == h.id }
        }
        /// G17 for every case: the current run is the streak, and the best is never above what was done.
        func runsAgree(_ s: HabitStore, _ h: Habit, _ name: String) {
            let runs = s.runs(of: h)
            let current = runs.last.map { $0.isCurrent ? $0.length : 0 } ?? 0
            same(current, s.streak(of: h, asOf: s.today()), "\(name) G17 current run = streak")
            same(s.bestStreak(of: h), runs.map(\.length).max() ?? 0, "\(name) G17 best from runs")
            expect(s.bestStreak(of: h) <= runs.reduce(0) { $0 + $1.length }, "\(name) G17 best ≤ total")
        }

        // G1: Read, once a day from Mon 21. Done Mon, Tue, Thu; Wed skipped; Fri (today) nothing yet.
        do {
            let (s, _) = await store()
            let read = Habit(name: "Read", symbol: "book", color: .blue, kind: .check, startsOn: monday)
            await add(s, read)
            for d in [21, 22, 24] { await tick(s, read, on: day(d)) }
            s.setSkipped(read, on: day(23), true); await s.flush()
            let r = row(s, read)
            same(r?.text, "3 of 3 days so far", "G1 row")
            same(r?.percent, 100, "G1 percent")
            same(r?.marks.map(\.mark), [.done, .done, .skipped, .done, .open, .upcoming, .upcoming], "G1 marks")
            same(s.streak(of: read, asOf: friday), 3, "G1 streak")
            same(s.bestStreak(of: read), 3, "G1 best")
            same(s.dayScore(on: monday, habits: [read]), HabitStore.DayScore(done: 1, part: 0, partCount: 0, planned: 1), "G1 Monday")
            same(s.dayScore(on: day(23), habits: [read]).planned, 0, "G1 skipped Wednesday not planned")
            same(s.outcome(read, on: friday), .open, "G1 today open")
            let snap = s.progressSnapshot(.week, containing: friday)
            same(snap.tally.done, 3, "G1 tally done"); same(snap.tally.planned, 3, "G1 tally planned")
            same(snap.title, "This week", "G1 title")
            expect(snap.goals == nil, "G1 no goals tile")
            runsAgree(s, read, "G1")
        }

        // Phase 3: a full day at 100, 80 or 60% of what was planned; only what's done counts.
        do {
            let four = HabitStore.DayScore(done: 4, part: 0.5, partCount: 1, planned: 5)
            expect(!four.isFull(at: 1) && four.isFull(at: 0.8) && four.isFull(at: 0.6), "Full day at 80%: 4 of 5")
            let three = HabitStore.DayScore(done: 3, part: 0.9, partCount: 1, planned: 5)
            expect(!three.isFull(at: 0.8) && three.isFull(at: 0.6), "Full day at 60%: 3 of 5; part credit doesn't count")
        }

        // Phase 3: money saved for a quit habit, from clean days.
        do {
            let (s, _) = await store()
            let smoking = Habit(name: "Smoking", symbol: "nosign", color: .gray, kind: .quit, createdAt: moment(day(16), hour: 9))
            await add(s, smoking)
            same(s.moneySaved(of: smoking), nil, "No cost, no money line")
            s.setCost(HabitCost(amount: 12.5, currency: "£"), of: smoking); await s.flush()
            same(s.moneySaved(of: smoking), "Saved so far: £125", "10 clean days at £12.50")
            s.setCost(nil, of: smoking); await s.flush()
            same(s.moneySaved(of: smoking), nil, "Cost removed")
        }

        // G2 and #60a: Gym, 3 times a week. Done Mon and Wed.
        do {
            let (s, _) = await store()
            let gym = Habit(name: "Gym", symbol: "dumbbell", color: .red, kind: .check, frequency: .perWeek(3), startsOn: day(15))
            await add(s, gym)
            await tick(s, gym, on: monday); await tick(s, gym, on: day(23))
            let r = row(s, gym)
            same(r?.text, "2 of 3 so far", "G2 row")
            expect(!(r?.marks.contains { $0.mark == .missed } ?? true), "G2 no not-done marks")
            same(s.outcome(gym, on: monday), .done, "G2 Monday counts done")
            same(s.outcome(gym, on: day(22)), .neutral, "G2 Tuesday neutral")
            same(s.outcome(gym, on: friday), .open, "G2 today open")
            let snap = s.progressSnapshot(.week, containing: friday)
            same(snap.goals?.total, 1, "G2 goals total"); same(snap.goals?.met, 0, "G2 goals met")
            same(snap.goals?.caption, "Weekly goals met so far", "G2 caption")
            // #60a: done for the day once logged that day; each ✓ still adds toward the week.
            expect(s.isSatisfied(gym, on: monday), "60a logged day is done for the day")
            expect(!s.isSatisfied(gym, on: day(22)), "60a empty day before the goal is met is still open")
            expect(!s.isComplete(gym, on: monday), "60a the week isn't complete at 2 of 3")
            await tick(s, gym, on: friday)
            expect(s.isSatisfied(gym, on: friday), "60a today done for the day after one tick")
            same(s.progress(of: gym, on: friday), 3, "60a every tick counts")
            same(s.daySummary(on: friday).done, 1, "60a day bar counts today's tick")
            runsAgree(s, gym, "G2")
        }

        // G3: Water, 8 glasses a day, from Thu 24. Thu 5, Fri 6 (today).
        do {
            let (s, _) = await store()
            let water = Habit(name: "Water", symbol: "drop", color: .blue, kind: .amount(unit: "glasses", increment: 1), goal: 8, startsOn: day(24))
            await add(s, water)
            await log(s, water, 5, on: day(24)); await log(s, water, 6, on: friday)
            same(s.outcome(water, on: day(24)), .part(0.625), "G3 Thursday part")
            same(s.outcome(water, on: friday), .part(0.75), "G3 today's ring shows progress")
            let snap = s.progressSnapshot(.week, containing: friday)
            same(snap.tally.planned, 1, "G3 today not counted until done")
            same(snap.tally.done, 0, "G3 done")
            same(s.dayScore(on: day(24), habits: [water]).partCount, 1, "G3 part done count")
            same(row(s, water)?.text, "11 glasses · 0 of 1 day so far", "G3 row")
        }

        // G4 and #60b: Coffee, no more than 3 a day, from Mon 21. Wed 4, Thu 0, Fri 2 (today).
        do {
            let (s, _) = await store()
            let coffee = Habit(name: "Coffee", symbol: "mug", color: .brown, kind: .amount(unit: "cups", increment: 1), goal: 3, atMost: true, startsOn: monday)
            await add(s, coffee)
            await log(s, coffee, 4, on: day(23)); await log(s, coffee, 2, on: friday)
            same(s.dayMark(coffee, on: day(23)), .missed, "G4 Wednesday over")
            same(s.dayMark(coffee, on: day(24)), .done, "G4 Thursday within")
            same(s.dayMark(coffee, on: friday), .some, "G4 today open, logged")
            same(s.outcome(coffee, on: friday), .neutral, "G4 today not counted")
            same(s.outcome(coffee, on: day(23)), .notDone, "G4 over counts not done")
            same(s.streak(of: coffee, asOf: friday), 1, "60b streak doesn't count today")
            same(s.bestStreak(of: coffee), 2, "G4 best (Mon, Tue)")
            let fresh = Habit(name: "Tea", symbol: "cup.and.saucer", color: .brown, kind: .amount(unit: "cups", increment: 1), goal: 2, atMost: true, startsOn: friday)
            await add(s, fresh)
            same(s.dayMark(fresh, on: friday), .open, "60b a limit isn't met at the start of the day")
            same(s.streak(of: fresh, asOf: friday), 0, "60b no streak before the day ends")
            same(row(s, coffee)?.text, "Avg 1 cup a day · limit 3 cups", "G4 row")
            same(s.runs(of: coffee).map(\.length), [2, 1], "G4 runs: Mon–Tue, then Thu")
            same(s.runs(of: coffee).map(\.isCurrent), [false, true], "G4 current run")
            runsAgree(s, coffee, "G4")
        }

        // G5: Meditate, 10 min until 14 Sep, 15 min from 15 Sep. Sun 14: 12 min; Tue 16: 12 min.
        do {
            let (s, _) = await store()
            var meditate = Habit(name: "Meditate", symbol: "brain", color: .purple, kind: .duration, goal: 10, startsOn: day(1))
            await add(s, meditate)
            await log(s, meditate, 12, on: day(14))
            s.clock = { moment(day(15)) }
            meditate.goal = 15
            s.update(meditate); await s.flush()
            s.clock = { moment(friday) }
            await log(s, meditate, 12, on: day(16))
            same(s.dayMark(meditate, on: day(14)), .done, "G5 old goal met")
            same(s.dayMark(meditate, on: day(16)), .some, "G5 new goal part")
            same(s.dayFraction(meditate, on: day(16)), 0.8, "G5 part share")
            let notes = s.overTime(meditate, range: .month, anchor: friday).footnotes
            // The date's wording follows the phone's language ("15 Sep", "Sep 15").
            expect(notes.contains { $0.hasPrefix("Goal changed from 10 min to 15 min on ") }, "G5 footnote: \(notes)")
            runsAgree(s, meditate, "G5")
        }

        // G6: Stretch, daily, from Thu 24. Done Thu.
        do {
            let (s, _) = await store()
            let stretch = Habit(name: "Stretch", symbol: "figure.flexibility", color: .teal, kind: .check, startsOn: day(24))
            await add(s, stretch)
            await tick(s, stretch, on: day(24))
            same(s.dayMark(stretch, on: monday), .before, "G6 before it started")
            same(s.dayScore(on: monday, habits: [stretch]).planned, 0, "G6 Monday unchanged")
            same(s.dayScore(on: day(24), habits: [stretch]).done, 1, "G6 Thursday done")
        }

        // G7: Run, daily from Mon 21, paused Tue–Thu, done Mon; Fri not yet.
        do {
            let (s, _) = await store()
            let run = Habit(name: "Run", symbol: "figure.run", color: .green, kind: .check, startsOn: monday)
            await add(s, run)
            await tick(s, run, on: monday)
            s.pause(run, from: day(22), through: day(24), now: moment(day(21))); await s.flush()
            same(s.dayMark(run, on: day(23)), .paused, "G7 paused")
            same(s.streak(of: run, asOf: friday), 1, "G7 streak kept")
            same(row(s, run)?.text, "1 of 1 day so far", "G7 row")
            runsAgree(s, run, "G7")
        }

        // G8 and #60c: Journal, daily from Mon 21, done Mon and Tue, archived Wed 23.
        do {
            let (s, p) = await store()
            let journal = Habit(name: "Journal", symbol: "book.closed", color: .indigo, kind: .check, startsOn: monday)
            await add(s, journal)
            await tick(s, journal, on: monday); await tick(s, journal, on: day(22))
            s.clock = { moment(day(23), hour: 9) }
            s.archive([journal]); await s.flush()
            s.clock = { moment(friday) }
            let archived = s.habits.first { $0.id == journal.id }!
            same(s.archivedOn[journal.id], day(23), "60c archive day saved")
            expect(!s.isDue(archived, on: day(24)), "60c no days after archiving")
            let snap = s.progressSnapshot(.week, containing: friday)
            expect(snap.archived.contains { $0.habit.id == journal.id }, "G8 listed under Archived")
            expect(!snap.rows.contains { $0.habit.id == journal.id }, "G8 not under Habits")
            same(snap.archived.first?.text, "2 of 2 days so far", "G8 counts Mon and Tue only")
            let next = s.progressSnapshot(.week, containing: day(29))
            expect(!next.archived.contains { $0.habit.id == journal.id }, "G8 not listed next week")
            let reload = HabitStore(repository: p.repository); reload.clock = { moment(friday) }; await reload.load()
            same(reload.archivedOn[journal.id], day(23), "60c archive day survives reload")
            _ = s.restore(archived); await s.flush()
            let restored = s.habits.first { $0.id == journal.id }!
            same(s.dayMark(restored, on: day(23)), .paused, "60c archived stretch becomes a pause on restore")
            same(s.dayMark(restored, on: day(24)), .paused, "60c the whole stretch")
            expect(s.archivedOn[journal.id] == nil, "60c restore clears the archive day")
        }

        // G9 (runs only; slips come with Log a Slip, #60d): Smoking from 1 Aug 09:00, slips 3 Sep 22:10 and 20 Sep 08:00.
        do {
            let (s, p) = await store()
            let smoking = Habit(name: "Smoking", symbol: "nosign", color: .gray, kind: .quit, createdAt: moment(day(1, 8), hour: 9))
            await add(s, smoking)
            for (d, h, m) in [(day(3), 22, 10), (day(20), 8, 0)] {
                let entry = Entry(habitID: smoking.id, day: d, value: 1, createdAt: moment(d, hour: h, minute: m))
                try? await p.repository.addEntry(entry: entry.record)
            }
            await s.load()
            let runs = s.quitRuns(of: smoking, now: moment(friday))
            let first = ((33 * 24 + 13) * 60 + 10) * 60, second = ((16 * 24 + 9) * 60 + 50) * 60
            same(Int(runs.best), first, "G9 best run 33 d 13 h 10 min")
            same(Int(runs.current), (5 * 24 + 4) * 3600, "G9 current run 5 d 4 h")
            let history = s.quitHistory(of: smoking, now: moment(friday))
            same(history.map { Int($0.length(now: moment(friday))) }, [first, second, (5 * 24 + 4) * 3600], "G9 runs")
            same(history.map(\.endedBy), [.slip, .slip, .ongoing], "G9 run endings")
            let september = s.quitStats(of: smoking, in: day(1)...friday, now: moment(friday))
            same(september.slips.count, 2, "G9 September slips")
            same(september.cleanDays, 23, "G9 September clean days"); same(september.days, 25, "G9 September days")
            let all = s.quitStats(of: smoking, in: day(1, 8)...friday, now: moment(friday))
            same(all.cleanDays, 54, "G9 clean days since 1 Aug")
            same(all.averageRun.map { Int($0) }, (first + second) / 2, "G9 average run")
            let line = s.quitTotalLine(of: smoking, now: moment(friday))
            expect(line.hasPrefix("54 clean days since ") && line.hasSuffix(" · 2 slips"), "G9 total line: \(line)")
            same(s.nextMilestone(of: smoking, now: moment(friday)), "Next: 7 days · in 2 days", "G9 next milestone")
            // #60d: a slip logged for an earlier moment starts a new run from then, and Undo removes exactly it.
            let slip = s.logSlip(smoking, at: moment(day(24), hour: 21, minute: 40), note: "Party")
            await s.flush()
            same(Int(s.quitRuns(of: smoking, now: moment(friday)).current), (14 * 60 + 20) * 60, "60d new run from the slip")
            same(s.note(of: smoking, on: day(24)), "Party", "60d the slip's note")
            same(s.quitStats(of: smoking, in: day(1)...friday, now: moment(friday)).slips.count, 3, "60d slip counted")
            s.undoEntry(slip); await s.flush()
            same(s.quitStats(of: smoking, in: day(1)...friday, now: moment(friday)).slips.count, 2, "60d undo removes the slip")
            let future = s.logSlip(smoking, at: moment(day(30)))
            await s.flush()
            same(s.entries.first { $0.id == future }?.createdAt, moment(friday), "60d a slip is never in the future")
            s.undoEntry(future); await s.flush()
        }

        // G10: Cycle, 60 km a month. 42 km by Fri 25 Sep.
        do {
            let (s, _) = await store()
            let cycle = Habit(name: "Cycle", symbol: "bicycle", color: .orange, kind: .amount(unit: "km", increment: 5), goal: 60, frequency: .perMonth(1), startsOn: day(1))
            await add(s, cycle)
            await log(s, cycle, 20, on: day(5)); await log(s, cycle, 22, on: day(20))
            same(row(s, cycle, .month)?.text, "42 of 60 km so far", "G10 row")
            let over = s.overTime(cycle, range: .month, anchor: friday)
            same(over.pace, "18 km to go · 6 days left", "G10 pace")
            same(over.running.last?.total, 42, "G10 running total")
            same(over.paceLine?.goal, 60, "G10 pace line to the goal")
            let snap = s.progressSnapshot(.month, containing: friday)
            same(snap.goals?.caption, "Monthly goals met so far", "G10 caption")
            same(snap.goals?.total, 1, "G10 total"); same(snap.goals?.met, 0, "G10 met")
            same(s.outcome(cycle, on: day(5)), .done, "60a a logged day of a month goal is done")
            same(s.outcome(cycle, on: day(6)), .neutral, "60a an empty day never counts against")
            runsAgree(s, cycle, "G10")
        }

        // G11: G1's week with the week starting on Sunday.
        do {
            let (s, _) = await store(weekStart: 1)
            let week = s.period(.week, containing: friday)
            same(week.lowerBound, day(20), "G11 week from Sunday")
            same(week.upperBound, day(26), "G11 week to Saturday")
            let span = s.weekSpan(week)
            expect(span.contains("20") && span.contains("26"), "G11 range title: \(span)")
        }

        // G12: the day ends at 3:00; now is Sat 26 at 02:00.
        do {
            let (s, _) = await store(now: moment(day(26), hour: 2))
            s.settings.dayEndHour = 3
            same(s.today(), friday, "G12 still Friday")
        }

        // G13: a new year. Daily from 1 Jan 2026, done every day; now 1 Jan 2027 12:00, nothing yet.
        do {
            let (s, _) = await store(now: moment(day(1, 1, 2027)))
            let habit = Habit(name: "Walk", symbol: "figure.walk", color: .green, kind: .check, startsOn: day(1, 1))
            await add(s, habit)
            var d = day(1, 1)
            while d.year == 2026 { await tick(s, habit, on: d); d = d.adding(days: 1, calendar: s.calendar) }
            let january = s.progressSnapshot(.month, containing: s.today())
            same(january.tally.planned, 0, "G13 tile shows 0, Done so far")
            expect(january.canGoBack, "G13 2026 is one ‹ away")
            let december = s.progressSnapshot(.month, containing: day(15, 12))
            same(december.tally.done, 31, "G13 December done"); same(december.tally.planned, 31, "G13 December planned")
            same(s.overTime(habit, range: .year, anchor: day(1, 6)).counts?.done, 365, "G13 year 2026 done")
            same(s.streak(of: habit, asOf: s.today()), 365, "G13 streak carries into the new year")
            runsAgree(s, habit, "G13")
            // Phase 2: the year on Progress, its dots, By Weekday and the 30-day rate.
            let year = s.progressSnapshot(.year, containing: day(1, 6))
            same(year.title, "2026", "G13 year title")
            same(year.tally.done, 365, "G13 year done"); same(year.tally.planned, 365, "G13 year planned")
            same(year.yearDots?.full.count, 365, "G13 year dots")
            same(year.rows.first?.yearDots?.full.count, 365, "G13 row year dots")
            same(year.yearDots?.months.count, 12, "G13 month columns")
            let weekdays = s.byWeekday(habit, in: year.period)
            same(weekdays.count, 7, "G13 by weekday"); expect(weekdays.allSatisfy { $0.value == 100 }, "G13 every weekday 100%")
            same(HabitStore.weekdayCaption(weekdays, averages: false), nil, "G13 no caption when every day is the same")
            same(s.rate30(habit).last?.percent, 100, "G13 30-day rate")
            same(s.runs(of: habit).map(\.length), [365], "G13 one run")
            // Phase 3: the year's picture draws on 1 January (ledger C032: the year-end crash).
            expect(s.yearShareItem(year)?.png() != nil, "G13 year picture")
            same(s.progressSnapshot(.year, containing: day(1, 6), fullAt: 0.8).tally.fullDays, 365, "G13 full days at 80%")
        }

        // G14: Pills, twice a day, from Thu 24. Thu 1 of 2.
        do {
            let (s, _) = await store()
            let pills = Habit(name: "Pills", symbol: "pills", color: .red, kind: .check, goal: 2, startsOn: day(24))
            await add(s, pills)
            await tick(s, pills, on: day(24))
            same(s.outcome(pills, on: day(24)), .part(0.5), "G14 part")
            same(row(s, pills)?.text, "1 of 2 times so far", "G14 row counts times")
        }

        // G15: Morning, a checklist of 5 steps, from Thu 24. Thu 3 ticked.
        do {
            let (s, _) = await store()
            let steps = (1...5).map { Step(name: "Step \($0)") }
            let morning = Habit(name: "Morning", symbol: "sun.max", color: .yellow, kind: .checklist, steps: steps, startsOn: day(24))
            await add(s, morning)
            for step in steps.prefix(3) { s.toggleStep(step, of: morning, on: day(24)); await s.flush() }
            same(s.outcome(morning, on: day(24)), .part(0.6), "G15 part")
            same(row(s, morning)?.text, "3 of 5 steps so far · 0 full days", "G15 row")
            same(s.overTime(morning, range: .week, anchor: friday).steps.map(\.ticked), [1, 1, 1, 0, 0], "G15 by step")
        }

        // G16: Run 5 km on 3 days a week, from Mon 21. Mon 5, Wed 3, Thu 6.
        do {
            let (s, _) = await store()
            let run = Habit(name: "Run", symbol: "figure.run", color: .blue, kind: .amount(unit: "km", increment: 0), goal: 5, frequency: .flexible(.week, 3), startsOn: monday)
            await add(s, run)
            await log(s, run, 5, on: monday); await log(s, run, 3, on: day(23)); await log(s, run, 6, on: day(24))
            same(row(s, run)?.text, "2 of 3 days so far · 14 km", "G16 row")
            expect(!(row(s, run)?.marks.contains { $0.mark == .missed } ?? true), "G16 no not-done marks")
            same(s.dayMark(run, on: day(23)), .some, "G16 Wednesday part")
            runsAgree(s, run, "G16")
        }

        return failures
    }
}
#endif
