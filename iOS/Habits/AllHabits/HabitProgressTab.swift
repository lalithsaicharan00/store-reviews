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
        if model.isNew {
            // Figma's New habit (1031:2743): nothing to count yet, so no record, milestones, month or year; this week
            // shows where the first logs will go.
            ContentUnavailableView {
                Label("No Progress Yet", systemImage: "chart.bar.xaxis")
            } description: {
                Text("Log \(habit.name) on Today. Your record, streaks and milestones build up here.")
            }
            .pageItem()
            .accessibilityIdentifier("habit-progress-empty")
            HabitPeriodCard(habit: habit, kind: .week, anchor: nil)
                .pageItem()
            HabitKeyCard(color: habit.color)
                .pageItem()
        } else {
            records
        }
    }

    @ViewBuilder private var records: some View {
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
            HabitRecordCard(habit: habit, record: record, showStreaks: showStreaks, showPercentages: showPercentages)
                .pageItem()
        }
        // Show Streaks off hides the runs in a row; a total a break can't take away stays (report §7.6, E9).
        let milestones = model.milestones.shown(streaks: showStreaks)
        if !milestones.next.isEmpty {
            MilestonesCard(habitID: habit.id, milestones: milestones, color: habit.color, seeAll: openMilestones)
                .pageItem()
                .id(HabitPageView.milestonesCard)
        }
        HabitKeyCard(color: habit.color)
            .pageItem()
        HabitPeriodCard(habit: habit, kind: .week, anchor: start?.range == .week ? start?.anchor : nil)
            .pageItem()
        HabitPeriodCard(habit: habit, kind: .month, anchor: start?.range == .month ? start?.anchor : nil)
            .pageItem()
        HabitYearCard(habit: habit, year: start?.range == .year ? start?.anchor.year : nil, openDay: openDay)
            .pageItem()
    }
}

// MARK: - What the squares mean

/// Figma's "What the squares mean" on the habit page (1142:253823 folded, 1142:255177 open): a card that's one row,
/// ? and the words with a chevron, closed whenever the page opens (`HeatKeyVisit`). Open, every kind of square in the
/// habit's own colour, one to a line, then that nothing counts against anyone. The row folds it again.
struct HabitKeyCard: View {
    let color: HabitColor
    @Environment(HeatKeyVisit.self) private var pageVisit: HeatKeyVisit?
    @State private var ownVisit = HeatKeyVisit()

    private static let squares: [(cell: HeatCell, title: String, isToday: Bool)] = [
        (.level(4), "Done: the goal was reached", false),
        (.level(5), "More than the goal", false),
        (.level(2), "Partially completed", false),
        (.level(0), "Not done", false),
        (.off(.notScheduled), "No goal that day", false),
        (.off(.skipped), "Skipped", false),
        (.off(.paused), "Paused", false),
        (.blank, "Before the habit started", false),
        (.upcoming, "Still to come", false),
        (.upcoming, "Today", true),
    ]

    var body: some View {
        let visit = pageVisit ?? ownVisit
        let open = visit.isOpen
        VStack(alignment: .leading, spacing: 0) {
            Button {
                withAnimation(.snappy(duration: 0.25)) { visit.toggle() }
            } label: {
                HStack(spacing: 16) {
                    Image(systemName: "questionmark.circle")
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .frame(width: 24)
                    Text("What the squares mean").font(.body).foregroundStyle(.primary)
                    Spacer(minLength: 8)
                    Image(systemName: "chevron.right")
                        .font(.footnote.weight(.semibold))
                        .foregroundStyle(.tertiary)
                        .rotationEffect(.degrees(open ? 90 : 0))
                }
                .padding(.horizontal, 16)
                .frame(minHeight: 52)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .accessibilityValue(open ? "Shown" : "Hidden")
            .accessibilityHint(open ? "Hides the key" : "Shows the key")
            .accessibilityIdentifier("heat-key-toggle")
            if open {
                Divider().padding(.leading, 56).padding(.trailing, 16)
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(Self.squares.indices, id: \.self) { i in
                        let square = Self.squares[i]
                        HStack(spacing: 16) {
                            HeatSquare(cell: square.cell, color: color, size: HeatSize.week, isToday: square.isToday)
                            Text(square.title).font(.subheadline)
                        }
                    }
                    Text("Nothing here counts against you: skipped, paused and no-goal days are left out of every count.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.top, 0)
                }
                .padding(16)
                .accessibilityElement(children: .combine)
                .accessibilityIdentifier("progress-key")
                .transition(.opacity)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.card, in: CardShape.shape)
        .onPerfCommand { action in
            if action == .toggleHeatKey { withAnimation(.snappy(duration: 0.25)) { visit.toggle() } }
        }
    }
}

// MARK: - Overall record

/// Figma's Overall record card (1158:119643): what's been recorded since the habit began, then four Stat tiles (current
/// streak on the habit's Fill, best streak, goal met, best day) and See All Streaks. 16 inside, 12 between its parts;
/// the title (Body) with "Since …" (Subheadline) beside it, the total (Title 1 Bold, its words in Body) under them.
/// At the accessibility text sizes (Figma's Accessibility 1) the title and its date stack and the tiles take a row each.
private struct HabitRecordCard: View {
    let habit: Habit
    let record: HabitOverall
    let showStreaks: Bool
    let showPercentages: Bool
    @Environment(\.dynamicTypeSize) private var typeSize

    var body: some View {
        let large = typeSize.isAccessibilitySize
        let tiles = tiles()
        VStack(alignment: .leading, spacing: 12) {
            Group {
                if large {
                    VStack(alignment: .leading, spacing: WeekSpacing.label) {
                        Text("Overall record").font(.body)
                        Text(record.since).font(.subheadline).foregroundStyle(.secondary)
                    }
                } else {
                    HStack(alignment: .firstTextBaseline, spacing: WeekSpacing.tight) {
                        Text("Overall record").font(.body)
                            .frame(maxWidth: .infinity, alignment: .leading)
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
            if !tiles.isEmpty {
                let columns = large ? 1 : 2
                Grid(horizontalSpacing: WeekSpacing.tight, verticalSpacing: WeekSpacing.tight) {
                    ForEach(Array(stride(from: 0, to: tiles.count, by: columns)), id: \.self) { start in
                        let row = tiles[start..<min(start + columns, tiles.count)]
                        GridRow {
                            ForEach(row) { tile in
                                // A tile with no partner takes the row (§8.1).
                                tile.gridCellColumns(row.count == 1 && columns == 2 ? 2 : 1)
                            }
                        }
                    }
                }
            }
            if showStreaks && record.best != nil {
                HStack {
                    Spacer(minLength: 0)
                    NavigationLink {
                        StreaksPage(habit: habit)
                    } label: {
                        Text("See All Streaks")
                    }
                    .buttonStyle(.borderless)
                    .controlSize(.small)
                    .foregroundStyle(Color.ink)
                    .accessibilityIdentifier("habit-see-all-streaks")
                }
            }
        }
        .pageCard()
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("habit-progress-record")
    }

    /// Current and Best streak (unless Show Streaks is off), then Goal met and Best day.
    private func tiles() -> [StatTile] {
        var tiles: [StatTile] = []
        if showStreaks, let current = record.current, let best = record.best {
            tiles.append(StatTile(fact: current, caption: current.detail, spoken: current.spoken, id: "habit-streak-current",
                                  streak: true, color: habit.color))
            tiles.append(StatTile(fact: best, caption: best.detail, spoken: best.spoken, id: "habit-streak-best"))
        }
        if let goal = record.goalMet {
            // The percentage follows Progress's "Show percentages".
            let percent = showPercentages && record.eligible > 0
                ? Int((Double(record.met) / Double(record.eligible) * 100).rounded()) : nil
            tiles.append(StatTile(fact: goal, caption: percent.map { "\($0)% \(record.percentNoun)" },
                                  spoken: goal.spoken + (percent.map { ", \($0) percent \(record.percentNoun)" } ?? ""),
                                  id: "habit-record-goal-met"))
        }
        if let best = record.bestPeriod {
            tiles.append(StatTile(fact: best, caption: best.detail, spoken: best.spoken, id: "habit-record-best-period"))
        }
        return tiles
    }
}

/// Figma's Stat tile (1005:2): one fact, as a label (Footnote, Secondary Label), the number (Title 2 Semibold) with its
/// unit (Subheadline), and a caption (Footnote, Secondary Label). 14 inside, 4 between, corners 16, on Tertiary System
/// Fill; the current streak is on the habit's Fill, with Today's 🔥. Tiles in a row share the tallest one's height.
struct StatTile: View, Identifiable {
    let fact: RecordFact
    let caption: String?
    let spoken: String
    let id: String
    var streak = false
    var color: HabitColor = .green

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(fact.title).font(.footnote).foregroundStyle(.secondary)
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                if streak { Text("🔥").font(.body) }
                Text(fact.number).font(.title2.weight(.semibold))
                if !fact.unit.isEmpty { Text(fact.unit).font(.subheadline) }
            }
            .monospacedDigit()
            .fixedSize(horizontal: false, vertical: true)
            if let caption {
                Text(caption).font(.footnote).foregroundStyle(.secondary).monospacedDigit()
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(14)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(streak ? AnyShapeStyle(color.fill) : AnyShapeStyle(Color(.tertiarySystemFill)),
                    in: RoundedRectangle(cornerRadius: 16, style: .continuous))
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(spoken)
        .accessibilityIdentifier(id)
    }
}

// MARK: - Milestones

/// Figma's Milestones card (Progress and milestones): the newest medal on a plate in the habit's Fill, up to three
/// earlier ones as badges, and the one thing to aim for next on each track. Only reached milestones are medals; later
/// ones aren't listed (U5: a row of grey squares read as a to-do list of locked items). Everything else is on All
/// Milestones, behind See All.
private struct MilestonesCard: View {
    let habitID: UUID
    let milestones: HabitMilestones
    let color: HabitColor
    let seeAll: () -> Void

    var body: some View {
        let reached = milestones.reached
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .center, spacing: WeekSpacing.tight) {
                Text("Milestones").font(.body).accessibilityAddTraits(.isHeader)
                Spacer(minLength: WeekSpacing.tight)
                if reached.count >= 2 {
                    // Plain, as See All Streaks under the record (Figma 1020:1492).
                    Button("See All \(reached.count)", action: seeAll)
                        .buttonStyle(.borderless)
                        .controlSize(.small)
                        .foregroundStyle(Color.ink)
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
                    MilestoneLabel("Earlier")
                    HStack(alignment: .top, spacing: WeekSpacing.pair) {
                        ForEach(reached.dropFirst().prefix(3)) { milestone in
                            MilestoneBadge(milestone: milestone, color: color)
                        }
                    }
                    .accessibilityElement(children: .contain)
                    .accessibilityIdentifier("habit-milestone-shelf")
                }
            }
            VStack(alignment: .leading, spacing: WeekSpacing.tight) {
                MilestoneLabel("Next")
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(milestones.next) { next in
                        NextMilestone(next: next, color: color)
                            .accessibilityIdentifier("habit-milestone-next-" + next.track.rawValue)
                    }
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

/// A part's label inside the card: Caption 1 Semibold, Secondary Label ("Earlier", "Next").
private struct MilestoneLabel: View {
    let text: String
    init(_ text: String) { self.text = text }

    var body: some View {
        Text(text).font(.caption.weight(.semibold)).foregroundStyle(.secondary).accessibilityAddTraits(.isHeader)
    }
}

/// The newest medal (Medium, 72) on a plate in the habit's Fill. The first time it's shown it scales in once with a
/// success haptic; with Reduce Motion it simply appears (spec §3.1, the reward moment).
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
        HStack(spacing: 16) {
            Medal(number: milestone.number, size: 72, color: color)
                .scaleEffect(shown ? 1 : 0.3)
                .opacity(shown ? 1 : 0)
            VStack(alignment: .leading, spacing: WeekSpacing.label) {
                if isLatest {
                    Text("Latest").font(.caption.weight(.semibold)).foregroundStyle(.secondary)
                }
                Text(milestone.title).font(.body)
                    .fixedSize(horizontal: false, vertical: true)
                Text(milestone.reachedText).font(.subheadline).foregroundStyle(.secondary)
            }
            Spacer(minLength: 0)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(color.fill, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
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

/// Figma's Milestone badge: a medal (52), what was reached in Caption 1 Semibold and when in Footnote. 96 wide, so
/// three sit in a card on the smallest iPhone; longer words wrap rather than shrink.
struct MilestoneBadge: View {
    let milestone: Milestone
    let color: HabitColor

    var body: some View {
        VStack(spacing: WeekSpacing.pair) {
            Medal(number: milestone.number, size: 52, color: color)
            VStack(spacing: 0) {
                Text(milestone.shelfTop).font(.caption.weight(.semibold))
                Text(milestone.shelfBottom).font(.footnote).foregroundStyle(.secondary)
            }
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
        }
        .frame(width: 96)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(milestone.spoken)
    }
}

/// The ring's middle: the next milestone's number in Body Semibold, or a check once the track has none left.
struct NextNumber: View {
    let next: MilestoneNext

    var body: some View {
        if next.target == nil {
            Image(systemName: "checkmark").font(.body.weight(.semibold))
        } else {
            Text(next.number)
                .font(.body.weight(.semibold))
                .monospacedDigit()
                .lineLimit(1)
                .minimumScaleFactor(0.6)
                .padding(.horizontal, 7)
        }
    }
}

/// Figma's Next milestone: a Progress ring (current ÷ target) with the target in it, then what it is and what's left.
struct NextMilestone: View {
    let next: MilestoneNext
    let color: HabitColor

    var body: some View {
        HStack(spacing: 12) {
            ProgressRing(fraction: next.fraction, tint: color.color) { NextNumber(next: next) }
            VStack(alignment: .leading, spacing: 0) {
                Text(next.title).font(.body.weight(.semibold))
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

/// Figma's Milestone row, a row of the All Milestones list: a Small medal (40) for one reached, or the Progress ring
/// for the next, in a 48 slot; what it is in Body and when (or what's left) under it, in the list's own insets (about
/// 72 tall, as Figma draws it); its line starts at the words, as every list row's does.
private struct MilestoneRow<Badge: View>: View {
    let headline: String
    let supporting: String?
    @ViewBuilder var badge: Badge

    var body: some View {
        HStack(spacing: 12) {
            badge.frame(width: 48, height: 48)
            VStack(alignment: .leading, spacing: 1) {
                Text(headline).font(.body)
                if let supporting {
                    Text(supporting).font(.subheadline).foregroundStyle(.secondary).monospacedDigit()
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            .alignmentGuide(.listRowSeparatorLeading) { $0[.leading] }
            Spacer(minLength: 0)
        }
        .accessibilityElement(children: .ignore)
    }
}

/// All Milestones (spec §3.2), pushed from See All: an inset-grouped list with a section per track, its next milestone
/// first and then every one reached, newest first.
struct AllMilestonesPage: View {
    let model: HabitPageModel
    let name: String
    let color: HabitColor
    @AppStorage(ProgressOptions.showStreaks) private var showStreaks = true

    var body: some View {
        if PerfSwitches.blankMilestonesPage {
            ScrollView { Color.clear.frame(height: 2000) }
                .navigationTitle("All Milestones")
                .navigationBarTitleDisplayMode(.inline)
        } else {
            page(model.milestones.shown(streaks: showStreaks))
        }
    }

    private func page(_ milestones: HabitMilestones) -> some View {
        List {
            Section {
            } header: {
                Text("\(name) · \(milestones.reached.count) reached")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .textCase(nil)
            }
            ForEach(milestones.next) { next in
                Section(Self.title(next.track)) {
                    MilestoneRow(headline: next.title, supporting: next.detail.map { "Next · " + $0 }) {
                        ProgressRing(fraction: next.fraction, tint: color.color) { NextNumber(next: next) }
                    }
                    .accessibilityLabel(next.spoken)
                    .accessibilityIdentifier("all-milestones-" + next.track.rawValue)
                    ForEach(milestones.reached.filter { $0.track == next.track }) { milestone in
                        MilestoneRow(headline: milestone.title, supporting: milestone.reachedText) {
                            Medal(number: milestone.number, size: 40, color: color)
                        }
                        .accessibilityLabel(milestone.spoken)
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
        .accessibilityIdentifier("all-milestones")
        .navigationTitle("All Milestones")
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
        let ticks: [Double]?
        let xLabels: [LightBarChart.XLabel]
        let rule: Habit
        let canGoBack: Bool
        let canGoForward: Bool
        /// A habit started today with nothing logged (Figma's New habit): "Your first week" over "Started today,
        /// Fri 23 Oct", in place of the card's own words.
        var opening: (headline: String, detail: String)?
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
                VStack(alignment: .leading, spacing: WeekSpacing.label) {
                    Text(data.opening?.headline ?? card.headline).font(.title3.weight(.semibold)).monospacedDigit()
                        .fixedSize(horizontal: false, vertical: true)
                    if let detail = data.opening?.detail ?? card.detail {
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
                                      xLabels: data.xLabels, ticks: data.ticks, color: habit.color.color,
                                      yLabel: { store.progressValue($0, data.rule) })
                            .frame(height: 140)
                    }
                }
            } else if data != nil {
                Text(habit.kind == .quit ? "Nothing recorded this \(noun)." : "Not started yet this \(noun).")
                    .font(.subheadline).foregroundStyle(.secondary)
            }
            // A first week has nothing before it to compare with (Figma's New habit leaves it out).
            if data?.opening == nil, let comparison = data?.comparison {
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
        var ticks: [Double]?
        // The amount recorded each day of the month, for habits that record amounts (research: actual quantities,
        // a goal line only where it is that day's goal).
        let shape = store.progressShape(rule)
        if kind == .month && [.times, .amount, .time, .periodTotal, .limitDay].contains(shape) && habit.kind != .quit {
            let days = store.days(in: span)
            let n = Double(days.count)
            // Figma (1142:260528): a day short of its goal is the lighter bar, as a partly done square is the lighter
            // square; a limit has no goal to reach, so its bars stay one colour.
            let reaching = shape != .limitDay && shape != .periodTotal
            for (i, day) in days.enumerated() where day <= today && day >= first {
                let dayRule = store.rule(habit, on: day)
                let value = store.dayProgress(of: dayRule, on: day)
                let goal = store.dayGoal(of: dayRule)
                let label = "\(day.day) \(store.calendar.shortStandaloneMonthSymbols[day.month - 1]): " + store.progressValue(value, rule)
                bars.append(LightBarChart.Bar(id: i, from: (Double(i) + 0.15) / n, to: (Double(i) + 0.85) / n, value: value,
                                              opacity: reaching && goal > 0 && value < goal ? 0.5 : 1, over: false, label: label))
            }
            // Lines at the goal and half of it, labelled (Figma), where the month has one daily goal; otherwise the goal
            // line follows each day's own goal.
            let goal = store.dayGoal(of: rule)
            if rule.frequency.isDayBased && !rule.frequency.isFlexible && goal > 0 {
                let dayGoals = Set(days.filter { $0 <= today && $0 >= first }.map { store.dayGoal(of: store.rule(habit, on: $0)) })
                if dayGoals.count <= 1 { ticks = [goal / 2, goal] } else { goals = [LightBarChart.GoalLine(from: 0, to: 1, value: goal)] }
            }
            // The first day and the last one shown: today, or the month's end.
            let last = days.lastIndex { $0 <= today } ?? days.count - 1
            xLabels = [0, last].reduce(into: [Int]()) { if !$0.contains($1) { $0.append($1) } }
                .map { LightBarChart.XLabel(at: (Double($0) + 0.5) / n, text: "\(days[$0].day)") }
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
            bars: bars, goals: goals, ticks: ticks, xLabels: xLabels, rule: rule,
            canGoBack: span.lowerBound > first,
            canGoForward: span.upperBound < today)
        if first == today, span.contains(today), habit.kind != .quit, store.entries(of: habit.id).isEmpty {
            data?.opening = ("Your first \(kind == .week ? "week" : "month")",
                             "Started today, " + DayWords.short(today, calendar: store.calendar))
        }
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

/// This period and the one before, on the same footing, as Figma's Comparison rows: the label and its value on one
/// line (Subheadline, the value Semibold), an 8-point bar under them. The larger value fills its track and the other its
/// share; this period in the habit's colour, the one before in its Fill. No arrows, no better or worse.
private struct ComparisonView: View {
    let comparison: PeriodComparison
    let color: HabitColor

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(comparison.title).font(.subheadline.weight(.semibold))
            if let note = comparison.note {
                Text(note).font(.subheadline).foregroundStyle(.secondary)
            } else {
                let top = max(comparison.thisValue ?? 0, comparison.previousValue ?? 0, 0.0001)
                row(comparison.thisLabel, comparison.thisText, (comparison.thisValue ?? 0) / top, color.color)
                row(comparison.previousLabel, comparison.previousText, (comparison.previousValue ?? 0) / top, color.fill)
            }
        }
        .accessibilityElement(children: .combine)
    }

    private func row(_ label: String, _ text: String, _ fraction: Double, _ fill: Color) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(alignment: .firstTextBaseline, spacing: WeekSpacing.tight) {
                Text(label).font(.subheadline).foregroundStyle(.secondary).lineLimit(1)
                Spacer(minLength: WeekSpacing.tight)
                Text(text).font(.subheadline.weight(.semibold)).monospacedDigit().lineLimit(1)
            }
            ZStack(alignment: .leading) {
                Capsule().fill(Color(.tertiarySystemFill))
                Capsule().fill(fill).scaleEffect(x: max(0.02, min(1, fraction)), y: 1, anchor: .leading)
            }
            .frame(height: 8)
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
        // Figma's Year in Pixels card: 16 inside, 12 between the header, the summary, the grid and the footnote.
        VStack(alignment: .leading, spacing: 12) {
            PeriodHeader(title: "Year in Pixels", subtitle: shown == today.year ? "\(shown) · This year" : "\(shown)", noun: "year",
                         canGoBack: shown > (data?.earliestYear ?? shown), canGoForward: shown < today.year) { step in
                selected = nil
                year = shown + step == today.year ? nil : shown + step
            }
            if let data {
                if let headline = data.headline {
                    VStack(alignment: .leading, spacing: WeekSpacing.label) {
                        Text(headline).font(.headline).monospacedDigit()
                            .fixedSize(horizontal: false, vertical: true)
                        if let detail = data.detail {
                            Text(detail).font(.subheadline).foregroundStyle(.secondary).monospacedDigit()
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }
                HeatYearPixels(cells: data.cells, monthStarts: data.starts, monthLengths: data.lengths,
                               monthNames: store.calendar.veryShortStandaloneMonthSymbols, todayIndex: data.todayIndex,
                               selected: selected, color: habit.color) { index in
                    let day = data.first.adding(days: index, calendar: store.calendar)
                    guard day <= today else { return }
                    selected = selected == index ? nil : index
                }
                .equatable()
                selection(data, today: today)
            }
        }
        .pageCard()
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
            .padding(14)
            .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
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
