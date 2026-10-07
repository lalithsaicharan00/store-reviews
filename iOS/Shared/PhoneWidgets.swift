import AppIntents
import SwiftUI
import UIKit
import WidgetKit

// Every iPhone widget (Implementation Spec — Every Widget, 6 Oct 2026): Small one habit, Medium and Large Today lists
// (Today or one section), Medium and Large task lists, the weekly Medium, and the Lock Screen circle, rectangle and
// line. One look across them (the user, 6 Oct 2026: clean, easy to understand, minimal but useful): the habit's icon in
// its colour, its name, one line of what today asks, and one round button that does exactly what it says.
// The extension only draws: every word, number and order comes from the app's snapshot (`WidgetSnapshot`).

/// Stable kinds: a widget someone has added keeps working across updates.
nonisolated enum PhoneWidgetKind {
    static let agenda = "OftenEnough.Today.v1"
    static let item = "OftenEnough.Item.v1"
    static let lock = "OftenEnough.LockToday.v1"
    static let tasks = "OftenEnough.Tasks.v1"
    static let history = "OftenEnough.History.v1"
}

nonisolated enum PhoneWidgetLayout: String, CaseIterable, Sendable {
    /// Medium and Large lists of habits, and the Lock Screen's Today rectangle and line.
    case habits
    /// Medium and Large lists of tasks.
    case tasks
    /// Small one habit, and the Lock Screen's one-habit circle and line.
    case item
    /// Medium one habit, this week.
    case week
}

nonisolated struct PhoneWidgetEntry: TimelineEntry {
    enum Status: Sendable { case ready, hidden, stale }
    var date: Date
    var frame: WidgetFrame?
    var status: Status = .ready
    /// The chosen habit (one-habit widgets), or nil before one is chosen.
    var selection: String?
    /// The chosen list: Today (`WidgetListSection.today`) or a section's ID; its name; and whether it was removed.
    var view = WidgetListSection.today
    var viewName = "Today"
    var viewMissing = false
    var page = 0
    var pageKey = ""
    var kind = ""
    var weekdays: [String] = []
    /// No habits at all yet (an honest empty state, never sample content).
    var noHabits = false
    /// Gallery and placeholder: sample content whose buttons do nothing.
    var sample = false
    var selected: WidgetItem? { frame?.item(selection) }
    func listKey(_ prefix: String) -> String { view == WidgetListSection.today ? prefix : prefix + ":" + view }
}

// MARK: - Timelines

nonisolated enum PhoneWidgetTimeline {
    /// How far ahead one timeline reaches. WidgetKit draws every entry of a timeline as soon as it gets one, before
    /// the widget shows anything new: a week of entries (21 for a Medium list, ~35 ms each on the iPhone 16) cost
    /// ~0.75 s per reload, twice per tap, and a run of taps queued seconds of drawing (Current Work 65, 7 Oct 2026).
    /// So a timeline holds only the next few hours and the next day's start; WidgetKit asks again after that (well
    /// within its 40–70 reloads a day), and the snapshot's seven days still carry the widget through days without the
    /// app. Apple: entries at least about 5 minutes apart.
    // LOCKED (widget taps, 8 Oct 2026): 3 hours and the next day's start; entries at least 5 minutes apart (W10). Read iOS/Docs/Widgets — Taps and Updates (Locked).md before changing; changes need the user's say-so.
    static let horizon: TimeInterval = 3 * 3600

    /// One entry for now, then each moment a drawn value changes before `horizon`: the moment held rows settle (U4), a
    /// running timer's fill (every 5 minutes for half an hour), a quit counter's hour or day count, "New best"; and the
    /// next day's start. After the snapshot's seven days the widget asks the app to update, except a quit counter,
    /// which is a stable fact and keeps counting up to a known pause or end.
    static func entries(snapshot: WidgetSnapshot?, now: Date = .now, listKey: String? = nil, selection: String? = nil,
                        setup: @escaping (inout PhoneWidgetEntry) -> Void) -> [PhoneWidgetEntry] {
        func make(_ date: Date, _ frame: WidgetFrame?, _ status: PhoneWidgetEntry.Status) -> PhoneWidgetEntry {
            var entry = PhoneWidgetEntry(date: date, frame: frame, status: status, selection: selection)
            entry.weekdays = snapshot?.weekdays ?? []
            entry.noHabits = snapshot.map { !$0.hidden && $0.choices.isEmpty } ?? false
            setup(&entry)
            return entry
        }
        guard let snapshot, snapshot.version == WidgetSnapshot.version, snapshot.timeZone == TimeZone.current.identifier,
              snapshot.locale == Locale.current.identifier else { return [make(now, nil, .stale)] }
        if snapshot.hidden { return [make(now, nil, .hidden)] }
        guard let current = snapshot.frame(at: now) else {
            if let counter = counterEntries(snapshot, now: now, selection: selection, make: make) { return counter }
            return [make(now, nil, .stale)]
        }
        #if DEBUG
        // The old week-long timeline, only for measuring the two side by side on the iPhone (S2; WidgetLatencyDeviceTests).
        if UserDefaults(suiteName: WidgetDisk.group)?.bool(forKey: "debug.weekTimeline") == true {
            var dates: Set<Date> = [now]
            for frame in snapshot.frames {
                if frame.start > now { dates.insert(frame.start) }
                if let settle = frame.settle, settle > now { dates.insert(settle) }
                let items = listKey.map { frame.list($0, at: now) } ?? frame.item(selection).map { [$0] } ?? []
                for moment in moments(items, now: now, within: frame.start..<frame.end) { dates.insert(moment) }
            }
            return dates.sorted().prefix(160).map { date in make(date, snapshot.frames.first { $0.start <= date && date < $0.end }, .ready) }
        }
        #endif
        let reach = min(current.end, now.addingTimeInterval(horizon))
        var dates: Set<Date> = [now]
        if let settle = current.settle, settle > now, settle < reach { dates.insert(settle) }
        let items = listKey.map { current.list($0, at: now) } ?? current.item(selection).map { [$0] } ?? []
        for moment in moments(items, now: now, within: now..<reach) { dates.insert(moment) }
        var result = dates.sorted().prefix(12).map { make($0, current, .ready) }
        if let next = snapshot.frames.first(where: { $0.start == current.end }) {
            result.append(make(next.start, next, .ready))
        } else if let counter = counterEntries(snapshot, now: current.end, selection: selection, make: make) {
            result += counter.prefix(4)
        } else {
            result.append(make(current.end, nil, .stale))
        }
        return result
    }

    static func moments(_ items: [WidgetItem], now: Date, within range: Range<Date>) -> [Date] {
        var moments: [Date] = []
        for item in items {
            if item.timerClock != nil {
                moments += (1...6).map { now.addingTimeInterval(Double($0) * 300) }
            }
            if let start = item.quitStart {
                let first = max(range.lowerBound, now)
                // Each new day of the run, and in its first day each hour ("14h" on the Lock Screen).
                var day = (first.timeIntervalSince(start) / 86_400).rounded(.down) + 1
                while day < 400 {
                    let moment = start.addingTimeInterval(day * 86_400)
                    if moment >= range.upperBound { break }
                    moments.append(moment); day += 1
                }
                if first.timeIntervalSince(start) < 86_400 {
                    for hour in 1...24 { moments.append(start.addingTimeInterval(Double(hour) * 3600)) }
                }
                if let best = item.quitBest { moments.append(start.addingTimeInterval(best)) }
            }
        }
        return moments.filter { $0 > now && range.contains($0) }
    }

    /// A quit counter after the snapshot's days: it keeps counting (one entry a day for 30 days) until a known pause or
    /// end; nil for anything else.
    private static func counterEntries(_ snapshot: WidgetSnapshot, now: Date, selection: String?,
                                       make: (Date, WidgetFrame?, PhoneWidgetEntry.Status) -> PhoneWidgetEntry) -> [PhoneWidgetEntry]? {
        guard let selection, let item = snapshot.frames.last?.item(selection), item.state == nil,
              let start = item.quitStart, let until = item.quitUntil, now < until else { return nil }
        var item2 = item
        item2.token = UUID().uuidString
        let frame = WidgetFrame(day: "counter", start: now, end: until, items: [item2])
        var dates: [Date] = [now]
        var day = (now.timeIntervalSince(start) / 86_400).rounded(.down) + 1
        while dates.count < 31 {
            let moment = start.addingTimeInterval(day * 86_400)
            if moment >= until { break }
            dates.append(moment); day += 1
        }
        var result = dates.map { make($0, frame, .ready) }
        if until < .distantFuture { result.append(make(until, nil, .stale)) }
        return result
    }

    static func timeline(_ entries: [PhoneWidgetEntry]) -> Timeline<PhoneWidgetEntry> {
        #if DEBUG
        WidgetTiming.mark("timeline: \(entries.count) entries, status \(entries.first.map { "\($0.status)" } ?? "none")")
        #endif
        let now = Date.now
        let running = entries.first?.frame?.items.contains { $0.timerClock != nil } ?? false
        // Ask again when the entries run out or the horizon is reached, whichever is first; a running timer's fill is
        // drawn for half an hour, then asked for again. Never sooner than 5 minutes (Apple's minimum spacing).
        let last = entries.last.map { max($0.date, now.addingTimeInterval(300)) } ?? now.addingTimeInterval(3600)
        let next = min(last, now.addingTimeInterval(running ? 30 * 60 : horizon))
        return Timeline(entries: entries, policy: .after(next))
    }
}

nonisolated struct AgendaWidgetProvider: AppIntentTimelineProvider {
    var kind = PhoneWidgetKind.agenda
    var layout = PhoneWidgetLayout.habits
    func placeholder(in context: Context) -> PhoneWidgetEntry { WidgetSamples.entry(layout) }
    func snapshot(for configuration: AgendaWidgetConfiguration, in context: Context) async -> PhoneWidgetEntry {
        context.isPreview ? WidgetSamples.entry(layout) : await configured(configuration, family: context.family).first!
    }
    func timeline(for configuration: AgendaWidgetConfiguration, in context: Context) async -> Timeline<PhoneWidgetEntry> {
        PhoneWidgetTimeline.timeline(await configured(configuration, family: context.family))
    }
    /// The configuration is read on the main actor (it's the app's main-actor type when the app compiles it).
    @MainActor private func configured(_ config: AgendaWidgetConfiguration, family: WidgetFamily) -> [PhoneWidgetEntry] {
        let snapshot = WidgetDisk.read()
        let view = config.view?.id ?? WidgetListSection.today
        let key = view == WidgetListSection.today ? "habits" : "habits:" + view
        let pageKey = "\(kind).\(family.rawValue).\(view)"
        let page = WidgetDisk.page(key: pageKey)
        return PhoneWidgetTimeline.entries(snapshot: snapshot, listKey: key) { entry in
            entry.view = view
            entry.viewName = view == WidgetListSection.today ? "Today"
                : snapshot?.sections.first { $0.id == view }?.name ?? config.view?.name ?? "Section"
            entry.viewMissing = view != WidgetListSection.today && snapshot.map { !$0.hidden && !$0.sections.contains { $0.id == view } } == true
            entry.page = page; entry.pageKey = pageKey; entry.kind = kind
        }
    }
}

nonisolated struct TasksWidgetProvider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> PhoneWidgetEntry { WidgetSamples.entry(.tasks) }
    func snapshot(for configuration: TasksWidgetConfiguration, in context: Context) async -> PhoneWidgetEntry {
        context.isPreview ? WidgetSamples.entry(.tasks) : await configured(configuration, family: context.family).first!
    }
    func timeline(for configuration: TasksWidgetConfiguration, in context: Context) async -> Timeline<PhoneWidgetEntry> {
        PhoneWidgetTimeline.timeline(await configured(configuration, family: context.family))
    }
    @MainActor private func configured(_ config: TasksWidgetConfiguration, family: WidgetFamily) -> [PhoneWidgetEntry] {
        let snapshot = WidgetDisk.read()
        let view = config.view?.id ?? WidgetListSection.today
        let key = view == WidgetListSection.today ? "tasks" : "tasks:" + view
        let pageKey = "\(PhoneWidgetKind.tasks).\(family.rawValue).\(view)"
        let page = WidgetDisk.page(key: pageKey)
        return PhoneWidgetTimeline.entries(snapshot: snapshot, listKey: key) { entry in
            entry.view = view
            entry.viewName = view == WidgetListSection.today ? "Tasks"
                : (snapshot?.taskSections.first { $0.id == view }?.name ?? config.view?.name ?? "Section") + " tasks"
            entry.viewMissing = view != WidgetListSection.today && snapshot.map { !$0.hidden && !$0.taskSections.contains { $0.id == view } } == true
            entry.page = page; entry.pageKey = pageKey; entry.kind = PhoneWidgetKind.tasks
        }
    }
}

nonisolated struct ItemWidgetProvider: AppIntentTimelineProvider {
    var layout = PhoneWidgetLayout.item
    func placeholder(in context: Context) -> PhoneWidgetEntry { WidgetSamples.entry(layout) }
    func snapshot(for configuration: ItemWidgetConfiguration, in context: Context) async -> PhoneWidgetEntry {
        context.isPreview ? WidgetSamples.entry(layout) : await configured(configuration).first!
    }
    func timeline(for configuration: ItemWidgetConfiguration, in context: Context) async -> Timeline<PhoneWidgetEntry> {
        PhoneWidgetTimeline.timeline(await configured(configuration))
    }
    @MainActor private func configured(_ config: ItemWidgetConfiguration) -> [PhoneWidgetEntry] {
        PhoneWidgetTimeline.entries(snapshot: WidgetDisk.read(), selection: config.item?.id) { _ in }
    }
}

nonisolated struct WeekWidgetProvider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> PhoneWidgetEntry { WidgetSamples.entry(.week) }
    func snapshot(for configuration: HistoryWidgetConfiguration, in context: Context) async -> PhoneWidgetEntry {
        context.isPreview ? WidgetSamples.entry(.week) : await configured(configuration).first!
    }
    func timeline(for configuration: HistoryWidgetConfiguration, in context: Context) async -> Timeline<PhoneWidgetEntry> {
        PhoneWidgetTimeline.timeline(await configured(configuration))
    }
    @MainActor private func configured(_ config: HistoryWidgetConfiguration) -> [PhoneWidgetEntry] {
        PhoneWidgetTimeline.entries(snapshot: WidgetDisk.read(), selection: config.item?.id) { _ in }
    }
}

// MARK: - Widgets

struct TodayPhoneWidget: Widget {
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: PhoneWidgetKind.agenda, intent: AgendaWidgetConfiguration.self, provider: AgendaWidgetProvider()) {
            PhoneWidgetView(entry: $0, layout: .habits)
        }.configurationDisplayName("Today")
            .description("Your habits for today, or one section of your day. Tap to log.")
            .contentMarginsDisabled()
            .supportedFamilies([.systemMedium, .systemLarge])
    }
}
struct TasksPhoneWidget: Widget {
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: PhoneWidgetKind.tasks, intent: TasksWidgetConfiguration.self, provider: TasksWidgetProvider()) {
            PhoneWidgetView(entry: $0, layout: .tasks)
        }.configurationDisplayName("Tasks")
            .description("Today's tasks, or one section's. Tap to check them off.")
            .contentMarginsDisabled()
            .supportedFamilies([.systemMedium, .systemLarge])
    }
}
struct ItemPhoneWidget: Widget {
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: PhoneWidgetKind.item, intent: ItemWidgetConfiguration.self, provider: ItemWidgetProvider()) {
            PhoneWidgetView(entry: $0, layout: .item)
        }.configurationDisplayName("One habit")
            .description("One habit's progress today. Touch and hold, then Edit Widget to choose the habit.")
            .contentMarginsDisabled()
            .supportedFamilies([.systemSmall, .accessoryCircular, .accessoryInline])
    }
}
struct WeekPhoneWidget: Widget {
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: PhoneWidgetKind.history, intent: HistoryWidgetConfiguration.self, provider: WeekWidgetProvider()) {
            PhoneWidgetView(entry: $0, layout: .week)
        }.configurationDisplayName("This week")
            .description("One habit: today's progress and the week so far.")
            .contentMarginsDisabled()
            .supportedFamilies([.systemMedium])
    }
}
struct LockTodayPhoneWidget: Widget {
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: PhoneWidgetKind.lock, intent: AgendaWidgetConfiguration.self,
                               provider: AgendaWidgetProvider(kind: PhoneWidgetKind.lock)) {
            PhoneWidgetView(entry: $0, layout: .habits)
        }.configurationDisplayName("Today")
            .description("How many habits are done today, and what's left.")
            .contentMarginsDisabled()
            .supportedFamilies([.accessoryRectangular, .accessoryInline])
    }
}

// MARK: - The view

struct PhoneWidgetView: View {
    let entry: PhoneWidgetEntry
    let layout: PhoneWidgetLayout
    /// WidgetKit supplies the family; the app-hosted render check passes one in, using the same views.
    var familyOverride: WidgetFamily? = nil
    @Environment(\.widgetFamily) private var systemFamily
    private var family: WidgetFamily { familyOverride ?? systemFamily }
    private var accessory: Bool { [.accessoryInline, .accessoryCircular, .accessoryRectangular].contains(family) }

    var body: some View {
        #if DEBUG
        let _ = WidgetTiming.enabled ? WidgetTiming.mark("render: \(layout) \(family) entry at \(Int(entry.date.timeIntervalSinceNow)) s") : ()
        #endif
        content
            // Names and progress stay hidden on a locked phone where the person's settings ask for it (spec §9).
            .privacySensitive()
            .containerBackground(for: .widget) {
                if accessory { Color.clear } else { Color(.systemBackground) }
            }
            .widgetURL(url)
    }

    @ViewBuilder private var content: some View {
        switch family {
        case .accessoryCircular: LockCircle(entry: entry)
        case .accessoryInline: LockInline(entry: entry, layout: layout)
        case .accessoryRectangular: LockRectangle(entry: entry)
        default:
            switch layout {
            case .habits, .tasks: ListWidget(entry: entry, tasks: layout == .tasks, large: family == .systemLarge)
            case .item: SmallWidget(entry: entry)
            case .week: WeekWidget(entry: entry)
            }
        }
    }

    /// The body of a one-habit widget opens its Day details; a list's opens its view; recovery opens the setup guide.
    private var url: URL {
        switch layout {
        case .item, .week:
            if let item = entry.selected, entry.status == .ready { return item.url }
            return URL(string: entry.status == .ready ? "oftenenough://widgets" : "oftenenough://today")!
        case .habits, .tasks:
            return WidgetLinks.view(entry.view)
        }
    }
}

nonisolated enum WidgetLinks {
    static let today = URL(string: "oftenenough://today")!
    static let setup = URL(string: "oftenenough://widgets")!
    static func view(_ id: String) -> URL {
        id == WidgetListSection.today ? today : URL(string: "oftenenough://section/" + id) ?? today
    }
}

// MARK: - The round button

/// The one button on a row or card (U14), drawn like the app's `RoundActionButton`: neutral fill and ink until positive
/// completion, then the habit's colour with white (U2). A 44 × 44 target around a 32 or 44 pt circle.
struct WidgetActionButton: View {
    let item: WidgetItem
    let day: String
    var size: CGFloat = 32
    var sample = false
    /// Small widgets can't hold a Link: an open action goes through `OpenURLIntent`.
    var small = false

    private var colored: Bool { item.done && item.state == nil && item.timerClock == nil && !item.limit }

    var body: some View {
        Group {
            if sample {
                face
            } else {
                switch item.action {
                #if DEBUG
                case .check where WidgetProbe.mode == "live", .add where WidgetProbe.mode == "live":
                    Button(intent: WidgetProbeLiveIntent()) { face }.buttonStyle(.plain)
                case .check where WidgetProbe.mode == "extension", .add where WidgetProbe.mode == "extension":
                    Button(intent: WidgetProbeExtensionIntent()) { face }.buttonStyle(.plain)
                case .check where WidgetProbe.mode == "chain", .add where WidgetProbe.mode == "chain":
                    Button(intent: WidgetProbeChainIntent()) { face }.buttonStyle(.plain)
                #endif
                case .check, .add:
                    // A switch, so iOS shows the tap at once, before the app has saved it (Current Work 66). A ✓ is on
                    // when the day is ticked; a + is always off, and "on" draws the moment after one more.
                    Toggle(isOn: item.action == .check && item.done, intent: WidgetTapIntent(item: item, day: day)) { EmptyView() }
                        .toggleStyle(WidgetRoundToggleStyle(item: item, size: size))
                        // VoiceOver hears the button it is ("Add 1 to Water", "Mark Read done"), not "switch, off".
                        .accessibilityRemoveTraits(.isToggle)
                        .accessibilityAddTraits(.isButton)
                case .timerStart, .timerPause:
                    // A switch too: ▶ becomes ⏸ the moment it's touched; the app starts or stops the timer behind it
                    // and the Live Activity shows it (Current Work 66).
                    Toggle(isOn: item.action == .timerPause, intent: WidgetTimerIntent(item: item, day: day)) { EmptyView() }
                        .toggleStyle(WidgetTimerToggleStyle(item: item, size: size))
                        .accessibilityRemoveTraits(.isToggle)
                        .accessibilityAddTraits(.isButton)
                case .open:
                    if small {
                        Button(intent: OpenURLIntent(item.routeURL)) { face }.buttonStyle(.plain)
                    } else {
                        Link(destination: item.routeURL) { face }
                    }
                }
            }
        }
        .accessibilityLabel(label)
    }

    private var face: some View { WidgetRoundFace(item: item, size: size, touched: false) }

    private var label: String { Self.label(for: item) }

    static func label(for item: WidgetItem) -> String {
        switch item.action {
        case .check: item.done ? "Undo \(item.name)" : "Mark \(item.name) done"
        case .add: "Add \(String((item.actionText ?? "+1").dropFirst())) to \(item.name)"
        case .timerStart: "Start \(item.name) timer"
        case .timerPause: "Pause \(item.name) timer"
        case .open:
            switch item.route?.split(separator: "/").dropFirst().first.map({ String($0) }) ?? "" {
            case "log": "Log an amount for \(item.name)"
            case "slip": "Record a slip for \(item.name)"
            case "timer": item.timerClock == nil ? "Start \(item.name) timer" : "Open \(item.name) timer"
            default: item.type == "checklist" && item.state == nil ? "Open \(item.name) steps" : "Open \(item.name)"
            }
        }
    }
}

/// The widget's ✓ and + as a switch: iOS draws both states ahead of time and shows the other one the moment it's
/// touched (Apple, WWDC23 "Bring widgets to life"), so a tap shows at once while the app saves it behind.
struct WidgetRoundToggleStyle: ToggleStyle {
    let item: WidgetItem
    let size: CGFloat
    func makeBody(configuration: Configuration) -> some View {
        // A ✓: on is ticked. A +: on is "just tapped".
        WidgetRoundFace(item: item, size: size, touched: item.action == .add && configuration.isOn,
                        ticked: item.action == .check ? configuration.isOn : nil)
    }
}

/// ▶ and ⏸ as a switch: on is running.
// LOCKED (widget taps, 8 Oct 2026): ▶/⏸ is a switch; the timer runs on the widget (W7). Read iOS/Docs/Widgets — Taps and Updates (Locked).md before changing; changes need the user's say-so.
struct WidgetTimerToggleStyle: ToggleStyle {
    let item: WidgetItem
    let size: CGFloat
    func makeBody(configuration: Configuration) -> some View {
        var shown = item
        shown.action = configuration.isOn ? .timerPause : .timerStart
        return WidgetRoundFace(item: shown, size: size)
    }
}

/// The round button, exactly as the app's `RoundActionButton` draws it: neutral fill and ink until positive completion,
/// then the habit's colour with white (U2). A 44 × 44 target around a 32 or 44 pt circle.
struct WidgetRoundFace: View {
    let item: WidgetItem
    var size: CGFloat = 32
    /// A + the moment it's touched: the habit's colour when this tap meets the goal, else the row's light tint of it
    /// (a limit's neutral grey), until the widget redraws with the saved numbers.
    var touched = false
    /// A ✓'s state as the switch shows it (nil: as saved).
    var ticked: Bool? = nil
    @Environment(\.colorScheme) private var scheme

    private var colored: Bool {
        if let ticked { return ticked && item.state == nil }
        if touched { return !item.limit && (item.done || item.completesNext == true) }
        return item.done && item.state == nil && item.timerClock == nil && !item.limit
    }
    private var tinted: Bool { touched && !colored }

    var body: some View {
        ZStack {
            Circle().fill(colored ? AnyShapeStyle(WidgetPalette.main(item.color))
                          : tinted ? AnyShapeStyle(item.limit ? Color.primary.opacity(0.18) : WidgetPalette.main(item.color).opacity(scheme == .dark ? 0.34 : 0.22))
                          : AnyShapeStyle(Color(.tertiarySystemFill)))
                .widgetAccentable(colored)
            glyph.foregroundStyle(colored ? Color.white : WidgetPalette.ink)
        }
        .frame(width: size, height: size)
        .frame(width: max(44, size), height: max(44, size))
        .contentShape(Rectangle())
    }

    @ViewBuilder private var glyph: some View {
        let glyphSize: CGFloat = size >= 44 ? 20 : 17
        switch item.action {
        case .add where item.type == "check":
            // A check habit counted several times, or toward a week or month goal: a ✓ that adds one check, never a
            // +1 (the user, 7 Oct 2026, Current Work 64). It fills only when the goal is met.
            Image(systemName: "checkmark").font(.system(size: glyphSize, weight: .semibold))
        case .add:
            Text(item.actionText ?? "+1").font(.system(size: size >= 44 ? 17 : 15, weight: .semibold).monospacedDigit())
                .lineLimit(1).minimumScaleFactor(0.55).padding(.horizontal, 3)
        case .check:
            Image(systemName: "checkmark").font(.system(size: glyphSize, weight: .semibold))
        case .timerStart:
            Image(systemName: "play.fill").font(.system(size: glyphSize - 2, weight: .semibold))
        case .timerPause:
            Image(systemName: "pause.fill").font(.system(size: glyphSize - 2, weight: .semibold))
        case .open:
            if item.state == nil, item.route?.hasPrefix("oftenenough://timer/") == true {
                Image(systemName: item.timerClock == nil ? "play.fill" : "pause.fill").font(.system(size: glyphSize - 2, weight: .semibold))
            // LOCKED (widget taps, 8 Oct 2026): a number to type shows a plain +; ↗ only for steps and quit (W8). Read iOS/Docs/Widgets — Taps and Updates (Locked).md before changing; changes need the user's say-so.
            } else if item.state == nil, item.route?.hasPrefix("oftenenough://log/") == true {
                // A number typed in the app: a plain +, as on Today's row (the user, 8 Oct 2026). The arrow stays for
                // what opens a screen of its own (a checklist's steps, a quit habit's slip).
                Image(systemName: "plus").font(.system(size: glyphSize, weight: .semibold))
            } else {
                Image(systemName: "arrow.up.right").font(.system(size: glyphSize - 2, weight: .semibold))
            }
        }
    }

}

// MARK: - The whole card at once (Current Work 66)

// LOCKED (widget taps, 8 Oct 2026): the card switch, its touch area, the header count and VoiceOver (W2, W6, W12, W13, W16). Read iOS/Docs/Widgets — Taps and Updates (Locked).md before changing; changes need the user's say-so.

/// Where a card's switch takes the touch: only its round button. The rest of the card keeps its own link.
nonisolated enum WidgetButtonRegion: Sendable {
    /// A 44-pt square at the top right (Small and the weekly card).
    case topTrailing
    /// A 44-pt square at the right, centred (a list row).
    case trailing
    /// The whole thing (the Lock Screen circle).
    case whole
    /// Nothing: the touch goes to what's inside (a + that has handed on to its next tap's switch).
    case none
}

struct WidgetButtonShape: Shape {
    let region: WidgetButtonRegion
    func path(in rect: CGRect) -> Path {
        switch region {
        case .whole: Path(rect)
        case .none: Path()
        case .topTrailing: Path(CGRect(x: rect.maxX - 44, y: rect.minY, width: 44, height: 44))
        case .trailing: Path(CGRect(x: rect.maxX - 44, y: rect.midY - 22, width: 44, height: 44))
        }
    }
}

/// The list header redrawn with one more (or one fewer) done, laid over the real one while a row shows its tap.
struct WidgetHeaderPatch {
    /// Where the header starts, in the list's coordinate space ("widgetList"), and how tall it is.
    let top: CGFloat
    let height: CGFloat
    let header: (Int) -> ListHeader
    let done: Int
}

/// A card or row as one switch (the user, 8 Oct 2026: "when I check it, immediately everything on the card should be
/// updated", as Reminders does). iOS draws a switch in both states ahead of time and shows the other the moment it's
/// touched, so the card shows its state after the tap at once: the button, the number, the bar, the row's fill, and a
/// list's "N of M done". Both states are the app's own (`WidgetItem.after`), never worked out here. The app saves the
/// tap behind it (`WidgetLogIntent`); the widget redraws with the saved data a few seconds later (L24).
struct WidgetTapCard<Content: View>: View {
    let item: WidgetItem
    let day: String
    var sample = false
    let region: WidgetButtonRegion
    var headerPatch: WidgetHeaderPatch? = nil
    /// The card showing `item`; `live`: its button is a real control (when this card isn't a switch).
    @ViewBuilder let content: (_ item: WidgetItem, _ live: Bool) -> Content

    private var probing: Bool {
        #if DEBUG
        WidgetProbe.mode != nil
        #else
        false
        #endif
    }

    var body: some View {
        if !sample, !probing, item.state == nil, item.action == .check || item.action == .add, let after = item.after?.first {
            let resting = item.action == .check && item.done
            Toggle(isOn: resting, intent: WidgetTapIntent(item: item, day: day)) { EmptyView() }
                .toggleStyle(WidgetCardToggleStyle(day: day, resting: resting, now: item, after: after, region: region,
                                                   headerPatch: headerPatch, content: content))
                // VoiceOver: one button named for what it does, with the card's state ("Add 1 to Water, 6 of 8
                // glasses"). The rest of the card still opens the app.
                .accessibilityElement(children: .ignore)
                .accessibilityRemoveTraits(.isToggle)
                .accessibilityAddTraits(.isButton)
                .accessibilityLabel(WidgetActionButton.label(for: item))
                .accessibilityValue(item.value.isEmpty ? item.line : item.value)
        } else {
            content(item, true)
        }
    }
}

struct WidgetCardToggleStyle<Content: View>: ToggleStyle {
    let day: String
    let resting: Bool
    let now: WidgetItem
    let after: WidgetItem
    let region: WidgetButtonRegion
    let headerPatch: WidgetHeaderPatch?
    let content: (WidgetItem, Bool) -> Content

    func makeBody(configuration: Configuration) -> some View {
        let tapped = configuration.isOn != resting
        content(tapped ? after : now, false)
            .contentShape(WidgetButtonShape(region: region))
            .overlay(alignment: .topLeading) {
                if tapped, let headerPatch, after.counts, after.countsDone != now.countsDone {
                    GeometryReader { geometry in
                        let frame = geometry.frame(in: .named("widgetList"))
                        // Only the count is drawn, on the same pill as the real one, so nothing else shows twice.
                        headerPatch.header(headerPatch.done + (after.countsDone ? 1 : -1))
                            .frame(width: frame.width, height: headerPatch.height)
                            .offset(y: headerPatch.top - frame.minY)
                    }
                    .allowsHitTesting(false)
                    .accessibilityHidden(true)
                }
            }
    }

}

// MARK: - Pieces

/// A quit run, live: "15d 22:36:35". The day count is redrawn at each new day (a timeline entry); the clock runs itself.
struct QuitClock: View {
    let start: Date
    let date: Date
    var body: some View {
        let elapsed = max(0, date.timeIntervalSince(start))
        let days = Int(elapsed / 86_400)
        let anchor = start.addingTimeInterval(Double(days) * 86_400)
        (Text("\(days)d ") + Text(timerInterval: anchor...anchor.addingTimeInterval(86_400), countsDown: false, showsHours: true))
            .monospacedDigit()
            .accessibilityLabel(Text("\(days) days and ") + Text(anchor, style: .relative))
    }
}

/// A row's or card's line, with a running timer's clock live ("Morning · 18:24 of 30 min").
struct WidgetValueLine: View {
    let item: WidgetItem
    let text: String
    var prefix: String = ""
    var body: some View {
        if let clock = item.timerClock {
            Text(prefix.isEmpty ? "" : prefix + " · ") + Text(clock, style: .timer).monospacedDigit() + Text(item.timerGoal ?? "")
        } else {
            Text(text)
        }
    }
}

/// A bar (Small 18 pt, weekly 8 pt): the habit's colour toward its goal, a limit's neutral grey, capped at full.
struct WidgetBar: View {
    let fraction: Double
    let color: Color
    let height: CGFloat
    var body: some View {
        ZStack(alignment: .leading) {
            Capsule().fill(Color(.tertiarySystemFill))
            GeometryReader { proxy in
                let f = min(1, max(0, fraction))
                if f > 0 {
                    Capsule().fill(color).frame(width: max(height, proxy.size.width * f))
                }
            }
            .widgetAccentable()
        }
        .frame(height: height)
        .accessibilityHidden(true)
    }
}

/// A list's or card's honest empty, private or unavailable state: a symbol, a title and what to do.
struct WidgetMessage: View {
    let symbol: String?
    let title: String
    let subtitle: String
    var body: some View {
        VStack(spacing: 4) {
            if let symbol { Image(systemName: symbol).font(.title3).foregroundStyle(.secondary) }
            Text(title).font(.headline).multilineTextAlignment(.center)
            Text(subtitle).font(.caption.weight(.medium)).foregroundStyle(.secondary).multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .accessibilityElement(children: .combine)
    }
}

/// What a running timer or a quit counter shows at an entry's date.
nonisolated enum WidgetLive {
    static func fraction(_ item: WidgetItem, at date: Date, card: Bool) -> Double? {
        if let clock = item.timerClock, let goalAt = item.timerGoalAt, goalAt > clock {
            return max(0, date.timeIntervalSince(clock)) / goalAt.timeIntervalSince(clock)
        }
        if let start = item.quitStart {
            guard let best = item.quitBest, best > 0 else { return card ? 0 : nil }
            return date.timeIntervalSince(start) / best
        }
        return card ? item.cardFraction : item.fraction
    }
    /// "Best 45 days", "New best" once the run passes it, "Quitting" with no earlier run.
    static func quitLine(_ item: WidgetItem, at date: Date) -> String {
        guard let start = item.quitStart else { return item.caption ?? "" }
        if let best = item.quitBest, best > 0 {
            return date.timeIntervalSince(start) > best ? "New best" : item.quitBestText ?? ""
        }
        return "Quitting"
    }
}

// MARK: - Lists (Medium and Large; habits and tasks)

struct ListWidget: View {
    let entry: PhoneWidgetEntry
    let tasks: Bool
    let large: Bool
    @Environment(\.dynamicTypeSize) private var textSize

    /// Large 5 a page, Medium 2 (the user, 6 Oct 2026); fewer at the largest text sizes, never squeezed.
    private var capacity: Int {
        if large { return textSize.isAccessibilitySize ? 3 : 5 }
        return textSize >= .xxLarge ? 1 : 2
    }
    private var items: [WidgetItem] {
        guard let frame = entry.frame else { return [] }
        return frame.list(entry.listKey(tasks ? "tasks" : "habits"), at: entry.date)
    }

    var body: some View {
        let items = self.items
        let pages = WidgetPaging.pages(items.count, capacity: capacity)
        let page = WidgetPaging.clamp(entry.page, count: items.count, capacity: capacity)
        let shown = WidgetPaging.slice(items, page: page, capacity: capacity)
        // Slots: a full page keeps every page's buttons in the same places; with no pages a Large list of four or
        // fewer uses taller rows, and a single Medium row fills the widget.
        let slots = pages > 1 ? capacity : large ? (items.count >= capacity ? capacity : max(1, min(capacity - 1, 4))) : max(1, items.count)
        let counted = items.filter(\.counts)
        let done = counted.filter(\.countsDone).count
        // A row's tap redraws this header with the new "N of M done" at once (Current Work 66).
        let patch = WidgetHeaderPatch(top: large ? 16 : 12, height: large ? 44 : 22,
                                      header: { header(counted: counted.count, done: $0, page: page, pages: pages, live: false, covering: done) },
                                      done: done)
        VStack(alignment: .leading, spacing: large ? 10 : 12) {
            header(counted: counted.count, done: done, page: page, pages: pages)
            if entry.status != .ready || entry.frame == nil || entry.viewMissing || items.isEmpty {
                message
            } else {
                VStack(spacing: 12) {
                    ForEach(0..<slots, id: \.self) { slot in
                        if slot < shown.count {
                            WidgetListRow(item: shown[slot], day: entry.frame?.day ?? "", date: entry.date,
                                          showSection: entry.view == WidgetListSection.today, sample: entry.sample,
                                          headerPatch: patch)
                        } else {
                            Color.clear.frame(maxHeight: .infinity)
                        }
                    }
                }
                .frame(maxHeight: .infinity)
            }
        }
        .padding(large ? 16 : 12)
        .coordinateSpace(.named("widgetList"))
    }

    private var title: String { entry.status == .ready ? entry.viewName : tasks ? "Tasks" : "Today" }

    private func header(counted: Int, done: Int, page: Int, pages: Int, live: Bool = true, covering: Int? = nil) -> ListHeader {
        ListHeader(entry: entry, title: title, large: large, counted: counted, done: done, page: page, pages: pages, live: live,
                   covering: covering)
    }

    @ViewBuilder private var message: some View {
        switch entry.status {
        case .hidden: WidgetMessage(symbol: "lock.fill", title: "Content hidden",
                                    subtitle: tasks ? "Unlock the app to see your tasks" : "Open the app to unlock")
        case .stale: WidgetMessage(symbol: "arrow.clockwise", title: "Open to update", subtitle: "Data unavailable")
        case .ready:
            if entry.viewMissing {
                WidgetMessage(symbol: nil, title: "Section unavailable", subtitle: "Touch and hold · Edit Widget")
            } else if tasks {
                WidgetMessage(symbol: nil, title: entry.view == WidgetListSection.today ? "No tasks today" : "No \(entry.viewName.lowercased()) today",
                              subtitle: "Add one in the app")
            } else if entry.noHabits {
                WidgetMessage(symbol: nil, title: "No habits yet", subtitle: "Start one in the app")
            } else {
                WidgetMessage(symbol: nil, title: entry.view == WidgetListSection.today ? "Nothing planned for today" : "Nothing planned in \(entry.viewName)",
                              subtitle: "Open \(entry.viewName)")
            }
        }
    }
}

/// A list's header: its name (a link to that view), "N of M done", and ‹ › when it has pages.
struct ListHeader: View {
    let entry: PhoneWidgetEntry
    let title: String
    let large: Bool
    let counted: Int
    let done: Int
    let page: Int
    let pages: Int
    /// false: drawn over the real header while a row shows its tap: only the count shows (on its pill, covering the
    /// real one); the title and arrows keep their places but aren't drawn.
    var live = true
    /// The count the real header shows, while this one is drawn over it: the pill is at least as wide as it.
    var covering: Int? = nil

    var body: some View {
        let count = counted == 0 || entry.status != .ready || entry.viewMissing ? nil : "\(done) of \(counted) done"
        HStack(alignment: .center, spacing: 8) {
            titleLink(count)
            Spacer(minLength: 4)
            if pages > 1 && entry.status == .ready {
                pager.opacity(live ? 1 : 0)
            } else if let count {
                countText(count)
            }
        }
        .frame(height: large ? 44 : 22)
        .accessibilityElement(children: .contain)
    }

    /// "2 of 5 done" on a pill of the colour nearest the widget's own background: a row's tap draws the new count on
    /// the same pill exactly over it (Current Work 66), since a widget can't paint the system's background itself.
    private func countText(_ count: String) -> some View {
        ZStack(alignment: .trailing) {
            if let covering, counted > 0 { Text("\(covering) of \(counted) done").hidden() }
            Text(count)
        }
        .font(.footnote.weight(.semibold)).foregroundStyle(.secondary).lineLimit(1)
        .padding(.horizontal, 4)
        .background(Capsule().fill(Color(.tertiarySystemBackground)))
    }

    @ViewBuilder private func titleLink(_ count: String?) -> some View {
        let label = Group {
            if large && pages > 1 {
                VStack(alignment: .leading, spacing: 0) {
                    Text(title).font(.title2.weight(.semibold)).lineLimit(1).opacity(live ? 1 : 0)
                    if let count { countText(count) }
                }
            } else {
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Text(title).font(large ? .title2.weight(.semibold) : .headline).lineLimit(1).opacity(live ? 1 : 0)
                    if pages > 1, let count { countText(count) }
                }
            }
        }
        if live { Link(destination: WidgetLinks.view(entry.view)) { label } } else { label }
    }

    private var pager: some View {
        HStack(spacing: 0) {
            pageButton("chevron.left", to: page - 1, enabled: page > 0, label: "Previous page")
            Text("\(page + 1)/\(pages)").font(.footnote.weight(.semibold)).monospacedDigit().frame(minWidth: 28)
                .accessibilityLabel("Page \(page + 1) of \(pages)")
            pageButton("chevron.right", to: page + 1, enabled: page + 1 < pages, label: "Next page")
        }
    }

    @ViewBuilder private func pageButton(_ symbol: String, to page: Int, enabled: Bool, label: String) -> some View {
        let face = Image(systemName: symbol).font(.system(size: 17, weight: .semibold))
            .foregroundStyle(enabled ? AnyShapeStyle(.primary) : AnyShapeStyle(.tertiary))
            .frame(width: 44, height: 44).contentShape(Rectangle())
        if live && enabled && !entry.sample {
            #if DEBUG
            if WidgetProbe.pageMode == "live" {
                Button(intent: WidgetPageLiveProbeIntent(key: entry.pageKey, page: page, kind: entry.kind)) { face }
                    .buttonStyle(.plain).accessibilityLabel(label)
            } else {
                Button(intent: WidgetPageIntent(key: entry.pageKey, page: page, kind: entry.kind)) { face }
                    .buttonStyle(.plain).accessibilityLabel(label)
            }
            #else
            Button(intent: WidgetPageIntent(key: entry.pageKey, page: page, kind: entry.kind)) { face }
                .buttonStyle(.plain).accessibilityLabel(label)
            #endif
        } else {
            face.accessibilityLabel(label).accessibilityHidden(!enabled)
        }
    }
}

/// One row: icon, name, one line, the button; the row fills toward its goal: today's, or a week or month goal's (U25).
struct WidgetListRow: View {
    let item: WidgetItem
    let day: String
    let date: Date
    /// In a Today list the line starts with the section ("Anytime · 3 of 8 glasses"); a section's own list drops it.
    let showSection: Bool
    var sample = false
    var headerPatch: WidgetHeaderPatch? = nil

    var body: some View {
        if item.after?.isEmpty == false, !sample {
            // The row as one switch (its round button takes the touch), with the rest of the row still opening Day
            // details through a link laid over it.
            ZStack {
                WidgetTapCard(item: item, day: day, sample: sample, region: .trailing, headerPatch: headerPatch) { shown, live in
                    WidgetRowContent(item: shown, day: day, date: date, showSection: showSection, sample: sample, live: live)
                }
                HStack(spacing: 0) {
                    Link(destination: item.url) { Color.white.opacity(0.001).contentShape(Rectangle()) }
                        .accessibilityHidden(true)
                    Color.clear.frame(width: 52).allowsHitTesting(false)
                }
            }
        } else {
            WidgetRowContent(item: item, day: day, date: date, showSection: showSection, sample: sample, live: true)
        }
    }
}

/// What a list row draws: icon, name, one line and the round button, over the row's fill.
struct WidgetRowContent: View {
    let item: WidgetItem
    let day: String
    let date: Date
    let showSection: Bool
    var sample = false
    /// true: the name opens Day details and the button is a real control; false: drawn inside the row's switch.
    var live = true
    @Environment(\.colorScheme) private var scheme

    var body: some View {
        HStack(spacing: 8) {
            if live {
                Link(destination: item.url) { identity.contentShape(Rectangle()) }
                WidgetActionButton(item: item, day: day, size: 32, sample: sample)
            } else {
                identity
                WidgetRoundFace(item: item, size: 32)
            }
        }
        .padding(.leading, 8)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background { fill }
        .accessibilityElement(children: .contain)
    }

    private var identity: some View {
        HStack(spacing: 10) {
            Image(systemName: item.symbol).font(.system(size: 20, weight: .medium))
                .foregroundStyle(WidgetPalette.mark(item.color)).widgetAccentable()
                .frame(width: 28, height: 28)
            VStack(alignment: .leading, spacing: 1) {
                HStack(alignment: .firstTextBaseline, spacing: 6) {
                    Text(item.name).font(.headline).lineLimit(1)
                    if item.type == "quit", item.state == nil, item.quitStart != nil {
                        Spacer(minLength: 4)
                        Text(WidgetLive.quitLine(item, at: date)).font(.caption.weight(.medium)).foregroundStyle(.secondary).lineLimit(1)
                    }
                }
                lineView.lineLimit(1)
            }
            Spacer(minLength: 0)
        }
    }

    @ViewBuilder private var lineView: some View {
        if item.type == "quit", let start = item.quitStart, item.state == nil {
            QuitClock(start: start, date: date).font(.subheadline.weight(.semibold))
        } else {
            let text = showSection ? (item.todayLine.isEmpty ? item.line : item.todayLine) : (item.line.isEmpty && item.isTask ? "Task" : item.line)
            WidgetValueLine(item: item, text: text, prefix: showSection ? item.place : "")
                .font(.footnote).foregroundStyle(.secondary)
        }
    }

    /// Positive goals only: the habit's colour at 0.15 (light) / 0.26 (dark), left to right; done is fully tinted.
    /// Toward the same goal as Today's row: a week or month goal fills toward its period (8 Oct 2026). No fill for quit
    /// or limits (U25).
    @ViewBuilder private var fill: some View {
        if !item.limitFill, item.state == nil, item.type != "quit", let fraction = WidgetLive.fraction(item, at: date, card: false),
           fraction > 0 {
            WidgetPalette.main(item.color).opacity(scheme == .dark ? 0.26 : 0.15)
                .scaleEffect(x: min(1, fraction), y: 1, anchor: .leading)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                .widgetAccentable()
        }
    }
}

// MARK: - Small · one habit, today

struct SmallWidget: View {
    let entry: PhoneWidgetEntry

    var body: some View {
        Group {
            if entry.status == .hidden {
                recovery("lock.fill", "Content hidden", "Private", button: false)
            } else if entry.status == .stale || entry.frame == nil {
                recovery("arrow.clockwise", "Open to update", "Data unavailable", button: true)
            } else if entry.noHabits {
                recovery("list.bullet", "No habits yet", "Start in the app", button: true)
            } else if entry.selection == nil {
                recovery("list.bullet", "Choose a habit", "Edit Widget", button: true)
            } else if let item = entry.selected {
                card(item)
            } else {
                recovery("list.bullet", "Choose a habit", "Habit unavailable", button: true)
            }
        }
        .padding(16)
    }

    /// The card as one switch (Current Work 66): its round button takes the touch and the whole card shows the tap.
    private func card(_ item: WidgetItem) -> some View {
        WidgetTapCard(item: item, day: entry.frame?.day ?? "", sample: entry.sample, region: .topTrailing) { shown, live in
            cardContent(shown, live: live)
        }
    }

    private func cardContent(_ item: WidgetItem, live: Bool) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center) {
                Image(systemName: item.symbol).font(.system(size: 24, weight: .medium))
                    .foregroundStyle(WidgetPalette.mark(item.color)).widgetAccentable()
                Spacer(minLength: 0)
                if live {
                    WidgetActionButton(item: item, day: entry.frame?.day ?? "", size: 44, sample: entry.sample, small: true)
                } else {
                    WidgetRoundFace(item: item, size: 44)
                }
            }
            Spacer(minLength: 4)
            Text(item.name).font(.headline).lineLimit(1)
            Group {
                if item.type == "quit", let start = item.quitStart, item.state == nil {
                    QuitClock(start: start, date: entry.date).font(.subheadline.weight(.semibold))
                } else {
                    WidgetValueLine(item: item, text: item.value).font(.subheadline)
                }
            }
            .lineLimit(1).minimumScaleFactor(0.8)
            .padding(.top, 2)
            bottom(item).padding(.top, 10)
        }
        .accessibilityElement(children: .contain)
    }

    /// The bar toward the goal (or a limit's grey bar); with no bar, a capsule of supporting text.
    @ViewBuilder private func bottom(_ item: WidgetItem) -> some View {
        if item.state == nil, item.type != "quit", let fraction = WidgetLive.fraction(item, at: entry.date, card: true) {
            WidgetBar(fraction: fraction, color: item.limitFill ? WidgetPalette.limitFill : WidgetPalette.main(item.color), height: 18)
        } else {
            let text = item.type == "quit" && item.state == nil ? WidgetLive.quitLine(item, at: entry.date) : (item.caption ?? "")
            Text(text.isEmpty ? " " : text).font(.caption.weight(.medium)).foregroundStyle(.secondary).lineLimit(1)
                .minimumScaleFactor(0.8)
                .frame(maxWidth: .infinity, minHeight: 18)
                .background(Capsule().fill(Color(.tertiarySystemFill)))
        }
    }

    /// A recovery card: a generic symbol, a title, a caption, and the arrow to the setup guide (choose, unavailable),
    /// or no button at all (hidden: unlock in the app).
    private func recovery(_ symbol: String, _ title: String, _ caption: String, button: Bool) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center) {
                Image(systemName: symbol).font(.system(size: 24, weight: .medium)).foregroundStyle(.secondary)
                Spacer(minLength: 0)
                if button {
                    Image(systemName: "arrow.up.right").font(.system(size: 18, weight: .semibold)).foregroundStyle(WidgetPalette.ink)
                        .frame(width: 44, height: 44).background(Circle().fill(Color(.tertiarySystemFill)))
                }
            }
            .frame(minHeight: 44)
            Spacer(minLength: 4)
            Text(title).font(.headline).lineLimit(2).minimumScaleFactor(0.8)
            Text(caption).font(.caption.weight(.medium)).foregroundStyle(.secondary).lineLimit(1).padding(.top, 2)
        }
        .accessibilityElement(children: .combine)
    }
}

// MARK: - Medium · one habit, this week

struct WeekWidget: View {
    let entry: PhoneWidgetEntry
    @ScaledMetric(relativeTo: .title) private var bigSize: CGFloat = 26
    @ScaledMetric(relativeTo: .caption2) private var dayNameSize: CGFloat = 10

    var body: some View {
        Group {
            if entry.status == .hidden {
                recovery("lock.fill", "Content hidden", "Private", "Unlock the app to see this widget.")
            } else if entry.status == .stale || entry.frame == nil {
                recovery("arrow.clockwise", "Open to update", "Data unavailable", "Open the app to refresh this widget.")
            } else if entry.noHabits {
                recovery("list.bullet", "No habits yet", "Start in the app", "Create a habit in the app, then choose it here.")
            } else if let item = entry.selected {
                card(item)
            } else {
                recovery("list.bullet", "Choose a habit", entry.selection == nil ? "Not selected" : "Habit unavailable",
                         "Touch and hold the widget, then Edit Widget to pick a habit.")
            }
        }
        .padding(12)
    }

    /// The card as one switch (Current Work 66): its round button takes the touch and the whole card shows the tap.
    private func card(_ item: WidgetItem) -> some View {
        WidgetTapCard(item: item, day: entry.frame?.day ?? "", sample: entry.sample, region: .topTrailing) { shown, live in
            cardContent(shown, live: live)
        }
    }

    private func cardContent(_ item: WidgetItem, live: Bool) -> some View {
        HStack(spacing: 12) {
            habitCard(item)
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .center, spacing: 8) {
                    today(item)
                    Spacer(minLength: 0)
                    if live {
                        WidgetActionButton(item: item, day: entry.frame?.day ?? "", size: 44, sample: entry.sample)
                    } else {
                        WidgetRoundFace(item: item, size: 44)
                    }
                }
                if item.state == nil, let fraction = WidgetLive.fraction(item, at: entry.date, card: true) {
                    WidgetBar(fraction: fraction, color: item.limitFill ? WidgetPalette.limitFill : WidgetPalette.main(item.color), height: 8)
                } else {
                    Capsule().fill(Color(.tertiarySystemFill)).frame(height: 8)
                }
                WidgetWeekStrip(item: item, weekdays: entry.weekdays, dayNameSize: dayNameSize)
                    .frame(maxHeight: .infinity)
                    .background(RoundedRectangle(cornerRadius: 16, style: .continuous).fill(WidgetPalette.container))
            }
        }
    }

    private func habitCard(_ item: WidgetItem) -> some View {
        VStack(spacing: 4) {
            Spacer(minLength: 0)
            Image(systemName: item.symbol).font(.system(size: 34, weight: .medium))
                .foregroundStyle(WidgetPalette.mark(item.color)).widgetAccentable()
                .frame(height: 44)
            Text(item.name).font(.subheadline.weight(.semibold)).multilineTextAlignment(.center).lineLimit(2)
                .minimumScaleFactor(0.85)
            underName(item)
            Spacer(minLength: 0)
        }
        .padding(.horizontal, 6)
        .frame(width: 96)
        .frame(maxHeight: .infinity)
        .background(RoundedRectangle(cornerRadius: 16, style: .continuous).fill(WidgetPalette.container))
        .accessibilityElement(children: .combine)
    }

    /// "🔥 12", or a quit run's best, or a limit's state; nothing rather than a zero (U3).
    @ViewBuilder private func underName(_ item: WidgetItem) -> some View {
        if item.type == "quit" {
            Text(item.state == nil ? WidgetLive.quitLine(item, at: entry.date) : (item.quitBestText ?? "Quitting"))
                .font(.caption.weight(.medium)).foregroundStyle(.secondary).lineLimit(1).minimumScaleFactor(0.8)
        } else if item.limit, let caption = item.caption, item.state == nil {
            Text(caption).font(.caption.weight(.medium)).foregroundStyle(.secondary).lineLimit(1).minimumScaleFactor(0.8)
        } else if let streak = item.streak {
            HStack(spacing: 2) {
                Text("🔥").font(.caption)
                Text(streak).font(.subheadline.weight(.semibold)).monospacedDigit()
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Streak \(streak)")
        }
    }

    @ViewBuilder private func today(_ item: WidgetItem) -> some View {
        if item.type == "quit", let start = item.quitStart, item.state == nil {
            VStack(alignment: .leading, spacing: 0) {
                QuitClock(start: start, date: entry.date).font(.system(size: bigSize * 0.85, weight: .semibold))
                    .lineLimit(1).minimumScaleFactor(0.6)
                Text(item.since ?? "").font(.subheadline).foregroundStyle(.secondary).lineLimit(1)
            }
        } else if item.state != nil {
            VStack(alignment: .leading, spacing: 0) {
                Text(item.big).font(.system(size: bigSize, weight: .semibold)).lineLimit(1).minimumScaleFactor(0.7)
                if let caption = item.caption, caption != item.big {
                    Text(caption).font(.subheadline).foregroundStyle(.secondary).lineLimit(1)
                }
            }
        } else if item.goal.isEmpty {
            Text(item.big).font(.system(size: bigSize, weight: .semibold)).lineLimit(1).minimumScaleFactor(0.6)
        } else {
            let long = item.big.count + item.goal.count > 16
            let big: Text = item.timerClock.map { Text($0, style: .timer).monospacedDigit() } ?? Text(item.big)
            (big.font(.system(size: long ? bigSize * 0.85 : bigSize, weight: .semibold))
                + Text(" " + item.goal).font(long ? .footnote : .subheadline).foregroundStyle(.secondary))
                .lineLimit(1).minimumScaleFactor(0.7)
        }
    }

    private func recovery(_ symbol: String, _ title: String, _ subtitle: String, _ instruction: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: symbol).font(.system(size: 30, weight: .medium)).foregroundStyle(.secondary)
                .frame(width: 96).frame(maxHeight: .infinity)
                .background(RoundedRectangle(cornerRadius: 16, style: .continuous).fill(WidgetPalette.container))
            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(title).font(.title3.weight(.semibold)).lineLimit(1).minimumScaleFactor(0.8)
                    Text(subtitle).font(.subheadline).foregroundStyle(.secondary).lineLimit(1)
                }
                Text(instruction).font(.footnote).foregroundStyle(.secondary).multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, maxHeight: .infinity).padding(8)
                    .background(RoundedRectangle(cornerRadius: 16, style: .continuous).fill(WidgetPalette.container))
            }
        }
        .accessibilityElement(children: .combine)
    }
}

/// The week's seven squares, drawn in one pass (S12): the Progress Week's language at 20 pt (the user, 6 Oct 2026).
struct WidgetWeekStrip: View {
    let item: WidgetItem
    let weekdays: [String]
    let dayNameSize: CGFloat
    @Environment(\.colorScheme) private var scheme
    @Environment(\.widgetRenderingMode) private var renderingMode

    var body: some View {
        let dark = scheme == .dark
        VStack(spacing: 4) {
            Canvas { context, size in
                let side: CGFloat = 20
                let gap = max(2, (size.width - side * 7) / 7)
                for (i, code) in item.week.prefix(7).enumerated() {
                    let x = gap / 2 + CGFloat(i) * (side + gap)
                    let rect = CGRect(x: x, y: (size.height - side) / 2, width: side, height: side)
                    draw(code, in: rect, today: i == item.weekToday, dark: dark, context: &context)
                }
            }
            .frame(height: 22)
            HStack(spacing: 0) {
                ForEach(Array(weekdays.prefix(7).enumerated()), id: \.offset) { index, name in
                    Text(name).font(.system(size: dayNameSize, weight: index == item.weekToday ? .semibold : .medium))
                        .foregroundStyle(index == item.weekToday ? .primary : .secondary)
                        .lineLimit(1).minimumScaleFactor(0.7)
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(.horizontal, 6)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(spoken)
    }

    private func draw(_ code: Int, in rect: CGRect, today: Bool, dark: Bool, context: inout GraphicsContext) {
        let radius = rect.width * 0.22
        let square = Path(roundedRect: rect, cornerRadius: radius, style: .continuous)
        let grey = WidgetPalette.hex(dark ? WidgetPalette.emptyDayDark : WidgetPalette.emptyDayLight)
        let sign = WidgetPalette.hex(dark ? WidgetPalette.signDark : WidgetPalette.signLight)
        let outline = WidgetPalette.hex(dark ? WidgetPalette.outlineDark : WidgetPalette.outlineLight)
        let full = renderingMode == .fullColor
        switch code {
        case WidgetCell.blank:
            break
        case WidgetCell.notScheduled:
            context.stroke(Path(roundedRect: rect.insetBy(dx: 0.75, dy: 0.75), cornerRadius: radius, style: .continuous),
                           with: .color(outline), style: StrokeStyle(lineWidth: 1.5, dash: [2.5, 2]))
        case WidgetCell.upcoming, WidgetCell.skipped, WidgetCell.paused:
            context.fill(square, with: .color(grey))
            if code == WidgetCell.skipped { forward(rect, sign, &context) }
            if code == WidgetCell.paused { pause(rect, sign, &context) }
        default:
            let level = max(0, min(5, code))
            if level == 0 {
                context.fill(square, with: .color(grey))
                cross(rect, sign, &context)
            } else {
                let steps = item.heat
                let index = (dark ? 5 : 0) + level - 1
                let color = full && steps.count == 11 ? WidgetPalette.hex(steps[index]) : Color.primary.opacity(0.2 + 0.15 * Double(level))
                context.fill(square, with: .color(color))
                if level >= 4 {
                    let check = !full ? Color(.systemBackground) : dark && steps.count == 11 ? WidgetPalette.hex(steps[10]) : .white
                    tick(rect, check, &context)
                }
            }
        }
        if today {
            context.stroke(Path(roundedRect: rect.insetBy(dx: -2, dy: -2), cornerRadius: radius + 2, style: .continuous),
                           with: .color(outline), lineWidth: 1.5)
        }
    }

    private func tick(_ r: CGRect, _ color: Color, _ context: inout GraphicsContext) {
        var p = Path()
        p.move(to: CGPoint(x: r.minX + r.width * 0.27, y: r.midY + r.height * 0.02))
        p.addLine(to: CGPoint(x: r.minX + r.width * 0.43, y: r.minY + r.height * 0.68))
        p.addLine(to: CGPoint(x: r.minX + r.width * 0.74, y: r.minY + r.height * 0.32))
        context.stroke(p, with: .color(color), style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
    }
    private func cross(_ r: CGRect, _ color: Color, _ context: inout GraphicsContext) {
        let inset = r.width * 0.3
        var p = Path()
        p.move(to: CGPoint(x: r.minX + inset, y: r.minY + inset)); p.addLine(to: CGPoint(x: r.maxX - inset, y: r.maxY - inset))
        p.move(to: CGPoint(x: r.maxX - inset, y: r.minY + inset)); p.addLine(to: CGPoint(x: r.minX + inset, y: r.maxY - inset))
        context.stroke(p, with: .color(color), style: StrokeStyle(lineWidth: 1.7, lineCap: .round))
    }
    private func pause(_ r: CGRect, _ color: Color, _ context: inout GraphicsContext) {
        let h = r.height * 0.42, w = r.width * 0.11, y = r.midY - h / 2
        context.fill(Path(roundedRect: CGRect(x: r.midX - w * 1.6, y: y, width: w, height: h), cornerRadius: w / 2), with: .color(color))
        context.fill(Path(roundedRect: CGRect(x: r.midX + w * 0.6, y: y, width: w, height: h), cornerRadius: w / 2), with: .color(color))
    }
    private func forward(_ r: CGRect, _ color: Color, _ context: inout GraphicsContext) {
        let h = r.height * 0.4, w = r.width * 0.2, y = r.midY - h / 2, x = r.midX - w
        var p = Path()
        p.move(to: CGPoint(x: x, y: y)); p.addLine(to: CGPoint(x: x + w, y: r.midY)); p.addLine(to: CGPoint(x: x, y: y + h)); p.closeSubpath()
        p.move(to: CGPoint(x: x + w, y: y)); p.addLine(to: CGPoint(x: x + 2 * w, y: r.midY)); p.addLine(to: CGPoint(x: x + w, y: y + h)); p.closeSubpath()
        context.fill(p, with: .color(color))
    }

    private var spoken: String {
        let words = item.week.prefix(7).enumerated().map { index, code -> String in
            let name = index < weekdays.count ? weekdays[index] : ""
            let state = switch code {
            case WidgetCell.blank: "before it began"
            case WidgetCell.upcoming: index == item.weekToday ? "open" : "still to come"
            case WidgetCell.notScheduled: "not scheduled"
            case WidgetCell.skipped: "skipped"
            case WidgetCell.paused: "paused"
            case 0: "not done"
            case 4: "done"
            case 5: "more than the goal"
            default: "part done"
            }
            return "\(name) \(state)"
        }
        return "This week: " + words.joined(separator: ", ")
    }
}

// MARK: - Lock Screen

/// One habit in a circle (spec §8): monochrome, the value on one line, a ring to the goal.
struct LockCircle: View {
    let entry: PhoneWidgetEntry

    var body: some View {
        ZStack {
            AccessoryWidgetBackground()
            if entry.status == .hidden {
                Image(systemName: "lock.fill").font(.system(size: 18, weight: .semibold)).accessibilityLabel("Content hidden")
            } else if let item = entry.selected, entry.status == .ready {
                content(item)
            } else {
                VStack(spacing: 1) {
                    Image(systemName: "list.bullet").font(.system(size: 13, weight: .semibold))
                    Text(entry.status == .stale ? "Update" : "Choose").font(.system(size: 12, weight: .semibold)).minimumScaleFactor(0.8)
                }
                .accessibilityElement(children: .combine)
            }
        }
    }

    /// The whole circle is the switch: its ring and number show the tap at once (Current Work 66).
    @ViewBuilder private func content(_ item: WidgetItem) -> some View {
        if let day = entry.frame?.day {
            WidgetTapCard(item: item, day: day, sample: entry.sample, region: .whole) { shown, _ in face(shown) }
        } else {
            face(item)
        }
    }

    private func face(_ item: WidgetItem) -> some View {
        ZStack {
            if let ring = item.ring, item.state == nil, item.type != "quit" {
                Circle().stroke(Color.primary.opacity(0.3), lineWidth: 6).padding(3)
                Circle().trim(from: 0, to: min(1, ring)).stroke(Color.primary, style: StrokeStyle(lineWidth: 6, lineCap: .round))
                    .rotationEffect(.degrees(-90)).padding(3)
            }
            label(item)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(spoken(item))
    }

    @ViewBuilder private func label(_ item: WidgetItem) -> some View {
        if item.state == "paused" {
            VStack(spacing: 0) {
                Image(systemName: item.symbol).font(.system(size: 13, weight: .semibold))
                Text("Paused").font(.system(size: 12, weight: .semibold)).minimumScaleFactor(0.7)
            }
        } else if item.type == "quit", let start = item.quitStart {
            VStack(spacing: 0) {
                Image(systemName: item.symbol).font(.system(size: 13, weight: .semibold))
                Text(HabitRunText.compact(entry.date.timeIntervalSince(start))).font(.system(size: 15, weight: .semibold)).monospacedDigit()
                    .lineLimit(1).minimumScaleFactor(0.6)
            }
        } else if let value = item.lock, item.state == nil {
            VStack(spacing: 0) {
                Image(systemName: item.symbol).font(.system(size: 12, weight: .semibold))
                Text(value).font(.system(size: value.count > 4 ? 12 : 15, weight: .semibold)).monospacedDigit()
                    .lineLimit(1).minimumScaleFactor(0.5)
            }
            .padding(.horizontal, 8)
        } else {
            // A single check: its icon only, inside a full ring once done.
            Image(systemName: item.symbol).font(.system(size: 20, weight: .semibold))
        }
    }

    private func spoken(_ item: WidgetItem) -> String {
        if item.type == "quit", let start = item.quitStart {
            return "\(item.name), \(HabitRunText.compact(entry.date.timeIntervalSince(start))) quit"
        }
        return "\(item.name), \(item.state == nil ? item.value : item.caption ?? item.value)"
    }
}

/// A quit run in the Lock Screen's few characters: "15d", or "14h" on the first day.
nonisolated enum HabitRunText {
    static func compact(_ seconds: TimeInterval) -> String {
        let days = Int(max(0, seconds) / 86_400)
        return days >= 1 ? "\(days)d" : "\(Int(max(0, seconds) / 3600))h"
    }
}

/// The Lock Screen line: one habit ("Smoking · 15d", "Water · 3/8") or Today ("3 of 5 habits done").
struct LockInline: View {
    let entry: PhoneWidgetEntry
    let layout: PhoneWidgetLayout

    var body: some View {
        if entry.status == .hidden {
            Label("Content hidden", systemImage: "lock.fill")
        } else if entry.status != .ready || entry.frame == nil {
            Label("Open to update", systemImage: "arrow.clockwise")
        } else if layout == .item {
            if let item = entry.selected {
                Label { Text(text(item)) } icon: { Image(systemName: item.symbol) }
            } else {
                Label("Choose a habit", systemImage: "list.bullet")
            }
        } else {
            let counted = (entry.frame?.list(entry.listKey("habits"), at: entry.date) ?? []).filter(\.counts)
            let done = counted.filter(\.countsDone).count
            if counted.isEmpty {
                Label("Nothing planned today", systemImage: "checkmark")
            } else if done == counted.count {
                Label("All \(counted.count) habits done", systemImage: "checkmark")
            } else {
                Label("\(done) of \(counted.count) habits done", systemImage: "checkmark")
            }
        }
    }

    private func text(_ item: WidgetItem) -> String {
        if item.state == "paused" { return "\(item.name) · Paused" }
        if item.type == "quit", let start = item.quitStart { return "\(item.name) · " + HabitRunText.compact(entry.date.timeIntervalSince(start)) }
        if item.type == "check" && item.lock == nil { return "\(item.name) · \(item.done ? "Done" : "Not yet")" }
        return "\(item.name) · \(item.lock ?? item.value)"
    }
}

/// Today on the Lock Screen: "Today  3 of 5 done", one segment per habit, and "2 left · Stretch, Read" in the person's
/// own order (never "Next": Anytime and quit habits have no next).
struct LockRectangle: View {
    let entry: PhoneWidgetEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            if entry.status == .hidden {
                Label("Content hidden", systemImage: "lock.fill").font(.headline)
                Text("Open the app to unlock").font(.subheadline)
            } else if entry.status != .ready || entry.frame == nil {
                Text(entry.viewName).font(.headline)
                Text("Open to update").font(.subheadline)
            } else {
                let counted = (entry.frame?.list(entry.listKey("habits"), at: entry.date) ?? []).filter(\.counts)
                let done = counted.filter(\.countsDone).count
                HStack(alignment: .firstTextBaseline, spacing: 6) {
                    Text(entry.viewName).font(.headline).lineLimit(1)
                    if !counted.isEmpty { Text("\(done) of \(counted.count) done").font(.subheadline).lineLimit(1) }
                }
                if counted.isEmpty {
                    Text(entry.noHabits ? "No habits yet" : "Nothing planned").font(.subheadline)
                } else {
                    HStack(spacing: 3) {
                        ForEach(counted.prefix(12)) { item in
                            Capsule().fill(item.countsDone ? Color.primary : Color.primary.opacity(0.3)).frame(height: 4)
                        }
                    }
                    .accessibilityHidden(true)
                    let left = counted.filter { !$0.countsDone }
                    Text(left.isEmpty ? "All done" : "\(left.count) left · " + left.map(\.name).joined(separator: ", "))
                        .font(.subheadline).lineLimit(1)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .accessibilityElement(children: .combine)
    }
}

// MARK: - Gallery samples

/// What the widget gallery shows before a widget is added: sample habits, never the person's data, with buttons that
/// do nothing.
nonisolated enum WidgetSamples {
    static func entry(_ layout: PhoneWidgetLayout) -> PhoneWidgetEntry {
        let frame = self.frame
        var entry = PhoneWidgetEntry(date: .now, frame: frame, status: .ready)
        entry.sample = true
        entry.weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        switch layout {
        case .tasks: entry.viewName = "Tasks"
        case .item, .week: entry.selection = frame.items.first?.id
        case .habits: break
        }
        return entry
    }

    static var frame: WidgetFrame {
        func item(_ n: Int, _ name: String, _ symbol: String, _ color: String, type: String, line: String, section: String,
                  fraction: Double?, done: Bool, action: WidgetAction, text: String? = nil, task: Bool = false) -> WidgetItem {
            var made = WidgetItem(id: String(format: "00000000-0000-0000-0000-%012d", n), name: name, symbol: symbol, color: color,
                                  type: type, isTask: task, line: line, value: line, token: UUID().uuidString, signature: "")
            made.place = section
            made.todayLine = section + " · " + line
            made.cards = [section.lowercased()]
            made.fraction = fraction; made.cardFraction = fraction ?? (done ? 1 : 0)
            made.done = done; made.action = action; made.actionText = text
            made.counts = true; made.countsDone = done
            made.big = line.components(separatedBy: " of ").first ?? line
            made.goal = line.contains(" of ") ? "/ " + (line.components(separatedBy: " of ").last ?? "") : ""
            made.streak = done ? "12" : "5"
            made.week = [4, 4, 4, 2, WidgetCell.upcoming, WidgetCell.upcoming, WidgetCell.upcoming]
            made.weekToday = 3
            made.lock = line.contains(" of ") ? "3/8" : nil
            made.ring = made.cardFraction
            return made
        }
        let items = [
            item(1, "Water", "drop.fill", "blue", type: "amount", line: "3 of 8 glasses", section: "Anytime", fraction: 3.0 / 8,
                 done: false, action: .add, text: "+1"),
            item(2, "Read", "book.fill", "orange", type: "check", line: "Done", section: "Anytime", fraction: 1, done: true, action: .check),
            item(3, "Stretch", "figure.flexibility", "green", type: "check", line: "Done", section: "Morning", fraction: 1, done: true, action: .check),
            item(4, "Meditate", "timer", "purple", type: "duration", line: "12 of 20 min", section: "Morning", fraction: 0.6,
                 done: false, action: .timerStart),
            item(5, "Wind down", "moon.fill", "purple", type: "checklist", line: "2 of 5 steps", section: "Evening", fraction: 0.4,
                 done: false, action: .open),
            item(6, "Water the plants", "drop.fill", "blue", type: "task", line: "", section: "Morning", fraction: 1, done: true,
                 action: .check, task: true),
            item(7, "Return library books", "books.vertical.fill", "orange", type: "task", line: "", section: "Anytime", fraction: nil,
                 done: false, action: .check, task: true),
            item(8, "Pick up parcel", "figure.walk", "green", type: "task", line: "5:00 PM", section: "Afternoon", fraction: nil,
                 done: false, action: .check, task: true),
        ]
        let ids = items.map(\.id)
        return WidgetFrame(day: "sample", start: .distantPast, end: .distantFuture, items: items,
                           lists: ["habits": Array(ids[0..<5]), "tasks": Array(ids[5..<8])])
    }
}
