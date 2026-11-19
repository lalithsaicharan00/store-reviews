import SwiftUI

/// "Which day?" (Figma's History flows 202 and 203, Go to Date… and Add): iOS's own calendar in a popover from the
/// button that asked, opened on today with nothing chosen, so nothing lands on a day by default. Days before the habit
/// started and after today can't be picked. Tapping a day picks it and the calendar closes by itself; a tap outside
/// closes it and nothing happens. `pick` runs once the popover has gone, so what it opens or scrolls to never fights
/// the popover's own leaving.
extension View {
    func dayCalendar(isPresented: Binding<Bool>, habit: Habit, pick: @escaping (LocalDay) -> Void) -> some View {
        modifier(DayCalendarPopover(isPresented: isPresented, habit: habit, pick: pick))
    }
}

private struct DayCalendarPopover: ViewModifier {
    @Binding var isPresented: Bool
    let habit: Habit
    let pick: (LocalDay) -> Void
    @State private var chosen: LocalDay?

    func body(content: Content) -> some View {
        content.popover(isPresented: $isPresented) {
            DayCalendar(habit: habit) { day in
                chosen = day
                isPresented = false
            }
            .presentationCompactAdaptation(.popover)
            // Solid, as Figma draws it: on glass, History's rows showed through the days.
            .presentationBackground(Color(.systemBackground))
            .onDisappear {
                if let day = chosen {
                    chosen = nil
                    pick(day)
                }
            }
        }
    }
}

/// The calendar itself. A `MultiDatePicker` because it's iOS's one calendar that starts with no day chosen
/// (a `DatePicker` always has one); the first tap is the choice.
private struct DayCalendar: View {
    let habit: Habit
    let pick: (LocalDay) -> Void
    @Environment(HabitStore.self) private var store
    @State private var picked: Set<DateComponents> = []

    var body: some View {
        let calendar = store.calendar
        let today = store.today()
        let first = min(habit.kind == .quit ? store.quitStartDay(of: habit) : store.startDay(of: habit), today)
        // The picker takes a day as allowed when any moment of it is in the range, so the range ends a second into
        // today: ending at tomorrow's midnight let tomorrow be picked (seen on the Simulator).
        MultiDatePicker("Day", selection: $picked,
                        in: first.date(calendar: calendar)..<today.date(calendar: calendar).addingTimeInterval(1))
            .labelsHidden()
            .tint(Color.ink)
            .environment(\.calendar, calendar)
            .environment(\.timeZone, calendar.timeZone)
            .frame(width: 330)
            .padding(.horizontal, 8)
            .accessibilityIdentifier("day-calendar")
            .onChange(of: picked) {
                guard let tapped = picked.first, let year = tapped.year, let month = tapped.month, let day = tapped.day else { return }
                pick(LocalDay(year: year, month: month, day: day))
            }
    }
}
