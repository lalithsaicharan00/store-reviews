import SwiftUI

/// Quiet discovery: the daily widget buttons never lead to purchases.
struct WidgetsView: View {
    @Environment(HabitStore.self) private var store
    @AppStorage(WidgetDisk.privacyKey) private var hidden = false
    var body: some View {
        ScrollView {
          LazyVStack(alignment: .leading, spacing: 20) {
            guideSection("Widgets") {
                Label("One habit · small", systemImage: "square")
                Label("Today · medium and large, or one section", systemImage: "list.bullet")
                Label("This week · one habit, medium", systemImage: "calendar")
                Label("Tasks · medium and large, or one section", systemImage: "checklist")
                Label("Lock Screen · one habit, Today, and a line above the clock", systemImage: "lock")
                Text("✓ and + log right on the widget, ▶ and ⏸ run the timer. An amount you type, a slip, or a checklist's steps open their own screen in the app, straight away. Lists keep your order and show five (large) or two (medium) at a time, with ‹ › for more.")
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
                Text("To choose a habit, or a section for a list: touch and hold the widget, tap Edit Widget, then choose. Each widget keeps its own choice.")
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
            .analyticsScreen(.widgetsSettings)
            .task { WidgetAnalyticsAdapter.refreshInventory() }
            .onChange(of: hidden) {
                Analytics.shared.event(.preference, ["setting": .text("widget_privacy"), "value": .text(hidden ? "hidden" : "visible")], ticket: Analytics.shared.ticket)
                store.analyticsConfiguration()
                Task { await AppModel.shared.widgets.publish(store) }
            }
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
