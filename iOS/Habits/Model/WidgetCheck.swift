#if DEBUG
import Core
import Foundation
import SwiftUI
import WidgetKit

/// Every kind of habit on Today, in its own section, and seven tasks: runs inside the actual iPhone app against the
/// Kotlin repository, not a mock (`-widget-fixture`). Today's cards by default: Quit or Cut Down, Anytime, Morning,
/// Afternoon, Evening.
enum WidgetFixture {
    static func install(in store: HabitStore) async {
        guard store.habits.isEmpty else { return }
        let start = store.today().adding(days: -40, calendar: store.calendar)
        let longLabels = ProcessInfo.processInfo.arguments.contains("-widget-long-labels")
        let items = [
            Habit(name: "Widget water", symbol: "drop.fill", color: .blue,
                  kind: .amount(unit: longLabels ? "large glasses" : "glasses", increment: 1), parts: [.anytime], goal: 8, startsOn: start),
            Habit(name: longLabels ? "Read before breakfast" : "Widget check", symbol: "book.fill", color: .orange, kind: .check,
                  parts: [.morning], startsOn: start),
            Habit(name: "Widget timer", symbol: "timer", color: .purple, kind: .duration, parts: [.morning], goal: 10, startsOn: start),
            Habit(name: "Widget steps", symbol: "figure.walk", color: .green, kind: .amount(unit: "steps", increment: 0),
                  parts: [.afternoon], goal: 8000, startsOn: start),
            Habit(name: "Widget routine", symbol: "list.bullet", color: .indigo, kind: .checklist, parts: [.evening],
                  steps: [Step(name: "Teeth"), Step(name: "Read"), Step(name: "Lights out")], startsOn: start),
            Habit(name: "Widget cut down", symbol: "cup.and.saucer.fill", color: .brown, kind: .amount(unit: "cups", increment: 1),
                  goal: 3, atMost: true, startsOn: start),
            Habit(name: "Widget quit", symbol: "hand.raised.fill", color: .green, kind: .quit, startsOn: start,
                  quitSince: start.date(calendar: store.calendar)),
        ]
        for item in items { store.add(item) }
        for i in 1...7 {
            store.add(Habit(name: "Widget task \(i)", symbol: "checkmark", color: .blue, kind: .task, parts: [.anytime],
                            dueDay: store.today(), startsOn: start))
        }
        await store.flush()
    }
}

/// The widgets' checks (Implementation Spec §12, and every widget problem users reported: Feature Ledger C040 blank,
/// stale or wrong widgets; C023 logging without opening the app; C090 no destructive taps). Data, words, order,
/// actions, day boundaries, privacy and the snapshot on disk. Rendering is `WidgetRenderCheck`; WidgetKit itself is
/// `WidgetSystemUITests`.
enum WidgetCheck {
    static func run() async -> [String] {
        var failures: [String] = []
        func expect(_ value: Bool, _ name: String) { if !value { failures.append(name) } }
        UserDefaults.standard.removeObject(forKey: WidgetDisk.privacyKey)
        UserDefaults.standard.set(DoneOrder.bottom.rawValue, forKey: Preferences.doneOrder)
        UserDefaults.standard.set(true, forKey: Preferences.timerScreen)
        UserDefaults.standard.set(true, forKey: ProgressOptions.showStreaks)
        let persistence = Persistence.inMemory()
        let store = HabitStore(repository: persistence.repository)
        await store.load(); await WidgetFixture.install(in: store)
        let now = Date.now, day = store.today(now: now)
        func habit(_ name: String) -> Habit { store.habits.first { $0.name == name }! }
        func snap() -> WidgetSnapshot { store.widgetSnapshot(now: now) }
        func row(_ name: String, _ frame: Int = 0) -> WidgetItem { snap().frames[frame].items.first { $0.name == name }! }
        func names(_ key: String, _ s: WidgetSnapshot? = nil) -> [String] { (s ?? snap()).frames[0].list(key, at: now).map(\.name) }

        // MARK: The snapshot

        var snapshot = snap()
        expect(snapshot.version == 2 && snapshot.frames.count == 7, "Seven logical days precomputed")
        expect(zip(snapshot.frames, snapshot.frames.dropFirst()).allSatisfy { $0.end == $1.start }, "Days follow each other with no gap")
        expect(snapshot.sections.map(\.id) == store.todayCards, "Sections in Today's card order: \(snapshot.sections.map(\.id))")
        expect(snapshot.sections.first { $0.id == .quittingCard }?.name == "Quit or Cut Down", "Quit or Cut Down is a section")
        expect(!snapshot.taskSections.contains { $0.id == .quittingCard }, "Tasks have no Quit or Cut Down section")
        expect(snapshot.choices.count == 7 && !snapshot.choices.contains { $0.name.hasPrefix("Widget task") },
               "Edit Widget offers habits only, in the person's order")
        expect(snapshot.choices.map(\.name) == store.habits.filter { $0.kind != .task }.map(\.name), "Habit choices keep the person's order")
        expect(snapshot.weekdays.count == 7, "Seven day names")
        expect(snapshot.frames[0].items.filter(\.isTask).count == 7, "Every task survives the snapshot")

        // MARK: Lists: habits and tasks apart, Today's order (U13)

        expect(!names("habits").contains { $0.hasPrefix("Widget task") }, "The habit list never shows tasks (C040: wrong content)")
        expect(names("tasks").allSatisfy { $0.hasPrefix("Widget task") } && names("tasks").count == 7, "The task list shows only tasks")
        expect(names("habits") == ["Widget cut down", "Widget quit", "Widget water", "Widget check", "Widget timer", "Widget steps", "Widget routine"],
               "Today follows the cards and the person's order: \(names("habits"))")
        expect(names("habits:morning") == ["Widget check", "Widget timer"], "A section lists only its own habits")
        expect(names("habits:quitting") == ["Widget cut down", "Widget quit"], "Quit or Cut Down holds quit habits and limits")
        expect(names("tasks:anytime").count == 7 && snapshot.frames[0].lists["tasks:quitting"] == nil, "Tasks by section")
        store.moveCard(.anytime, .bottom); await store.flush()
        expect(names("habits").first == "Widget cut down" && names("habits").last == "Widget water",
               "Moving Anytime to the bottom moves it on the widget: \(names("habits"))")
        expect(snap().sections.map(\.id) == store.todayCards, "The sections follow a card move")
        store.moveCard(.anytime, .top); store.moveCard(.quittingCard, .top); await store.flush()
        store.reorder([habit("Widget timer").id, habit("Widget check").id]); await store.flush()
        expect(names("habits:morning") == ["Widget timer", "Widget check"], "Reordering in the app reorders the widget: \(names("habits:morning"))")
        store.reorder([habit("Widget check").id, habit("Widget timer").id]); await store.flush()
        let both = Habit(name: "Widget both", symbol: "sun.max.fill", color: .yellow, kind: .check, parts: [.morning, .evening],
                         startsOn: day.adding(days: -3, calendar: store.calendar))
        store.add(both); await store.flush()
        expect(names("habits:morning").contains("Widget both") && names("habits:evening").contains("Widget both")
               && names("habits").filter { $0 == "Widget both" }.count == 1, "A habit in two sections shows in each, and once in Today")
        store.delete([both]); await store.flush()

        // MARK: Words, numbers and the button for every type (Implementation Spec §3)

        let water = habit("Widget water")
        store.addProgress(water, value: 3, on: day); await store.flush()
        var w = row("Widget water")
        expect(w.value == "3 of 8 glasses" && w.line == "3 of 8 glasses" && w.todayLine == "Anytime · 3 of 8 glasses",
               "Amount reads \"3 of 8 glasses\": \(w.value) / \(w.todayLine)")
        expect(w.action == .add && w.actionText == "+1" && !w.done && w.fraction == 3.0 / 8, "Saved +1 adds; the row fills 3/8")
        expect(w.big == "3" && w.goal == "/ 8 glasses" && w.lock == "3/8" && w.ring == 3.0 / 8, "Weekly card and Lock Screen values")
        store.addProgress(water, value: 6, on: day); await store.flush()
        w = row("Widget water")
        expect(w.value == "9 of 8 glasses" && w.done && w.action == .add && w.actionText == "+1",
               "Above the goal: the true value, the habit's colour, and +1 still adds")
        expect(w.countsDone && w.counts, "A met goal counts as done")

        let check = habit("Widget check")
        var c = row("Widget check")
        expect(c.action == .check && c.line == "Not yet" && c.value == "Not checked" && c.lock == nil && !c.done, "A single check: ✓, Not yet")
        let checkEvent = UUID(), checkSignature = HabitStore.widgetSignature(check)
        store.logFromWidget(id: check.id, day: day, event: checkEvent, signature: checkSignature, mode: "check", now: now)
        store.logFromWidget(id: check.id, day: day, event: checkEvent, signature: checkSignature, mode: "check", now: now)
        store.logFromWidget(id: check.id, day: day, event: UUID(), signature: checkSignature, mode: "check", now: now)
        await store.flush()
        expect(store.dayProgress(of: check, on: day) == 1 && store.entries(of: check.id).first?.source == .widget,
               "✓ logs once however often the callback repeats, recorded as a widget log")
        c = row("Widget check")
        expect(c.done && c.line == "Done" && c.action == .check, "Done check: the habit's colour, ✓ can take it back")
        expect(WidgetLogIntent(item: c, day: day.key).mode == "uncheck", "A done ✓'s button unchecks that day (U14)")
        let uncheck = UUID()
        store.logFromWidget(id: check.id, day: day, event: uncheck, signature: checkSignature, mode: "uncheck", now: now)
        store.logFromWidget(id: check.id, day: day, event: uncheck, signature: checkSignature, mode: "uncheck", now: now)
        await store.flush()
        expect(store.dayProgress(of: check, on: day) == 0, "Uncheck takes back that day's tick, and a retried uncheck does nothing more")
        store.logFromWidget(id: check.id, day: day, event: checkEvent, signature: checkSignature, mode: "check", now: now); await store.flush()
        expect(store.dayProgress(of: check, on: day) == 0, "A replayed old ✓ after Undo never comes back (tombstone)")
        store.problem = nil

        let steps = row("Widget steps")
        expect(steps.action == .open && steps.route == "oftenenough://log/\(habit("Widget steps").id.uuidString)",
               "An amount with no saved step opens its amount entry directly")
        expect(steps.value == "0 of 8k steps", "Steps read \"0 of 8k steps\": \(steps.value)")
        store.logFromWidget(id: habit("Widget steps").id, day: day, event: UUID(), signature: HabitStore.widgetSignature(habit("Widget steps")),
                            mode: "add", now: now)
        await store.flush()
        expect(store.dayProgress(of: habit("Widget steps"), on: day) == 0, "Steps are never made up by a widget tap")
        store.problem = nil

        let timer = habit("Widget timer")
        var t = row("Widget timer")
        expect(t.action == .open && t.route == "oftenenough://timer/\(timer.id.uuidString)?start=1",
               "▶ opens the full-screen timer when Open Timer Full Screen is on")
        UserDefaults.standard.set(false, forKey: Preferences.timerScreen)
        t = row("Widget timer")
        expect(t.action == .timerStart, "▶ starts the timer in place when Open Timer Full Screen is off")
        expect(store.timerFromWidget(id: timer.id, day: day, start: true, signature: HabitStore.widgetSignature(timer), now: now)
               && store.timers[timer.id] != nil, "▶ from a widget starts the timer (and its Live Activity)")
        store.timerFromWidget(id: timer.id, day: day, start: true, signature: HabitStore.widgetSignature(timer), now: now)
        expect(store.timers[timer.id] != nil, "A repeated ▶ never stops it")
        t = row("Widget timer")
        expect(t.action == .timerPause && t.timerClock != nil && t.timerGoalAt != nil && !t.done, "Running: ⏸, a live clock, neutral")
        expect(WidgetTimerIntent(item: t, day: day.key).start == false, "The running timer's button pauses")
        // A session of a second or more is saved (shorter ones aren't a log).
        try? await Task.sleep(for: .seconds(1.2))
        store.timerFromWidget(id: timer.id, day: day, start: false, signature: HabitStore.widgetSignature(timer), now: now)
        store.timerFromWidget(id: timer.id, day: day, start: false, signature: HabitStore.widgetSignature(timer), now: now)
        await store.flush()
        expect(store.timers[timer.id] == nil && store.entries(of: timer.id).count == 1, "⏸ saves the session once, a repeat saves nothing")
        UserDefaults.standard.set(true, forKey: Preferences.timerScreen)
        expect(row("Widget timer").value.hasSuffix("of 10 min"), "Minutes read \"2 of 10 min\": \(row("Widget timer").value)")

        let routine = row("Widget routine")
        expect(routine.action == .open && routine.route == routine.url.absoluteString && routine.value == "0 of 3 steps",
               "A checklist opens its named steps; never a guessed step")

        let quit = row("Widget quit")
        expect(quit.action == .open && quit.route == "oftenenough://slip/\(habit("Widget quit").id.uuidString)",
               "Quit: the button opens Record a slip (never logged by a tap, C090)")
        expect(quit.quitStart != nil && quit.since?.hasPrefix("Since ") == true && !quit.counts && !quit.done, "Quit: live run, Since, not counted")
        expect(["39d", "40d"].contains(quit.lock ?? ""), "Lock Screen quit shows days: \(quit.lock ?? "nil")")
        expect(quit.quitBest == nil && WidgetLive.quitLine(quit, at: now) == "Quitting", "No earlier run: \"Quitting\", never a zero")

        let cut = habit("Widget cut down")
        var limit = row("Widget cut down")
        expect(limit.limit && limit.limitFill && limit.caption == "Daily limit" && limit.value == "0 of 3 cups max" && limit.ring == nil,
               "Cut down: neutral, \"max\", Daily limit, no ring")
        for _ in 0..<3 { store.logFromWidget(id: cut.id, day: day, event: UUID(), signature: HabitStore.widgetSignature(cut), now: now) }
        await store.flush()
        limit = row("Widget cut down")
        expect(limit.caption == "Limit reached" && !limit.done && limit.action == .add, "At the limit: Limit reached, never celebrated")
        store.logFromWidget(id: cut.id, day: day, event: UUID(), signature: HabitStore.widgetSignature(cut), now: now); await store.flush()
        limit = row("Widget cut down")
        expect(limit.caption == "Over the limit" && limit.value == "4 of 3 cups max" && limit.line.hasSuffix("· Over the limit")
               && store.dayProgress(of: cut, on: day) == 4, "Over: the true amount, still logged, no red or shame words")
        expect(!limit.counts, "A limit is never \"left\" to do")

        let weekly = Habit(name: "Widget weekly", symbol: "star.fill", color: .pink, kind: .check, frequency: .perWeek(3),
                           startsOn: day.adding(days: -10, calendar: store.calendar))
        store.add(weekly); await store.flush()
        store.logFromWidget(id: weekly.id, day: day, event: UUID(), signature: HabitStore.widgetSignature(weekly), mode: "add", now: now)
        await store.flush()
        let wk = row("Widget weekly")
        expect(wk.action == .add && wk.actionText == "+1" && wk.fraction == nil && wk.cardFraction == 1.0 / 3,
               "A week goal: +1, no row fill, the card fills toward the week")
        expect(wk.line == "1 today · 3 a week" && wk.value == "1 of 3 times", "Week goal words: \(wk.line) / \(wk.value)")
        expect(!wk.done && wk.countsDone, "One tick doesn't finish a week goal's button, but counts today as done (U14)")

        // MARK: Done rows sink after the pause; a run of taps moves nothing (U4, U13)

        store.logFromWidget(id: check.id, day: day, event: UUID(), signature: checkSignature, mode: "check", now: now); await store.flush()
        expect(names("habits:morning") == ["Widget timer", "Widget check"], "A done habit sinks below the rest of its section")
        UserDefaults.standard.set(DoneOrder.inPlace.rawValue, forKey: Preferences.doneOrder)
        expect(names("habits:morning") == ["Widget check", "Widget timer"], "Stay in Place keeps done habits where they are")
        UserDefaults.standard.set(DoneOrder.bottom.rawValue, forKey: Preferences.doneOrder)
        store.logFromWidget(id: check.id, day: day, event: UUID(), signature: checkSignature, mode: "uncheck", now: now); await store.flush()
        let before = store.widgetSnapshot(now: now)
        store.logFromWidget(id: check.id, day: day, event: UUID(), signature: checkSignature, mode: "check", now: now); await store.flush()
        let held = store.widgetSnapshot(now: now, previous: before, hold: now.addingTimeInterval(1.5))
        expect(held.frames[0].list("habits:morning", at: now).map(\.name) == ["Widget check", "Widget timer"],
               "Right after a widget tap the rows stay where they were")
        expect(held.frames[0].list("habits:morning", at: now.addingTimeInterval(2)).map(\.name) == ["Widget timer", "Widget check"],
               "After the pause the done row sinks")
        let entries = PhoneWidgetTimeline.entries(snapshot: held, now: now, listKey: "habits:morning") { _ in }
        expect(entries.contains { abs($0.date.timeIntervalSince(now.addingTimeInterval(1.5))) < 0.01 }, "The timeline redraws when the rows settle")

        // MARK: Counts ("2 of 5 done") match Today's day bar (U10)

        let today = snap().frames[0].list("habits", at: now)
        let counted = today.filter(\.counts)
        let summary = store.daySummary(on: day)
        let tasksDone = store.habits.filter { $0.kind == .task && store.isDone($0, on: day) }.count
        let tasksAll = store.habits.filter { $0.kind == .task && store.isDue($0, on: day) }.count
        expect(counted.count == summary.total - tasksAll && counted.filter(\.countsDone).count == summary.done - tasksDone,
               "The habit list's count is the day bar's (habits only): \(counted.count) vs \(summary.total - tasksAll)")
        expect(!counted.contains { $0.type == "quit" || $0.limit }, "Quit and cut down are never counted as left (C040: false \"all done\")")

        // MARK: Tasks

        let task = habit("Widget task 1")
        var taskRow = row("Widget task 1")
        expect(taskRow.action == .check && taskRow.todayLine == "Anytime" && taskRow.line.isEmpty && taskRow.streak == nil && taskRow.week.isEmpty,
               "A task: ✓, its section, no statistics")
        store.logFromWidget(id: task.id, day: day, event: UUID(), signature: HabitStore.widgetSignature(task), mode: "check", now: now)
        await store.flush()
        taskRow = row("Widget task 1")
        expect(taskRow.done && store.isDone(task, on: day) && names("tasks").last == "Widget task 1", "A done task: tinted, sinks to the end")
        store.logFromWidget(id: task.id, day: day, event: UUID(), signature: HabitStore.widgetSignature(task), mode: "uncheck", now: now)
        await store.flush()
        expect(!store.isDone(task, on: day), "A task's ✓ can be taken back")
        var timed = Habit(name: "Widget timed task", symbol: "phone.fill", color: .green, kind: .task, parts: [.afternoon], dueDay: day,
                          dueMinute: 17 * 60, startsOn: day)
        store.add(timed); await store.flush()
        expect(row("Widget timed task").todayLine == "Afternoon · " + DaySection.clock(17 * 60), "A task's time follows its section")
        timed.dueDay = day.adding(days: -2, calendar: store.calendar)
        timed.startsOn = timed.dueDay
        store.update(timed); await store.flush()
        expect(row("Widget timed task").todayLine.hasPrefix("From "), "A carried-over task says where it came from")
        store.delete([timed]); await store.flush()

        // MARK: Neutral days, the week and the streak

        let skipped = habit("Widget routine")
        store.setSkipped(skipped, on: day, true); await store.flush()
        let sr = row("Widget routine")
        expect(sr.state == "skipped" && sr.action == .open && sr.route == sr.url.absoluteString && !sr.counts && sr.sinks
               && names("habits:evening") == ["Widget routine"], "Skipped: stays, neutral, opens Day details, not counted")
        store.setSkipped(skipped, on: day, false); await store.flush()
        store.pause(water, from: day, through: nil, now: now); await store.flush()
        let pr = row("Widget water")
        expect(pr.state == "paused" && pr.value == "Paused" && pr.action == .open && !names("habits").contains("Widget water"),
               "Paused: off the lists, Paused on its own widget, opens Day details")
        store.logFromWidget(id: water.id, day: day, event: UUID(), signature: HabitStore.widgetSignature(water), now: now); await store.flush()
        expect(store.dayProgress(of: water, on: day) == 9, "A paused habit rejects an old widget tap")
        store.problem = nil
        store.resume(water, now: now); await store.flush()

        let streaky = Habit(name: "Widget streak", symbol: "flame", color: .red, kind: .check, startsOn: day.adding(days: -5, calendar: store.calendar))
        store.add(streaky); await store.flush()
        for back in 1...3 { store.toggleCheck(streaky, on: day.adding(days: -back, calendar: store.calendar)) }
        await store.flush()
        expect(row("Widget streak").streak == "3", "Streak: \(row("Widget streak").streak ?? "nil")")
        store.toggleCheck(streaky, on: day); await store.flush()
        let sw = row("Widget streak")
        expect(sw.streak == "4" && sw.week.count == 7 && sw.weekToday >= 0 && sw.weekToday < 7 && sw.week[sw.weekToday] == 4,
               "The week's squares: today ✓ in its place")
        expect(sw.heat.count == 11, "The habit's heat colours travel with it")
        UserDefaults.standard.set(false, forKey: ProgressOptions.showStreaks)
        expect(row("Widget streak").streak == nil, "Hidden streaks stay hidden on widgets")
        UserDefaults.standard.set(true, forKey: ProgressOptions.showStreaks)
        let oldStart = store.settings.weekStart
        store.setWeekStart(2); await store.flush()
        expect(snap().weekdays.first == store.weekColumns(store.period(.week, containing: day), today: day).first?.short
               && store.period(.week, containing: day).lowerBound.weekday(calendar: store.calendar) == 2,
               "The week follows the person's week start (C040: widget ignored the week start)")
        store.setWeekStart(oldStart); await store.flush()

        // MARK: Days: a tap from yesterday, tomorrow's frame, the day start (D7)

        let stale = store.dayProgress(of: water, on: day)
        store.logFromWidget(id: water.id, day: day.adding(days: -1, calendar: store.calendar), event: UUID(),
                            signature: HabitStore.widgetSignature(water), now: now)
        await store.flush()
        expect(store.dayProgress(of: water, on: day) == stale && store.problem != nil, "Yesterday's button never logs into today")
        store.problem = nil
        expect(row("Widget water", 1).value == "0 of 8 glasses" && row("Widget water", 1).fraction == 0,
               "Tomorrow starts at zero (C040: stuck on yesterday's numbers)")
        var edited = water; edited.goal = 10; store.update(edited); await store.flush()
        store.logFromWidget(id: water.id, day: day, event: UUID(), signature: HabitStore.widgetSignature(water), now: now); await store.flush()
        expect(store.dayProgress(of: edited, on: day) == stale && store.problem != nil, "A button drawn before an edit is refused")
        store.problem = nil
        expect(row("Widget water").value == "9 of 10 glasses", "The edit shows at once: \(row("Widget water").value)")
        do {
            var calendar = Calendar(identifier: .gregorian); calendar.timeZone = TimeZone(identifier: "America/New_York")!
            let late = HabitStore(repository: Persistence.inMemory().repository, calendar: calendar)
            await late.load()
            late.setDayEnd(3); await late.flush()
            let lateDay = LocalDay(year: 2026, month: 10, day: 6)
            let oneThirty = calendar.date(from: DateComponents(year: 2026, month: 10, day: 7, hour: 1, minute: 30))!
            late.add(Habit(name: "Late", symbol: "moon", color: .blue, kind: .check, startsOn: lateDay)); await late.flush()
            let s = late.widgetSnapshot(now: oneThirty)
            expect(s.frames[0].day == lateDay.key && s.frames[0].items.contains { $0.name == "Late" },
                   "At 1:30 AM before a 3 AM day start, the widget still shows the evening's day")
            let lateHabit = late.habits.first { $0.name == "Late" }!
            late.logFromWidget(id: lateHabit.id, day: lateDay, event: UUID(), signature: HabitStore.widgetSignature(lateHabit),
                               mode: "check", now: oneThirty)
            await late.flush()
            expect(late.isDone(lateHabit, on: lateDay), "A tap after midnight, before the day start, logs the evening's day")
            for (month, date) in [(3, 8), (11, 1)] {
                let dst = LocalDay(year: 2026, month: month, day: date)
                let bounds = late.dayBounds(dst)
                expect(calendar.component(.hour, from: bounds.lowerBound) == 3, "Day boundaries stay at 03:00 across DST \(month)")
            }
        }

        // MARK: Configuration: a removed section, an archived or deleted habit (C040: widgets losing their choice)

        store.saveSections(store.sections.filter { $0.id != .evening }); await store.flush()
        snapshot = snap()
        expect(!snapshot.sections.contains { $0.id == .evening } && snapshot.frames[0].lists["habits:evening"] == nil,
               "A removed section is gone (the widget says Section unavailable, never another section)")
        expect(names("habits:anytime").contains("Widget routine"), "Its habits move to Anytime, as on Today")
        let archived = habit("Widget streak")
        store.archive([archived]); await store.flush()
        expect(snap().frames[0].item(archived.id.uuidString) == nil && !snap().choices.contains { $0.id == archived.id.uuidString },
               "An archived habit leaves the widgets (its widget says Habit unavailable)")
        let archivedCount = store.entries(of: archived.id).count
        store.logFromWidget(id: archived.id, day: day, event: UUID(), signature: HabitStore.widgetSignature(archived), mode: "uncheck", now: now)
        await store.flush()
        expect(store.entries(of: archived.id).count == archivedCount && store.problem != nil, "An archived habit can't be changed from an old widget")
        store.problem = nil
        let gone = habit("Widget weekly")
        store.delete([gone]); await store.flush()
        store.logFromWidget(id: gone.id, day: day, event: UUID(), signature: HabitStore.widgetSignature(gone), now: now); await store.flush()
        expect(!store.habits.contains { $0.id == gone.id } && snap().frames[0].item(gone.id.uuidString) == nil,
               "A deleted habit is never revived or shown (C040: deleted task still shown)")
        store.problem = nil

        // MARK: Privacy

        UserDefaults.standard.set(true, forKey: WidgetDisk.privacyKey)
        store.logFromWidget(id: cut.id, day: day, event: UUID(), signature: HabitStore.widgetSignature(cut), now: now); await store.flush()
        expect(store.dayProgress(of: cut, on: day) == 4, "Hide widget content turns widget logging off")
        UserDefaults.standard.removeObject(forKey: WidgetDisk.privacyKey); store.problem = nil
        let hidden = store.widgetSnapshot(now: now, hidden: true)
        expect(hidden.hidden && hidden.frames.allSatisfy { $0.items.isEmpty && $0.lists.isEmpty } && hidden.sections.isEmpty && hidden.choices.isEmpty,
               "A private snapshot holds no names, sections or progress")
        let hiddenEntries = PhoneWidgetTimeline.entries(snapshot: hidden, now: now, listKey: "habits") { _ in }
        expect(hiddenEntries.count == 1 && hiddenEntries[0].status == .hidden, "Every widget shows Content hidden")

        // MARK: Pages (Implementation Spec §5)

        expect(WidgetPaging.pages(5, capacity: 5) == 1 && WidgetPaging.pages(6, capacity: 5) == 2 && WidgetPaging.pages(12, capacity: 5) == 3
               && WidgetPaging.pages(16, capacity: 5) == 4 && WidgetPaging.pages(5, capacity: 2) == 3 && WidgetPaging.pages(0, capacity: 2) == 1,
               "Large five a page, Medium two")
        expect(WidgetPaging.slice(Array(1...12), page: 2, capacity: 5) == [11, 12], "12 = 5 + 5 + 2")
        expect(WidgetPaging.slice(Array(1...6), page: 9, capacity: 5) == [6], "A page past the end shows the last page, never an empty one")
        expect(WidgetPaging.clamp(-3, count: 6, capacity: 5) == 0, "No page before the first")
        let pagingKey = "widget-check." + UUID().uuidString
        expect(WidgetDisk.page(key: pagingKey, set: 100_001) == 100_000 && WidgetDisk.page(key: pagingKey, set: -1) == 0,
               "Stored pages are clamped")
        let other = "widget-check." + UUID().uuidString
        _ = WidgetDisk.page(key: pagingKey, set: 2); _ = WidgetDisk.page(key: other, set: 1)
        expect(WidgetDisk.page(key: pagingKey) == 2 && WidgetDisk.page(key: other) == 1, "Two lists keep their own pages")

        // MARK: Links open exactly what the button names

        let router = AppModel.shared.router
        let id = UUID()
        HabitsApp.route(URL(string: "oftenenough://log/" + id.uuidString)!, model: .shared)
        expect(router.widgetSheet == WidgetSheet(kind: .log, habit: id), "log/<id> opens the amount entry")
        HabitsApp.route(URL(string: "oftenenough://slip/" + id.uuidString)!, model: .shared)
        expect(router.widgetSheet == WidgetSheet(kind: .slip, habit: id), "slip/<id> opens Record a slip")
        router.widgetSheet = nil
        HabitsApp.route(URL(string: "oftenenough://timer/\(id.uuidString)?start=1")!, model: .shared)
        expect(router.timerHabit == id && router.startTimer, "timer/<id>?start=1 starts the timer and opens it")
        router.timerHabit = nil; router.startTimer = false
        HabitsApp.route(URL(string: "oftenenough://section/morning")!, model: .shared)
        expect(router.focusSection == "morning", "section/<id> opens that section")
        router.focusSection = nil; router.widgetToday = false
        HabitsApp.route(URL(string: "oftenenough://widgets")!, model: .shared)
        expect(router.widgetSetup, "Choose a habit opens the Widgets guide")
        router.widgetSetup = false

        // MARK: The file on disk and the timeline (C040: blank, stale or broken widgets)

        let directory = FileManager.default.temporaryDirectory.appendingPathComponent("WidgetCheck-" + UUID().uuidString)
        defer { try? FileManager.default.removeItem(at: directory) }
        let file = directory.appendingPathComponent("snapshot.json")
        snapshot = snap()
        do {
            try WidgetDisk.write(snapshot, to: file)
            let read = WidgetDisk.read(from: file)
            expect(read?.frames.first?.items.count == snapshot.frames.first?.items.count
                   && read?.frames.first?.lists == snapshot.frames.first?.lists, "Atomic disk round trip keeps every list")
            try Data("{".utf8).write(to: file, options: .atomic)
            expect(WidgetDisk.read(from: file) == nil, "A corrupt file asks the app to update, never draws a blank")
            var future = snapshot; future.version = 999
            expect(WidgetDisk.decode(try JSONEncoder().encode(future)) == nil, "An unknown version is refused")
            var invalid = snapshot; invalid.frames[0].items[0].id = "invalid\nitem"
            expect(WidgetDisk.decode(try JSONEncoder().encode(invalid)) == nil, "A malformed ID is refused")
            var duplicate = snapshot; duplicate.frames[0].items.append(duplicate.frames[0].items[0])
            expect(WidgetDisk.decode(try JSONEncoder().encode(duplicate)) == nil, "Duplicate rows are refused")
            var badAction = snapshot
            if let i = badAction.frames[0].items.firstIndex(where: { $0.action == .add }) { badAction.frames[0].items[i].token = "x" }
            expect(WidgetDisk.decode(try JSONEncoder().encode(badAction)) == nil, "A malformed tap event is refused")
            var dangling = snapshot; dangling.frames[0].lists["habits"]?.append(UUID().uuidString)
            expect(WidgetDisk.decode(try JSONEncoder().encode(dangling)) == nil, "A list naming a missing row is refused")
        } catch { failures.append("Disk round trip: \(error)") }
        expect(WidgetDisk.decode(Data(repeating: 0, count: WidgetDisk.maximumBytes + 1)) == nil, "An oversized file is refused")
        expect(snapshot.frame(at: now, timeZone: "invalid") == nil, "Travel to another time zone asks the app to update")
        expect(snapshot.frame(at: now, locale: "invalid") == nil, "A new language asks the app to update")
        expect(snapshot.frame(at: snapshot.frames.last!.end) == nil, "After the seven days, old numbers are never shown")
        let timeline = PhoneWidgetTimeline.entries(snapshot: snapshot, now: now, listKey: "habits") { _ in }
        expect(zip(timeline, timeline.dropFirst()).allSatisfy { $0.date < $1.date }, "Timeline dates strictly increase")
        expect(timeline.last?.status == .stale && timeline.filter { $0.frame != nil }.count >= 7, "Each day has an entry, then Open to update")
        let quitID = habit("Widget quit").id.uuidString
        let later = now.addingTimeInterval(30 * 86_400)
        let counter = PhoneWidgetTimeline.entries(snapshot: snapshot, now: later, selection: quitID) { _ in }
        expect(counter.first?.selected?.quitStart != nil, "A quit counter keeps counting after the seven days")
        var bounded = snapshot
        for i in bounded.frames.indices {
            if let j = bounded.frames[i].items.firstIndex(where: { $0.id == quitID }) {
                bounded.frames[i].items[j].quitUntil = now.addingTimeInterval(10 * 86_400)
            }
        }
        expect(PhoneWidgetTimeline.entries(snapshot: bounded, now: later, selection: quitID) { _ in }.first?.selected == nil,
               "A known pause or end stops the extended counter")
        UserDefaults.standard.set(false, forKey: Preferences.timerScreen)
        store.timerFromWidget(id: timer.id, day: day, start: true, signature: HabitStore.widgetSignature(timer), now: now)
        let runningSnapshot = store.widgetSnapshot(now: now)
        let running = PhoneWidgetTimeline.entries(snapshot: runningSnapshot, now: now, selection: timer.id.uuidString) { _ in }
        // Each minute for half an hour, or up to the day's end if that comes first (T11: any time of day).
        let minutesLeft = min(30, Int(runningSnapshot.frames[0].end.timeIntervalSince(now) / 60))
        expect(running.filter { $0.date > now && $0.date < now.addingTimeInterval(31 * 60) }.count >= minutesLeft,
               "A running timer's fill moves each minute")
        store.timerFromWidget(id: timer.id, day: day, start: false, signature: HabitStore.widgetSignature(timer), now: now)
        await store.flush()
        UserDefaults.standard.set(true, forKey: Preferences.timerScreen)

        // MARK: Durable writes, publication and failure (D rules)

        let cold = HabitStore(repository: persistence.repository); await cold.load()
        let persistedWater = cold.habits.first { $0.id == water.id }!
        expect(HabitStore.widgetSignature(persistedWater) == HabitStore.widgetSignature(habit("Widget water")),
               "Database precision preserves the button's signature")
        let coldEvent = UUID()
        cold.logFromWidget(id: water.id, day: day, event: coldEvent, signature: HabitStore.widgetSignature(persistedWater), now: now)
        cold.logFromWidget(id: water.id, day: day, event: coldEvent, signature: HabitStore.widgetSignature(persistedWater), now: now)
        await cold.flush()
        expect(cold.problem == nil && cold.entries(of: water.id).filter { $0.id == coldEvent }.count == 1,
               "A tap after a cold start logs exactly once")
        for _ in 0..<3 { cold.logFromWidget(id: water.id, day: day, event: UUID(), signature: HabitStore.widgetSignature(persistedWater), now: now) }
        cold.addProgress(persistedWater, value: 1, on: day, source: .today)
        await cold.flush()
        expect(cold.entries(of: water.id).filter { $0.day == day }.count == store.entries(of: water.id).filter { $0.day == day }.count + 5,
               "Widget and app taps together keep every entry")
        let missing = HabitStore(repository: Persistence.inMemory().repository, databaseOpened: false)
        await missing.load()
        missing.logFromWidget(id: cut.id, day: day, event: UUID(), signature: HabitStore.widgetSignature(cut), now: now); await missing.flush()
        expect(missing.entries.isEmpty && !missing.isStorageReady, "A database that didn't open can't log")
        do {
            try WidgetDisk.write(snapshot, to: file)
            let publisher = WidgetPublisher(file: file)
            await publisher.publish(missing)
            expect(WidgetDisk.read(from: file)?.generated == snapshot.generated, "An unread database keeps the last good widgets")
            let failed = WidgetPublisher(file: directory)
            await failed.publish(store)
            expect(failed.problem != nil, "A failed publication is shown and can be retried")
            let holding = WidgetPublisher(file: file)
            await holding.publish(store)
            await holding.publish(store, hold: true)
            expect(WidgetDisk.read(from: file)?.frames.first?.settle != nil, "A widget tap's publication holds the rows")
        } catch { failures.append("Publication fixture: \(error)") }
        do {
            let errorFile = directory.appendingPathComponent("ordered-publication-error.json")
            let publisher = WidgetPublisher(file: errorFile)
            let earlier = Task { await publisher.publish(store) }
            for _ in 0..<100 {
                if FileManager.default.fileExists(atPath: errorFile.path) { break }
                try? await Task.sleep(for: .milliseconds(5))
            }
            try FileManager.default.removeItem(at: errorFile)
            try FileManager.default.createDirectory(at: errorFile, withIntermediateDirectories: true)
            await publisher.publish(store)
            await earlier.value
            expect(publisher.problem != nil, "An older publication never clears a newer error")
        } catch { failures.append("Publication ordering fixture: \(error)") }
        let shared = WidgetPublisher()
        await shared.publish(store)
        expect(shared.problem == nil && WidgetDisk.read()?.frames.first?.items.count == store.habits.filter { !$0.archived }.count,
               "The app's App Group holds a readable snapshot")
        do {
            let racing = HabitStore(repository: Persistence.inMemory().repository)
            await racing.load(); await WidgetFixture.install(in: racing)
            let visible = WidgetPublisher(file: file)
            let older = Task { await visible.publish(racing) }
            await Task.yield()
            UserDefaults.standard.set(true, forKey: WidgetDisk.privacyKey)
            await WidgetPublisher(file: file).publish(racing)
            await older.value
            let privateSnapshot = WidgetDisk.read(from: file)
            expect(privateSnapshot?.hidden == true && privateSnapshot?.frames.allSatisfy { $0.items.isEmpty } == true,
                   "Turning privacy on mid-publication never republishes names")
            UserDefaults.standard.removeObject(forKey: WidgetDisk.privacyKey)
            let preserved = privateSnapshot?.generated
            let cancelled = Task { await visible.publish(racing) }
            cancelled.cancel(); await cancelled.value
            expect(WidgetDisk.read(from: file)?.generated == preserved, "A cancelled publication keeps the last snapshot")
        }
        let failingPersistence = Persistence.inMemory()
        let failing = HabitStore(repository: failingPersistence.repository)
        await failing.load(); await WidgetFixture.install(in: failing)
        let failedHabit = failing.habits.first { $0.name == "Widget water" }!
        do {
            let prior = failing.widgetSnapshot(now: now)
            try WidgetDisk.write(prior, to: file)
            try failingPersistence.repository.close()
            failing.logFromWidget(id: failedHabit.id, day: failing.today(now: now), event: UUID(),
                                  signature: HabitStore.widgetSignature(failedHabit), now: now)
            await failing.flush()
            expect(failing.problem != nil && failing.entries.isEmpty, "A failed write never shows a widget log as saved")
            await WidgetPublisher(file: file).publish(failing)
            expect(WidgetDisk.read(from: file)?.generated == prior.generated, "A failed write keeps the last durable widgets")
        } catch { failures.append("Failed-write fixture: \(error)") }
        return failures
    }
}

/// Uses exactly the views shipped in the extension, at iPhone widget sizes: a rendering test, not WidgetKit's host.
struct WidgetRenderCheck: View {
    @State private var frame: WidgetFrame?
    @State private var weekdays: [String] = []
    @State private var selected: String?
    @State private var family = WidgetFamily.systemSmall
    @State private var layout = PhoneWidgetLayout.item
    @State private var view = WidgetListSection.today
    @State private var viewName = "Today"
    @State private var page = 0
    @State private var status = PhoneWidgetEntry.Status.ready
    @State private var dark = false
    private let families: [WidgetFamily] = [.systemSmall, .systemMedium, .systemLarge, .accessoryInline, .accessoryCircular, .accessoryRectangular]
    var body: some View {
        VStack(spacing: 6) {
            ScrollView(.horizontal) {
                HStack { ForEach(families, id: \.rawValue) { value in
                    Button(String(describing: value)) { family = value }.accessibilityIdentifier("family-\(String(describing: value))")
                } }
            }
            HStack {
                ForEach(PhoneWidgetLayout.allCases, id: \.rawValue) { value in
                    Button(value.rawValue) { layout = value; page = 0 }.accessibilityIdentifier("layout-\(value.rawValue)")
                }
            }
            HStack {
                Button("Today") { view = WidgetListSection.today; viewName = layout == .tasks ? "Tasks" : "Today"; page = 0 }
                    .accessibilityIdentifier("view-today")
                Button("Morning") { view = .morning; viewName = layout == .tasks ? "Morning tasks" : "Morning"; page = 0 }
                    .accessibilityIdentifier("view-morning")
                Button("Next page") { page += 1 }.accessibilityIdentifier("render-next-page")
                Button("Hidden") { status = status == .hidden ? .ready : .hidden }.accessibilityIdentifier("render-hidden")
            }
            Toggle("Dark preview", isOn: $dark).accessibilityIdentifier("widget-dark")
            if let frame {
                ScrollView(.horizontal) { HStack { ForEach(frame.items.filter { !$0.isTask }) { item in
                    Button(item.name) { selected = item.id }.accessibilityIdentifier("select-\(item.name)")
                } } }
                PhoneWidgetView(entry: entry(frame), layout: layout, familyOverride: family)
                    .frame(width: size.width, height: size.height)
                    .background(Color(.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: [.accessoryInline, .accessoryCircular, .accessoryRectangular].contains(family) ? 8 : 22,
                                                style: .continuous))
                    .background(Color(.secondarySystemBackground))
                    .environment(\.colorScheme, dark ? .dark : .light)
                    .accessibilityElement(children: .contain)
                    .accessibilityIdentifier("widget-render")
            }
            Spacer()
        }.padding().task {
            await AppModel.shared.ensureLoaded()
            let snapshot = AppModel.shared.store.widgetSnapshot()
            frame = snapshot.frames.first; weekdays = snapshot.weekdays
            selected = frame?.items.first { !$0.isTask }?.id
        }
    }
    private func entry(_ frame: WidgetFrame) -> PhoneWidgetEntry {
        var entry = PhoneWidgetEntry(date: .now, frame: frame, status: status, selection: selected)
        entry.view = view; entry.viewName = viewName; entry.page = page; entry.weekdays = weekdays
        entry.pageKey = "render-check"
        return entry
    }
    private var size: CGSize {
        switch family {
        case .systemSmall: .init(width: 158, height: 158)
        case .systemMedium: .init(width: 338, height: 158)
        case .systemLarge: .init(width: 338, height: 354)
        case .accessoryInline: .init(width: 234, height: 26)
        case .accessoryCircular: .init(width: 72, height: 72)
        default: .init(width: 160, height: 72)
        }
    }
}
#endif
