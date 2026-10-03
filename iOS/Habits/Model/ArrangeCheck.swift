#if DEBUG
import Foundation

/// Arrange Your Day (3 Oct 2026): splitting times of day in every direction, Anytime and Quitting moving among the
/// times of day, the one-off sorts, and new habits going to the end. Run with `-arrangecheck`.
enum ArrangeCheck {
    static func run() async -> [String] {
        var failures: [String] = []
        func expect(_ value: Bool, _ name: String) { if !value { failures.append(name) } }
        func h(_ hour: Int, _ minute: Int = 0) -> Int { hour * 60 + minute }

        // The user's days: Morning 9–12, Afternoon 12–5 PM, Evening 5 PM–midnight.
        let day = [
            DaySection(id: .anytime, name: "Anytime", start: nil, end: nil),
            DaySection(id: .morning, name: "Morning", start: h(9), end: nil),
            DaySection(id: .afternoon, name: "Afternoon", start: h(12), end: nil),
            DaySection(id: .evening, name: "Evening", start: h(17), end: h(24)),
        ]
        func plan(_ start: Int, _ end: Int, editing: String? = nil, name: String = "Mid Morning", in sections: [DaySection]? = nil) -> SectionPlan {
            let list = sections ?? day
            let subject = editing.flatMap { id in list.first { $0.id == id } } ?? DaySection(id: "new", name: name, start: nil, end: nil)
            return SectionPlan.make(sections: list, subject: subject, start: start, end: end)
        }
        func ranges(_ plan: SectionPlan) -> [String] { plan.rows.map { "\($0.name) \($0.start)-\($0.end)" } }
        func check(_ plan: SectionPlan, _ expected: [String], split: Set<String>, _ name: String) {
            expect(plan.problem == nil, "\(name): no problem (got \(plan.problem ?? ""))")
            expect(ranges(plan) == expected, "\(name): \(ranges(plan)) should be \(expected)")
            expect(Set(plan.split.map(\.name)) == split, "\(name): splits \(plan.split.map(\.name)) should be \(split)")
            // What's saved reads back as the same day.
            let saved = plan.sections.filter { !$0.isAnytime }
            let back = saved.enumerated().map { i, s in "\(s.name) \(s.start!)-\(i + 1 < saved.count ? saved[i + 1].start! : (s.end ?? 24 * 60))" }
            expect(back == expected, "\(name): saved as \(back)")
        }

        // The user's two examples.
        check(plan(h(11), h(14)), ["Morning 540-660", "Mid Morning 660-840", "Afternoon 840-1020", "Evening 1020-1440"],
              split: ["Morning", "Afternoon"], "across Morning and Afternoon")
        check(plan(h(11), h(12)), ["Morning 540-660", "Mid Morning 660-720", "Afternoon 720-1020", "Evening 1020-1440"],
              split: ["Morning"], "the end of Morning")
        // Starting with Morning, ending inside it: Morning moves to start at the end.
        check(plan(h(9), h(10), name: "Early"), ["Early 540-600", "Morning 600-720", "Afternoon 720-1020", "Evening 1020-1440"],
              split: ["Morning"], "the start of Morning")
        // Starting before the first and ending inside it.
        check(plan(h(7), h(10), name: "Early"), ["Early 420-600", "Morning 600-720", "Afternoon 720-1020", "Evening 1020-1440"],
              split: ["Morning"], "before the first, into it")
        // Entirely before the first: nothing is split; it runs until Morning starts.
        check(plan(h(6), h(7), name: "Dawn"), ["Dawn 360-540", "Morning 540-720", "Afternoon 720-1020", "Evening 1020-1440"],
              split: [], "before the first")
        // Inside the latest, at its end: Evening ends where Night starts, Night keeps its own end.
        check(plan(h(22), h(24), name: "Night"), ["Morning 540-720", "Afternoon 720-1020", "Evening 1020-1320", "Night 1320-1440"],
              split: ["Evening"], "the end of the latest")
        // After the last, past midnight.
        check(plan(h(23), h(1), name: "Night"), ["Morning 540-720", "Afternoon 720-1020", "Evening 1020-1380", "Night 1380-1500"],
              split: ["Evening"], "across midnight")
        // Inside a middle section: it runs on until the next one starts.
        check(plan(h(13), h(14), name: "Lunch"), ["Morning 540-720", "Afternoon 720-780", "Lunch 780-1020", "Evening 1020-1440"],
              split: ["Afternoon"], "inside Afternoon")
        // Covering all of one: refused, nothing lost.
        let covering = plan(h(11), h(18))
        expect(covering.problem?.contains("Afternoon") == true, "covering Afternoon is refused: \(covering.problem ?? "nil")")
        // Changing a section's own times: Afternoon 12–5 becomes 1–5, so Morning runs until 1.
        check(plan(h(13), h(17), editing: .afternoon), ["Morning 540-780", "Afternoon 780-1020", "Evening 1020-1440"],
              split: ["Morning"], "Afternoon starts later")
        // The latest ends earlier: nothing else changes.
        check(plan(h(17), h(22), editing: .evening), ["Morning 540-720", "Afternoon 720-1020", "Evening 1020-1320"],
              split: [], "Evening ends earlier")
        // Evening starts earlier: Afternoon gives up its end.
        check(plan(h(16), h(24), editing: .evening), ["Morning 540-720", "Afternoon 720-960", "Evening 960-1440"],
              split: ["Afternoon"], "Evening starts earlier")
        // Renaming only changes nothing else.
        let renamed = SectionPlan.make(sections: day, subject: DaySection(id: .morning, name: "Mornings", start: nil, end: nil), start: h(9), end: h(12))
        expect(renamed.split.isEmpty && renamed.problem == nil, "renaming splits nothing")
        expect(DaySection.startsText(h(6)).hasPrefix("Starts "), "Starts text")

        // The store: Anytime and Quitting move; timed sections keep their time order.
        let persistence = Persistence.inMemory()
        let store = HabitStore(repository: persistence.repository)
        await store.load()
        expect(store.todayCards == [.quittingCard, .anytime, .morning, .afternoon, .evening], "default cards: \(store.todayCards)")
        store.moveCard(.anytime, .bottom); await store.flush()
        expect(store.todayCards == [.quittingCard, .morning, .afternoon, .evening, .anytime], "Anytime to the bottom: \(store.todayCards)")
        store.moveCard(.quittingCard, .down); await store.flush()
        expect(store.todayCards == [.morning, .quittingCard, .afternoon, .evening, .anytime], "Quitting down one: \(store.todayCards)")
        store.moveCard(.morning, .bottom); await store.flush()
        expect(store.todayCards == [.morning, .quittingCard, .afternoon, .evening, .anytime], "a timed section never moves by hand")
        // A new time of day takes its place by time, beside the one before it.
        let night = DaySection(id: "night", name: "Night", start: h(22), end: nil)
        store.saveSections(SectionPlan.make(sections: store.sections, subject: night, start: h(22), end: h(23)).sections)
        await store.flush()
        expect(store.todayCards == [.morning, .quittingCard, .afternoon, .evening, "night", .anytime], "Night after Evening: \(store.todayCards)")
        let reread = HabitStore(repository: persistence.repository)
        await reread.load()
        expect(reread.todayCards == store.todayCards, "the card order is saved")

        // Order: new habits and tasks at the end, whatever their reminders, in one order; sorts once.
        func add(_ name: String, _ kind: HabitKind = .check, at time: ReminderTime? = nil) async -> Habit {
            let habit = Habit(name: name, symbol: "star", color: .blue, kind: kind, parts: [.morning],
                              dueDay: kind == .task ? store.today() : nil, reminders: time.map { [$0] } ?? [], remind: time != nil)
            store.add(habit); await store.flush()
            return habit
        }
        _ = await add("Walk")
        _ = await add("Pay bill", .task)
        _ = await add("Read", at: ReminderTime(hour: 10, minute: 0))
        _ = await add("Coffee", at: ReminderTime(hour: 7, minute: 0))
        let names = { store.members(ofCard: .morning).map(\.name) }
        expect(names() == ["Walk", "Pay bill", "Read", "Coffee"], "new ones at the end, in the order added: \(names())")
        store.sortCard(.morning, by: .reminderTime); await store.flush()
        expect(names() == ["Coffee", "Read", "Walk", "Pay bill"], "sorted by reminder time once: \(names())")
        store.sortCard(.morning, by: .name); await store.flush()
        expect(names() == ["Coffee", "Pay bill", "Read", "Walk"], "A to Z: \(names())")
        let bike = await add("Bike")
        expect(names().last == bike.name, "a habit added after sorting goes to the end: \(names())")
        let moved = store.members(ofCard: .morning)
        store.reorder([moved[4].id, moved[1].id, moved[0].id, moved[2].id, moved[3].id]); await store.flush()
        expect(names() == ["Bike", "Pay bill", "Coffee", "Read", "Walk"], "dragging sets the order, a task among habits: \(names())")
        let again = HabitStore(repository: persistence.repository)
        await again.load()
        expect(again.members(ofCard: .morning).map(\.name) == names(), "the order is saved")
        return failures
    }
}
#endif
