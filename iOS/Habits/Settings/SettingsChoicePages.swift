import SwiftUI

/// Settings' three choice pages (Figma: Day Starts At 1186:13870, Week Starts On 1186:13871, Appearance 1188:376784;
/// 21 Nov 2026). Each is one inset-grouped `List`: a line saying what the choice does, then one Checkmark row per
/// option. Tapping a row moves the tick and saves at once, and the page stays open, as iPhone Settings does (General ›
/// Language & Region › First Day of Week); Back returns. Figma's "End of the list" variants are the same pages scrolled.
///
/// The line above the rows is an ordinary clear row, not a section header: iOS fades and capitalises headers, and
/// Figma draws it as Body in Secondary Label, 16 in from the card's edge.

/// Day Starts At: logs before this hour count for the day before. **12:00 AM to 12:00 PM, not Figma's 24 hours:** the
/// day's rules (`HabitStore.setDayEnd`, the shared core and Android) accept 0 to 12, so a later hour would be cut back
/// to noon without a word; Figma's other 11 hours are open decision D-24, for the logic pass.
struct DayStartsAtPage: View {
    @Environment(HabitStore.self) private var store

    var body: some View {
        ChoiceList(intro: "Logs before this time count for the day before. Choose a later hour if you’re often up after midnight.") {
            ForEach(0...12, id: \.self) { hour in
                CheckRow(title: DaySection.clock(hour * 60), selected: store.settings.dayEndHour == hour) {
                    store.setDayEnd(hour)
                }
                .accessibilityIdentifier("day-start-\(hour)")
            }
        }
        .analyticsScreen(.dayAndWeek)
        .navigationTitle("Day Starts At")
        .navigationBarTitleDisplayMode(.inline)
    }
}

/// Week Starts On: Sunday to Saturday, as Figma, with no Automatic row. Until someone picks a day the store follows
/// the iPhone's region, so the tick sits on that region's day, which is what the week really is.
struct WeekStartsOnPage: View {
    @Environment(HabitStore.self) private var store

    var body: some View {
        ChoiceList(intro: "Week goals, the week view and Progress start on this day.") {
            ForEach(1...7, id: \.self) { day in
                CheckRow(title: Self.name(day), selected: store.settings.weekStart == day) {
                    store.setWeekStart(day)
                }
                .accessibilityIdentifier("week-start-\(day)")
            }
        }
        .analyticsScreen(.dayAndWeek)
        .navigationTitle("Week Starts On")
        .navigationBarTitleDisplayMode(.inline)
    }

    /// "Sunday" … "Saturday" (1 is Sunday, as `Calendar` counts), in the iPhone's language.
    static func name(_ day: Int) -> String {
        Calendar.autoupdatingCurrent.standaloneWeekdaySymbols[(day - 1 + 7) % 7]
    }
}

/// Appearance: Automatic, Light or Dark. Done order and the timer switches the old page had aren't in Figma, so they
/// left the screen; what they did stays in the app as it was (`Preferences`), for the logic pass to settle.
struct AppearancePage: View {
    @Environment(HabitStore.self) private var store
    @AppStorage(Preferences.theme) private var theme = Theme.automatic.rawValue

    var body: some View {
        ChoiceList(intro: "Automatic follows your iPhone’s Light or Dark appearance.") {
            ForEach(Theme.allCases) { option in
                CheckRow(title: option.title, selected: (Theme(rawValue: theme) ?? .automatic) == option) {
                    theme = option.rawValue
                }
                .accessibilityIdentifier("appearance-\(option.rawValue)")
            }
        }
        .analyticsScreen(.appearance)
        .navigationTitle("Appearance")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: theme) {
            Theme.apply(theme)
            store.analytics.event(.preference, ["setting": .text("theme"), "value": .text(theme)], ticket: store.analytics.ticket)
            store.analyticsConfiguration()
        }
    }
}

/// The shape all three share: the intro line on the page, then the choices in one card.
private struct ChoiceList<Rows: View>: View {
    let intro: String
    @ViewBuilder let rows: Rows

    var body: some View {
        List {
            Section {
                Text(intro)
                    .foregroundStyle(.secondary)
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            }
            .listSectionSpacing(24)
            Section { rows }
        }
        .listStyle(.insetGrouped)
        .contentMargins(.top, 8, for: .scrollContent)
    }
}
