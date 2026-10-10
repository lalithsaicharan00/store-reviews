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
            // One rule for the round button (6 Oct 2026, Current Work 54): a weekly count counts up, like a habit ticked
            // several times a day: every tap adds one, even two on one day, and never takes one back (its Undo does).
            expect(s.countsUp(gym, on: friday), "Tap rule: a weekly count counts up")
            s.toggleCheck(gym, on: day(24)); await s.flush()
            same(s.progress(of: gym, on: day(24)), 4, "Tap rule: a tap on Thursday adds one")
            s.toggleCheck(gym, on: day(24)); await s.flush()
            same(s.progress(of: gym, on: day(24)), 5, "Tap rule: a second tap on Thursday adds another, never takes one back")
            same(s.dayProgress(of: gym, on: day(24)), 2, "Tap rule: two on one day both count")
            let call = Habit(name: "Call", symbol: "phone", color: .green, kind: .check, frequency: .perWeek(3), startsOn: day(15))
            await add(s, call)
            s.toggleCheck(call, on: friday); await s.flush()
            expect(!s.isDone(call, on: friday), "Tap rule: one call of three isn't the week's goal (the button stays open)")
            expect(s.isSatisfied(call, on: friday), "Tap rule: but it's done for the day (#60a)")
            s.toggleCheck(call, on: friday); s.toggleCheck(call, on: friday); await s.flush()
            expect(s.isDone(call, on: friday), "Tap rule: three calls in one day meet the week (the button fills)")
            let monthly = Habit(name: "Visit", symbol: "house", color: .green, kind: .check, frequency: .perMonth(2), startsOn: day(15))
            await add(s, monthly)
            expect(s.countsUp(monthly, on: friday), "Tap rule: a monthly count counts up")
            s.toggleCheck(monthly, on: friday); await s.flush()
            expect(!s.isDone(monthly, on: friday), "Tap rule: one of two this month isn't done")
            let pills = Habit(name: "Pills", symbol: "pills.fill", color: .red, kind: .check, goal: 3, startsOn: day(15))
            await add(s, pills)
            expect(s.countsUp(pills, on: friday), "Tap rule: three times a day counts up")
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

        // G18, groups (groups spec §5): one group per habit, the order, and group numbers that add up to All.
        // A and B in Health, C in Mind, D in none, Zeta empty; all daily from Mon 21. A done Mon–Thu, B Mon, C Mon–Wed.
        do {
            let (s, persistence) = await store()
            let habits = ["A", "B", "C", "D"].map { Habit(name: $0, symbol: "star", color: .blue, kind: .check, startsOn: monday) }
            for h in habits { await add(s, h) }
            let (a, b, c, d) = (habits[0], habits[1], habits[2], habits[3])
            for n in 21...24 { await tick(s, a, on: day(n)) }
            await tick(s, b, on: monday)
            for n in 21...23 { await tick(s, c, on: day(n)) }
            let health = HabitGroup(name: "Health", color: .green, habits: [a.id, b.id])
            var mind = HabitGroup(name: "Mind", color: .purple, habits: [c.id])
            let zeta = HabitGroup(name: "Zeta", color: .gray)
            s.saveGroup(zeta); s.saveGroup(mind); s.saveGroup(health); await s.flush()
            same(s.groups.map(\.name), ["Health", "Mind", "Zeta"], "G18 A to Z")
            same(s.groupOf[a.id], health.id, "G18 A in Health")
            same(s.groupOf[d.id], nil, "G18 D in none")
            // One group per habit: putting A in Mind takes it out of Health.
            mind.habits = [c.id, a.id]
            s.saveGroup(mind); await s.flush()
            same(s.groupOf[a.id], mind.id, "G18 A moved to Mind")
            same(s.groups.first { $0.id == health.id }?.habits, [b.id], "G18 A left Health")
            s.setGroup(health.id, of: a.id); await s.flush()
            same(s.groupOf[a.id], health.id, "G18 setGroup moves A back")
            same(s.groups.first { $0.id == mind.id }?.habits, [c.id], "G18 A left Mind")
            same(s.groupCount(nil, on: friday), 4, "G18 All chip counts today's habits")
            same(s.groupCount(health.id, on: friday), 2, "G18 Health chip")
            same(s.groupCount(zeta.id, on: friday), nil, "G18 empty group is –")

            // The numbers: Health 5 of 8, Mind 3 of 4, none 0 of 4, All 8 of 16 (today adds only what's done).
            let all = s.progressSnapshot(.week, containing: friday)
            same(all.tally.done, 8, "G18 All done"); same(all.tally.planned, 16, "G18 All planned")
            same(all.groupBars.map(\.group.name), ["Health", "Mind"], "G18 bars in group order, empty group left out")
            same(all.groupBars.map { "\($0.tally.done)/\($0.tally.planned)" }, ["5/8", "3/4"], "G18 bar tallies")
            same(all.sections.map { $0.group?.name ?? ($0.ungrouped ? "No Group" : "Habits") }, ["Health", "Mind", "No Group"], "G18 sections")
            let sum = all.groupBars.reduce(0) { $0 + $1.tally.planned } + 4
            same(sum, all.tally.planned, "G18 groups and No Group add up to All")
            let onlyHealth = s.progressSnapshot(.week, containing: friday, group: health.id)
            same("\(onlyHealth.tally.done)/\(onlyHealth.tally.planned)", "5/8", "G18 Health chosen")
            same(onlyHealth.sections.map { $0.rows.map(\.habit.name) }, [["A", "B"]], "G18 Health rows under Habits")
            expect(onlyHealth.groupBars.isEmpty, "G18 no bars with a group chosen")
            same(s.progressDayDetail(on: monday, group: mind.id).rows.map(\.habit.name), ["C"], "G18 Day sheet for Mind")

            // Order: dragging sets the person's own order, kept after reopening; Sort A to Z goes back.
            s.moveGroups(from: [2], to: 0); await s.flush()
            same(s.groups.map(\.name), ["Zeta", "Health", "Mind"], "G18 dragged order")
            let reopened = HabitStore(repository: persistence.repository)
            await reopened.load()
            same(reopened.groups.map(\.name), ["Zeta", "Health", "Mind"], "G18 order kept after reopening")
            expect(reopened.groupsManual, "G18 own order remembered")
            same(reopened.groupOf[a.id], health.id, "G18 membership kept after reopening")
            s.sortGroupsAZ(); await s.flush()
            same(s.groups.map(\.name), ["Health", "Mind", "Zeta"], "G18 Sort A to Z")

            // Deleting a group keeps its habits and their history; a deleted group reads as All.
            s.deleteGroup(health.id); await s.flush()
            same(s.groups.map(\.name), ["Mind", "Zeta"], "G18 Health deleted")
            same(s.habits.count, 4, "G18 its habits stay")
            same(s.groupOf[a.id], nil, "G18 A has no group")
            same(s.existingGroup(health.id.uuidString), nil, "G18 a deleted group's filter is All")
            let after = s.progressSnapshot(.week, containing: friday, group: health.id)
            same(after.tally.done, 8, "G18 deleted group's numbers are All's")
            same(s.streak(of: a, asOf: day(24)), 4, "G18 A's history untouched")
        }

        // G19, milestones and the finishing tap (ported 1 Oct 2026): the 7th day in a row is marked beside its Undo;
        // finishing every habit today is marked when the streak isn't a milestone; never for a habit that isn't today.
        do {
            let (s, _) = await store()
            let walk = Habit(name: "Walk", symbol: "figure.walk", color: .green, kind: .check, startsOn: day(19))
            let read = Habit(name: "Read", symbol: "book", color: .blue, kind: .check, startsOn: day(19))
            await add(s, walk); await add(s, read)
            for n in 19...24 { await tick(s, walk, on: day(n)) }
            same(s.streak(of: walk, asOf: friday), 6, "G19 six days before the tap")
            await tick(s, walk, on: friday)
            same(s.milestoneOffer?.text, "7 days in a row", "G19 the 7th day is a milestone")
            same(s.milestoneOffer?.entry, s.undoOffer?.id, "G19 shown with the tap's own Undo")
            await tick(s, read, on: friday)
            same(s.milestoneOffer?.text, "All 2 done today", "G19 finishing the day")
            expect(s.dayFinishedAt != nil, "G19 the finishing tap is noted for the review prompt")
            // The 11 Oct 2026 ladders (spec "Habit Progress" §4): every earlier value kept, more between them.
            same(StreakUnit.days.milestones(upTo: 400), [3, 7, 10, 14, 30, 50, 75, 100, 150, 200, 250, 365], "G19 day milestones (11 Oct 2026 ladder)")
            same(StreakUnit.weeks.nextMilestone(after: 4), 6, "G19 next week milestone")
            same(StreakUnit.months.milestones(upTo: 40), [2, 3, 4, 5, 6, 9, 12, 15, 18, 24, 30, 36], "G19 month milestones")
            same(StreakUnit.months.nextMilestone(after: 36), 48, "G19 every 12 months after 36")
            same(StreakUnit.years.milestones(upTo: 3), [1, 2, 3], "G19 every year from 1 (E6)")
            same(StreakUnit.days.nextMilestone(after: 1000), 1095, "G19 every 365 days after 730")
            same(Array(HabitStore.quitMilestones(upTo: 0).prefix(15)), [1, 3, 7, 10, 14, 30, 45, 60, 90, 120, 180, 270, 365, 500, 730], "G19 quit ladder")
            same(TotalMilestones.ladder(for: .day), [10, 25, 50, 100, 250, 500, 1000, 2500, 5000], "G19 in total")
            same(Array(TotalMilestones.ladder(for: .month).prefix(3)), [3, 6, 10], "G19 in total, month goals (E5)")
            same(Array(TotalMilestones.ladder(for: .year).prefix(3)), [2, 5, 10], "G19 in total, year goals (E5)")
        }

        // G21, the habit Progress tab (spec "Habit Progress — Overall Record, Streaks and Milestones", 11 Oct 2026).
        // A week goal: Gym 3 times a week from Mon 7 Sep; met Wed 9 and Thu 17; this week 2 so far.
        do {
            let (s, _) = await store()
            let gym = Habit(name: "Gym", symbol: "dumbbell", color: .red, kind: .check, frequency: .perWeek(3), startsOn: day(7))
            await add(s, gym)
            for d in [7, 8, 9, 14, 16, 17, 21, 22] { await tick(s, gym, on: day(d)) }
            let record = s.habitRecord(of: gym, today: friday)
            same(record.headline, "8 times recorded", "G21 week goal headline")
            same(record.current?.number, "2", "G21 current streak")
            same(record.current?.unit, "weeks", "G21 in weeks")
            same(record.current?.detail, "This week: 2 of 3", "G21 the running week")
            expect(record.best.flatMap(\.detail).map { $0.contains("7") && $0.contains("20") && $0.contains("Sep") } == true, "G21 best run's dates: \(record.best?.detail ?? "none")")
            same(record.goalMet?.number, "2", "G21 goal met")
            same(record.goalMet?.unit, "of 2 weeks", "G21 of weeks")
            same(record.percentNoun, "of weeks", "G21 percent of weeks")
            same(record.bestPeriod?.title, "Best week", "G21 best week")
            same(record.bestPeriod?.number, "3", "G21 best week's count")
            same(record.bestPeriod?.unit, "times", "G21 best week's unit")
            expect(record.bestPeriod.flatMap(\.detail).map { $0.contains("7") && $0.contains("13") && $0.contains("Sep") } == true, "G21 best week's dates: \(record.bestPeriod?.detail ?? "none")")
            // E3: a week is dated the day its goal was met, not its last day or today.
            same(record.metDates, [day(9), day(17)], "G21 E3 weeks dated the day they were met")
            let m = s.habitMilestones(of: gym, record: record, today: friday)
            same(m.reached.map(\.title), ["2 weeks in a row"], "G21 one medal")
            same(m.reached.first?.reached, day(17), "G21 E3 the medal's date")
            same(m.reached.first?.shelfTop, "2 weeks", "G21 shelf caption")
            same(m.reached.first?.shelfBottom, "in a row", "G21 shelf caption, second line")
            same(m.next.map(\.title), ["3 weeks in a row", "10 weeks of goals met"], "G21 next, worded per §5.3")
            same(m.next.map(\.detail), ["1 to go · now 2", "8 to go · 2 so far"], "G21 next details")
            same(m.next.map(\.fraction), [2.0 / 3.0, 0.2], "G21 ring: current ÷ target")
            await tick(s, gym, on: day(23))
            let done = s.habitRecord(of: gym, today: friday)
            same(done.current?.detail, "This week: done", "G21 this week done")
            same(done.current?.number, "3", "G21 the running week adds once met")
            same(done.metDates.last, day(23), "G21 E3 met on Wednesday")
            runsAgree(s, gym, "G21")
        }

        // G21 E7: a milestone is reached once, dated by the first run that reached it. Read daily from 1 Sep: 1–10, then
        // 19–25 (today).
        do {
            let (s, _) = await store()
            let read = Habit(name: "Read", symbol: "book", color: .blue, kind: .check, startsOn: day(1))
            await add(s, read)
            for d in Array(1...10) + Array(19...25) { await tick(s, read, on: day(d)) }
            let record = s.habitRecord(of: read, today: friday)
            same(record.headline, "Done on 17 days", "G21 E7 headline")
            same(record.current?.number, "7", "G21 E7 current")
            same(record.best?.number, "10", "G21 E7 best")
            expect(record.best.flatMap(\.detail).map { $0.contains("1") && $0.contains("10") && $0.contains("Sep") } == true, "G21 E7 best run's dates: \(record.best?.detail ?? "none")")
            same(record.current?.detail, nil, "G21 a day goal has no running-period line")
            same(record.goalMet?.unit, "of 25 days", "G21 goal met of planned days")
            same(record.bestPeriod, nil, "G21 once a day: no best day")
            let m = s.habitMilestones(of: read, record: record, today: friday)
            same(m.reached.map(\.id), ["inARow-days-10", "inTotal-day-10", "inARow-days-7", "inARow-days-3"], "G21 E7 one medal each, newest first")
            same(m.reached.first { $0.id == "inARow-days-7" }?.reached, day(7), "G21 E7 dated by the first run")
            same(m.reached.first { $0.id == "inARow-days-7" }?.shelfTop, "7 in a row", "G21 daily shelf caption")
            same(m.next.first?.title, "14 days in a row", "G21 E7 next above the best")
            same(m.next.first?.detail, "7 to go · now 7, best 10", "G21 E7 next detail")
            same(m.next.last?.title, "25 times in total", "G21 next total")
            same(m.shown(streaks: false).reached.map(\.id), ["inTotal-day-10"], "G21 E9 Show Streaks off keeps totals")
            same(m.shown(streaks: false).next.count, 1, "G21 E9 no in-a-row Next")
        }

        // G21 E1 and E2: Walk once a week for 8 weeks (from Mon 6 Jul), then a day goal from Mon 31 Aug, done 21–25 Sep.
        do {
            let (s, _) = await store()
            var walk = Habit(name: "Walk", symbol: "figure.walk", color: .green, kind: .check, frequency: .perWeek(1), startsOn: day(6, 7))
            await add(s, walk)
            for d in [day(6, 7), day(13, 7), day(20, 7), day(27, 7), day(3, 8), day(10, 8), day(17, 8), day(24, 8)] { await tick(s, walk, on: d) }
            s.clock = { moment(day(31, 8)) }
            walk.frequency = .daily
            s.update(walk); await s.flush()
            s.clock = { moment(friday) }
            for d in 21...25 { await tick(s, walk, on: day(d)) }
            let record = s.habitRecord(of: walk, today: friday)
            same(record.current?.number, "5", "G21 E1 the run starts with the new goal")
            same(record.current?.unit, "days", "G21 E1 in the new goal's unit")
            same(record.best?.number, "5", "G21 E1 best follows today's goal")
            // E2: Goal met counts only days now; the 8 weeks never count as days.
            same(record.goalMet?.number, "5", "G21 E2 goal met")
            same(record.goalMet?.unit, "of 26 days", "G21 E2 only days of the day goal")
            same(record.kinds, [.week, .day], "G21 E1 both kinds of goal")
            let m = s.habitMilestones(of: walk, record: record, today: friday)
            let ids = Set(m.reached.map(\.id))
            expect(ids.isSuperset(of: ["inARow-weeks-8", "inARow-weeks-6", "inARow-weeks-2", "inARow-days-3"]), "G21 E1 kept medals: \(ids)")
            same(m.reached.first { $0.id == "inARow-weeks-8" }?.title, "8 weeks in a row", "G21 E1 in their own unit")
            same(m.reached.first { $0.id == "inARow-weeks-8" }?.reached, day(24, 8), "G21 E1 dated the day the 8th week was met")
            same(m.next.first?.title, "7 days in a row", "G21 E1 Next follows today's goal")
        }

        // G21 a month goal: In total starts at 3 (E5). Call home once a month from 1 Jun; met 1 Jun, 1 Jul, 1 Aug.
        do {
            let (s, _) = await store()
            let call = Habit(name: "Call", symbol: "phone", color: .green, kind: .check, frequency: .perMonth(1), startsOn: day(1, 6))
            await add(s, call)
            for d in [day(1, 6), day(1, 7), day(1, 8)] { await tick(s, call, on: d) }
            let record = s.habitRecord(of: call, today: friday)
            same(record.current?.detail, "This month: 0 of 1", "G21 the running month")
            same(record.bestPeriod?.title, "Best month", "G21 best month")
            let m = s.habitMilestones(of: call, record: record, today: friday)
            same(m.reached.map(\.title), ["3 months in a row", "3 months of goals met", "2 months in a row"], "G21 month medals")
            same(m.next.last?.title, "6 months of goals met", "G21 next month total")
        }

        // G20, Siri and Shortcuts (ported 1 Oct 2026): logs like a tap, never twice, and asks how much when it must.
        do {
            let (s, _) = await store()
            let stretch = Habit(name: "Stretch", symbol: "figure.flexibility", color: .teal, kind: .check, startsOn: monday)
            let water = Habit(name: "Water", symbol: "drop", color: .blue, kind: .amount(unit: "glasses", increment: 1), goal: 8, startsOn: monday)
            let pages = Habit(name: "Pages", symbol: "book", color: .indigo, kind: .amount(unit: "pages", increment: 0), goal: 20, startsOn: monday)
            for h in [stretch, water, pages] { await add(s, h) }
            same(s.logFromShortcut(stretch, amount: nil, on: friday), .logged, "G20 tick")
            await s.flush()
            same(s.logFromShortcut(stretch, amount: nil, on: friday), .alreadyDone, "G20 a tick done stays done")
            same(s.logFromShortcut(water, amount: nil, on: friday), .logged, "G20 one quick step")
            same(s.logFromShortcut(water, amount: 2, on: friday), .logged, "G20 an amount said")
            await s.flush()
            same(s.progress(of: water, on: friday), 3, "G20 1 + 2 glasses")
            same(s.logFromShortcut(pages, amount: nil, on: friday), .needsAmount, "G20 no quick step: asks how much")
            same(s.shortcutStatus(water, on: friday), "Water: 3 of 8 glasses today.", "G20 status")
            same(s.entries.filter { $0.habitID == water.id }.compactMap(\.source), [.shortcut, .shortcut], "G20 marked as Siri or Shortcuts")
        }

        // Week cards (2 Oct 2026, report "Weekly Habit Cards — What Each Card Shows" §5): the headline on each goal's
        // own clock, one different fact or none, and each day's own value.
        do {
            let (s, _) = await store()
            let read = Habit(name: "Read", symbol: "book", color: .blue, kind: .check, startsOn: monday)
            let gym = Habit(name: "Gym", symbol: "dumbbell", color: .red, kind: .check, frequency: .perWeek(3), startsOn: day(15))
            let water = Habit(name: "Water", symbol: "drop", color: .blue, kind: .amount(unit: "glasses", increment: 1), goal: 8, startsOn: day(24))
            let coffee = Habit(name: "Coffee", symbol: "mug", color: .brown, kind: .amount(unit: "cups", increment: 1), goal: 3, atMost: true, startsOn: monday)
            let smoking = Habit(name: "Smoking", symbol: "nosign", color: .gray, kind: .quit, createdAt: moment(day(16), hour: 9))
            for h in [read, gym, water, coffee, smoking] { await add(s, h) }
            for d in [21, 22, 24] { await tick(s, read, on: day(d)) }
            s.setSkipped(read, on: day(23), true); await s.flush()
            await tick(s, gym, on: monday); await tick(s, gym, on: day(23))
            await log(s, water, 5, on: day(24)); await log(s, water, 6, on: friday)
            await log(s, coffee, 4, on: day(23)); await log(s, coffee, 2, on: friday)
            let snap = s.progressSnapshot(.week, containing: friday, weekCards: true)
            func card(_ h: Habit) -> ProgressWeekCard? { (snap.cards + snap.archivedCards).first { $0.habit.id == h.id } }
            same(snap.title, "21–27 Sep", "W title: the dates")
            same(snap.caption, "This week", "W caption")
            same(snap.columns.count, 7, "W seven columns")
            expect(snap.rows.isEmpty && snap.goals == nil && snap.groupBars.isEmpty, "W no rows, overview or group numbers")
            same(card(read)?.headline, "3 of 3 days so far", "W1 daily headline")
            same(card(read)?.detail, nil, "W1 nothing more to say")
            same(card(read)?.days.map(\.mark), [.done, .done, .skipped, .done, .open, .upcoming, .upcoming], "W1 marks")
            same(card(gym)?.headline, "2 of 3 this week", "W2 week goal headline")
            same(card(gym)?.detail, "1 to go · 3 days left", "W2 what's left")
            expect(!(card(gym)?.days.contains { $0.mark == .missed } ?? true), "W2 no not-done marks")
            same(card(water)?.headline, "Reached on 0 of 1 day so far", "W3 amount headline")
            same(card(water)?.detail, "11 glasses this week", "W3 total in the unit")
            same(card(water)?.days.map(\.value), ["", "", "", "5", "6", "", ""], "W3 each day's value")
            same(card(coffee)?.headline, "Within limit on 3 of 4 days", "W4 daily limit, today not judged")
            same(card(coffee)?.detail, "6 cups this week", "W4 total")
            same(card(coffee)?.days.map(\.over), [false, false, true, false, false, false, false], "W4 Wednesday over")
            same(card(smoking)?.headline, "Current run 9 d 3 h", "W5 quit: the run")
            same(card(smoking)?.detail, "No slips this week", "W5 quit: this week's slips")
            same(card(smoking)?.isQuit, true, "W5 quit card")
            // Month (2 Oct 2026): the same cards over September, no values under the marks.
            let month = s.progressSnapshot(.month, containing: friday, weekCards: true)
            func monthCard(_ h: Habit) -> ProgressWeekCard? { month.cards.first { $0.habit.id == h.id } }
            same(month.title, "September", "M title: the month")
            same(month.caption, "This month", "M caption")
            same(month.columns.count, 30, "M a column per day")
            same(month.monthLead, 1, "M 1 September is a Tuesday; weeks start on Monday")
            same(month.letters.first, s.weekdayNames.veryShort[1], "M letters start on Monday")
            same(monthCard(read)?.headline, "3 of 3 days so far", "M1 daily headline")
            same(monthCard(gym)?.headline, "Met 0 of 1 week so far", "M2 week goal over a month: the open week isn't counted until it's met or over")
            same(monthCard(gym)?.detail, "2 times this month", "M2 what was done")
            same(monthCard(water)?.detail, "11 glasses this month", "M3 total in the unit")
            expect(month.cards.allSatisfy { $0.days.allSatisfy { $0.value.isEmpty } }, "M no values under the marks")
            same(monthCard(smoking)?.detail, "No slips this month", "M5 quit: the month's slips")
            same(HabitStore.compactNumber(9100), "9.1k", "W value 9.1k")
            same(HabitStore.compactNumber(8000), "8k", "W value 8k")
            same(HabitStore.compactNumber(6.5), "6.5", "W value 6.5")
            same(HabitStore.compactNumber(123_456), "123k", "W value 123k")
            same(HabitStore.compactMinutes(25), "25m", "W minutes 25m")
            same(HabitStore.compactMinutes(65), "1h05", "W minutes 1h05")
            same(HabitStore.compactMinutes(120), "2h", "W minutes 2h")
        }

        return failures
    }
}
#endif
