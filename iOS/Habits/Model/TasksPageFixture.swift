#if DEBUG
import Foundation

/// `-tasks-page-fixture`: tasks shaped like Figma's Tasks page (999:1061), so every group shows: one carried from an
/// earlier day, today's (one with a time, one done), tomorrow's, one later this week, one next month; repeating ones
/// every day (one done today), every few days, every week and every month; one done yesterday (Completed) and one
/// archived. Test launches only (D8).
enum TasksPageFixture {
    static func install(in store: HabitStore) async {
        guard !store.habits.contains(where: { $0.name == "Call the dentist" }) else { return }
        let today = store.today(), calendar = store.calendar
        func day(_ n: Int) -> LocalDay { today.adding(days: n, calendar: calendar) }
        func task(_ name: String, _ symbol: String, _ color: HabitColor, due: LocalDay?, minute: Int? = nil,
                  part: String = .anytime, frequency: Frequency = .daily) -> Habit {
            var t = Habit(name: name, symbol: symbol, color: color, kind: .task, parts: [part], dueDay: due, remind: false)
            t.dueMinute = minute
            t.frequency = frequency
            t.createdAt = day(-30).date(calendar: calendar)
            if due == nil { t.startsOn = day(-30) }
            return t
        }
        let tasks: [(Habit, LocalDay?)] = [
            (task("Call the dentist", "phone.fill", .blue, due: day(-3)), nil),
            (task("Pay electricity bill", "bolt.fill", .yellow, due: today, part: .morning), nil),
            (task("Pick up dry cleaning", "tshirt.fill", .purple, due: today, minute: 17 * 60, part: .evening), nil),
            (task("Book flights", "airplane", .teal, due: today), today),
            (task("Clean the fridge", "refrigerator.fill", .teal, due: day(1)), nil),
            (task("Renew passport", "person.text.rectangle.fill", .brown, due: day(4), part: .morning), nil),
            (task("Car service", "car.fill", .blue, due: day(40), part: .morning), nil),
            (task("Send the parcel", "shippingbox.fill", .orange, due: day(-2)), day(-1)),
            (task("Feed the fish", "fish.fill", .orange, due: nil), today),
            (task("Take vitamins", "pills.fill", .red, due: nil, minute: 8 * 60), nil),
            (task("Water plants", "leaf.fill", .green, due: nil, frequency: .everyNDays(3)), nil),
            (task("Take out recycling", "arrow.3.trianglepath", .blue, due: nil, frequency: .weekdays([3])), nil),
            (task("Pay rent", "house.fill", .pink, due: nil, frequency: .monthDates([1])), nil),
        ]
        for (t, done) in tasks {
            store.add(t); await store.flush()
            if let done { store.toggleCheck(t, on: done); await store.flush() }
        }
        var archived = task("Plan the garage sale", "tag.fill", .green, due: day(-10))
        archived.archived = true
        store.add(archived); await store.flush()
    }
}
#endif
