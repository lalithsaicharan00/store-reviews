#if DEBUG
import Foundation

/// Every phrase reviewed in `iOS/Tools/copy_oracle/copy_oracle.py` (all 127 day sets, date patterns, calendar
/// rules, 70 habit shapes and edge cases), checked against `HabitCopy`; then the New Habit form's choices saved
/// into a habit and read back. The user's rule (29 Sep): the copy is the value, so test the words, not only the
/// code. `CopyUITests` launches the app with `-copycheck` and reads the result.
enum CopyCheck {
    static func run() -> [String] {
        var failures: [String] = []
        func expect(_ got: String, _ want: String, _ what: String) {
            if got != want { failures.append("\(what): got \"\(got)\", want \"\(want)\"") }
        }
        func ensure(_ ok: Bool, _ what: String) { if !ok { failures.append(what) } }
        let savedLocale = HabitCopy.locale
        HabitCopy.locale = Locale(identifier: "en_US")
        defer { HabitCopy.locale = savedLocale }

        // The reviewed phrases.
        for (days, weekStart, full, short) in CopyCheckCases.weekdays {
            expect(HabitCopy.dayText(days, weekStart: weekStart), full, "Days \(days.sorted()) week from \(weekStart)")
            expect(HabitCopy.dayText(days, weekStart: weekStart, short: true), short, "Short days \(days.sorted()) week from \(weekStart)")
        }
        for (dates, lastDay, every, text) in CopyCheckCases.dates {
            expect(HabitCopy.monthDates(dates, useLastDay: lastDay, every: every), text, "Dates \(dates.sorted()) last \(lastDay) every \(every)")
        }
        for (rule, weekStart, full, short) in CopyCheckCases.calendars {
            expect(HabitCopy.calendarText(rule, weekStart: weekStart), full, "Rule \(rule.unit) \(rule.interval)")
            expect(HabitCopy.calendarText(rule, weekStart: weekStart, short: true), short, "Short rule \(rule.unit) \(rule.interval)")
        }
        for (habit, weekStart, sentence, caption) in CopyCheckCases.habits {
            expect(HabitCopy.sentence(habit, weekStart: weekStart), sentence, "Sentence for \(habit.name)")
            expect(HabitCopy.todayCaption(habit, weekStart: weekStart), caption, "Today line for \(habit.name)")
        }
        for (value, unit, word) in CopyCheckCases.units {
            expect(HabitCopy.unitWord(value, unit), word, "Unit \(value) \(unit)")
        }
        for (value, unit, text) in CopyCheckCases.amounts {
            expect(HabitCopy.amount(value, unit), text, "Amount \(value) \(unit)")
        }

        // The form's choices, saved into a habit and said back: what the user sees on the form and on Today.
        func made(_ plan: HabitPlan, _ name: String, weekStart: Int = 2) -> Habit {
            var habit = Habit(name: name, symbol: "star", color: .blue, kind: .check)
            plan.apply(to: &habit)
            return habit
        }
        func said(_ plan: HabitPlan, _ name: String, weekStart: Int = 2) -> String {
            HabitCopy.sentence(made(plan, name), weekStart: weekStart)
        }
        expect(said(HabitPlan(amount: 2, unit: "chapters", often: .total(.week)), "Read"), "Read 2 chapters a week", "The user's reading example")
        expect(said(HabitPlan(amount: 5, unit: "miles"), "Run"), "Run 5 miles a day", "The user's running example")
        expect(said(HabitPlan(amount: 8, unit: "km"), "Run"), "Run 8 km a day", "8K a day")
        expect(said(HabitPlan(often: .weekdays([2, 4])), "Gym"), "Gym every Monday and Wednesday", "The user's Monday and Wednesday example")
        expect(said(HabitPlan(often: .weekdays([1, 2, 3, 4, 5])), "Run"), "Run every Sunday to Thursday", "The user's Sunday to Thursday example")
        expect(said(HabitPlan(often: .weekdays([1, 2, 3, 4, 5])), "Run", weekStart: 1), "Run every Sunday to Thursday", "Sunday to Thursday, week from Sunday")
        expect(said(HabitPlan(often: .weekdays([6, 7, 1])), "Hike", weekStart: 2), "Hike every Friday to Sunday", "Friday to Sunday")
        expect(said(HabitPlan(often: .weekdays([6, 7, 1])), "Hike", weekStart: 1), "Hike every Friday to Sunday", "Friday to Sunday across the week's start")
        expect(said(HabitPlan(often: .weekdays(Set(1...7))), "Walk"), "Walk every day", "All seven days is every day")
        expect(said(HabitPlan(often: .timesADay(2)), "Brush teeth"), "Brush teeth twice a day", "Twice a day")
        expect(said(HabitPlan(often: .times(.week, 3)), "Gym"), "Gym 3 times a week", "3 times a week")
        expect(said(HabitPlan(often: .times(.week, 1)), "Call mum"), "Call mum once a week", "Once a week")
        expect(said(HabitPlan(often: .days(.week, 3)), "Yoga"), "Yoga 3 days a week", "3 different days a week")
        expect(said(HabitPlan(often: .times(.month, 1)), "Clean mirror"), "Clean mirror once a month", "Once a month")
        expect(said(HabitPlan(often: .times(.year, 12)), "Hike"), "Hike 12 times a year", "12 times a year")
        expect(said(HabitPlan(amount: 5, unit: "km", often: .times(.week, 3)), "Run"), "Run 5 km on 3 days a week", "An amount on 3 days a week")
        expect(said(HabitPlan(amount: 3, unit: "miles", often: .days(.week, 1)), "Run"), "Run 3 miles, once a week", "An amount once a week")
        expect(said(HabitPlan(amount: 30, unit: HabitPlan.timeUnit, often: .days(.week, 5)), "Study"), "Study 30 min on 5 days a week", "Time on 5 days")
        expect(said(HabitPlan(amount: 180, unit: HabitPlan.timeUnit, often: .total(.week)), "Practise piano"), "Practise piano 3 h a week", "Time a week")
        expect(said(HabitPlan(amount: 90, unit: HabitPlan.timeUnit), "Read"), "Read 1 h 30 min a day", "Hours and minutes")
        expect(said(HabitPlan(amount: 12, unit: "books", often: .total(.year)), "Read"), "Read 12 books a year", "A year")
        expect(said(HabitPlan(amount: 100, unit: "$", often: .total(.month)), "Save"), "Save $100 a month", "Money")
        expect(said(HabitPlan(amount: 2000, unit: "ml"), "Drink water"), "Drink water 2,000 ml a day", "Grouped thousands")
        expect(said(HabitPlan(amount: 1, unit: "glasses"), "Drink water"), "Drink water 1 glass a day", "One glass, not one glasses")
        expect(said(HabitPlan(amount: 100, unit: "push-ups"), "Push-ups"), "100 push-ups a day", "Name is the unit")
        expect(said(HabitPlan(amount: 5, unit: "km", often: .weekdays([2, 4, 6])), "Run"), "Run 5 km every Monday, Wednesday and Friday", "Amount on set days")
        expect(said(HabitPlan(amount: 3, unit: "coffees", atMost: true), "Coffee"), "At most 3 coffees a day", "Cut down, name is the unit")
        expect(said(HabitPlan(amount: 10, unit: "drinks", often: .total(.week), atMost: true), "Alcohol"), "Alcohol: at most 10 drinks a week", "Cut down a week")
        expect(said(HabitPlan(often: .calendar(CalendarSchedule(unit: .month, interval: 1, dates: [1], pattern: .dates))), "Pay rent"),
               "Pay rent on the 1st of every month", "On a date")
        expect(said(HabitPlan(often: .calendar(CalendarSchedule(unit: .month, interval: 1, dates: [1, 15], pattern: .dates))), "Pay bills"),
               "Pay bills on the 1st and 15th of every month", "Two dates")
        expect(said(HabitPlan(often: .calendar(CalendarSchedule(unit: .month, interval: 1, dates: Set(1...31), pattern: .dates))), "Journal"),
               "Journal every day", "All 31 dates is every day")
        expect(said(HabitPlan(often: .calendar(CalendarSchedule(unit: .month, interval: 1, pattern: .weekday, ordinal: 1, weekday: 7))), "Book club"),
               "Book club on the first Saturday of every month", "First Saturday")
        expect(said(HabitPlan(often: .calendar(CalendarSchedule(unit: .day, interval: 2))), "Jog"), "Jog every other day", "Every other day")
        expect(said(HabitPlan(often: .calendar(CalendarSchedule(unit: .week, interval: 2, weekdays: [6]))), "Change sheets"),
               "Change sheets every other week on Friday", "Every other week")
        expect(said(HabitPlan(often: .calendar(CalendarSchedule(unit: .year, interval: 1, month: 10, day: 1))), "Flu shot"),
               "Flu shot every year on October 1", "Every year")
        expect(said(HabitPlan(checklist: true), "Clean kitchen"), "Clean kitchen every day", "A checklist")
        expect(said(HabitPlan(checklist: true), ""), "Every day", "No name yet") // the read-back before a name is typed
        expect(said(HabitPlan(often: .times(.week, 3)), "   "), "3 times a week", "Spaces only")

        // What's stored, so Today counts it the way the sentence says.
        var habit = made(HabitPlan(amount: 5, unit: "km", often: .times(.week, 3)), "Run")
        ensure(habit.frequency == .flexible(.week, 3) && habit.goal == 5 && habit.quickIncrement == 5, "5 km on 3 days: days reaching 5 km, + adds 5 km")
        habit = made(HabitPlan(often: .times(.week, 3)), "Gym")
        ensure(habit.kind == .check && habit.frequency == .perWeek(3) && habit.goal == 3, "3 times a week counts every tick")
        habit = made(HabitPlan(often: .days(.week, 3)), "Yoga")
        ensure(habit.kind == .check && habit.frequency == .flexible(.week, 3) && habit.goal == 1, "3 days a week counts different days")
        habit = made(HabitPlan(often: .timesADay(2)), "Brush")
        ensure(habit.frequency == .daily && habit.goal == 2, "Twice a day is a daily goal of 2")
        habit = made(HabitPlan(amount: 2, unit: "chapters", often: .total(.week)), "Read")
        ensure(habit.frequency == .perWeek(1) && habit.goal == 2, "2 chapters a week is one weekly total")
        habit = made(HabitPlan(amount: 30, unit: HabitPlan.timeUnit), "Meditate")
        ensure(habit.kind == .duration && habit.goal == 30, "Time makes a timed habit")
        habit = made(HabitPlan(checklist: true), "Clean")
        ensure(habit.kind == .checklist, "Steps make a checklist")
        habit = made(HabitPlan(amount: 3, unit: "coffees", atMost: true), "Coffee")
        ensure(habit.atMost && habit.frequency == .daily && habit.goal == 3, "A daily limit")
        habit = made(HabitPlan(often: .weekdays(Set(1...7))), "Walk")
        ensure(habit.frequency == .daily, "Seven chosen days are stored as every day")

        // + adds what it says: the suggested step, or the person's own.
        func step(_ amount: Double, _ unit: String, _ often: HowOften = .everyDay) -> Double? {
            made(HabitPlan(amount: amount, unit: unit, often: often), "T").quickIncrement
        }
        ensure(step(8, "glasses") == 1, "8 glasses: +1")
        ensure(step(12, "books", .total(.year)) == 1, "12 books a year: +1")
        ensure(step(2000, "ml") == 250, "2,000 ml: +250 ml")
        ensure(step(2.5, "litres") == 0.25, "2.5 litres: +0.25")
        ensure(step(64, "oz") == 8, "64 oz: +8 oz")
        ensure(step(10000, "steps") == 1000, "10,000 steps: +1,000")
        ensure(step(100, "push-ups") == 10, "100 push-ups: +10")
        ensure(step(5, "km") == 1, "5 km a day: +1 km")
        ensure(step(5, "km", .times(.week, 3)) == 5, "5 km on 3 days: +5 km")
        ensure(step(0.5, "") == 0.5, "Half: +0.5")
        ensure(step(150, "ml") == 150, "A goal smaller than a glass: all of it")
        ensure(made(HabitPlan(amount: 8, unit: "glasses", step: 2), "T").quickIncrement == 2, "The person's own step is kept")
        ensure(made(HabitPlan(often: .timesADay(2)), "T").quickIncrement == nil, "Just do it has ✓, not +")

        // The How often row's words.
        expect(HowOften.total(.week).label(hasAmount: true, weekStart: 2), "A week", "Row: a week")
        expect(HowOften.everyDay.label(hasAmount: true, weekStart: 2), "Every day", "Row: every day")
        expect(HowOften.times(.week, 3).label(hasAmount: false, weekStart: 2), "3 times a week", "Row: 3 times a week")
        expect(HowOften.times(.week, 3).label(hasAmount: true, weekStart: 2), "On 3 days a week", "Row: an amount on 3 days")
        expect(HowOften.days(.week, 3).label(hasAmount: false, weekStart: 2), "3 days a week", "Row: 3 days a week")
        expect(HowOften.days(.week, 1).label(hasAmount: false, weekStart: 2), "Once a week", "Row: once a week")
        expect(HowOften.timesADay(3).label(hasAmount: false, weekStart: 2), "3 times a day", "Row: 3 times a day")
        expect(HowOften.weekdays([2, 3, 4, 5, 6]).label(hasAmount: false, weekStart: 2), "On weekdays", "Row: weekdays")

        // The How often screen keeps every number while switching, and an amount never gets ✓ counts.
        var draft = OftenDraft()
        draft.choice = .timesADay; draft.perDay = 3
        ensure(draft.often(hasAmount: false) == .timesADay(3), "Draft: 3 times a day")
        ensure(draft.often(hasAmount: true) == .everyDay, "Draft: an amount is never N times a day")
        draft.choice = .times; draft.count = 4; draft.countPeriod = .month
        ensure(draft.often(hasAmount: false) == .times(.month, 4), "Draft: 4 times a month")
        draft.countsDays = true
        ensure(draft.often(hasAmount: false) == .times(.month, 4), "Draft: Just do it always counts times (Days removed 29 Sep)")
        draft.choice = .timesADay
        ensure(draft.perDay == 3, "Draft: switching back keeps 3 a day")
        draft.choice = .total; draft.totalPeriod = .year
        ensure(draft.often(hasAmount: true) == .total(.year), "Draft: a year in total")
        ensure(draft.often(hasAmount: false) == .times(.year, 1), "Draft: without an amount, once a year")
        draft.seed(start: LocalDay(year: 2026, month: 9, day: 29).date(), weekStart: 2)
        ensure(draft.weekdays == [3] && draft.dateRule.dates == [29] && draft.dateRule.month == 9, "Draft: seeded from Tuesday 29 September")

        // Longest names and units still read as one sentence.
        let long = made(HabitPlan(amount: 12345.67, unit: "tablespoons", often: .weekdays([1, 3, 5, 7])), "Evening wind-down routin")
        expect(HabitCopy.sentence(long, weekStart: 2), "Evening wind-down routin 12,345.67 tablespoons every Tuesday, Thursday, Saturday and Sunday",
               "Longest name and unit")
        return failures
    }
}
#endif
