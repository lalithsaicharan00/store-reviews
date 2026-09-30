import AppIntents
import SwiftUI
import WidgetKit

/// The Today widget (report "Widgets — Tick Without Opening the App", 30 Sep). Free, like every widget (C009).
///
/// Home Screen: how many are done, then today's habits with names (not icons alone), unfinished first, each with the
/// same ✓ or +1 as on Today, tappable without opening the app (C023). Done rows show a filled ✓ and aren't buttons (a
/// widget only adds; a wrong tap is undone in the app, C090). Habits that need typing or a timer open the app.
/// Lock Screen: a ring of done out of planned, and the next habit.
/// It draws only what the app wrote, and turns over at the start of the day by itself (C040).
struct HabitsTodayWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: WidgetShared.kind, provider: TodayProvider()) { entry in
            TodayWidgetView(entry: entry)
                .containerBackground(.background, for: .widget)
        }
        .configurationDisplayName("Today")
        .description("See what's left today and tick habits off without opening the app.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge, .accessoryCircular, .accessoryRectangular, .accessoryInline])
    }
}

struct TodayEntry: TimelineEntry {
    let date: Date
    /// Nil when the app hasn't written this day yet: the widget says so rather than show an old day.
    let day: WidgetDay?
}

struct TodayProvider: TimelineProvider {
    func placeholder(in context: Context) -> TodayEntry { TodayEntry(date: .now, day: .sample) }

    func getSnapshot(in context: Context, completion: @escaping (TodayEntry) -> Void) {
        let day = WidgetFile.read()?.day(at: .now)
        completion(TodayEntry(date: .now, day: day ?? (context.isPreview ? .sample : nil)))
    }

    /// Now, then the start of each day the app has written (tomorrow turns over by itself), then "open the app" once
    /// the last written day has ended. The app asks for a new timeline after every change.
    func getTimeline(in context: Context, completion: @escaping (Timeline<TodayEntry>) -> Void) {
        let now = Date.now
        let file = WidgetFile.read()
        var entries = [TodayEntry(date: now, day: file?.day(at: now))]
        for day in file?.days ?? [] where day.starts > now {
            entries.append(TodayEntry(date: day.starts, day: day))
        }
        if let last = file?.days.map(\.starts).max() {
            let end = last.addingTimeInterval(WidgetFile.dayLength)
            if end > now { entries.append(TodayEntry(date: end, day: nil)) }
        }
        completion(Timeline(entries: entries, policy: .never))
    }
}

struct TodayWidgetView: View {
    let entry: TodayEntry
    @Environment(\.widgetFamily) private var family

    var body: some View {
        if let day = entry.day {
            switch family {
            case .accessoryCircular:
                Gauge(value: Double(day.done), in: 0...Double(max(day.total, 1))) {
                    Image(systemName: "checkmark")
                } currentValueLabel: {
                    Text("\(day.done)")
                }
                .gaugeStyle(.accessoryCircularCapacity)
                .accessibilityLabel("\(day.done) of \(day.total) habits done")
            case .accessoryRectangular:
                VStack(alignment: .leading, spacing: 1) {
                    Text("\(day.done) of \(day.total) done").font(.headline).widgetAccentable()
                    Text(day.next.map { "Next: \($0.name)" } ?? "All done today").lineLimit(1)
                }
            case .accessoryInline:
                Text(day.next == nil ? "All habits done" : "\(day.done) of \(day.total) habits done")
            case .systemSmall:
                VStack(alignment: .leading, spacing: 6) {
                    header(day)
                    Spacer(minLength: 0)
                    if let next = day.next {
                        HabitWidgetRow(row: next, day: day.day, compact: true)
                    } else {
                        Label("All done", systemImage: "checkmark.circle.fill").font(.subheadline.weight(.semibold))
                    }
                }
            default:
                VStack(alignment: .leading, spacing: 6) {
                    header(day)
                    let limit = family == .systemLarge ? 7 : 3
                    ForEach(day.rows.prefix(limit)) { HabitWidgetRow(row: $0, day: day.day, compact: false) }
                    if day.rows.count > limit {
                        Text("+\(day.rows.count - limit) more").font(.caption).foregroundStyle(.secondary)
                    }
                    Spacer(minLength: 0)
                }
            }
        } else {
            VStack(spacing: 6) {
                Image(systemName: "checklist").font(.title2).widgetAccentable()
                if family != .accessoryInline {
                    Text("Open Habits to see today").font(.caption).multilineTextAlignment(.center)
                }
            }
        }
    }

    private func header(_ day: WidgetDay) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .firstTextBaseline) {
                Text("Today").font(.headline)
                Spacer(minLength: 4)
                Text("\(day.done)/\(day.total)").font(.subheadline.weight(.semibold).monospacedDigit()).foregroundStyle(.secondary)
            }
            ProgressView(value: Double(day.done), total: Double(max(day.total, 1)))
                .tint(.primary)
                .widgetAccentable()
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Today, \(day.done) of \(day.total) done")
    }
}

/// One habit: its icon, name and progress, and the same button as on Today.
struct HabitWidgetRow: View {
    let row: WidgetDay.Row
    let day: String
    let compact: Bool

    var body: some View {
        let color = WidgetColor.named(row.color)
        HStack(spacing: 8) {
            Image(systemName: row.symbol)
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(color)
                .frame(width: 26, height: 26)
                .background(Circle().fill(color.opacity(0.15)))
                .widgetAccentable()
            VStack(alignment: .leading, spacing: 0) {
                Text(row.name).font(.subheadline).lineLimit(1)
                if !compact && !row.line.isEmpty {
                    Text(row.line).font(.caption).foregroundStyle(.secondary).monospacedDigit().lineLimit(1)
                }
            }
            Spacer(minLength: 4)
            button(color)
        }
        .opacity(row.done ? 0.6 : 1)
    }

    @ViewBuilder private func button(_ color: Color) -> some View {
        if row.done {
            Image(systemName: "checkmark")
                .font(.system(size: 12, weight: .bold))
                .foregroundStyle(.white)
                .frame(width: 30, height: 30)
                .background(Circle().fill(color))
                .accessibilityLabel("\(row.name) done")
        } else if row.step != nil {
            Button(intent: LogHabitFromWidget(habitID: row.id, day: day)) {
                Text(row.stepLabel)
                    .font(.system(size: 12, weight: .bold).monospacedDigit())
                    .lineLimit(1).minimumScaleFactor(0.6)
                    .foregroundStyle(.primary)
                    .frame(width: 30, height: 30)
                    .background(Circle().fill(Color.primary.opacity(0.1)))
            }
            .buttonStyle(.plain)
            .accessibilityLabel(row.stepLabel == "✓" ? "Mark \(row.name) done" : "Add \(row.stepLabel.dropFirst()) to \(row.name)")
        } else {
            // A timer, a checklist or an amount typed each time: the widget opens the app for it.
            Image(systemName: "chevron.right").font(.caption.weight(.semibold)).foregroundStyle(.tertiary)
                .frame(width: 30, height: 30)
                .accessibilityHidden(true)
        }
    }
}

enum WidgetColor {
    static func named(_ name: String) -> Color {
        switch name {
        case "red": .red
        case "orange": .orange
        case "yellow": .yellow
        case "green": .green
        case "mint": .mint
        case "teal": .teal
        case "cyan": .cyan
        case "indigo": .indigo
        case "purple": .purple
        case "pink": .pink
        case "brown": .brown
        case "gray": .gray
        default: .blue
        }
    }
}

extension WidgetDay {
    /// For the widget gallery and placeholders.
    static let sample = WidgetDay(day: "2026-09-29", starts: .now, rows: [
        .init(id: "1", name: "Drink water", symbol: "drop.fill", color: "blue", progress: 3, goal: 8, suffix: " glasses",
              showsCount: true, step: 1, stepLabel: "+1", isLimit: false, done: false),
        .init(id: "2", name: "Stretch", symbol: "figure.flexibility", color: "teal", progress: 0, goal: 1, suffix: "",
              showsCount: false, step: 1, stepLabel: "✓", isLimit: false, done: false),
        .init(id: "3", name: "Read", symbol: "book.fill", color: "orange", progress: 12, goal: 20, suffix: " min",
              showsCount: true, step: nil, stepLabel: "", isLimit: false, done: false),
        .init(id: "4", name: "Meds", symbol: "pills.fill", color: "red", progress: 1, goal: 1, suffix: "",
              showsCount: false, step: 1, stepLabel: "✓", isLimit: false, done: true),
    ])
}
