import SwiftUI

// The habit page's Phase 2 sections (Build Plan #60f; report §8.4, §8.5, §10.3). Each works its numbers out when the
// data or its own choice changes, never while drawing.

/// A year of this habit's days as dots (report §8.4), with ‹ year ›. Tapping a month opens it in the calendar above.
struct HabitYearSection: View {
    let habit: Habit
    let onMonth: (LocalDay) -> Void
    @Environment(HabitStore.self) private var store
    @State private var year: Int?
    @State private var dots: YearDots?
    @State private var key: Key?

    private struct Key: Hashable { let year: Int; let version: Int; let habit: Habit }

    var body: some View {
        let today = store.today()
        let shown = year ?? today.year
        let current = Key(year: shown, version: store.dataVersion, habit: habit)
        let first = habit.kind == .quit ? store.quitStartDay(of: habit).year : store.startDay(of: habit).year
        Section {
            VStack(spacing: 10) {
                HStack {
                    Button("Previous year", systemImage: "chevron.left") { year = shown - 1 }
                        .labelStyle(.iconOnly).disabled(shown <= first)
                    Spacer()
                    Text(String(shown)).font(.headline).accessibilityIdentifier("habit-year-title")
                    Spacer()
                    Button("Next year", systemImage: "chevron.right") { year = shown + 1 == today.year ? nil : shown + 1 }
                        .labelStyle(.iconOnly).disabled(shown >= today.year)
                }
                .buttonStyle(.borderless)
                if let dots {
                    ScrollViewReader { proxy in
                        ScrollView(.horizontal, showsIndicators: false) {
                            YearGridView(dots: dots, color: habit.color.color, dot: 8, gap: 2, labels: true, onMonth: onMonth)
                                .padding(.vertical, 2)
                                .id("grid")
                        }
                        .onAppear { if shown == today.year { proxy.scrollTo("grid", anchor: .trailing) } }
                    }
                    .accessibilityIdentifier("habit-year-grid")
                }
            }
            .padding(.vertical, 4)
            .onAppear { load(current) }
            .onChange(of: current) { load(current) }
        } header: {
            Text("Year")
        }
    }

    private func load(_ key: Key) {
        guard key != self.key else { return }
        self.key = key
        let span = store.period(.year, containing: LocalDay(year: key.year, month: 6, day: 1))
        if habit.kind == .quit {
            let marks = store.quitStats(of: habit, in: span).marks
            let byDay = Dictionary(uniqueKeysWithValues: marks.map { ($0.day, $0) })
            dots = store.yearDots(span) { byDay[$0] }
        } else {
            let today = store.today()
            dots = store.yearDots(span) { day in
                guard day <= today else { return nil }
                let mark = store.dayMark(habit, on: day)
                // Only planned days get a dot; today counts once it's done (report §13.3).
                guard mark == .done || (day < today && (mark == .some || mark == .missed)) else { return nil }
                return ProgressMark(day: day, mark: mark, fraction: mark == .some ? store.dayFraction(habit, on: day) : 1, over: false)
            }
        }
    }
}

/// The five longest runs, with the current one marked, and Show All (report §8.5). Same walk as the streak.
struct HabitRunsSection: View {
    let habit: Habit
    @Environment(HabitStore.self) private var store
    @State private var runs: [HabitStore.Run] = []
    @State private var key: Int?
    @State private var showAll = false

    var body: some View {
        let unit = habit.frequency.streakUnit
        let top = runs.sorted { ($0.length, $0.end) > ($1.length, $1.end) }.prefix(5)
        Section {
            // One row, so its modifiers run once (a Section repeats them per row: Design Rules).
            VStack(alignment: .leading, spacing: 8) {
                if runs.isEmpty {
                    Text("Runs show here once it's been done a few times.").foregroundStyle(.secondary)
                }
                ForEach(Array(top), id: \.self) { run in
                    Text(store.runText(run, unit: unit)).monospacedDigit()
                        .fontWeight(run.isCurrent ? .semibold : .regular)
                }
                if runs.count > 5 {
                    Button("Show All (\(runs.count))") { showAll = true }.buttonStyle(.borderless)
                }
            }
            .padding(.vertical, 4)
            .onAppear { load() }
            .onChange(of: store.dataVersion) { load() }
            .accessibilityIdentifier("habit-runs")
            .sheet(isPresented: $showAll) {
                NavigationStack {
                    List(runs.reversed(), id: \.self) { run in
                        Text(store.runText(run, unit: unit)).monospacedDigit()
                    }
                    .navigationTitle("Runs")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar { ToolbarItem(placement: .confirmationAction) { Button("Done") { showAll = false } } }
                }
            }
        } header: {
            Text("Runs")
        }
    }

    private func load() {
        guard key != store.dataVersion else { return }
        key = store.dataVersion
        runs = store.runs(of: habit)
    }
}

// MARK: Quit habits (report §10.3)

/// The live clock, best run, clean days, the next milestone, and Log a Slip.
struct QuitNumbers: View {
    let habit: Habit
    @Environment(HabitStore.self) private var store
    @State private var showSlip = false
    @State private var lastSlip: UUID?
    @State private var showCost = false

    var body: some View {
        let now = Date.now
        let history = store.quitHistory(of: habit, now: now)
        let current = history.last.flatMap { $0.endedBy == .ongoing ? $0 : nil }
        let best = history.map { $0.length(now: now) }.max() ?? 0
        VStack(spacing: 10) {
            HStack(spacing: 0) {
                VStack(spacing: 2) {
                    if let current {
                        // Ticks every second inside this tile only, anchored at the run's start (Design Rules).
                        TimelineView(.periodic(from: current.start, by: 1)) { context in
                            Text(Self.clock(context.date.timeIntervalSince(current.start)))
                                .font(.title3.weight(.semibold).monospacedDigit()).lineLimit(1).minimumScaleFactor(0.6)
                        }
                    } else {
                        Text("Paused").font(.title3.weight(.semibold))
                    }
                    Text("This run").font(.caption).foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
                .accessibilityElement(children: .combine)
                VStack(spacing: 2) {
                    Text(Format.days(best)).font(.title3.weight(.semibold).monospacedDigit())
                    Text("Best run").font(.caption).foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
                .accessibilityElement(children: .combine)
            }
            Text(store.quitTotalLine(of: habit, now: now)).font(.footnote).foregroundStyle(.secondary)
                .accessibilityIdentifier("quit-total-line")
            if let next = store.nextMilestone(of: habit, now: now) {
                Text(next).font(.footnote).foregroundStyle(.secondary)
            }
            // Money saved (report §10.5, Phase 3): optional, set here, never asked for.
            if let saved = store.moneySaved(of: habit, now: now) {
                Button(saved) { showCost = true }
                    .font(.footnote.weight(.semibold))
                    .buttonStyle(.borderless)
                    .accessibilityIdentifier("quit-money-saved")
            } else {
                Button("What It Costs a Day…") { showCost = true }
                    .font(.footnote)
                    .buttonStyle(.borderless)
                    .accessibilityIdentifier("quit-set-cost")
            }
            HStack(spacing: 12) {
                Button("Log a Slip…", systemImage: "arrow.uturn.backward.circle") { showSlip = true }
                    .buttonStyle(.bordered)
                    .tint(habit.color.color)
                    .accessibilityIdentifier("habit-log-slip")
                if let id = lastSlip { SlipUndoLine(id: id) { withAnimation { lastSlip = nil } } }
            }
        }
        .padding(.vertical, 4)
        .sheet(isPresented: $showSlip) { LogSlipSheet(habit: habit) { id in withAnimation { lastSlip = id } } }
        .sheet(isPresented: $showCost) { QuitCostSheet(habit: habit) }
    }

    /// "12 d 4 h 31 min 07 s".
    static func clock(_ t: TimeInterval) -> String {
        let s = max(0, Int(t))
        let d = s / 86400, h = s % 86400 / 3600, m = s % 3600 / 60, sec = s % 60
        let tail = String(format: "%d min %02d s", m, sec)
        return d > 0 ? "\(d) d \(h) h \(tail)" : h > 0 ? "\(h) h \(tail)" : tail
    }
}

/// A quit habit's Over Time: slips, clean days and runs in Week · Month · Year · All, the runs chart, the slips
/// list and the milestones reached (report §10.3). Never "relapse", "failed" or "reset".
struct QuitOverTimeSection: View {
    let habit: Habit
    @Environment(HabitStore.self) private var store
    @State private var range: OverTimeRange = .month
    @State private var anchor: LocalDay?
    @State private var data: QuitData?
    @State private var key: Key?

    private struct Key: Hashable { let range: OverTimeRange; let anchor: LocalDay?; let version: Int; let habit: Habit }
    private struct QuitData {
        let span: ClosedRange<LocalDay>
        let title: String
        let stats: QuitStats
        let runs: [HabitStore.QuitRun]
        let average: TimeInterval?
        let notes: [LocalDay: String]
        let reached: String?
    }

    var body: some View {
        let current = Key(range: range, anchor: anchor, version: store.dataVersion, habit: habit)
        Section {
            VStack(alignment: .leading, spacing: 14) {
                Picker("Range", selection: $range) {
                    ForEach(OverTimeRange.allCases) { Text($0.title).tag($0) }
                }
                .pickerStyle(.segmented)
                .accessibilityIdentifier("quit-over-time-range")
                if let data {
                    HStack {
                        if let kind = range.kind {
                            Button("Previous", systemImage: "chevron.left") { move(data.span, kind, -1) }
                                .labelStyle(.iconOnly).disabled(data.span.lowerBound <= store.quitStartDay(of: habit))
                        }
                        Spacer()
                        Text(data.title).font(.headline)
                        Spacer()
                        if let kind = range.kind {
                            Button("Next", systemImage: "chevron.right") { move(data.span, kind, 1) }
                                .labelStyle(.iconOnly).disabled(data.span.contains(store.today()))
                        }
                    }
                    .buttonStyle(.borderless)
                    LazyVGrid(columns: [GridItem(.flexible(), alignment: .top), GridItem(.flexible(), alignment: .top)], spacing: 12) {
                        tile("\(data.stats.slips.count)", "Slips")
                        tile("\(data.stats.cleanDays) of \(data.stats.days)", "Clean days")
                        tile(Format.days(data.stats.longestRun), "Longest run")
                        if range == .all, let average = data.average { tile(Format.days(average), "Average run") }
                    }
                    if !data.runs.isEmpty { runsChart(data) }
                    if !data.stats.slips.isEmpty {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Slips").font(.subheadline.weight(.semibold))
                            ForEach(data.stats.slips.reversed(), id: \.self) { slip in
                                VStack(alignment: .leading, spacing: 1) {
                                    Text(slip.formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated).hour().minute()))
                                        .font(.subheadline)
                                    if let note = data.notes[store.today(now: slip)] {
                                        Text(note).font(.footnote).foregroundStyle(.secondary).lineLimit(3)
                                    }
                                }
                            }
                        }
                        .accessibilityIdentifier("quit-slips")
                    }
                    if range == .all, let reached = data.reached {
                        Text(reached).font(.footnote).foregroundStyle(.secondary)
                    }
                }
            }
            .padding(.vertical, 6)
            .id("over-time")
            .onAppear { load(current) }
            .onChange(of: current) { load(current) }
        } header: {
            Text("Over Time")
        }
    }

    private func tile(_ value: String, _ caption: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(value).font(.headline.monospacedDigit())
            Text(caption).font(.caption).foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .accessibilityElement(children: .combine)
    }

    /// One bar per run in time order; the current run in the habit's colour, labelled "Now"; a dashed average line.
    private func runsChart(_ data: QuitData) -> some View {
        let now = Date.now
        let color = habit.color.color
        return VStack(alignment: .leading, spacing: 6) {
            Text("Runs").font(.subheadline.weight(.semibold))
            let count = Double(max(data.runs.count, 1))
            LightBarChart(title: "Runs",
                          bars: data.runs.enumerated().map { i, run in
                              let days = run.length(now: now) / 86400
                              let ongoing = run.endedBy == .ongoing
                              return LightBarChart.Bar(id: i, from: Double(i) / count, to: Double(i + 1) / count, value: days,
                                                       opacity: ongoing ? 1 : 0.4, over: false,
                                                       label: (ongoing ? "Now, " : "Run \(i + 1), ") + Format.days(run.length(now: now)),
                                                       note: ongoing ? "Now" : nil)
                          },
                          goals: data.average.map { [LightBarChart.GoalLine(from: 0, to: 1, value: $0 / 86400)] } ?? [],
                          dashedGoals: true, color: color, yLabel: { Format.amount($0) })
            .frame(height: 140)
        }
        .accessibilityIdentifier("quit-runs-chart")
    }

    private func move(_ span: ClosedRange<LocalDay>, _ kind: HabitStore.PeriodKind, _ step: Int) {
        let calendar = store.calendar
        let day = step < 0 ? span.lowerBound.adding(days: -1, calendar: calendar) : span.upperBound.adding(days: 1, calendar: calendar)
        anchor = store.period(kind, containing: day).contains(store.today()) ? nil : day
    }

    private func load(_ key: Key) {
        guard key != self.key else { return }
        self.key = key
        let today = store.today()
        let now = Date.now
        let start = store.quitStartDay(of: habit)
        let span = key.range.kind.map { store.period($0, containing: key.anchor ?? today) } ?? (min(start, today)...today)
        let stats = store.quitStats(of: habit, in: span, now: now)
        let lower = store.dayStartMoment(span.lowerBound), upper = store.dayStartMoment(span.upperBound.adding(days: 1, calendar: store.calendar))
        let runs = store.quitHistory(of: habit, now: now).filter { $0.start < upper && ($0.end ?? now) > lower }
        let title = key.range == .all ? "All time" : key.range == .year ? String(span.lowerBound.year)
            : store.periodTitle(key.range == .week ? .week : .month, span, today: today)
        var notes: [LocalDay: String] = [:]
        for slip in stats.slips { let day = store.today(now: slip); notes[day] = store.note(of: habit, on: day) }
        data = QuitData(span: span, title: title, stats: stats, runs: runs, average: stats.averageRun, notes: notes,
                    reached: store.reachedMilestones(of: habit, now: now))
    }
}

/// What a quit habit cost a day, for "Saved so far" (report §10.5, Phase 3).
struct QuitCostSheet: View {
    let habit: Habit
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var amount = ""
    @State private var currency = "$"

    private var currencies: [String] {
        var list = ["$", "€", "£", "₹"]
        if let local = Locale.current.currencySymbol, !list.contains(local) { list.insert(local, at: 0) }
        return list
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        TextField("Amount", text: $amount)
                            .keyboardType(.decimalPad)
                            .frame(minWidth: 80, maxWidth: 160)
                            .accessibilityIdentifier("cost-amount")
                        Picker("Currency", selection: $currency) {
                            ForEach(currencies, id: \.self) { Text($0).tag($0) }
                        }
                        .labelsHidden()
                        Spacer()
                        Text("a day").foregroundStyle(.secondary)
                    }
                } footer: {
                    Text("Progress counts what you've saved on clean days.")
                }
                if store.costs[habit.id] != nil {
                    Section {
                        Button("Remove", role: .destructive) {
                            store.setCost(nil, of: habit)
                            dismiss()
                        }
                    }
                }
            }
            .selectsNumbersOnFocus()
            .navigationTitle("What It Costs a Day")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) { Button("Cancel") { dismiss() } }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let value = Double(amount.replacingOccurrences(of: ",", with: ".")) ?? 0
                        store.setCost(HabitCost(amount: value, currency: currency), of: habit)
                        dismiss()
                    }
                    .disabled((Double(amount.replacingOccurrences(of: ",", with: ".")) ?? 0) <= 0)
                    .accessibilityIdentifier("cost-save")
                }
            }
            .onAppear {
                if let cost = store.costs[habit.id] {
                    amount = String(format: "%g", cost.amount)
                    currency = cost.currency
                } else {
                    currency = currencies[0]
                }
            }
        }
        .presentationDetents([.medium])
    }
}
