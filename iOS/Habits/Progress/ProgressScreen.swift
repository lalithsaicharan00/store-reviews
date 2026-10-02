import SwiftUI

/// Progress, opened from the ≡ menu (Build Plan #60; report "The Progress Page — What People Need, and How to Build
/// It", §7). Week (2 Oct 2026, report "Weekly Habit Cards — What Each Card Shows"): the dates of the week, pinned at the
/// top, then a card per habit, each on its own goal's clock; no overview, no day rings, no group numbers. Month and
/// Year: an overview of day rings and three numbers, then a row per habit with its strip; tapping a day opens the Day
/// sheet. Tapping a habit opens its own page at Over Time. It only reads: nothing here logs.
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
    /// Phase 3: what counts as a full day, in percent (report §25.1, ledger C201).
    @AppStorage(ProgressOptions.fullDay) private var fullDay = 100
    /// The group chip chosen ("" is All), remembered; Progress keeps its own, apart from Today's (groups spec §2).
    @AppStorage(GroupFilter.progress) private var groupRaw = ""
    /// A day in the period on screen; nil means the current one, so the page always opens on it.
    @State private var anchor: LocalDay?
    /// Kept between openings (one for the app): reopening Progress with nothing changed shows the numbers already
    /// worked out instead of working them out again (PERFORMANCE.md rule 5).
    @State private var model = ProgressModel.shared
    @State private var openDay: LocalDay?
    /// The day "Show on Today" asked for, opened once the Day sheet has gone.
    @State private var showOnToday: LocalDay?
    @State private var showExplainer = false

    private var range: ProgressRange { ProgressRange(rawValue: rangeRaw) ?? .week }

    private func analyticsRange() {
        let counter: AnalyticsCounter = switch range { case .week: .progressWeek; case .month: .progressMonth; case .year: .progressYear }
        store.analytics.count(counter, ticket: store.analytics.ticket)
    }

    var body: some View {
        let key = ProgressModel.Key(range: range, anchor: anchor, version: store.dataVersion, fullDay: fullDay,
                                    group: store.existingGroup(groupRaw), today: store.today())
        Group {
            if let snapshot = model.snapshot {
                if snapshot.hasHabits {
                    if snapshot.range == .week { weekList(snapshot) } else { list(snapshot) }
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
        .analyticsScreen(.progress)
        .navigationTitle("Progress")
        .onPerfCommand { action in
            guard let snapshot = model.snapshot else { return }
            switch action {
            case .previousMonth: move(snapshot, by: -1)
            case .nextMonth: move(snapshot, by: 1)
            case .nextRange:
                let all = ProgressRange.allCases
                rangeRaw = all[((all.firstIndex(of: range) ?? 0) + 1) % all.count].rawValue
                anchor = nil
            default: break
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    // Menu items with a check, not switches: the app's green switch style (HabitsApp) must not reach
                    // a menu, where a switch-styled toggle stopped responding to taps (testHidePercentages, 2 Oct).
                    Group {
                        Toggle("Show Percentages", isOn: $showPercentages)
                        Toggle("Show Streaks", isOn: $showStreaks)
                    }
                    .toggleStyle(.automatic)
                    Picker("Full Day", selection: $fullDay) {
                        Text("All Done").tag(100)
                        Text("80% Done").tag(80)
                        Text("60% Done").tag(60)
                    }
                    .pickerStyle(.menu)
                } label: {
                    Label("View Options", systemImage: "ellipsis.circle")
                }
                .accessibilityIdentifier("progress-options")
            }
        }
        // Worked out before the first frame and again only when the key changes (report §20).
        .onAppear { model.load(key, store: store); analyticsRange() }
        .onChange(of: rangeRaw) { analyticsRange() }
        .onChange(of: showStreaks) {
            store.analytics.event(.preference, ["setting": .text("streaks"), "value": .text(showStreaks ? "enabled" : "disabled")], ticket: store.analytics.ticket)
            store.analyticsConfiguration()
        }
        .onChange(of: groupRaw) { store.analytics.count(.progressGroup, ticket: store.analytics.ticket) }
        .onChange(of: key) { model.load(key, store: store) }
        .sheet(item: $openDay, onDismiss: {
            // "Show on Today": close Progress and open that day on Today, where logging happens (report §7.4).
            guard let day = showOnToday else { return }
            showOnToday = nil
            router.showDay = day
            menu.path = NavigationPath()
        }) { day in
            ProgressDaySheet(day: day, group: model.snapshot?.group) { showOnToday = day }
        }
        .sheet(isPresented: $showExplainer) { ProgressExplainer().analyticsScreen(nil) }
        .navigationDestination(for: HabitPageLink.self) { link in
            HabitPageView(id: link.id, overTime: OverTimeStart(range: OverTimeRange(rawValue: link.range.rawValue) ?? .month, anchor: link.anchor))
        }
    }

    /// A scroll view of grouped cards, not a `List`: switching to Month sent the list's collection view into an
    /// endless self-sizing loop (it crashed, then hung, on CI, 30 Sep 2026). The habit rows stay lazy.
    private func list(_ snapshot: ProgressSnapshot) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                ProgressCard { rangeControl(snapshot) }
                // Groups (report §15): the chips filter every number below; nothing shows until a group exists.
                if !store.groups.isEmpty {
                    GroupChipRow(selection: snapshot.group) { groupRaw = $0?.uuidString ?? "" }
                        .padding(.top, -10)
                }
                overview(snapshot)
                if !snapshot.groupBars.isEmpty { groupBars(snapshot) }
                ForEach(snapshot.sections) { section in
                    rowSection(section, snapshot: snapshot)
                }
                if snapshot.group != nil && snapshot.sections.isEmpty && snapshot.quitting.isEmpty {
                    Text("No habits in this group yet. Add them in Filter on Today, or in a habit's Group.")
                        .font(.subheadline).foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .accessibilityIdentifier("progress-group-empty")
                }
                if !snapshot.quitting.isEmpty {
                    ProgressGroup(title: "Quitting") {
                        if snapshot.range == .week && !typeSize.isAccessibilitySize {
                            WeekStripHeader(days: snapshot.days.map(\.day), calendar: store.calendar)
                                .padding(.top, 6)
                        }
                        ForEach(Array(snapshot.quitting.enumerated()), id: \.element.id) { index, row in
                            if index > 0 { Divider().padding(.leading, 44) }
                            Button { open(row.habit, snapshot) } label: {
                                ProgressQuitRowView(row: row, range: snapshot.range).padding(.vertical, 8)
                            }
                            .buttonStyle(.plain)
                            .accessibilityIdentifier("progress-quit-\(row.habit.name)")
                        }
                    }
                }
                habitsSection(snapshot.archived, title: "Archived", snapshot: snapshot,
                              footer: "Archived habits count for the days before they were archived.")
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .background(Color(.systemGroupedBackground))
    }

    // MARK: Week

    /// The Week view. Week | Month | Year and the group chips scroll away; the dates stay pinned at the top while the
    /// cards scroll, so it's always clear which week they show and ‹ › are one tap away (report §3; NN/g: a sticky
    /// header should be small and hold only what's needed while scrolling). A lazy stack of cards in a scroll view,
    /// never a `List` (Design Rules).
    private func weekList(_ snapshot: ProgressSnapshot) -> some View {
        let all = snapshot.cards + snapshot.archivedCards
        return ScrollView {
            LazyVStack(alignment: .leading, spacing: 0, pinnedViews: [.sectionHeaders]) {
                rangePicker
                    .padding(.horizontal, 16)
                    .padding(.top, WeekSpacing.tight)
                    .padding(.bottom, WeekSpacing.tight)
                Section {
                    VStack(alignment: .leading, spacing: WeekSpacing.card) {
                        // Groups (report §15): the chips choose which habits' cards show; nothing shows until a group exists.
                        if !store.groups.isEmpty {
                            GroupChipRow(selection: snapshot.group) { groupRaw = $0?.uuidString ?? "" }
                        }
                        // What each mark means: folded until asked (the user, 2 Oct 2026).
                        WeekKey()
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, WeekSpacing.tight)
                    .padding(.bottom, WeekSpacing.section)
                    if snapshot.group != nil && all.isEmpty {
                        Text("No habits in this group yet. Add them in Filter on Today, or in a habit's Group.")
                            .font(.subheadline).foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)
                            .accessibilityIdentifier("progress-group-empty")
                    }
                    ForEach(snapshot.cards) { card in
                        weekCardButton(card, snapshot)
                    }
                    if !snapshot.archivedCards.isEmpty {
                        Text("Archived")
                            .font(.subheadline.weight(.semibold)).foregroundStyle(.secondary)
                            .padding(.horizontal, 32)
                            .padding(.top, WeekSpacing.tight)
                            .padding(.bottom, WeekSpacing.tight)
                            .accessibilityAddTraits(.isHeader)
                        ForEach(snapshot.archivedCards) { card in
                            weekCardButton(card, snapshot)
                        }
                        Text("Archived habits count for the days before they were archived.")
                            .font(.footnote).foregroundStyle(.secondary)
                            .padding(.horizontal, 32)
                    }
                } header: {
                    WeekPeriodBar(title: snapshot.title, caption: snapshot.caption, canGoBack: snapshot.canGoBack,
                                  canGoForward: snapshot.canGoForward) { move(snapshot, by: $0) }
                }
            }
            .padding(.bottom, WeekSpacing.section)
        }
        .background(Color(.systemGroupedBackground))
    }

    private func weekCardButton(_ card: ProgressWeekCard, _ snapshot: ProgressSnapshot) -> some View {
        Button { open(card.habit, snapshot) } label: {
            WeekCardView(card: card, columns: snapshot.columns)
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 16)
        .padding(.bottom, WeekSpacing.card)
        .accessibilityIdentifier(card.isQuit ? "progress-quit-\(card.habit.name)" : "progress-row-\(card.habit.name)")
    }

    // MARK: Range

    private var rangePicker: some View {
        Picker("Range", selection: $rangeRaw) {
            ForEach(ProgressRange.allCases) { Text($0.title).tag($0.rawValue) }
        }
        .pickerStyle(.segmented)
        .accessibilityIdentifier("progress-range")
    }

    private func rangeControl(_ snapshot: ProgressSnapshot) -> some View {
        VStack(spacing: 10) {
            rangePicker
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
            ProgressGroup {
                if snapshot.hasPlan {
                    switch snapshot.range {
                    case .week: weekRings(snapshot)
                    case .month: monthRings(snapshot)
                    case .year: yearOverview(snapshot)
                    }
                    Divider().padding(.vertical, 6)
                    tiles(snapshot)
                    if showPercentages, let previous = snapshot.previous {
                        Text("\(previous.title): \(previous.tally.done) of \(previous.tally.planned)")
                            .font(.subheadline).foregroundStyle(.secondary).monospacedDigit()
                            .frame(maxWidth: .infinity)
                            .padding(.top, 8)
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
                    // Year ▶ Share: a picture of the year, drawn only when shared (report §25.1, Phase 3).
                    if let item = store.yearShareItem(snapshot) {
                        ShareLink(item: item, preview: SharePreview("Year \(snapshot.title)", image: Image(systemName: "calendar"))) {
                            Label("Share the Year", systemImage: "square.and.arrow.up")
                        }
                        .labelStyle(.iconOnly)
                        .font(.body)
                        .frame(minWidth: 44, minHeight: 32)
                        .accessibilityIdentifier("progress-share-year")
                    }
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
        let names = store.weekdayNames.veryShort
        return HStack(spacing: 0) {
            ForEach(snapshot.days) { cell in
                VStack(spacing: 4) {
                    Text(names[cell.day.weekday(calendar: calendar) - 1])
                        .font(.caption2.weight(.semibold)).foregroundStyle(.secondary)
                        .accessibilityHidden(true)
                    ring(cell)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.vertical, 4)
    }

    /// A month of rings, one row per week. A plain grid, not a lazy one: a lazy grid inside a list row has no height
    /// until it's drawn, and the list re-measured the row until UIKit stopped the app (CI, 30 Sep 2026).
    private func monthRings(_ snapshot: ProgressSnapshot) -> some View {
        let calendar = store.calendar
        let first = snapshot.period.lowerBound.date(calendar: calendar)
        let lead = (calendar.component(.weekday, from: first) - calendar.firstWeekday + 7) % 7
        let symbols = calendar.veryShortStandaloneWeekdaySymbols
        let ordered = Array(symbols[(calendar.firstWeekday - 1)...] + symbols[..<(calendar.firstWeekday - 1)])
        let slots: [ProgressDay?] = Array(repeating: nil, count: lead) + snapshot.days.map { Optional($0) }
        let weeks = stride(from: 0, to: slots.count, by: 7).map { Array(slots[$0..<min($0 + 7, slots.count)]) }
        return VStack(spacing: 6) {
            HStack(spacing: 0) {
                ForEach(0..<7, id: \.self) { i in
                    Text(ordered[i]).font(.caption2.weight(.semibold)).foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity)
                        .accessibilityHidden(true)
                }
            }
            ForEach(0..<weeks.count, id: \.self) { w in
                HStack(spacing: 0) {
                    ForEach(0..<7, id: \.self) { i in
                        if i < weeks[w].count, let cell = weeks[w][i] {
                            ring(cell)
                        } else {
                            Color.clear.frame(maxWidth: .infinity).frame(height: 44).accessibilityHidden(true)
                        }
                    }
                }
            }
        }
        .padding(.vertical, 4)
    }

    /// The year as dots, each day's share of what was planned (report §7.2). Tapping a month opens it in Month.
    @ViewBuilder private func yearOverview(_ snapshot: ProgressSnapshot) -> some View {
        if let dots = snapshot.yearDots {
            YearGridView(dots: dots, color: .ink, dot: 4, gap: 1.5, labels: true) { first in
                rangeRaw = ProgressRange.month.rawValue
                anchor = store.period(.month, containing: first).contains(store.today()) ? nil : first
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 4)
            .accessibilityElement(children: .contain)
            .accessibilityLabel("\(snapshot.title): \(snapshot.tally.done) of \(snapshot.tally.planned) done")
            .accessibilityIdentifier("progress-year-grid")
        }
    }

    private func ring(_ cell: ProgressDay) -> some View {
        let calendar = store.calendar
        let score = cell.score
        let words = score.planned == 0 ? "nothing planned"
            : cell.isFuture ? "\(score.planned) planned"
            : "\(score.done) of \(score.planned) done" + (score.partCount > 0 ? ", \(score.partCount) part done" : "")
        return Button { openDay = cell.day } label: {
            DayRing(fraction: score.fraction, planned: score.planned > 0, isFuture: cell.isFuture,
                    label: String(cell.day.day), bold: cell.isToday, full: score.isFull(at: Double(fullDay) / 100))
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
            let fullCaption = fullDay < 100 ? "Full days (\(fullDay)%)" : "Full days"
            tile("\(tally.fullDays)", fullCaption, id: "progress-tile-full", spoken: "\(fullCaption), \(tally.fullDays)")
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

    // MARK: Groups

    /// One bar per group for the period, in the groups' own order, never ranked (report §15). Tapping one chooses it.
    private func groupBars(_ snapshot: ProgressSnapshot) -> some View {
        ProgressGroup(title: "Groups") {
            ForEach(Array(snapshot.groupBars.enumerated()), id: \.element.id) { index, bar in
                if index > 0 { Divider() }
                Button { groupRaw = bar.group.id.uuidString } label: {
                    ProgressGroupBarView(bar: bar, showPercentages: showPercentages).padding(.vertical, 8)
                }
                .buttonStyle(.plain)
                .accessibilityIdentifier("progress-group-\(bar.group.name)")
            }
        }
    }

    /// A group's habits under its heading, "● Health · 24 of 30 · 80%"; or "No Group"; or "Habits" when there's one.
    @ViewBuilder
    private func rowSection(_ section: ProgressRowSection, snapshot: ProgressSnapshot) -> some View {
        if let group = section.group {
            ProgressGroup(content: { rowCards(section.rows, snapshot: snapshot) }, header: {
                HStack(spacing: 6) {
                    Circle().fill(group.color.color).frame(width: 8, height: 8)
                    Text(group.name)
                    if let tally = section.tally, tally.planned > 0 {
                        Text("· \(tally.done) of \(tally.planned)" + (showPercentages ? tally.percent.map { " · \($0)%" } ?? "" : ""))
                            .monospacedDigit()
                    }
                }
                .accessibilityElement(children: .combine)
            })
        } else {
            habitsSection(section.rows, title: section.ungrouped ? "No Group" : "Habits", snapshot: snapshot, footer: nil)
        }
    }

    // MARK: Habit rows

    @ViewBuilder
    private func habitsSection(_ rows: [ProgressHabitRow], title: String, snapshot: ProgressSnapshot, footer: String?) -> some View {
        if !rows.isEmpty {
            ProgressGroup(title: title, footer: footer) { rowCards(rows, snapshot: snapshot) }
        }
    }

    @ViewBuilder
    private func rowCards(_ rows: [ProgressHabitRow], snapshot: ProgressSnapshot) -> some View {
        // The weekday initials over the week strips, once per card (report §7.3).
        if snapshot.range == .week && !typeSize.isAccessibilitySize {
            WeekStripHeader(days: snapshot.days.map(\.day), calendar: store.calendar)
                .padding(.top, 6)
        }
        LazyVStack(spacing: 0) {
            ForEach(Array(rows.enumerated()), id: \.element.id) { index, row in
                if index > 0 { Divider().padding(.leading, 44) }
                Button { open(row.habit, snapshot) } label: {
                    ProgressRowView(row: row, range: snapshot.range, showPercentages: showPercentages)
                        .padding(.vertical, 8)
                }
                .buttonStyle(.plain)
                .accessibilityIdentifier("progress-row-\(row.habit.name)")
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
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .center, spacing: 12) {
                HabitIcon(symbol: row.habit.symbol, color: row.habit.color)
                VStack(alignment: .leading, spacing: 3) {
                    Text(row.habit.name).foregroundStyle(.primary).lineLimit(2)
                    Text(subtitle).font(.subheadline).foregroundStyle(.secondary).monospacedDigit()
                    if strips && range == .month {
                        MonthStrip(marks: row.marks, color: row.habit.color.mark).padding(.top, 3)
                    }
                }
                Spacer(minLength: 8)
                if strips && range == .week {
                    WeekStrip(marks: row.marks, color: row.habit.color.mark)
                }
            }
            // Year: the habit's own year of dots, the card's full width (report §7.3).
            if strips && range == .year, let dots = row.yearDots {
                YearGridView(dots: dots, color: row.habit.color.mark, dot: 4, gap: 1.5)
                    .accessibilityHidden(true)
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
    static let shared = ProgressModel()

    struct Key: Hashable {
        let range: ProgressRange
        let anchor: LocalDay?
        let version: Int
        var fullDay = 100
        /// The group chip chosen; nil is All.
        var group: UUID? = nil
        /// A new day makes new numbers: "This week" kept from before midnight would be last week (CI, 1 Oct 2026).
        var today: LocalDay? = nil
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
        // Ranges × periods × groups: room for every group's week, month and year and the ones before them.
        if cache.count > 80 { cache.removeAll() }
        let today = key.today ?? store.today()
        let made = perfTimed("Progress \(key.range): whole snapshot") {
            store.progressSnapshot(key.range, containing: key.anchor ?? today, today: today, fullAt: Double(key.fullDay) / 100,
                                   group: key.group, weekCards: key.range == .week)
        }
        cache[key] = made
        snapshot = made
    }
}

/// A grouped card like an inset-grouped list's section, on a scroll view (no `List`; see `ProgressScreen.list`).
struct ProgressCard<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 0) { content }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.card, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}

/// A card with a header above it and an optional footer below, as a grouped list section reads.
struct ProgressGroup<Content: View, Header: View>: View {
    let header: Header
    let footer: String?
    @ViewBuilder let content: Content

    init(title: String, footer: String? = nil, @ViewBuilder content: () -> Content) where Header == Text {
        header = Text(title)
        self.footer = footer
        self.content = content()
    }

    init(footer: String? = nil, @ViewBuilder content: () -> Content, @ViewBuilder header: () -> Header) {
        self.header = header()
        self.footer = footer
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            header
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.secondary)
                .padding(.horizontal, 16)
                .accessibilityAddTraits(.isHeader)
            ProgressCard { content }
            if let footer {
                Text(footer).font(.footnote).foregroundStyle(.secondary).padding(.horizontal, 16)
            }
        }
    }
}

/// A quit habit's row (report §10.2): the run going on, ticking once a minute (days and hours only; seconds tick only
/// on its own page), the best run and the slips in the period, and its strip.
struct ProgressQuitRowView: View {
    let row: ProgressQuitRow
    let range: ProgressRange
    @Environment(\.dynamicTypeSize) private var typeSize

    var body: some View {
        let strips = !typeSize.isAccessibilitySize
        let color = row.habit.color.mark
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .center, spacing: 12) {
                HabitIcon(symbol: row.habit.symbol, color: row.habit.color)
                VStack(alignment: .leading, spacing: 3) {
                    HStack {
                        Text(row.habit.name).foregroundStyle(.primary).lineLimit(2)
                        Spacer(minLength: 8)
                        if row.paused {
                            Text("Paused").font(.subheadline).foregroundStyle(.secondary)
                        } else if let start = row.runStart {
                            // Only this text ticks, anchored at the run's start (Design Rules: speed).
                            TimelineView(.periodic(from: start, by: 60)) { context in
                                Text(ProgressQuitRowView.short(context.date.timeIntervalSince(start)))
                                    .font(.subheadline.weight(.semibold).monospacedDigit())
                            }
                        }
                    }
                    Text(row.text).font(.subheadline).foregroundStyle(.secondary).monospacedDigit()
                    if strips && range == .month { MonthStrip(marks: row.marks, color: color).padding(.top, 3) }
                }
                if strips && range == .week { WeekStrip(marks: row.marks, color: color) }
            }
            if strips && range == .year, let dots = row.yearDots {
                YearGridView(dots: dots, color: color, dot: 4, gap: 1.5).accessibilityHidden(true)
            }
        }
        .contentShape(Rectangle())
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(row.habit.name + ". " + (row.paused ? "Paused. " : "") + row.text)
        .accessibilityHint("Opens the habit")
        .accessibilityAddTraits(.isButton)
    }

    /// "12 d 4 h", "5 h 20 min".
    static func short(_ t: TimeInterval) -> String {
        let minutes = max(0, Int(t / 60))
        let d = minutes / 1440, h = minutes % 1440 / 60, m = minutes % 60
        return d > 0 ? "\(d) d \(h) h" : "\(h) h \(m) min"
    }
}

/// A quit card's headline: the run going on now, "12 d 11 h current run". Only this text ticks, once a minute,
/// anchored at the run's start (PERFORMANCE.md rules 3 and 4).
struct QuitRunClock: View {
    let start: Date

    var body: some View {
        TimelineView(.periodic(from: start, by: 60)) { context in
            Text(ProgressQuitRowView.short(context.date.timeIntervalSince(start)))
                .font(.title3.weight(.semibold)).monospacedDigit()
            + Text(" current run").font(.subheadline).foregroundStyle(.secondary)
        }
    }
}

/// A group's bar in the Groups card: "● Health", its done of planned and the bar (report §15).
struct ProgressGroupBarView: View {
    let bar: ProgressGroupBar
    let showPercentages: Bool

    var body: some View {
        let tally = bar.tally
        let text = tally.planned == 0 ? "Nothing planned"
            : "\(tally.done) of \(tally.planned)" + (showPercentages ? tally.percent.map { " · \($0)%" } ?? "" : "")
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 8) {
                Circle().fill(bar.group.color.color).frame(width: 10, height: 10)
                Text(bar.group.name).foregroundStyle(.primary).lineLimit(1)
                Spacer(minLength: 8)
                Text(text).font(.subheadline).foregroundStyle(.secondary).monospacedDigit()
            }
            ProgressView(value: tally.planned == 0 ? 0 : Double(tally.done) / Double(tally.planned))
                .tint(bar.group.color.color)
        }
        .contentShape(Rectangle())
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("\(bar.group.name), \(text)")
        .accessibilityHint("Shows this group only")
        .accessibilityAddTraits(.isButton)
    }
}
