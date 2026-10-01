import SwiftUI

/// ≡ → Day and Week (Build Plan #61): when a new day starts and which day a week starts on.
/// Research: "Ticking Off, Folding and Small Settings — What People Need" §4–5 (1 Oct 2026). The clock format,
/// daylight saving and time zones have no setting: the app follows the iPhone, and each is handled here in code.
struct DayAndWeekView: View {
    @Environment(HabitStore.self) private var store

    var body: some View {
        Form {
            Section {
                Picker("New Day Starts At", selection: Binding(get: { store.settings.dayEndHour },
                                                                  set: { store.setDayEnd($0) })) {
                    ForEach(0...12, id: \.self) { hour in
                        Text(Self.hourName(hour)).tag(hour)
                    }
                }
                .accessibilityIdentifier("day-start-picker")
            } footer: {
                Text(dayFooter)
            }

            Section {
                Picker("Week Starts On", selection: Binding(get: { store.settings.weekStartChosen ? store.settings.weekStart : 0 },
                                                               set: { store.setWeekStart($0 == 0 ? nil : $0) })) {
                    Text("Automatic (\(Self.weekdayName(Calendar.autoupdatingCurrent.firstWeekday)))").tag(0)
                    ForEach(Self.weekOrder, id: \.self) { day in
                        Text(Self.weekdayName(day)).tag(day)
                    }
                }
                .accessibilityIdentifier("week-start-picker")
            } footer: {
                Text("Weekly goals, week streaks, the calendar and Progress count in these weeks, past weeks too. Automatic follows your iPhone's region.")
            }

            Section {
                Label("Times follow your iPhone's 24-Hour Time setting, in General › Date & Time.", systemImage: "clock")
                Label("Daylight saving and travel are handled for you: what you log keeps its day, and reminders keep their time.",
                      systemImage: "globe")
            } header: {
                Text("Clock")
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
        }
        .navigationTitle("Day and Week")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var dayFooter: String {
        let hour = store.settings.dayEndHour
        guard hour > 0 else {
            return "Your day starts at midnight. For late nights or night shifts, pick a later hour: what you log before it counts for the day before."
        }
        return "What you log before \(Self.hourName(hour)) counts for the day before. Days already logged keep their day."
    }

    /// "Midnight", "1:00 AM" … "Noon", in the iPhone's own clock format (12- or 24-hour).
    static func hourName(_ hour: Int) -> String {
        switch hour {
        case 0: "Midnight"
        case 12: "Noon"
        default: DaySection.clock(hour * 60)
        }
    }

    /// Monday first; Automatic, above them, names the region's own day.
    static let weekOrder = [2, 3, 4, 5, 6, 7, 1]

    static func weekdayName(_ day: Int) -> String {
        let names = Calendar.autoupdatingCurrent.standaloneWeekdaySymbols
        return names[(day - 1) % 7]
    }
}
