import SwiftUI

// The habit page's Progress tab (the user, 3 Oct 2026; research Progress, revised): the key, then one card each for the
// Overall record, Milestones, Week, Month and Year in Pixels, all open, each with its own scope and ‹ ›. Facts are
// recorded data and plain counts with their denominators (no scores, predictions or health claims). Squares are the
// heat map's, the same as Progress and History. Every card works out its numbers when its period or the data change.

struct HabitProgressTab: View {
    let habit: Habit
    let model: HabitPageModel
    let start: OverTimeStart?
    let openDay: (LocalDay) -> Void
    @Environment(HabitStore.self) private var store
    @AppStorage(ProgressOptions.showStreaks) private var showStreaks = true
    @AppStorage(ProgressOptions.showPercentages) private var showPercentages = true

    var body: some View {
        HeatKeySection(place: HeatKeyVisit.habit(habit.id))
            .pageItem()
        if habit.kind == .quit {
            VStack(alignment: .leading, spacing: WeekSpacing.card) {
                // "Tracking since": the header's "Quitting since" is the run going on now, which can be later.
                CardTitle(title: "Overall record", subtitle: "Tracking since " + store.quitStartDay(of: habit).date(calendar: store.calendar)
                    .formatted(.dateTime.day().month(.abbreviated).year()))
                // The live run, the best run, clean days and slips, and Log a Slip (report §10.3).
                QuitNumbers(habit: habit)
            }
            .pageCard()
            .pageItem()
            // A container keeps its children's own ids; without it this id replaced Log a Slip's (3 Oct 2026).
            .accessibilityElement(children: .contain)
            .accessibilityIdentifier("habit-progress-record")
        } else if let record = model.record {
            HabitRecordCard(record: record, showPercentages: showPercentages)
                .pageItem()
        }
        // Show Streaks off hides the runs in a row; a total a break can't take away stays (report §7.6).
        let tracks = model.tracks.filter { showStreaks || $0.kind == .inTotal }
        if !tracks.isEmpty {
            MilestonesCard(tracks: tracks, color: habit.color)
                .pageItem()
        }
        HabitPeriodCard(habit: habit, kind: .week, anchor: start?.range == .week ? start?.anchor : nil)
            .pageItem()
        HabitPeriodCard(habit: habit, kind: .month, anchor: start?.range == .month ? start?.anchor : nil)
            .pageItem()
        HabitYearCard(habit: habit, year: start?.range == .year ? start?.anchor.year : nil, openDay: openDay)
            .pageItem()
    }
}

// MARK: - Overall record

/// What's been recorded since the habit began, and how many goals were met out of how many there were.
private struct HabitRecordCard: View {
    let record: HabitOverall
    let showPercentages: Bool

    var body: some View {
        let percent = showPercentages && record.eligible > 0
            ? Int((Double(record.met) / Double(record.eligible) * 100).rounded()) : nil
        VStack(alignment: .leading, spacing: WeekSpacing.card) {
            CardTitle(title: "Overall record", subtitle: record.since)
            VStack(alignment: .leading, spacing: WeekSpacing.pair) {
                Text(record.headline).font(.title2.weight(.semibold)).monospacedDigit()
                    .fixedSize(horizontal: false, vertical: true)
                if let detail = record.detail {
                    Text(detail + (percent.map { " · \($0)%" } ?? ""))
                        .font(.subheadline).foregroundStyle(.secondary).monospacedDigit()
                        .fixedSize(horizontal: false, vertical: true)
                }
                if let best = record.best {
                    Text(best).font(.subheadline).foregroundStyle(.secondary).monospacedDigit()
                }
            }
        }
        .pageCard()
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(["Overall record", record.since, record.headline, record.detail ?? "",
                             percent.map { "\($0) percent" } ?? "", record.best ?? ""].filter { !$0.isEmpty }.joined(separator: ". "))
        .accessibilityIdentifier("habit-progress-record")
    }
}

// MARK: - Milestones

/// Milestones (report "Milestones on the Habit Page", 3 Oct 2026): for each track, what's next and how far, then the
/// milestones themselves as squares: reached ones filled in the habit's colour with their date, the next one outlined
/// and filling, later ones grey. No badges, levels or celebration.
private struct MilestonesCard: View {
    let tracks: [MilestoneTrack]
    let color: HabitColor

    var body: some View {
        VStack(alignment: .leading, spacing: WeekSpacing.card) {
            CardTitle(title: "Milestones")
            ForEach(Array(tracks.enumerated()), id: \.element.id) { index, track in
                if index > 0 { Divider() }
                MilestoneTrackView(track: track, color: color)
            }
        }
        .pageCard()
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("habit-milestones")
    }
}

private struct MilestoneTrackView: View {
    let track: MilestoneTrack
    let color: HabitColor
    @Environment(HabitStore.self) private var store

    var body: some View {
        let next = track.next
        VStack(alignment: .leading, spacing: WeekSpacing.tight) {
            HStack(alignment: .firstTextBaseline, spacing: WeekSpacing.tight) {
                Text(track.title).font(.subheadline.weight(.semibold))
                Spacer(minLength: WeekSpacing.tight)
                Text(status).font(.subheadline).foregroundStyle(.secondary).monospacedDigit()
            }
            if let next {
                let previous = track.steps.last { $0.reached != nil }?.value ?? 0
                let span = max(1, next.value - previous)
                let done = max(0, min(span, track.current - previous))
                VStack(alignment: .leading, spacing: WeekSpacing.pair) {
                    HStack(alignment: .firstTextBaseline) {
                        Text("Next: " + phrase(next.value)).font(.title3.weight(.semibold)).monospacedDigit()
                        Spacer(minLength: WeekSpacing.tight)
                        Text("\(next.value - min(track.current, next.value)) to go")
                            .font(.subheadline.weight(.semibold)).foregroundStyle(.secondary).monospacedDigit()
                    }
                    ProgressTrack(fraction: Double(done) / Double(span), color: color)
                }
            } else {
                Text("Every milestone reached").font(.title3.weight(.semibold))
            }
            ScrollViewReader { proxy in
                ScrollView(.horizontal) {
                    HStack(alignment: .top, spacing: 10) {
                        ForEach(track.steps) { step in
                            MilestoneToken(step: step, label: label(step.value), caption: caption(step, next: next),
                                           isNext: step.value == next?.value,
                                           progress: progress(step), color: color,
                                           spoken: spoken(step, next: next))
                                .id(step.value)
                        }
                    }
                    .padding(.vertical, 2)
                }
                .scrollIndicators(.hidden)
                .onAppear { if let target = next?.value ?? track.steps.last?.value { proxy.scrollTo(target, anchor: .center) } }
            }
        }
    }

    private var status: String {
        switch track.kind {
        case .inARow: "Now \(track.current) · best \(track.best ?? track.current)"
        case .inTotal: "\(track.current) so far"
        case .sinceSlip: "Now \(days(track.current)) · best \(days(track.best ?? track.current))"
        }
    }

    /// "30 days in a row", "250 times in total", "14 days".
    private func phrase(_ n: Int) -> String {
        switch track.kind {
        case .inARow: "\(n) \(unit(n)) in a row"
        case .inTotal: "\(n) \(unit(n)) in total"
        case .sinceSlip: days(n)
        }
    }

    private func unit(_ n: Int) -> String { n == 1 && track.unit.hasSuffix("s") ? String(track.unit.dropLast()) : track.unit }
    private func days(_ n: Int) -> String {
        if n >= 365 && n % 365 == 0 { return n == 365 ? "1 year" : "\(n / 365) years" }
        return n == 1 ? "1 day" : "\(n) days"
    }

    /// The number on the square: "30", or "1" for a year.
    private func label(_ n: Int) -> String {
        track.kind == .sinceSlip && n >= 365 && n % 365 == 0 ? "\(n / 365)" : "\(n)"
    }

    /// Under the square: the date it was reached, how far to go for the next, or its unit.
    private func caption(_ step: MilestoneStep, next: MilestoneStep?) -> String {
        if let reached = step.reached {
            return reached.date(calendar: store.calendar).formatted(.dateTime.day().month(.abbreviated))
        }
        if step.value == next?.value { return "\(step.value - min(track.current, step.value)) to go" }
        if track.kind == .sinceSlip && step.value >= 365 && step.value % 365 == 0 { return step.value == 365 ? "year" : "years" }
        return track.kind == .sinceSlip ? "days" : unit(step.value)
    }

    private func progress(_ step: MilestoneStep) -> Double {
        guard step.reached == nil else { return 1 }
        let previous = track.steps.last { $0.value < step.value && $0.reached != nil }?.value ?? 0
        return max(0, min(1, Double(track.current - previous) / Double(max(1, step.value - previous))))
    }

    private func spoken(_ step: MilestoneStep, next: MilestoneStep?) -> String {
        if let reached = step.reached {
            return phrase(step.value) + ", reached " + reached.date(calendar: store.calendar).formatted(.dateTime.day().month(.wide).year())
        }
        if step.value == next?.value { return phrase(step.value) + ", next, \(step.value - min(track.current, step.value)) to go" }
        return phrase(step.value) + ", not reached yet"
    }
}

/// A thin bar toward the next milestone (a fill drawn by scaling, never measured: Rulebook S10).
private struct ProgressTrack: View {
    let fraction: Double
    let color: HabitColor

    var body: some View {
        ZStack(alignment: .leading) {
            Capsule().fill(Color(.tertiarySystemFill))
            Capsule().fill(color.mark).scaleEffect(x: max(0.02, min(1, fraction)), y: 1, anchor: .leading)
        }
        .frame(height: 8)
        .accessibilityHidden(true)
    }
}

/// One milestone as a square: filled when reached, outlined and filling when it's next, grey after that.
private struct MilestoneToken: View {
    let step: MilestoneStep
    let label: String
    let caption: String
    let isNext: Bool
    let progress: Double
    let color: HabitColor
    let spoken: String
    @Environment(\.colorScheme) private var scheme

    var body: some View {
        let shape = RoundedRectangle(cornerRadius: 12, style: .continuous)
        let reached = step.reached != nil
        VStack(spacing: 6) {
            ZStack {
                if reached {
                    shape.fill(color.mark)
                } else if isNext {
                    shape.fill(Color(.tertiarySystemFill))
                    shape.fill(HeatPalette.color(2, color, dark: scheme == .dark))
                        .scaleEffect(x: 1, y: max(0.04, progress), anchor: .bottom)
                        .clipShape(shape)
                    shape.strokeBorder(color.mark, lineWidth: 2)
                } else {
                    shape.fill(Color(.tertiarySystemFill))
                }
                Text(label)
                    .font(.title3.weight(.bold)).monospacedDigit()
                    .lineLimit(1).minimumScaleFactor(0.6)
                    .foregroundStyle(reached ? Color.white : isNext ? Color.primary : Color.secondary)
                    .padding(.horizontal, 4)
            }
            .frame(width: 56, height: 56)
            Text(caption)
                .font(.caption2.weight(isNext ? .semibold : .regular)).monospacedDigit()
                .foregroundStyle(isNext ? Color.primary : Color.secondary)
                .lineLimit(1).minimumScaleFactor(0.8)
        }
        .frame(width: 64)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(spoken)
    }
}

// MARK: - Week and Month

/// The Week or Month card: its dates with ‹ ›, what was recorded on the goal's own clock, the squares (the same strip
/// and calendar as Progress), and the period against the one before. Month adds the amount recorded each day for
/// habits that record amounts.
private struct HabitPeriodCard: View {
    enum Kind { case week, month }
    let habit: Habit
    let kind: Kind
    @Environment(HabitStore.self) private var store
    @State private var anchor: LocalDay?
    @State private var data: PeriodData?
    @State private var loaded: Key?

    struct Key: Hashable {
        let anchor: LocalDay
        let version: Int
        let today: LocalDay
        let habit: Habit
    }

    struct PeriodData {
        let span: ClosedRange<LocalDay>
        let subtitle: String
        let columns: [WeekColumn]
        let card: ProgressWeekCard?
        let comparison: PeriodComparison?
        let lead: Int
        let letters: [String]
        let bars: [LightBarChart.Bar]
        let goals: [LightBarChart.GoalLine]
        let xLabels: [LightBarChart.XLabel]
        let rule: Habit
        let canGoBack: Bool
        let canGoForward: Bool
    }

    init(habit: Habit, kind: Kind, anchor: LocalDay?) {
        self.habit = habit
        self.kind = kind
        _anchor = State(initialValue: anchor)
    }

    var body: some View {
        let today = store.today()
        let key = Key(anchor: anchor ?? today, version: store.dataVersion, today: today, habit: habit)
        let noun = kind == .week ? "week" : "month"
        VStack(alignment: .leading, spacing: WeekSpacing.card) {
            PeriodHeader(title: kind == .week ? "Week" : "Month", subtitle: data?.subtitle ?? " ", noun: noun,
                         canGoBack: data?.canGoBack ?? false, canGoForward: data?.canGoForward ?? false) { step in
                guard let span = data?.span else { return }
                let day = step < 0 ? span.lowerBound.adding(days: -1, calendar: store.calendar)
                    : span.upperBound.adding(days: 1, calendar: store.calendar)
                anchor = day
            }
            if let data, let card = data.card {
                VStack(alignment: .leading, spacing: WeekSpacing.pair) {
                    Text(card.headline).font(.title3.weight(.semibold)).monospacedDigit()
                        .fixedSize(horizontal: false, vertical: true)
                    if let detail = card.detail {
                        Text(detail).font(.subheadline).foregroundStyle(.secondary).monospacedDigit()
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                if data.columns.count == card.days.count {
                    if kind == .week {
                        WeekCardStrip(columns: data.columns, days: card.days, color: habit.color)
                    } else {
                        MonthCardGrid(layout: MonthLayout(lead: data.lead, letters: data.letters), columns: data.columns,
                                      days: card.days, color: habit.color)
                    }
                }
                if !data.bars.isEmpty {
                    VStack(alignment: .leading, spacing: WeekSpacing.tight) {
                        Text("Recorded each day").font(.subheadline.weight(.semibold))
                        LightBarChart(title: "Recorded each day", bars: data.bars, goals: data.goals, dashedGoals: true,
                                      xLabels: data.xLabels, color: habit.color.mark,
                                      yLabel: { store.progressValue($0, data.rule) })
                            .frame(height: 140)
                    }
                }
            } else if data != nil {
                Text(habit.kind == .quit ? "Nothing recorded this \(noun)." : "Not started yet this \(noun).")
                    .font(.subheadline).foregroundStyle(.secondary)
            }
            if let comparison = data?.comparison {
                Divider()
                ComparisonView(comparison: comparison, color: habit.color)
            }
        }
        .pageCard()
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier(kind == .week ? "habit-progress-week" : "habit-progress-month")
        .onAppear { load(key) }
        .onChange(of: key) { load(key) }
    }

    private func load(_ key: Key) {
        guard key != loaded else { return }
        loaded = key
        let store = store
        let today = key.today
        let span = store.period(kind == .week ? .week : .month, containing: min(key.anchor, today))
        let range: ProgressRange = kind == .week ? .week : .month
        let card = habit.kind == .quit ? store.weekQuitCard(habit, in: span, range: range, today: today, now: store.clock())
            : store.weekCard(habit, in: span, range: range, today: today)
        let title = kind == .week ? store.weekTitle(span, today: today) : store.monthTitle(span, today: today)
        let caption = kind == .week ? store.weekCaption(span, today: today) : store.monthCaption(span, today: today)
        let first = habit.kind == .quit ? store.quitStartDay(of: habit) : store.startDay(of: habit)
        let rule = store.rule(habit, on: min(span.upperBound, today))
        var bars: [LightBarChart.Bar] = []
        var goals: [LightBarChart.GoalLine] = []
        var xLabels: [LightBarChart.XLabel] = []
        // The amount recorded each day of the month, for habits that record amounts (research: actual quantities,
        // a goal line only where it is that day's goal).
        let shape = store.progressShape(rule)
        if kind == .month && [.times, .amount, .time, .periodTotal, .limitDay].contains(shape) && habit.kind != .quit {
            let days = store.days(in: span)
            let n = Double(days.count)
            for (i, day) in days.enumerated() where day <= today && day >= first {
                let value = store.dayProgress(of: store.rule(habit, on: day), on: day)
                let label = "\(day.day) \(store.calendar.shortStandaloneMonthSymbols[day.month - 1]): " + store.progressValue(value, rule)
                bars.append(LightBarChart.Bar(id: i, from: (Double(i) + 0.15) / n, to: (Double(i) + 0.85) / n, value: value,
                                              opacity: 1, over: false, label: label))
            }
            if rule.frequency.isDayBased && !rule.frequency.isFlexible && store.dayGoal(of: rule) > 0 {
                goals = [LightBarChart.GoalLine(from: 0, to: 1, value: store.dayGoal(of: rule))]
            }
            xLabels = [1, 8, 15, 22, 29].filter { $0 <= days.count }.map { LightBarChart.XLabel(at: (Double($0) - 0.5) / n, text: "\($0)") }
            if !bars.contains(where: { $0.value > 0 }) { bars = [] }
        }
        data = PeriodData(
            span: span,
            subtitle: title + (caption.map { " · " + $0 } ?? ""),
            columns: store.weekColumns(span, today: today),
            card: card,
            comparison: store.periodComparison(of: habit, in: span, noun: kind == .week ? "week" : "month", today: today),
            lead: store.monthLead(span),
            letters: store.orderedWeekdayLetters(),
            bars: bars, goals: goals, xLabels: xLabels, rule: rule,
            canGoBack: span.lowerBound > first,
            canGoForward: span.upperBound < today)
    }
}

/// A card's title and scope, with ‹ › for the period before and after (research: period controls in the heading).
private struct PeriodHeader: View {
    let title: String
    let subtitle: String
    let noun: String
    let canGoBack: Bool
    let canGoForward: Bool
    let move: (Int) -> Void

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            CardTitle(title: title, subtitle: subtitle)
            Spacer(minLength: WeekSpacing.tight)
            Button { move(-1) } label: {
                Image(systemName: "chevron.left").frame(width: 44, height: 44)
            }
            .disabled(!canGoBack)
            .accessibilityLabel("Previous \(noun)")
            Button { move(1) } label: {
                Image(systemName: "chevron.right").frame(width: 44, height: 44)
            }
            .disabled(!canGoForward)
            .accessibilityLabel("Next \(noun)")
        }
        .buttonStyle(.borderless)
        .font(.body.weight(.semibold))
        .padding(.trailing, -12)
        .padding(.vertical, -8)
    }
}

/// This period and the one before, on the same footing, as two labelled bars with exact values. The habit's colour for
/// this period, a lighter step for the one before: no arrows, no better or worse.
private struct ComparisonView: View {
    let comparison: PeriodComparison
    let color: HabitColor
    @Environment(\.colorScheme) private var scheme

    var body: some View {
        VStack(alignment: .leading, spacing: WeekSpacing.tight) {
            Text(comparison.title).font(.subheadline.weight(.semibold))
            if let note = comparison.note {
                Text(note).font(.subheadline).foregroundStyle(.secondary)
            } else {
                let top = max(comparison.thisValue ?? 0, comparison.previousValue ?? 0, 0.0001)
                row(comparison.thisLabel, comparison.thisText, (comparison.thisValue ?? 0) / top, color.mark)
                row(comparison.previousLabel, comparison.previousText, (comparison.previousValue ?? 0) / top,
                    HeatPalette.color(2, color, dark: scheme == .dark))
            }
        }
        .accessibilityElement(children: .combine)
    }

    private func row(_ label: String, _ text: String, _ fraction: Double, _ fill: Color) -> some View {
        HStack(spacing: WeekSpacing.tight) {
            Text(label).font(.subheadline).foregroundStyle(.secondary)
                .lineLimit(1).frame(width: 92, alignment: .leading)
            ZStack(alignment: .leading) {
                Capsule().fill(Color(.tertiarySystemFill))
                Capsule().fill(fill).scaleEffect(x: max(0.02, min(1, fraction)), y: 1, anchor: .leading)
            }
            .frame(height: 10)
            Text(text).font(.subheadline.weight(.semibold)).monospacedDigit()
                .lineLimit(1).frame(minWidth: 64, alignment: .trailing)
        }
    }
}

// MARK: - Year in Pixels

/// Year in Pixels: the whole year as twelve month columns, what the year holds on the goal's own clock, and a tap on any
/// square shows its day under the grid with Open Day.
private struct HabitYearCard: View {
    let habit: Habit
    let openDay: (LocalDay) -> Void
    @Environment(HabitStore.self) private var store
    @State private var year: Int?
    @State private var data: YearData?
    @State private var loaded: Key?
    @State private var selected: Int?

    struct Key: Hashable {
        let year: Int
        let version: Int
        let today: LocalDay
        let habit: Habit
    }

    struct YearData {
        let first: LocalDay
        let cells: [HeatCell]
        let starts: [Int]
        let lengths: [Int]
        let todayIndex: Int?
        let headline: String?
        let detail: String?
        let earliestYear: Int
    }

    init(habit: Habit, year: Int?, openDay: @escaping (LocalDay) -> Void) {
        self.habit = habit
        self.openDay = openDay
        _year = State(initialValue: year)
    }

    var body: some View {
        let today = store.today()
        let shown = year ?? today.year
        let key = Key(year: shown, version: store.dataVersion, today: today, habit: habit)
        VStack(alignment: .leading, spacing: WeekSpacing.card) {
            PeriodHeader(title: "Year in Pixels", subtitle: shown == today.year ? "\(shown) · This year" : "\(shown)", noun: "year",
                         canGoBack: shown > (data?.earliestYear ?? shown), canGoForward: shown < today.year) { step in
                selected = nil
                year = shown + step == today.year ? nil : shown + step
            }
            if let data {
                if let headline = data.headline {
                    VStack(alignment: .leading, spacing: WeekSpacing.pair) {
                        Text(headline).font(.title3.weight(.semibold)).monospacedDigit()
                            .fixedSize(horizontal: false, vertical: true)
                        if let detail = data.detail {
                            Text(detail).font(.subheadline).foregroundStyle(.secondary).monospacedDigit()
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }
                HeatYearPixels(cells: data.cells, monthStarts: data.starts, monthLengths: data.lengths,
                               monthNames: store.calendar.shortStandaloneMonthSymbols, todayIndex: data.todayIndex,
                               selected: selected, color: habit.color) { index in
                    let day = data.first.adding(days: index, calendar: store.calendar)
                    guard day <= today else { return }
                    selected = selected == index ? nil : index
                }
                .equatable()
                selection(data, today: today)
            }
        }
        .pageCard(padding: 12)
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("habit-year-grid")
        .onAppear { load(key) }
        .onChange(of: key) { load(key) }
    }

    /// The tapped day: its date and result, with Open Day; until then, how to use the grid.
    @ViewBuilder private func selection(_ data: YearData, today: LocalDay) -> some View {
        if let selected {
            let day = data.first.adding(days: selected, calendar: store.calendar)
            HStack(spacing: WeekSpacing.tight) {
                VStack(alignment: .leading, spacing: WeekSpacing.label) {
                    Text(day.date(calendar: store.calendar).formatted(.dateTime.weekday(.wide).day().month(.wide)))
                        .font(.subheadline.weight(.semibold))
                    Text(store.dayResult(habit, on: day)).font(.subheadline).foregroundStyle(.secondary).monospacedDigit()
                }
                Spacer(minLength: WeekSpacing.tight)
                Button("Open Day") { openDay(day) }
                    .buttonStyle(.bordered)
                    .controlSize(.small)
                    .accessibilityIdentifier("year-open-day")
            }
            .padding(12)
            .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
        } else {
            Text("Tap a square to see its day.").font(.footnote).foregroundStyle(.secondary)
        }
    }

    private func load(_ key: Key) {
        guard key != loaded else { return }
        loaded = key
        let store = store
        let calendar = store.calendar
        let span = store.period(.year, containing: LocalDay(year: key.year, month: 6, day: 1))
        let cells = store.heatCells(habit, in: span, range: .year, today: key.today)
        var starts: [Int] = [], lengths: [Int] = []
        for m in 1...12 {
            let first = LocalDay(year: key.year, month: m, day: 1)
            starts.append(span.lowerBound.days(to: first, calendar: calendar))
            lengths.append(calendar.range(of: .day, in: .month, for: first.date(calendar: calendar))?.count ?? 30)
        }
        let card = habit.kind == .quit ? store.weekQuitCard(habit, in: span, range: .year, today: key.today, now: store.clock())
            : store.weekCard(habit, in: span, range: .year, today: key.today)
        let first = habit.kind == .quit ? store.quitStartDay(of: habit) : store.startDay(of: habit)
        data = YearData(first: span.lowerBound, cells: cells, starts: starts, lengths: lengths,
                        todayIndex: span.contains(key.today) ? span.lowerBound.days(to: key.today, calendar: calendar) : nil,
                        headline: card?.headline, detail: card?.detail, earliestYear: first.year)
    }
}
