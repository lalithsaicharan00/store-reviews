import AppIntents
import SwiftUI
import WidgetKit

// The watch face's views (E), shared by the complications (WatchWidgets) and the app's face gallery, which draws them
// from the same snapshot for the screenshot review. Every word, number and order comes from the snapshot the Watch app
// writes after each change (`WidgetPublisher`, the projection the iPhone's widgets draw, U26).

nonisolated struct FaceEntry: TimelineEntry {
    let date: Date
    let snapshot: WidgetSnapshot?
    let frame: WidgetFrame?
    /// The habit a one-habit complication shows.
    var habitID: String?

    var plus: Bool { snapshot?.plus ?? true }
    var discreet: Bool { snapshot?.discreet == true }
    var today: [WidgetItem] { frame?.list("habits", at: date) ?? [] }
    var counted: [WidgetItem] { today.filter(\.counts) }
    var done: Int { counted.filter(\.countsDone).count }
    var left: [WidgetItem] { counted.filter { !$0.countsDone } }
    /// A timer running today, for the face while a routine or timer runs (E3, R7).
    var running: WidgetItem? { frame?.items.first { $0.timerClock != nil } }
    var habit: WidgetItem? { habitID.flatMap { id in frame?.items.first { $0.id == id } } }
}

nonisolated enum FaceTimeline {
    static func entries(habitID: String? = nil, now: Date = .now) -> [FaceEntry] {
        let snapshot = WidgetDisk.read()
        var entries = [FaceEntry(date: now, snapshot: snapshot, frame: snapshot?.frame(at: now), habitID: habitID)]
        // The next day start (WA5) and, for a running timer, the moment it reaches its goal; nothing more (S17).
        var moments: [Date] = []
        if let next = snapshot?.frames.first(where: { $0.start > now })?.start { moments.append(next) }
        if let goal = entries[0].running?.timerGoalAt, goal > now { moments.append(goal) }
        for moment in moments.sorted() {
            entries.append(FaceEntry(date: moment, snapshot: snapshot, frame: snapshot?.frame(at: moment), habitID: habitID))
        }
        return entries
    }
}

struct TodayFace: View {
    let entry: FaceEntry
    let family: WidgetFamily

    var body: some View {
        if !entry.plus {
            NotPlusFace(family: family)
        } else if entry.frame == nil {
            // Not sure what today is (no snapshot for now): the app's name, never a count (WA11).
            Text("Often Enough").font(.headline)
        } else {
            switch family {
            case .accessoryCircular:
                Gauge(value: Double(entry.done), in: 0...Double(max(1, entry.counted.count))) {
                    Text("Today")
                } currentValueLabel: {
                    Text(entry.left.isEmpty ? "✓" : "\(entry.left.count)")
                }
                .gaugeStyle(.accessoryCircular)
                .accessibilityLabel(entry.left.isEmpty ? "All done today" : "\(entry.left.count) left today")
            case .accessoryInline:
                Text(entry.left.isEmpty ? "All done today" : "\(entry.left.count) left today")
            case .accessoryCorner:
                Text(entry.left.isEmpty ? "✓" : "\(entry.left.count)")
                    .widgetLabel { Text(entry.left.isEmpty ? "All done" : "left today") }
            default:
                if let timer = entry.running { TimerFace(item: timer, discreet: entry.discreet) } else { rectangle }
            }
        }
    }

    private var rectangle: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack {
                Text("Today").font(.headline)
                Spacer()
                Text("\(entry.done) of \(entry.counted.count)").foregroundStyle(.secondary)
            }
            DayBar(done: entry.done, total: entry.counted.count)
            Text(entry.left.isEmpty ? "All done" : entry.discreet ? "\(entry.left.count) left"
                 : entry.left.map(\.name).joined(separator: ", "))
                .font(.footnote)
                .lineLimit(1)
        }
        .accessibilityElement(children: .combine)
    }
}

/// While a timer or routine runs: the habit, its time to the goal, and how far through (E3, R7).
struct TimerFace: View {
    let item: WidgetItem
    let discreet: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack {
                Text(discreet ? "Timer" : item.name).font(.headline).lineLimit(1)
                Spacer()
                if let goal = item.timerGoalAt, goal > .now {
                    Text(timerInterval: Date.now...goal, countsDown: true).monospacedDigit().foregroundStyle(.secondary)
                        .frame(maxWidth: 60, alignment: .trailing)
                }
            }
            if let start = item.timerClock, let end = item.timerGoalAt, end > start {
                ProgressView(timerInterval: start...end, countsDown: false) { EmptyView() } currentValueLabel: { EmptyView() }
                    .tint(WatchPalette.color(item.color))
            }
            Text(item.place.isEmpty ? item.value : item.place + " · " + item.value).font(.footnote).lineLimit(1)
        }
    }
}

struct DayBar: View {
    let done: Int
    let total: Int

    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<max(1, min(total, 12)), id: \.self) { i in
                Capsule().fill(i < done ? Color.white : Color.white.opacity(0.3)).frame(height: 4)
            }
        }
        .widgetAccentable()
    }
}

/// Our complication without Plus (G7): the app's name and "Part of Plus"; tapping opens the Plus screen. No names or counts.
struct NotPlusFace: View {
    let family: WidgetFamily

    var body: some View {
        switch family {
        case .accessoryCircular, .accessoryCorner:
            Image(systemName: "checkmark").font(.title3.weight(.bold))
        case .accessoryInline:
            Text("Often Enough · Part of Plus")
        default:
            VStack(alignment: .leading, spacing: 2) {
                Text("Often Enough").font(.headline)
                Text("Part of Plus. Tap to learn more.").font(.footnote)
            }
        }
    }
}

struct HabitFace: View {
    let entry: FaceEntry
    let family: WidgetFamily

    var body: some View {
        if !entry.plus {
            NotPlusFace(family: family)
        } else if let item = entry.habit {
            switch family {
            case .accessoryCircular: circle(item)
            case .accessoryInline: Text(entry.discreet ? (item.lock ?? item.value) : item.name + " " + (item.lock ?? item.value))
            case .accessoryCorner:
                Image(systemName: item.symbol).widgetLabel { Text(item.lock ?? item.value) }
            default:
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(entry.discreet ? "Habit" : item.name).font(.headline).lineLimit(1)
                        Text(item.value).font(.footnote).lineLimit(1)
                    }
                    Spacer(minLength: 4)
                    // Its own small circle: the button's background otherwise takes half the width and cuts the line.
                    FaceButton(item: item, day: entry.frame?.day ?? "")
                        .frame(width: 44, height: 44)
                }
            }
        } else {
            Image(systemName: "checkmark.circle")
        }
    }

    @ViewBuilder
    private func circle(_ item: WidgetItem) -> some View {
        if item.type == "quit", let start = item.quitStart {
            // A quit habit's current run (E1: "15 d"), in the app's words (RunWords), counted to this entry's date;
            // under a day the system's own clock keeps it moving between entries.
            let days = Int(entry.date.timeIntervalSince(start) / 86_400)
            VStack(spacing: 0) {
                Image(systemName: item.symbol).font(.caption)
                if days >= 1 {
                    Text("\(days) d").font(.caption.weight(.semibold)).lineLimit(1).minimumScaleFactor(0.5)
                } else {
                    Text(timerInterval: start...Date.distantFuture, countsDown: false)
                        .font(.caption2).monospacedDigit().lineLimit(1).minimumScaleFactor(0.5)
                }
            }
        } else if let ring = item.ring {
            Gauge(value: min(1, ring)) {
                Image(systemName: item.symbol)
            } currentValueLabel: {
                if let lock = item.lock { Text(lock) } else { Image(systemName: item.symbol) }
            }
            .gaugeStyle(.accessoryCircular)
            .tint(entry.discreet ? .white : WatchPalette.color(item.color))
        } else {
            ZStack {
                AccessoryWidgetBackground()
                Image(systemName: item.done ? "checkmark" : item.symbol).font(.title3)
            }
        }
    }
}

struct LogFace: View {
    let entry: FaceEntry

    var body: some View {
        if !entry.plus {
            NotPlusFace(family: .accessoryRectangular)
        } else if entry.frame == nil {
            Text("Often Enough").font(.headline)
        } else {
            AccessoryWidgetGroup("Today · \(entry.done) of \(entry.counted.count)") {
                ForEach(entry.left.prefix(3), id: \.id) { item in
                    FaceButton(item: item, day: entry.frame?.day ?? "")
                }
            }
        }
    }
}

/// One habit's button on the face, doing exactly what it shows (U26): ✓ toggles today, +N adds one step; anything that
/// needs a screen (a timer, an amount to type, steps) opens that habit in the app.
struct FaceButton: View {
    let item: WidgetItem
    let day: String

    var body: some View {
        switch item.action {
        case .check, .add:
            Button(intent: WatchTapIntent(item: item.id, day: day, signature: item.signature, name: item.name)) { label }
                .buttonStyle(.plain)
                .accessibilityLabel(item.action == .add ? "Add \(item.actionText ?? "") \(item.name)" : "Mark \(item.name) done")
        default:
            Link(destination: URL(string: "oftenenough://watch/habit/\(item.id)\(item.action == .timerStart ? "?start=1" : "")")!) { label }
                .accessibilityLabel("Open \(item.name)")
        }
    }

    private var label: some View {
        ZStack {
            AccessoryWidgetBackground()
            if item.action == .add, let text = item.actionText {
                VStack(spacing: 0) {
                    Image(systemName: item.symbol).font(.caption2)
                    Text(text).font(.caption2.weight(.bold))
                }
            } else {
                Image(systemName: item.action == .timerStart ? "play.fill" : item.action == .timerPause ? "pause.fill"
                      : item.done ? "checkmark" : item.symbol)
                    .font(.body.weight(.semibold))
            }
        }
        .widgetAccentable()
    }
}
