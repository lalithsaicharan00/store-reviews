import SwiftUI

/// Quiet discovery: the daily widget buttons never lead to purchases.
struct WidgetsView: View {
    @Environment(HabitStore.self) private var store
    @AppStorage(WidgetDisk.privacyKey) private var hidden = false
    var body: some View {
        ScrollView {
          LazyVStack(alignment: .leading, spacing: 20) {
            guideSection("Included") {
                Label("Today agenda · small, medium and large", systemImage: "list.bullet")
                Label("One habit or task · Home and Lock Screen", systemImage: "square")
                Label("Today summary · all Lock Screen sizes", systemImage: "lock")
                Text("Your five free habits, including quit and cut down, and unlimited tasks. Checks and saved amount increments log in place. Timers, checklists and slips open their existing controls.")
                    .font(.footnote).foregroundStyle(.secondary)
            }
            guideSection("Extra layouts with Plus") {
                Label("Named icon grid", systemImage: "square.grid.3x3")
                Label("Recent week and month history", systemImage: "calendar")
                if !store.isPlus { NavigationLink("See Plus", value: MenuPlace.plus) }
                Text("If Plus ends, these widgets keep showing a free agenda or item status. Basic tracking stays available.")
                    .font(.footnote).foregroundStyle(.secondary)
            }
            if let problem = AppModel.shared.widgets.problem {
                guideSection("Widget updates") {
                    Text(problem)
                    Button("Try again") { Task { await AppModel.shared.widgets.publish(store) } }
                }
            }
            guideSection("Add a widget") {
                Text("Home Screen: touch and hold an empty area, tap Edit, then Add Widget. Search for this app, choose a size, and tap Add Widget.")
                Text("Lock Screen: touch and hold your Lock Screen, tap Customize, choose Lock Screen, then tap the widget area. Choose this app and a widget.")
                Text("Touch and hold an installed widget and choose Edit Widget to select an item, show completed items, or show tasks only. Lists use pages because iPhone widgets cannot scroll.")
                Text("Open the app after changing your time zone or when a widget asks to update. iOS decides when timelines refresh.")
            }
            guideSection("Privacy") {
                Toggle("Hide widget content", isOn: $hidden).accessibilityIdentifier("widgets-hide")
                Text("Hides names and progress and disables widget logging. Enabling the app's Face ID lock also hides widgets; the app lock alone cannot erase a widget already shown by iOS immediately.")
                    .font(.footnote).foregroundStyle(.secondary)
            }
          }.padding()
        }.background(Color(.systemGroupedBackground))
            .navigationTitle("Widgets")
            .onChange(of: hidden) { Task { await AppModel.shared.widgets.publish(store) } }
    }

    private func guideSection<Content: View>(_ title: LocalizedStringKey, @ViewBuilder content: () -> Content) -> some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 12) { content() }
                .frame(maxWidth: .infinity, alignment: .leading)
        } label: {
            Text(title).font(.headline).accessibilityAddTraits(.isHeader)
        }
    }
}
