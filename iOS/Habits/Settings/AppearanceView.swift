import SwiftUI

/// ≡ → Appearance (Build Plan #61): the theme, where done habits go on Today, and how a tick feels.
/// Research: "Ticking Off, Folding and Small Settings — What People Need" (1 Oct 2026). Everything here is free.
struct AppearanceView: View {
    @Environment(HabitStore.self) private var store
    @AppStorage(Preferences.theme) private var theme = Theme.automatic.rawValue
    @AppStorage(Preferences.doneOrder) private var doneOrder = DoneOrder.inPlace.rawValue
    @AppStorage(Preferences.haptics) private var haptics = true
    @AppStorage(Preferences.sound) private var sound = false

    var body: some View {
        Form {
            Section {
                Picker("Theme", selection: $theme) {
                    ForEach(Theme.allCases) { Text($0.title).tag($0.rawValue) }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } header: {
                Text("Theme")
            } footer: {
                Text("Automatic follows your iPhone, light by day and dark at night if you've set it to.")
            }

            Section {
                Picker("Done Habits", selection: $doneOrder) {
                    ForEach(DoneOrder.allCases) { Text($0.title).tag($0.rawValue) }
                }
                .accessibilityIdentifier("appearance-done-order")
            } header: {
                Text("Today")
            } footer: {
                Text(doneOrder == DoneOrder.inPlace.rawValue
                     ? "Habits keep your order when they're done."
                     : "Done habits go below the rest once you pause, never while you're still ticking.")
            }

            Section {
                Toggle("Haptics", isOn: $haptics)
                    .tint(.green)
                    .accessibilityIdentifier("appearance-haptics")
                Toggle("Sound When Done", isOn: $sound)
                    .tint(.green)
                    .accessibilityIdentifier("appearance-sound")
                    .onChange(of: sound) { if sound { TickFeedback.playChime() } }
            } header: {
                Text("When You Tick")
            } footer: {
                Text("A light tap as you log, and a chime when a habit is done. The chime follows your iPhone's silent switch.")
            }
        }
        .analyticsScreen(.appearance)
        .navigationTitle("Appearance")
        .navigationBarTitleDisplayMode(.inline)
         .onChange(of: theme) {
            Theme.apply(theme)
            store.analytics.event(.preference, ["setting": .text("theme"), "value": .text(Theme(rawValue: theme)?.rawValue ?? "automatic")], ticket: store.analytics.ticket)
            store.analyticsConfiguration()
        }
        .onChange(of: haptics) { store.analyticsConfiguration() }
        .onChange(of: sound) { store.analyticsConfiguration() }
    }
}
