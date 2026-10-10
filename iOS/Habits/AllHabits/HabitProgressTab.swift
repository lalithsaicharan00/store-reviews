import SwiftUI

// The habit page's Progress tab (the user, 3 Oct 2026; research Progress, revised): the key, then one card each for the
// Overall record, Milestones, Week, Month and Year in Pixels, all open, each with its own scope and ‹ ›. Facts are
// recorded data and plain counts with their denominators (no scores, predictions or health claims). Squares are the
// heat map's, the same as Progress and History. Every card works out its numbers when its period or the data change.
// Overall record and Milestones: spec "Habit Progress — Overall Record, Streaks and Milestones" (11 Oct 2026).

struct HabitProgressTab: View {
    let habit: Habit
    let model: HabitPageModel
    let start: OverTimeStart?
    let openDay: (LocalDay) -> Void
    let openMilestones: () -> Void
    @Environment(HabitStore.self) private var store
    @AppStorage(ProgressOptions.showStreaks) private var showStreaks = true
    @AppStorage(ProgressOptions.showPercentages) private var showPercentages = true

    var body: some View {
        HeatKeySection()
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
            HabitRecordCard(record: record, color: habit.color, showStreaks: showStreaks, showPercentages: showPercentages)
                .pageItem()
        }
        // Show Streaks off hides the runs in a row; a total a break can't take away stays (report §7.6, E9).
        let milestones = model.milestones.shown(streaks: showStreaks)
        if !milestones.next.isEmpty {
            MilestonesCard(habitID: habit.id, milestones: milestones, color: habit.color, seeAll: openMilestones)
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

/// What's been recorded since the habit began, the streaks, and how many goals were met out of how many there were
/// (spec §2): a title line, the headline, then a 2 × 2 grid of boxes (one column at accessibility text sizes).
private struct HabitRecordCard: View {
    let record: HabitOverall
    let color: HabitColor
    let showStreaks: Bool
    let showPercentages: Bool
    @Environment(\.dynamicTypeSize) private var typeSize

    struct Box: Identifiable {
        let id: String
        let fact: RecordFact
        let detail: String?
        let spoken: String
        let tinted: Bool
    }

    var body: some View {
        let large = typeSize.isAccessibilitySize
        let grid = rows(columns: large ? 1 : 2)
        VStack(alignment: .leading, spacing: WeekSpacing.card) {
            Group {
                if large {
                    VStack(alignment: .leading, spacing: WeekSpacing.label) {
                        Text("Overall record").font(.headline)
                        Text(record.since).font(.subheadline).foregroundStyle(.secondary)
                    }
                } else {
                    HStack(alignment: .firstTextBaseline, spacing: WeekSpacing.tight) {
                        Text("Overall record").font(.headline)
                        Spacer(minLength: WeekSpacing.tight)
                        Text(record.since).font(.subheadline).foregroundStyle(.secondary).lineLimit(1)
                    }
                }
            }
            .accessibilityElement(children: .combine)
            .accessibilityAddTraits(.isHeader)
            Text("\(Text(record.lead).font(.body).foregroundStyle(.secondary))\(record.lead.isEmpty ? "" : " ")\(Text(record.value).font(.title.weight(.bold)))\(record.trail.isEmpty ? "" : " ")\(Text(record.trail).font(.body).foregroundStyle(.secondary))")
                .monospacedDigit()
                .fixedSize(horizontal: false, vertical: true)
                .accessibilityLabel(record.headline)
                .accessibilityIdentifier("habit-record-headline")
            if !grid.isEmpty {
                Grid(horizontalSpacing: WeekSpacing.tight, verticalSpacing: WeekSpacing.tight) {
                    ForEach(grid.indices, id: \.self) { index in
                        GridRow {
                            ForEach(grid[index]) { box in
                                RecordBox(box: box, color: color)
                                    .gridCellColumns(grid[index].count == 1 && !large ? 2 : 1)
                            }
                        }
                    }
                }
            }
        }
        .pageCard()
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("habit-progress-record")
    }

    /// Current and Best streak (unless Show Streaks is off), then Goal met and Best day; a box with no partner takes the
    /// row (§8.1).
    private func rows(columns: Int) -> [[Box]] {
        var boxes: [Box] = []
        if showStreaks, let current = record.current, let best = record.best {
            boxes.append(Box(id: "habit-streak-current", fact: current, detail: current.detail, spoken: current.spoken, tinted: true))
            boxes.append(Box(id: "habit-streak-best", fact: best, detail: best.detail, spoken: best.spoken, tinted: false))
        }
        if let goal = record.goalMet {
            // The percentage follows Progress's "Show percentages".
            let percent = showPercentages && record.eligible > 0
                ? Int((Double(record.met) / Double(record.eligible) * 100).rounded()) : nil
            let detail = percent.map { "\($0)% \(record.percentNoun)" }
            boxes.append(Box(id: "habit-record-goal-met", fact: goal, detail: detail,
                             spoken: goal.spoken + (percent.map { ", \($0) percent \(record.percentNoun)" } ?? ""), tinted: false))
        }
        if let best = record.bestPeriod {
            boxes.append(Box(id: "habit-record-best-period", fact: best, detail: best.detail, spoken: best.spoken, tinted: false))
        }
        return stride(from: 0, to: boxes.count, by: columns).map { Array(boxes[$0..<min($0 + columns, boxes.count)]) }
    }
}

/// One box: its label, the number with its unit, and a line under it. Current streak is tinted with the habit's colour
/// and has Today's 🔥.
private struct RecordBox: View {
    let box: HabitRecordCard.Box
    let color: HabitColor

    var body: some View {
        let fact = box.fact
        VStack(alignment: .leading, spacing: WeekSpacing.label) {
            Text(fact.title).font(.footnote).foregroundStyle(.secondary)
            Text("\(box.tinted ? "🔥 " : "")\(Text(fact.number).font(.title2.weight(.semibold)))\(fact.unit.isEmpty ? "" : " ")\(Text(fact.unit).font(.subheadline))")
                .monospacedDigit()
                .fixedSize(horizontal: false, vertical: true)
            if let detail = box.detail {
                Text(detail).font(.footnote).foregroundStyle(.secondary).monospacedDigit()
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(box.tinted ? AnyShapeStyle(color.mark.opacity(0.15)) : AnyShapeStyle(Color(.tertiarySystemFill)),
                    in: RoundedRectangle(cornerRadius: 12, style: .continuous))
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(box.spoken)
        .accessibilityIdentifier(box.id)
    }
}

// MARK: - Milestones

/// Milestones as awards (spec §3): the newest on a plate, the rest on a shelf, and the one thing to aim for next on
/// each track. Only reached milestones are medals; later ones aren't listed (U5: the row of grey squares read as a
/// to-do list of locked items).
private struct MilestonesCard: View {
    let habitID: UUID
    let milestones: HabitMilestones
    let color: HabitColor
    let seeAll: () -> Void

    var body: some View {
        let reached = milestones.reached
        VStack(alignment: .leading, spacing: WeekSpacing.card) {
            HStack(alignment: .firstTextBaseline, spacing: WeekSpacing.tight) {
                Text("Milestones").font(.headline).accessibilityAddTraits(.isHeader)
                Spacer(minLength: WeekSpacing.tight)
                if reached.count >= 2 {
                    Button(action: seeAll) {
                        HStack(alignment: .firstTextBaseline, spacing: WeekSpacing.pair) {
                            Text("See all \(reached.count)")
                            Image(systemName: "chevron.right").font(.footnote.weight(.semibold))
                        }
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .frame(minHeight: 44)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    // A 44-point target that reaches into the card's padding without moving the title.
                    .padding(.vertical, -12)
                    .accessibilityLabel("See all \(reached.count) milestones")
                    .accessibilityIdentifier("habit-milestones-see-all")
                } else if reached.count == 1 {
                    Text("1 reached").font(.subheadline).foregroundStyle(.secondary)
                }
            }
            if let latest = reached.first {
                LatestPlate(milestone: latest, isLatest: reached.count > 1, habitID: habitID, color: color)
            }
            if reached.count > 1 {
                VStack(alignment: .leading, spacing: WeekSpacing.tight) {
                    Text("Earlier").font(.footnote).foregroundStyle(.secondary)
                    MilestoneShelf(milestones: reached.dropFirst(), color: color)
                }
            }
            VStack(alignment: .leading, spacing: 12) {
                Text("Next").font(.footnote).foregroundStyle(.secondary)
                ForEach(milestones.next) { next in
                    MilestoneNextRow(next: next, color: color, onPage: false)
                        .accessibilityIdentifier("habit-milestone-next-" + next.track.rawValue)
                }
            }
        }
        .pageCard()
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("habit-milestones")
        .onAppear { MilestoneSeen.remember(reached.map(\.id), habit: habitID) }
        .onChange(of: reached.first?.id) { MilestoneSeen.remember(reached.map(\.id), habit: habitID) }
    }
}

/// The newest medal on a plate tinted with the habit's colour. The first time it's shown it scales in once with a
/// light haptic; with Reduce Motion it simply appears (spec §3.1, the reward moment).
private struct LatestPlate: View {
    let milestone: Milestone
    let isLatest: Bool
    let color: HabitColor
    @State private var shown: Bool
    @State private var reward = 0
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    init(milestone: Milestone, isLatest: Bool, habitID: UUID, color: HabitColor) {
        self.milestone = milestone
        self.isLatest = isLatest
        self.color = color
        _shown = State(initialValue: MilestoneSeen.contains(milestone.id, habit: habitID))
    }

    var body: some View {
        HStack(spacing: 14) {
            MilestoneMedal(number: milestone.number, size: 64, color: color)
                .scaleEffect(shown ? 1 : 0.3)
                .opacity(shown ? 1 : 0)
            VStack(alignment: .leading, spacing: WeekSpacing.label) {
                if isLatest {
                    Text("Latest").font(.footnote.weight(.semibold)).foregroundStyle(.secondary)
                }
                Text(milestone.title).font(.headline)
                    .fixedSize(horizontal: false, vertical: true)
                Text(milestone.reachedText).font(.subheadline).foregroundStyle(.secondary)
            }
            Spacer(minLength: 0)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(color.mark.opacity(0.12), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
        .accessibilityElement(children: .ignore)
        .accessibilityLabel((isLatest ? "Latest: " : "") + milestone.spoken)
        .accessibilityIdentifier("habit-milestone-latest")
        .sensoryFeedback(.success, trigger: reward)
        .onAppear {
            guard !shown else { return }
            reward += 1
            if reduceMotion { shown = true } else { withAnimation(.spring(duration: 0.5, bounce: 0.35).delay(0.2)) { shown = true } }
        }
    }
}

/// The earlier medals, newest first, sideways; the fifth peeks at the card's edge.
private struct MilestoneShelf: View {
    let milestones: ArraySlice<Milestone>
    let color: HabitColor

    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .top, spacing: WeekSpacing.tight) {
                ForEach(milestones) { milestone in
                    VStack(spacing: 6) {
                        MilestoneMedal(number: milestone.number, size: 44, color: color)
                        VStack(spacing: 0) {
                            Text(milestone.shelfTop).font(.caption.weight(.semibold))
                            Text(milestone.shelfBottom).font(.caption2).foregroundStyle(.secondary)
                        }
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                    }
                    .frame(width: 64)
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(milestone.spoken)
                }
            }
            .padding(.vertical, 2)
        }
        .scrollIndicators(.hidden)
        .contentMargins(.horizontal, WeekSpacing.card, for: .scrollContent)
        .padding(.horizontal, -WeekSpacing.card)
        .accessibilityIdentifier("habit-milestone-shelf")
    }
}

/// A milestone reached: a circle in the habit's colour, lighter at the top, with a fine white inner ring and the number
/// in white. Nothing else on the page looks like one. The colours are the habit's mark (the same in light and dark mode,
/// where white reaches 3:1 on every colour), so the number reads in both.
struct MilestoneMedal: View {
    let number: String
    let size: CGFloat
    let color: HabitColor

    var body: some View {
        let mark = color.mark
        let share: CGFloat = number.count >= 4 ? 0.28 : number.count == 3 ? 0.34 : 0.40
        ZStack {
            Circle()
                .fill(LinearGradient(colors: [mark.mix(with: .white, by: 0.12), mark.mix(with: .black, by: 0.28)],
                                     startPoint: .top, endPoint: .bottom))
                .shadow(color: mark.mix(with: .black, by: 0.5).opacity(0.35), radius: 3, y: 2)
            Circle()
                .strokeBorder(Color.white.opacity(0.55), lineWidth: size >= 56 ? 1.5 : 1)
                .padding(size * 0.09)
            Text(number)
                .font(.system(size: size * share, weight: .bold))
                .monospacedDigit()
                .foregroundStyle(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.6)
                .padding(.horizontal, size * 0.12)
        }
        .frame(width: size, height: size)
        .accessibilityHidden(true)
    }
}

/// A track's next milestone: a ring filling clockwise from the top (current ÷ target), the target inside, and what's
/// left. No `GeometryReader`: the ring is a trimmed circle.
private struct MilestoneNextRow: View {
    let next: MilestoneNext
    let color: HabitColor
    let onPage: Bool

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle().inset(by: 2.5).stroke(Color(.tertiarySystemFill), lineWidth: 5)
                Circle().inset(by: 2.5).trim(from: 0, to: next.fraction)
                    .stroke(color.mark, style: StrokeStyle(lineWidth: 5, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                if next.target == nil {
                    Image(systemName: "checkmark").font(.body.weight(.bold))
                } else {
                    Text(next.number)
                        .font(.system(size: next.number.count >= 3 ? 15 : 17, weight: .bold))
                        .monospacedDigit()
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                        .padding(.horizontal, 7)
                }
            }
            .frame(width: 48, height: 48)
            VStack(alignment: .leading, spacing: WeekSpacing.label) {
                Text(onPage ? next.pageTitle : next.title).font(.body.weight(.semibold))
                    .fixedSize(horizontal: false, vertical: true)
                if let detail = next.detail {
                    Text(detail).font(.subheadline).foregroundStyle(.secondary).monospacedDigit()
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            Spacer(minLength: 0)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(next.spoken)
    }
}

/// All milestones (spec §3.2), pushed from "See all N ›": one card per track with its Next row and every medal
/// reached, newest first, in a three-column grid (two at accessibility text sizes).
struct AllMilestonesPage: View {
    let model: HabitPageModel
    let color: HabitColor
    @AppStorage(ProgressOptions.showStreaks) private var showStreaks = true
    @Environment(\.dynamicTypeSize) private var typeSize

    var body: some View {
        let milestones = model.milestones.shown(streaks: showStreaks)
        let columns = typeSize.isAccessibilitySize ? 2 : 3
        ScrollView {
            VStack(alignment: .leading, spacing: WeekSpacing.card) {
                ForEach(milestones.next) { next in
                    let reached = milestones.reached.filter { $0.track == next.track }
                    VStack(alignment: .leading, spacing: WeekSpacing.card) {
                        HStack(alignment: .firstTextBaseline, spacing: WeekSpacing.tight) {
                            Text(Self.title(next.track)).font(.headline).accessibilityAddTraits(.isHeader)
                            Spacer(minLength: WeekSpacing.tight)
                            Text("\(reached.count) reached").font(.subheadline).foregroundStyle(.secondary)
                        }
                        MilestoneNextRow(next: next, color: color, onPage: true)
                        if !reached.isEmpty {
                            Divider()
                            Grid(horizontalSpacing: WeekSpacing.tight, verticalSpacing: WeekSpacing.card) {
                                ForEach(Array(stride(from: 0, to: reached.count, by: columns)), id: \.self) { first in
                                    GridRow {
                                        ForEach(reached[first..<min(first + columns, reached.count)]) { milestone in
                                            VStack(spacing: 6) {
                                                MilestoneMedal(number: milestone.number, size: 56, color: color)
                                                Text(milestone.pageCaption).font(.subheadline.weight(.semibold))
                                                Text(milestone.pageDate).font(.footnote).foregroundStyle(.secondary)
                                            }
                                            .multilineTextAlignment(.center)
                                            .frame(maxWidth: .infinity)
                                            .accessibilityElement(children: .ignore)
                                            .accessibilityLabel(milestone.spoken)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .pageCard()
                    .accessibilityElement(children: .contain)
                    .accessibilityIdentifier("all-milestones-" + next.track.rawValue)
                }
                Text("Milestones you reach stay here, even when a run starts again.")
                    .font(.footnote).foregroundStyle(.secondary)
                    .padding(.horizontal, WeekSpacing.card)
            }
            .padding(WeekSpacing.card)
        }
        .background(Color(.systemGroupedBackground))
        .accessibilityIdentifier("all-milestones")
        .navigationTitle("Milestones")
        .navigationBarTitleDisplayMode(.inline)
    }

    static func title(_ track: Milestone.Track) -> String {
        switch track {
        case .inARow: "In a row"
        case .inTotal: "In total"
        case .sinceSlip: "Since a slip"
        }
    }
}

/// The medals already shown, per habit, so a new one scales in once (spec §3.1). Read once per habit into memory and
/// written only when a medal is shown for the first time (S15). Test launches keep theirs in memory only (D8).
enum MilestoneSeen {
    private static var known: [UUID: Set<String>] = [:]
    private static let prefix = "milestones.seen."

    static func contains(_ id: String, habit: UUID) -> Bool { seen(habit).contains(id) }

    static func remember(_ ids: [String], habit: UUID) {
        let before = seen(habit)
        let after = before.union(ids)
        guard after.count > before.count else { return }
        known[habit] = after
        guard !TestLaunchIsolation.isTestLaunch else { return }
        UserDefaults.standard.set(after.sorted(), forKey: prefix + habit.uuidString)
    }

    private static func seen(_ habit: UUID) -> Set<String> {
        if let set = known[habit] { return set }
        let stored = TestLaunchIsolation.isTestLaunch ? [] : UserDefaults.standard.stringArray(forKey: prefix + habit.uuidString) ?? []
        known[habit] = Set(stored)
        return Set(stored)
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
        // The ‹ › keep 44-pt targets and reach the card's edge; the title keeps the card's whole top padding. A -8 here
        // pulled "Week", "Month" and "Year in Pixels" up against the card's top edge (Current Work 31, 8 Oct 2026).
        .padding(.trailing, -12)
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
        // 12 at the sides so twelve month columns fit the iPhone SE; 16 above and below, as the Week and Month cards.
        .pageCard(padding: 12, vertical: WeekSpacing.card)
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
