#if DEBUG
import Foundation

/// Test-only habits matching the Day-details and Entry-editor wireframes (handoff "Day Details and Entry Editor",
/// 4 Oct 2026), so `DayDetailsScreenshotUITests` can show each of the 31 states as built, in the wireframes' order.
/// Installed only with `-day-details-fixture` on an empty test database; uses normal writes.
enum DayDetailsFixture {
    static func install(in store: HabitStore) async {
        guard store.habits.isEmpty else { return }
        let today = store.today()
        let start = today.adding(days: -30, calendar: store.calendar)
        let made = Date.now.addingTimeInterval(-30 * 86_400)
        func habit(_ name: String, _ symbol: String, _ color: HabitColor, _ kind: HabitKind, goal: Double = 1,
                   frequency: Frequency = .daily, atMost: Bool = false, dueDay: LocalDay? = nil, steps: [Step] = [],
                   quitSince: Date? = nil) -> Habit {
            Habit(name: name, symbol: symbol, color: color, kind: kind, goal: goal, frequency: frequency, atMost: atMost,
                  dueDay: dueDay, steps: steps, remind: false, startsOn: kind == .task ? nil : start, quitSince: quitSince,
                  createdAt: made)
        }
        let vitamins = habit("Take vitamins", "checkmark", .yellow, .check)
        let call = habit("Call family", "phone.fill", .green, .check, frequency: .perWeek(3))
        let stretch = habit("Stretch breaks", "plus", .blue, .check, goal: 3)
        let desk = habit("Tidy desk", "sparkles", .teal, .checklist,
                         steps: [Step(name: "Clear papers"), Step(name: "Wipe the surface"), Step(name: "Put pens away")])
        let water = habit("Water", "drop.fill", .blue, .amount(unit: "glasses", increment: 1), goal: 8)
        let coffee = habit("Coffee", "mug.fill", .brown, .amount(unit: "cups", increment: 1), goal: 2, atMost: true)
        let read = habit("Read", "book.fill", .orange, .duration, goal: 20)
        let smoking = habit("Smoking", "nosign", .gray, .quit, quitSince: Date.now.addingTimeInterval(-15 * 86_400))
        let task = habit("Test", "calendar", .blue, .task, dueDay: today)
        let monthly = habit("Deep clean", "house.fill", .purple, .check, frequency: .perMonth(4))
        let paused = habit("Meditate", "leaf.fill", .mint, .check)
        let social = habit("Social media", "iphone", .pink, .duration, goal: 30, atMost: true)
        let squats = habit("Squats", "figure.strengthtraining.traditional", .red, .check, goal: 3)
        for h in [vitamins, call, stretch, desk, water, coffee, read, smoking, task, monthly, paused, social, squats] { store.add(h) }
        await store.flush()

        let yesterday = today.adding(days: -1, calendar: store.calendar)
        store.addProgress(call, value: 1, on: today, source: .today)
        store.addProgress(stretch, value: 1, on: today, source: .today)
        store.addProgress(stretch, value: 1, on: today, source: .today)
        store.toggleStep(desk.steps[0], of: desk, on: today)
        store.toggleStep(desk.steps[1], of: desk, on: today)
        store.addProgress(water, value: 1, on: today, source: .today)
        store.addProgress(water, value: 1, on: today, source: .manual)
        store.addProgress(water, value: 1, on: yesterday, source: .today)
        store.addProgress(water, value: 2, on: yesterday, source: .manual)
        store.addProgress(read, value: 3, on: today, source: .manual)
        store.addProgress(read, value: 2, on: today, source: .routine)
        store.addProgress(monthly, value: 1, on: today, source: .today)
        store.addProgress(social, value: 1.23 / 60, on: today, source: .timer)
        store.addProgress(squats, value: 2, on: today, source: .manual)
        store.pause(paused, from: today, through: nil)
        await store.flush()
        store.clearLogOffer()
    }
}
#endif
