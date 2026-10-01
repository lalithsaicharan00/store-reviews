import Foundation
import WidgetKit

/// Inventory exposes kinds/families, not Home-vs-Lock placement, impressions, names or selections.
enum WidgetAnalyticsAdapter {
    private static var lastInventoryDay: Int?
    static func consentChanged(_ enabled: Bool) {
        WidgetAnalyticsRelay.consent(enabled, directory: WidgetDisk.directory, rotate: true)
        lastInventoryDay = nil
        if enabled { refreshInventory() }
    }
    static func foreground() {
        WidgetAnalyticsRelay.consent(Analytics.shared.consented, directory: WidgetDisk.directory)
        guard let ticket = Analytics.shared.ticket else { return }
        let directory = WidgetDisk.directory
        DispatchQueue.global(qos: .utility).async {
            Analytics.shared.widgetPages(WidgetAnalyticsRelay.drain(directory: directory), ticket: ticket)
        }
        refreshInventory()
    }
    static func refreshInventory() {
        guard let ticket = Analytics.shared.ticket else { return }
        let day = AnalyticsLedger.day(.now)
        guard lastInventoryDay != day else { return }
        lastInventoryDay = day
        WidgetCenter.shared.getCurrentConfigurations { result in
            var properties: [String: AnalyticsValue] = ["query_supported": .flag(true), "host": .text("unknown")]
            switch result {
            case .failure: properties["query_result"] = .text("failed")
            case .success(let widgets):
                properties["query_result"] = .text("success")
                let kinds = [PhoneWidgetKind.agenda: "today", PhoneWidgetKind.item: "item", PhoneWidgetKind.lock: "lock_today", PhoneWidgetKind.icons: "icons", PhoneWidgetKind.history: "history"]
                let families: [WidgetFamily: String] = [.systemSmall: "small", .systemMedium: "medium", .systemLarge: "large", .accessoryInline: "accessory_inline", .accessoryCircular: "accessory_circular", .accessoryRectangular: "accessory_rectangular"]
                for kind in kinds.values { properties["kind_" + kind + "_count"] = .number(0) }
                for family in families.values { properties["family_" + family + "_count"] = .number(0) }
                for widget in widgets {
                    guard let kind = kinds[widget.kind], let family = families[widget.family] else { continue }
                    for key in ["kind_" + kind + "_count", "family_" + family + "_count"] {
                        if case .number(let count) = properties[key] { properties[key] = .number(min(100_000, count + 1)) }
                    }
                }
            }
            Analytics.shared.widgetInventory(properties, ticket: ticket)
        }
    }
}
