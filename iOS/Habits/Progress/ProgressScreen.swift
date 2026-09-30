import SwiftUI

/// Progress, opened from the ≡ menu (Build Plan #60; report "The Progress Page — What People Need, and How to Build
/// It", §7). Week or Month: an overview of day rings and three numbers, then a row per habit with its strip. Tapping a
/// day opens the Day sheet; tapping a habit opens its own page at Over Time. It only reads: nothing here logs.
///
/// Speed (report §20): every number comes from one `ProgressSnapshot`, worked out when the data, the range or the
/// period changes, never while drawing. Month strips are flattened into one layer per row, in a lazy list.
struct ProgressScreen: View {
    @Environment(HabitStore.self) private var store
    @Environment(MenuModel.self) private var menu
    @Environment(AppRouter.self) private var router
    @Environment(\.dynamicTypeSize) private var typeSize
    @AppStorage(ProgressOptions.range) private var rangeRaw = ProgressRange.week.rawValue
    @AppStorage(ProgressOptions.showPercentages) private var showPercentages = true
    @AppStorage(ProgressOptions.showStreaks) private var showStreaks = true
    /// A day in the period on screen; nil means the current one, so the page always opens on it.
    @State private var anchor: LocalDay?
    @State private var model = ProgressModel()
    @State private var openDay: LocalDay?
    /// The day "Show on Today" asked for, opened once the Day sheet has gone.
    @State private var showOnToday: LocalDay?
    @State private var showExplainer = false

    private var range: ProgressRange { ProgressRange(rawValue: rangeRaw) ?? .week }

    var body: some View {
        let key = ProgressModel.Key(range: range, anchor: anchor, version: store.dataVersion)
        Group {
            if let snapshot = model.snapshot {
                if snapshot.hasHabits {
                    list(snapshot)
                } else {
                    ContentUnavailableView {
                        Label("No Progress Yet", systemImage: "chart.bar.xaxis")
                    } description: {
                        Text("Add a habit on Today and its progress shows here.")
                    }
                    .background(Color(.systemGroupedBackground))
                }
            } else {
                Color(.systemGroupedBackground).ignoresSafeArea()
            }
        }
        .navigationTitle("Progress")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Toggle("Show Percentages", isOn: $showPercentages)
                    Toggle("Show Streaks", isOn: $showStreaks)
                } label: {
                    Label("View Options", systemImage: "ellipsis.circle")
                }
                .accessibilityIdentifier("progress-options")
            }
        }
        // Worked out before the first frame and again only when the key changes (report §20).
        .onAppear { model.load(key, store: store) }
        .onChange(of: key) { model.load(key, store: store) }
        .sheet(item: $openDay, onDismiss: {
            // "Show on Today": close Progress and open that day on Today, where logging happens (report §7.4).
            guard let day = showOnToday else { return }
            showOnToday = nil
            router.showDay = day
            menu.path = NavigationPath()
        }) { day in
            ProgressDaySheet(day: day) { showOnToday = day }
        }
        .sheet(isPresented: $showExplainer) { ProgressExplainer() }
        .navigationDestination(for: HabitPageLink.self) { link in
            HabitPageView(id: link.id, overTime: OverTimeStart(range: link.range == .week ? .week : .month, anchor: link.anchor))
        }
    }

    private func list(_ snapshot: ProgressSnapshot) -> some View {
        List {
            Section { rangeControl(snapshot) }
            overview(snapshot)
            habitsSection(snapshot.rows, title: "Habits", snapshot: snapshot, footer: nil)
            if !snapshot.quitting.isEmpty {
                Section("Quitting") {
                    ForEach(snapshot.quitting) { row in
                        Button { open(row.habit, snapshot) } label: {
                            HStack(spacing: 12) {
                                HabitIcon(symbol: row.habit.symbol, color: row.habit.color)
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(row.habit.name).foregroundStyle(.primary).lineLimit(2)
                                    Text(row.text).font(.subheadline).foregroundStyle(.secondary).monospacedDigit()
                                }
                                Spacer(minLength: 0)
                            }
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                        .accessibilityElement(children: .combine)
                        .accessibilityAddTraits(.isButton)
                    }
                }
            }
            habitsSection(snapshot.archived, title: "Archived", snapshot: snapshot,
                          footer: "Archived habits count for the days before they were archived.")
        }
        .listStyle(.insetGrouped)
    }

    // MARK: Range

    private func rangeControl(_ snapshot: ProgressSnapshot) -> some View {
        VStack(spacing: 10) {
            Picker("Range", selection: $rangeRaw) {
                ForEach(ProgressRange.allCases) { Text($0.title).tag($0.rawValue) }
            }
            .pickerStyle(.segmented)
            .accessibilityIdentifier("progress-range")
            HStack {
                Button("Previous \(range.noun)", systemImage: "chevron.left") { move(snapshot, by: -1) }
                    .labelStyle(.iconOnly)
                    .frame(width: 44, height: 44)
                    .disabled(!snapshot.canGoBack)
                    .accessibilityIdentifier("progress-previous")
                Spacer()
                Text(snapshot.title).font(.headline).monospacedDigit()
                    .accessibilityIdentifier("progress-period")
                Spacer()
                Button("Next \(range.noun)", systemImage: "chevron.right") { move(snapshot, by: 1) }
                    .labelStyle(.iconOnly)
                    .frame(width: 44, height: 44)
                    .disabled(!snapshot.canGoForward)
                    .accessibilityIdentifier("progress-next")
            }
            .buttonStyle(.borderless)
        }
        .padding(.vertical, 2)
    }

    private func move(_ snapshot: ProgressSnapshot, by step: Int) {
        let calendar = store.calendar
        let day = step < 0 ? snapshot.period.lowerBound.adding(days: -1, calendar: calendar)
            : snapshot.period.upperBound.adding(days: 1, calendar: calendar)
        anchor = store.period(range.kind, containing: day).contains(store.today()) ? nil : day
    }

    // MARK: Overview

    @ViewBuilder private func overview(_ snapshot: ProgressSnapshot) -> some View {
        if snapshot.hasPlan || !snapshot.isRunning {
            Section {
                if snapshot.hasPlan {
                    if snapshot.range == .week { weekRings(snapshot) } else { monthRings(snapshot) }
                    tiles(snapshot)
                    if showPercentages, let previous = snapshot.previous {
                        Text("\(previous.title): \(previous.tally.done) of \(previous.tally.planned)")
                            .font(.subheadline).foregroundStyle(.secondary).monospacedDigit()
                            .frame(maxWidth: .infinity)
                            .accessibilityIdentifier("progress-previous-line")
                    }
                } else {
                    Text("Nothing was planned this \(snapshot.range.noun).")
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity)
                }
            } header: {
                HStack {
                    Text("Overview")
                    Spacer()
                    Button("How It's Counted", systemImage: "info.circle") { showExplainer = true }
                        .labelStyle(.iconOnly)
                        .font(.body)
                        .frame(minWidth: 44, minHeight: 32)
                        .accessibilityIdentifier("progress-info")
                }
            }
        }
    }

    private func weekRings(_ snapshot: ProgressSnapshot) -> some View {
        let calendar = store.calendar
        return HStack(spacing: 0) {
            ForEach(snapshot.days) { cell in
                VStack(spacing: 4) {
                    Text(calendar.veryShortStandaloneWeekdaySymbols[calendar.component(.weekday, from: cell.day.date(calendar: calendar)) - 1])
                        .font(.caption2.weight(.semibold)).foregroundStyle(.secondary)
                        .accessibilityHidden(true)
                    ring(cell)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.vertical, 4)
    }

    private func monthRings(_ snapshot: ProgressSnapshot) -> some View {
        let calendar = store.calendar
        let first = snapshot.period.lowerBound.date(calendar: calendar)
        let lead = (calendar.component(.weekday, from: first) - calendar.firstWeekday + 7) % 7
        let symbols = calendar.veryShortStandaloneWeekdaySymbols
        let ordered = Array(symbols[(calendar.firstWeekday - 1)...] + symbols[..<(calendar.firstWeekday - 1)])
        return LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 7), spacing: 6) {
            ForEach(Array(ordered.enumerated()), id: \.offset) {
                Text($0.element).font(.caption2.weight(.semibold)).foregroundStyle(.secondary).accessibilityHidden(true)
            }
            ForEach(0..<lead, id: \.self) { _ in Color.clear.frame(height: 44).accessibilityHidden(true) }
            ForEach(snapshot.days) { ring($0) }
        }
        .padding(.vertical, 4)
    }

    private func ring(_ cell: ProgressDay) -> some View {
        let calendar = store.calendar
        let score = cell.score
        let words = score.planned == 0 ? "nothing planned"
            : cell.isFuture ? "\(score.planned) planned"
            : "\(score.done) of \(score.planned) done" + (score.partCount > 0 ? ", \(score.partCount) part done" : "")
        return Button { openDay = cell.day } label: {
            DayRing(fraction: score.fraction, planned: score.planned > 0, isFuture: cell.isFuture,
                    label: String(cell.day.day), bold: cell.isToday, full: score.isFull)
                .frame(maxWidth: .infinity, minHeight: 44)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .disabled(cell.isFuture)
        .accessibilityLabel(cell.day.date(calendar: calendar).formatted(.dateTime.weekday(.wide).day().month(.wide)))
        .accessibilityValue((cell.isToday ? "Today, " : "") + words)
        .accessibilityHint(cell.isFuture ? "" : "Opens the day")
        .accessibilityIdentifier("progress-day-\(cell.day.year)-\(cell.day.month)-\(cell.day.day)")
    }

    private func tiles(_ snapshot: ProgressSnapshot) -> some View {
        let tally = snapshot.tally
        let percent = showPercentages ? tally.percent : nil
        return HStack(alignment: .top, spacing: 0) {
            // Never "0 of 0" and never 0% (report §7.8).
            if tally.planned == 0 {
                tile("0", "Done so far", id: "progress-tile-done", spoken: "Done so far, 0")
            } else {
                tile("\(tally.done) of \(tally.planned)", percent.map { "Done · \($0)%" } ?? "Done", id: "progress-tile-done",
                     spoken: "Done, \(tally.done) of \(tally.planned)" + (percent.map { ", \($0) percent" } ?? ""))
            }
            tile("\(tally.fullDays)", "Full days", id: "progress-tile-full", spoken: "Full days, \(tally.fullDays)")
            if let goals = snapshot.goals {
                tile("\(goals.met) of \(goals.total)", goals.caption, id: "progress-tile-goals",
                     spoken: "\(goals.caption), \(goals.met) of \(goals.total)")
            }
        }
        .padding(.vertical, 2)
    }

    private func tile(_ value: String, _ caption: String, id: String, spoken: String) -> some View {
        VStack(spacing: 2) {
            Text(value).font(.title3.weight(.semibold).monospacedDigit()).lineLimit(1).minimumScaleFactor(0.7)
            Text(caption).font(.caption).foregroundStyle(.secondary).multilineTextAlignment(.center).lineLimit(2)
        }
        .frame(maxWidth: .infinity)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(spoken)
        .accessibilityIdentifier(id)
    }

    // MARK: Habit rows

    @ViewBuilder
    private func habitsSection(_ rows: [ProgressHabitRow], title: String, snapshot: ProgressSnapshot, footer: String?) -> some View {
        if !rows.isEmpty {
            Section {
                // The weekday initials over the week strips, once (report §7.3).
                if snapshot.range == .week && !typeSize.isAccessibilitySize {
                    WeekStripHeader(days: snapshot.days.map(\.day), calendar: store.calendar)
                        .listRowSeparator(.hidden)
                        .padding(.bottom, -8)
                }
                ForEach(rows) { row in
                    Button { open(row.habit, snapshot) } label: {
                        ProgressRowView(row: row, range: snapshot.range, showPercentages: showPercentages)
                    }
                    .buttonStyle(.plain)
                    .accessibilityIdentifier("progress-row-\(row.habit.name)")
                }
            } header: {
                Text(title)
            } footer: {
                if let footer { Text(footer) }
            }
        }
    }

    /// The habit's own page at Over Time, on the same range and period (report §7.3).
    private func open(_ habit: Habit, _ snapshot: ProgressSnapshot) {
        let anchor = snapshot.isRunning ? snapshot.today : snapshot.period.lowerBound
        menu.path.append(HabitPageLink(id: habit.id, range: snapshot.range, anchor: anchor))
    }
}

/// A habit's page opened from Progress, at Over Time on Progress's range and period.
struct HabitPageLink: Hashable {
    let id: UUID
    let range: ProgressRange
    let anchor: LocalDay
}

/// One habit's row: icon, name, the subtitle for its type, and its strip (report §7.3, §9.1).
struct ProgressRowView: View {
    let row: ProgressHabitRow
    let range: ProgressRange
    let showPercentages: Bool
    @Environment(\.dynamicTypeSize) private var typeSize

    var body: some View {
        let percent = showPercentages ? row.percent : nil
        let subtitle = row.text + (percent.map { " · \($0)%" } ?? "")
        // From the accessibility sizes up, strips give way to the numbers, which carry the meaning (report §21).
        let strips = !typeSize.isAccessibilitySize
        HStack(alignment: .center, spacing: 12) {
            HabitIcon(symbol: row.habit.symbol, color: row.habit.color)
            VStack(alignment: .leading, spacing: 3) {
                Text(row.habit.name).foregroundStyle(.primary).lineLimit(2)
                Text(subtitle).font(.subheadline).foregroundStyle(.secondary).monospacedDigit()
                if strips && range == .month {
                    MonthStrip(marks: row.marks, color: row.habit.color.color).padding(.top, 3)
                }
            }
            Spacer(minLength: 8)
            if strips && range == .week {
                WeekStrip(marks: row.marks, color: row.habit.color.color)
            }
        }
        .padding(.vertical, 2)
        .contentShape(Rectangle())
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(row.accessibility + (percent.map { " \($0) percent." } ?? ""))
        .accessibilityHint("Opens the habit")
        .accessibilityAddTraits(.isButton)
    }
}

/// Holds Progress's numbers: one snapshot per range, period and data version, worked out once and kept, so going back
/// to a period is instant (report §20).
@Observable final class ProgressModel {
    struct Key: Hashable {
        let range: ProgressRange
        let anchor: LocalDay?
        let version: Int
    }

    private(set) var snapshot: ProgressSnapshot?
    @ObservationIgnored private var cache: [Key: ProgressSnapshot] = [:]

    func load(_ key: Key, store: HabitStore) {
        if let hit = cache[key] {
            snapshot = hit
            return
        }
        // Numbers from before a change are never shown again.
        cache = cache.filter { $0.key.version == key.version }
        if cache.count > 30 { cache.removeAll() }
        let made = store.progressSnapshot(key.range, containing: key.anchor ?? store.today())
        cache[key] = made
        snapshot = made
    }
}
