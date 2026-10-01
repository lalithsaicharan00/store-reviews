import AppIntents
import SwiftUI
import WidgetKit

nonisolated enum PhoneWidgetKind {
    static let agenda = "OftenEnough.Today.v1"
    static let item = "OftenEnough.Item.v1"
    static let lock = "OftenEnough.LockToday.v1"
    static let icons = "OftenEnough.Icons.v1"
    static let history = "OftenEnough.History.v1"
}
nonisolated struct PhoneWidgetEntry: TimelineEntry {
    var date: Date
    var frame: WidgetFrame?
    var plus = false
    var hidden = false
    var selection: String?
    var completed = false
    var tasksOnly = false
    var month = false
    var page = 0
    var pageGroup = "agenda"
    var sample = false
    var pageKey: String { "\(pageGroup).\(tasksOnly).\(completed)" }
    var rows: [WidgetItem] { (frame?.agenda(completed: completed) ?? []).filter { !tasksOnly || $0.isTask } }
    var selected: WidgetItem? { frame?.items.first { $0.id == selection } }
    static var placeholder: Self {
        let item = WidgetItem(id: "preview", name: "Drink water", symbol: "drop", status: "3 glasses / 8 glasses", value: 3, goal: 8,
                              done: false, planned: true, ongoing: false, isTask: false, action: nil,
                              token: "", signature: "", counterStart: nil,
                              history: (1...31).map { WidgetDay(id: "preview-\($0)", label: String($0),
                                                             state: $0 % 4 == 0 ? "some" : "done", value: "3 glasses") })
        return Self(date: .now, frame: .init(day: "Preview", start: .distantPast, end: .distantFuture, items: [item]),
                    selection: item.id, sample: true)
    }
}
nonisolated enum PhoneWidgetTimeline {
    static func entries(snapshot: WidgetSnapshot?, now: Date = .now) -> [PhoneWidgetEntry] {
        guard let snapshot, snapshot.timeZone == TimeZone.current.identifier else { return [.init(date: now, frame: nil)] }
        if snapshot.hidden { return [.init(date: now, frame: nil, hidden: true)] }
        guard let current = snapshot.frame(at: now) else { return [.init(date: now, frame: nil)] }
        var entries = [PhoneWidgetEntry(date: now, frame: current, plus: snapshot.plus)]
        entries += snapshot.frames.filter { $0.start > now }.map { .init(date: $0.start, frame: $0, plus: snapshot.plus) }
        // Never carry an old day's rows indefinitely after the precomputed outlook ends.
        if let last = snapshot.frames.last { entries.append(.init(date: last.end, frame: nil)) }
        return entries
    }
    static func itemEntries(snapshot: WidgetSnapshot?, selection: String?, now: Date = .now) -> [PhoneWidgetEntry] {
        var result = entries(snapshot: snapshot, now: now).map { original in
            var entry = original; entry.selection = selection
            // A saved quit start is a stable fact: its system-rendered clock needs no daily refresh.
            // Only extend it up to the next known pause/end; never extend actionable agenda rows.
            if entry.frame == nil, !entry.hidden, snapshot?.timeZone == TimeZone.current.identifier,
               let item = snapshot?.frames.last?.items.first(where: { $0.id == selection }),
               item.isQuit, item.counterStart != nil, let until = item.counterValidUntil, entry.date < until {
                entry.frame = .init(day: "counter", start: entry.date, end: until, items: [item])
            }
            return entry
        }
        if let last = result.last, let frame = last.frame, frame.day == "counter", frame.end < .distantFuture {
            result.append(.init(date: frame.end, frame: nil))
        }
        return result
    }
    static func timeline(_ entries: [PhoneWidgetEntry]) -> Timeline<PhoneWidgetEntry> {
        let forever = entries.last?.frame.map { $0.day == "counter" && $0.end == .distantFuture } ?? false
        return Timeline(entries: entries, policy: forever ? .never : .after(max(entries.last?.date ?? .now, Date.now.addingTimeInterval(3600))))
    }
}
nonisolated struct AgendaWidgetProvider: AppIntentTimelineProvider {
    var kind = "agenda"
    func placeholder(in context: Context) -> PhoneWidgetEntry { .placeholder }
    func snapshot(for configuration: AgendaWidgetConfiguration, in context: Context) async -> PhoneWidgetEntry {
        context.isPreview ? .placeholder : await configured(configuration, family: context.family).first!
    }
    func timeline(for configuration: AgendaWidgetConfiguration, in context: Context) async -> Timeline<PhoneWidgetEntry> {
        PhoneWidgetTimeline.timeline(await configured(configuration, family: context.family))
    }
    @MainActor private func configured(_ config: AgendaWidgetConfiguration, family: WidgetFamily) -> [PhoneWidgetEntry] {
        PhoneWidgetTimeline.entries(snapshot: WidgetDisk.read()).map { original in
            var entry = original; entry.completed = config.completed; entry.tasksOnly = config.tasksOnly
            entry.pageGroup = "\(kind).\(family.rawValue)"
            entry.page = WidgetDisk.page(key: entry.pageKey)
            return entry
        }
    }
}
nonisolated struct ItemWidgetProvider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> PhoneWidgetEntry { .placeholder }
    func snapshot(for configuration: ItemWidgetConfiguration, in context: Context) async -> PhoneWidgetEntry {
        context.isPreview ? .placeholder : await configured(configuration).first!
    }
    func timeline(for configuration: ItemWidgetConfiguration, in context: Context) async -> Timeline<PhoneWidgetEntry> {
        PhoneWidgetTimeline.timeline(await configured(configuration))
    }
    @MainActor private func configured(_ config: ItemWidgetConfiguration) -> [PhoneWidgetEntry] {
        PhoneWidgetTimeline.itemEntries(snapshot: WidgetDisk.read(), selection: config.item?.id)
    }
}
nonisolated struct HistoryWidgetProvider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> PhoneWidgetEntry { .placeholder }
    func snapshot(for configuration: HistoryWidgetConfiguration, in context: Context) async -> PhoneWidgetEntry {
        context.isPreview ? .placeholder : await configured(configuration).first!
    }
    func timeline(for configuration: HistoryWidgetConfiguration, in context: Context) async -> Timeline<PhoneWidgetEntry> {
        PhoneWidgetTimeline.timeline(await configured(configuration))
    }
    @MainActor private func configured(_ config: HistoryWidgetConfiguration) -> [PhoneWidgetEntry] {
        PhoneWidgetTimeline.entries(snapshot: WidgetDisk.read()).map { original in
            var entry = original; entry.selection = config.item?.id; entry.month = config.range == .month; return entry
        }
    }
}

struct TodayPhoneWidget: Widget {
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: PhoneWidgetKind.agenda, intent: AgendaWidgetConfiguration.self, provider: AgendaWidgetProvider()) {
            PhoneWidgetView(entry: $0, layout: .agenda)
        }.configurationDisplayName("Today").description("Habits and unlimited tasks, with checks and saved amount increments.")
            .contentMarginsDisabled()
            .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}
struct ItemPhoneWidget: Widget {
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: PhoneWidgetKind.item, intent: ItemWidgetConfiguration.self, provider: ItemWidgetProvider()) {
            PhoneWidgetView(entry: $0, layout: .item)
        }.configurationDisplayName("One item").description("A habit, task, limit or quit counter. Choose your item by editing the widget.")
            .contentMarginsDisabled()
            .supportedFamilies([.systemSmall, .accessoryInline, .accessoryCircular, .accessoryRectangular])
    }
}
struct LockTodayPhoneWidget: Widget {
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: PhoneWidgetKind.lock, intent: AgendaWidgetConfiguration.self, provider: AgendaWidgetProvider()) {
            PhoneWidgetView(entry: $0, layout: .agenda)
        }.configurationDisplayName("Today on Lock Screen").description("What's left today, without opening the app.")
            .contentMarginsDisabled()
            .supportedFamilies([.accessoryInline, .accessoryCircular, .accessoryRectangular])
    }
}
struct IconsPhoneWidget: Widget {
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: PhoneWidgetKind.icons, intent: AgendaWidgetConfiguration.self, provider: AgendaWidgetProvider(kind: "icons")) {
            PhoneWidgetView(entry: $0, layout: .icons)
        }.configurationDisplayName("Icons · Plus").description("Compact named tiles. Free users get the complete Today agenda.")
            .contentMarginsDisabled()
            .supportedFamilies([.systemMedium, .systemLarge])
    }
}
struct HistoryPhoneWidget: Widget {
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: PhoneWidgetKind.history, intent: HistoryWidgetConfiguration.self, provider: HistoryWidgetProvider()) {
            PhoneWidgetView(entry: $0, layout: .history)
        }.configurationDisplayName("History · Plus").description("A habit's recent week or month. Free users get the selected item's status.")
            .contentMarginsDisabled()
            .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

nonisolated enum PhoneWidgetLayout: String, CaseIterable { case agenda, item, icons, history }
struct PhoneWidgetView: View {
    let entry: PhoneWidgetEntry
    let layout: PhoneWidgetLayout
    // WidgetKit supplies this read-only environment. The app-hosted screenshot harness
    // passes a family explicitly while using the same view branches and controls.
    var familyOverride: WidgetFamily? = nil
    @Environment(\.widgetFamily) private var systemFamily
    private var family: WidgetFamily { familyOverride ?? systemFamily }
    @Environment(\.widgetRenderingMode) private var renderingMode
    @Environment(\.dynamicTypeSize) private var textSize
    private var accessory: Bool { [.accessoryInline, .accessoryCircular, .accessoryRectangular].contains(family) }
    private var effective: PhoneWidgetLayout {
        if !entry.plus && !entry.sample && layout == .icons { return .agenda }
        if !entry.plus && !entry.sample && layout == .history { return .item }
        return layout
    }
    var body: some View {
        Group {
            if entry.frame == nil { unavailable }
            else if accessory { lockContent }
            else {
                switch effective {
                case .agenda: agenda
                case .item: single
                case .icons: icons
                case .history: history
                }
            }
        }
        .padding(accessory ? 0 : 10)
        .foregroundStyle(.primary)
        .containerBackground(.background, for: .widget)
        .widgetURL(effective == .item || effective == .history ? entry.selected?.url ?? Self.todayURL : Self.todayURL)
    }
    static let todayURL = URL(string: "oftenenough://today")!
    private var unavailable: some View {
        VStack(alignment: .leading, spacing: 4) {
            Image(systemName: entry.hidden ? "lock" : "arrow.clockwise")
            Text(entry.hidden ? "Content hidden" : "Open app to update")
                .font(accessory ? .caption : .callout).lineLimit(accessory ? 1 : 3)
        }.accessibilityElement(children: .combine)
    }
    private var heading: String { entry.tasksOnly ? "Tasks today" : layout == .icons && !entry.plus && !entry.sample ? "Today · free" : "Today" }
    private var agenda: some View {
        VStack(alignment: .leading, spacing: family == .systemLarge ? 9 : 4) {
            HStack {
                Text(heading).font(.headline)
                Spacer()
                Text("\(entry.rows.filter { !$0.done && !$0.ongoing }.count) left").font(.caption).foregroundStyle(.secondary)
            }
            if family == .systemSmall {
                Text("\(entry.rows.count)").font(.largeTitle.bold()).monospacedDigit()
                Text(entry.rows.isEmpty ? "Nothing planned" : "Open today's list").font(.caption)
                if let first = entry.rows.first { Text(first.name).font(.caption).lineLimit(2) }
                Spacer(minLength: 0)
            } else {
                let capacity = family == .systemLarge ? (textSize.isAccessibilitySize ? 4 : 6) : (textSize >= .xLarge ? 2 : 3)
                let page = clampedPage(capacity)
                let rows = Array(entry.rows.dropFirst(page * capacity).prefix(capacity))
                if rows.isEmpty { Text("Nothing left to check off").font(.callout); Spacer(minLength: 0) }
                ForEach(rows) { item in row(item) }
                Spacer(minLength: 0)
                footer(capacity)
            }
        }
    }
    private func row(_ item: WidgetItem) -> some View {
        HStack(spacing: 7) {
            control(item, size: family == .systemMedium ? 27 : 30)
            Link(destination: item.url) {
                VStack(alignment: .leading, spacing: 1) {
                    Text(item.name).font(.caption.weight(.semibold)).lineLimit(1)
                    status(item).font(.caption2).foregroundStyle(.secondary).lineLimit(1)
                }.frame(maxWidth: .infinity, alignment: .leading)
            }.accessibilityLabel("\(item.name), \(item.status). Open details")
        }
    }
    private var single: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let item = entry.selected {
                HStack { Image(systemName: item.symbol).font(.title2).foregroundStyle(color(item)).widgetAccentable(); Spacer(); control(item, size: 38) }
                Text(item.name).font(.headline).lineLimit(2)
                status(item).font(.callout).lineLimit(3)
                Spacer(minLength: 0)
                Text(layout == .history && !entry.plus && !entry.sample ? "History with Plus · status stays free" : item.action == nil ? "Open details" : item.action == "add" ? "+ adds \(item.stepLabel ?? "one step")" : "Tap to check off")
                    .font(.caption2).foregroundStyle(.secondary)
            } else {
                Image(systemName: "square.and.pencil")
                Text(entry.selection == nil ? "Choose an item" : "Item unavailable").font(.headline)
                Text("Touch and hold this widget, then Edit Widget.").font(.caption)
            }
        }
    }
    @ViewBuilder private func status(_ item: WidgetItem) -> some View {
        if let start = item.counterStart {
            Text(start, style: .relative).monospacedDigit().accessibilityLabel("\(item.name), time since last slip")
        } else { Text(item.status) }
    }
    @ViewBuilder private func control(_ item: WidgetItem, size: CGFloat) -> some View {
        if item.action != nil, !entry.sample, let day = entry.frame?.day {
            Button(intent: WidgetLogIntent(item: item, day: day)) {
                Image(systemName: item.action == "add" ? "plus.circle" : "circle")
                    .foregroundStyle(color(item)).font(.system(size: size * 0.68, weight: .medium)).frame(width: size, height: size)
            }.buttonStyle(.plain).widgetAccentable()
                .accessibilityLabel("\(item.action == "add" ? "Add \(item.stepLabel ?? "one saved step") to" : "Check off") \(item.name)")
                .accessibilityValue(item.status)
        } else {
            Link(destination: item.url) {
                Image(systemName: item.done ? "checkmark.circle.fill" : item.symbol)
                    .foregroundStyle(color(item)).font(.system(size: size * 0.6)).frame(width: size, height: size)
            }.widgetAccentable().accessibilityLabel("Open \(item.name), \(item.status)")
        }
    }
    private var lockContent: some View {
        Group {
            if effective == .item, let item = entry.selected {
                switch family {
                case .accessoryInline:
                    if let start = item.counterStart { Text(item.name + ": ") + Text(start, style: .relative) }
                    else { Text("\(item.name): \(item.status)") }
                case .accessoryCircular:
                    VStack(spacing: 0) {
                        control(item, size: 28)
                        if let start = item.counterStart { Text(start, style: .relative).font(.system(size: 9)).lineLimit(1) }
                        else { Text(item.done ? "Done" : item.value.formatted(.number.precision(.fractionLength(0...1))))
                            .font(.caption2).lineLimit(1) }
                    }
                default:
                    HStack(spacing: 5) {
                        control(item, size: 28)
                        VStack(alignment: .leading, spacing: 1) {
                            Text(item.name).font(.caption.weight(.semibold)).lineLimit(1)
                            status(item).font(.caption2).lineLimit(1)
                        }
                    }
                }
            } else if effective == .item {
                Text("Choose an item").font(.caption)
            } else {
                let remaining = entry.rows.filter { !$0.done && !$0.ongoing }.count
                switch family {
                case .accessoryInline: Label("\(remaining) left today", systemImage: "checklist")
                case .accessoryCircular:
                    VStack(spacing: 1) { Image(systemName: "checklist"); Text("\(remaining)").font(.headline); Text("left").font(.caption2) }
                default:
                    VStack(alignment: .leading) {
                        Text("\(remaining) left today").font(.headline)
                        Text(entry.rows.first?.name ?? "Nothing planned").font(.caption).lineLimit(1)
                    }
                }
            }
        }.accessibilityElement(children: .contain)
    }
    private var icons: some View {
        let larger = textSize >= .xLarge
        let capacity = family == .systemLarge ? (larger ? 6 : 12) : (larger ? 3 : 6)
        let page = clampedPage(capacity)
        return VStack(spacing: 4) {
            HStack { Text(heading).font(.headline); Spacer(); Text("Icons · Plus").font(.caption2).foregroundStyle(.secondary) }
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 4), count: 3), spacing: 4) {
                ForEach(Array(entry.rows.dropFirst(page * capacity).prefix(capacity))) { item in
                    VStack(spacing: 0) {
                        control(item, size: family == .systemLarge ? 34 : 25)
                        Text(item.name).font(larger ? .caption2 : .system(size: family == .systemLarge ? 12 : 10)).lineLimit(1)
                        status(item).font(larger ? .caption2 : .system(size: family == .systemLarge ? 10 : 8)).lineLimit(1).foregroundStyle(.secondary)
                    }.frame(maxWidth: .infinity)
                }
            }
            Spacer(minLength: 0)
            footer(capacity)
        }
    }
    private var history: some View {
        VStack(alignment: .leading, spacing: 6) {
            if let item = entry.selected {
                Text(item.name).font(family == .systemSmall && entry.month ? .caption.weight(.semibold) : .headline).lineLimit(1)
                if item.isTask || item.isQuit {
                    status(item).font(.callout)
                    Text("History is for tracked habits").font(.caption2)
                } else {
                    let days = Array(item.history.suffix(entry.month ? 31 : 7))
                    Text(entry.month ? "Last 31 days" : "Last 7 days").font(.caption).foregroundStyle(.secondary)
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 3), count: 7), spacing: 5) {
                        ForEach(days) { day in
                            VStack(spacing: 2) {
                                Image(systemName: mark(day.state)).font(.system(size: entry.month && family != .systemLarge ? 9 : 14))
                                    .foregroundStyle(color(item)).widgetAccentable()
                                if !entry.month || family == .systemLarge { Text(day.label).font(.system(size: 8)) }
                            }.accessibilityElement(children: .ignore)
                                .accessibilityLabel("\(day.id), \(spoken(day.state)), \(day.value)")
                        }
                    }
                    if family == .systemLarge || !entry.month {
                        Text("Filled: done · ring: open · pause: paused").font(.system(size: 9)).foregroundStyle(.secondary).lineLimit(2)
                    }
                }
                Spacer(minLength: 0)
            } else { Text("Choose a habit").font(.headline); Text("Edit this widget to choose.").font(.caption) }
        }
    }
    private func color(_ item: WidgetItem) -> Color {
        guard renderingMode == .fullColor else { return .primary }
        switch item.color {
        case "red": return .red
        case "orange": return .orange
        case "yellow": return .yellow
        case "green": return .green
        case "mint": return .mint
        case "teal": return .teal
        case "cyan": return .cyan
        case "indigo": return .indigo
        case "purple": return .purple
        case "pink": return .pink
        case "brown": return .brown
        case "gray": return .gray
        default: return .blue
        }
    }
    private func mark(_ state: String) -> String {
        switch state {
        case "done": "circle.fill"
        case "some": "circle.lefthalf.filled"
        case "paused": "pause.circle"
        case "skipped": "forward.circle"
        case "notItsDay", "before", "upcoming": "minus"
        default: "circle"
        }
    }
    private func spoken(_ state: String) -> String {
        switch state {
        case "done": "Done"
        case "some": "Part recorded"
        case "paused": "Paused"
        case "skipped": "Skipped"
        case "missed": "Nothing recorded"
        case "notItsDay", "before", "upcoming": "Not planned"
        default: "Open"
        }
    }
    private func clampedPage(_ capacity: Int) -> Int { min(max(0, entry.page), max(0, (entry.rows.count - 1) / capacity)) }
    private func footer(_ capacity: Int) -> some View {
        let pages = max(1, (entry.rows.count + capacity - 1) / capacity)
        let page = clampedPage(capacity)
        return HStack(spacing: 8) {
            if pages > 1 {
                Button(intent: WidgetPageIntent(key: entry.pageKey, page: max(0, page - 1))) { Image(systemName: "chevron.left") }
                    .disabled(page == 0).accessibilityLabel("Previous page")
                Text("\(page + 1)/\(pages)").font(.caption2).monospacedDigit()
                Button(intent: WidgetPageIntent(key: entry.pageKey, page: min(pages - 1, page + 1))) { Image(systemName: "chevron.right") }
                    .disabled(page + 1 == pages).accessibilityLabel("Next page")
            }
            Spacer(minLength: 0)
            Link("Open Today", destination: Self.todayURL).font(.caption2)
        }.buttonStyle(.plain)
    }
}
