import SwiftUI

/// Habits & Tasks › Habits (Figma's Habits page, 6 and 10 Nov 2026): a Habit history card for every habit, grouped
/// under its routine's heading, then Quitting and Paused; at the end, Archived and What the squares mean. The view
/// (Week, Month, Year) and the period are in the bottom bar, in reach of the thumb; Back to This Week floats above it on
/// another week. Every number comes from Progress's snapshot (`ProgressModel`), worked out when the data or the period
/// changes, never while drawing (S5). The page only reads: logging happens on Today.
struct HabitsPage: View {
    /// A habit just made from Create New: the page scrolls to its card once the snapshot has it (Figma's Habit added),
    /// then lets go.
    @Binding var added: UUID?
    @Environment(HabitStore.self) private var store
    @AppStorage(ProgressOptions.range) private var rangeRaw = ProgressRange.week.rawValue
    @AppStorage(ProgressOptions.fullDay) private var fullDay = 100
    /// A day in the period on screen; nil is the current one, so the page always opens on it.
    @State private var anchor: LocalDay?
    @State private var model = ProgressModel.shared
    @State private var showKey = false
    @State private var editing: DaySection?
    @State private var heatVisit = HeatKeyVisit()

    private var range: ProgressRange { ProgressRange(rawValue: rangeRaw) ?? .week }

    var body: some View {
        let key = ProgressModel.Key(range: range, anchor: anchor, version: store.dataVersion, fullDay: fullDay,
                                    today: store.today())
        let habits = store.habits.filter { $0.kind != .task }
        Group {
            if habits.isEmpty {
                ContentUnavailableView {
                    Label("No Habits Yet", systemImage: "checklist")
                } description: {
                    Text("Habits you add show here, with how each one is going.")
                } actions: {
                    NewHabitButton(added: $added)
                }
            } else if !habits.contains(where: { !$0.archived }) {
                VStack(spacing: 0) {
                    ContentUnavailableView {
                        Label("No Habits Right Now", systemImage: "checklist")
                    } description: {
                        Text("Every habit is archived. Restore one, or add a new habit.")
                    } actions: {
                        NewHabitButton(added: $added)
                    }
                    archivedRow(count: habits.count).padding(16)
                }
            } else if let snapshot = model.snapshot {
                list(snapshot)
                    .toolbar { periodBar(snapshot) }
                    .overlay(alignment: .bottom) { backToNow }
            } else {
                Color(.systemGroupedBackground)
            }
        }
        .background(Color(.systemGroupedBackground))
        .environment(heatVisit)
        .onAppear { model.load(key, store: store) }
        .onChange(of: key) { model.load(key, store: store) }
        .sheet(item: $editing) { section in
            NavigationStack { SectionEditor(existing: section) { _ in } }
        }
        .sheet(isPresented: $showKey) { ProgressExplainer().analyticsScreen(nil) }
        .navigationDestination(for: HabitPageLink.self) { link in
            HabitPageView(id: link.id, overTime: OverTimeStart(range: OverTimeRange(rawValue: link.range.rawValue) ?? .month, anchor: link.anchor))
        }
    }

    // MARK: The cards

    /// One heading and its cards. `routine` is the routine Edit opens; nil for Anytime, Quitting and Paused.
    private struct Heading: Identifiable {
        let id: String
        let title: String
        var routine: DaySection?
        var cards: [ProgressWeekCard]
    }

    /// Routines with a set time by start, then Anytime, then Quitting, then Paused. A routine the person made shows with
    /// no habits ("No habits yet"); Anytime, built in, shows only with some.
    private func groups(_ snapshot: ProgressSnapshot) -> [Heading] {
        let today = store.today()
        let timed = store.timedSections.map(\.section)
        var byRoutine: [String: [ProgressWeekCard]] = [:]
        var quitting: [ProgressWeekCard] = [], paused: [ProgressWeekCard] = []
        for card in snapshot.cards {
            if store.isPaused(card.habit, on: today) { paused.append(card) }
            else if card.isQuit { quitting.append(card) }
            else { byRoutine[store.placements(of: card.habit).first?.section ?? .anytime, default: []].append(card) }
        }
        var result = timed.map { Heading(id: $0.id, title: $0.name, routine: $0, cards: byRoutine[$0.id] ?? []) }
        // A routine that was deleted leaves its habits in Anytime.
        let known = Set(timed.map(\.id))
        let anytime = byRoutine.filter { !known.contains($0.key) }.sorted { $0.key == .anytime && $1.key != .anytime }.flatMap(\.value)
        if !anytime.isEmpty { result.append(Heading(id: .anytime, title: store.section(.anytime).name, cards: anytime)) }
        if !quitting.isEmpty { result.append(Heading(id: "quitting", title: "Quitting", cards: quitting)) }
        if !paused.isEmpty { result.append(Heading(id: "paused", title: "Paused", cards: paused)) }
        return result
    }

    /// A lazy stack of cards in a scroll view, never a `List` (a list's self-sizing looped on Month, 30 Sep 2026).
    private func list(_ snapshot: ProgressSnapshot) -> some View {
        let arrived = added.flatMap { id in snapshot.cards.contains { $0.habit.id == id } ? id : nil }
        return ScrollViewReader { proxy in ScrollView {
            LazyVStack(alignment: .leading, spacing: 12) {
                ForEach(groups(snapshot)) { group in
                    heading(group)
                    if group.cards.isEmpty {
                        Text("No habits yet")
                            .font(.subheadline).foregroundStyle(.secondary)
                            .padding(.horizontal, 16)
                    }
                    ForEach(group.cards) { card in cardButton(card, snapshot) }
                }
                VStack(spacing: 12) {
                    let archived = store.habits.filter { $0.archived && $0.kind != .task }.count
                    if archived > 0 { archivedRow(count: archived) }
                    keyRow
                }
                .padding(.top, 8)
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
            // Figma's 80 at the end: room for Back to This Week, so it never covers the last row.
            .padding(.bottom, 80)
        }
        .onChange(of: arrived, initial: true) { _, id in
            guard let id else { return }
            withAnimation { proxy.scrollTo(id, anchor: .top) }
            added = nil
        } }
    }

    /// A routine's name, with Edit on its right (a Small Borderless button, as on Edit Today); Anytime, Quitting and
    /// Paused have no Edit.
    private func heading(_ group: Heading) -> some View {
        HStack {
            Text(group.title).font(.subheadline.weight(.semibold)).foregroundStyle(.primary)
                .accessibilityAddTraits(.isHeader)
            Spacer(minLength: 8)
            if let routine = group.routine {
                Button("Edit") { editing = routine }
                    .buttonStyle(.borderless)
                    .controlSize(.small)
                    .font(.subheadline)
                    .tint(.ink)
                    .accessibilityLabel("Edit \(routine.name)")
                    .accessibilityIdentifier("habits-edit-" + routine.name)
            }
        }
        .padding(.leading, 16)
        .padding(.trailing, 6)
        .padding(.top, 4)
        .frame(minHeight: 28)
    }

    private func cardButton(_ card: ProgressWeekCard, _ snapshot: ProgressSnapshot) -> some View {
        NavigationLink(value: HabitPageLink(id: card.habit.id, range: snapshot.range, anchor: snapshot.period.lowerBound)) {
            WeekCardView(card: card, columns: snapshot.columns,
                         month: snapshot.range == .month ? MonthLayout(lead: snapshot.monthLead, letters: snapshot.letters) : nil,
                         year: snapshot.year, moreRoom: HistoryCardMore.size)
        }
        .buttonStyle(.plain)
        // Over the header's end, outside the card's link, so it takes its own taps (Figma's More button).
        .overlay(alignment: .topTrailing) {
            HistoryCardMore(habit: card.habit)
                .padding(.top, WeekSpacing.card - (HistoryCardMore.size - 32) / 2)
                .padding(.trailing, WeekSpacing.card - 12)
        }
        .accessibilityIdentifier(card.isQuit ? "progress-quit-\(card.habit.name)" : "progress-row-\(card.habit.name)")
        .id(card.habit.id)
    }

    // MARK: The end of the list

    private func archivedRow(count: Int) -> some View {
        NavigationLink(value: ArchivedHabitsLink()) {
            EndRow(symbol: "archivebox.fill", title: "Archived", subtitle: count == 1 ? "1 habit" : "\(count) habits")
        }
        .buttonStyle(.plain)
        .accessibilityIdentifier("habits-archived")
    }

    private var keyRow: some View {
        Button { showKey = true } label: {
            EndRow(symbol: "questionmark.circle", title: "What the squares mean", subtitle: nil)
        }
        .buttonStyle(.plain)
        .accessibilityIdentifier("heat-key-toggle")
    }

    // MARK: The bottom bar

    /// Figma's Period bar: the view as a drop-down, then ‹ the period ›.
    @ToolbarContentBuilder private func periodBar(_ snapshot: ProgressSnapshot) -> some ToolbarContent {
        ToolbarItem(placement: .bottomBar) {
            Menu {
                Picker("View", selection: Binding(get: { range }, set: { rangeRaw = $0.rawValue; anchor = nil })) {
                    ForEach(ProgressRange.allCases) { Text($0.title).tag($0) }
                }
            } label: {
                HStack(spacing: 4) {
                    Text(range.title).fontWeight(.semibold)
                    Image(systemName: "chevron.up.chevron.down").font(.caption.weight(.semibold))
                }
                .padding(.horizontal, 8)
            }
            .accessibilityLabel("View, \(range.title)")
            .accessibilityIdentifier("progress-range")
        }
        if #available(iOS 26, *) { ToolbarSpacer(.flexible, placement: .bottomBar) }
        ToolbarItemGroup(placement: .bottomBar) {
            Button("Previous \(range.noun)", systemImage: "chevron.left") { move(snapshot, by: -1) }
                .disabled(!snapshot.canGoBack)
                .accessibilityIdentifier("progress-previous")
            Menu {
                ForEach(recent(snapshot), id: \.self) { day in
                    Button(store.periodTitle(range, store.period(range.kind, containing: day), today: store.today())) {
                        anchor = store.period(range.kind, containing: day).contains(store.today()) ? nil : day
                    }
                }
            } label: {
                HStack(spacing: 3) {
                    Text(snapshot.title).fontWeight(.semibold).monospacedDigit().lineLimit(1)
                    Image(systemName: "chevron.down").font(.caption.weight(.semibold))
                }
            }
            .accessibilityLabel(snapshot.title)
            .accessibilityHint("Goes to another \(range.noun)")
            .accessibilityIdentifier("progress-period")
            Button("Next \(range.noun)", systemImage: "chevron.right") { move(snapshot, by: 1) }
                .disabled(!snapshot.canGoForward)
                .accessibilityIdentifier("progress-next")
        }
    }

    /// The current period and the eleven before it, for the period's drop-down.
    private func recent(_ snapshot: ProgressSnapshot) -> [LocalDay] {
        var day = store.today()
        var days: [LocalDay] = []
        for _ in 0..<12 {
            days.append(day)
            day = store.period(range.kind, containing: day).lowerBound.adding(days: -1, calendar: store.calendar)
        }
        return days
    }

    /// Back to This Week (Month, Year): the plain glass button above the bar, on another period only.
    @ViewBuilder private var backToNow: some View {
        if anchor != nil {
            Button { anchor = nil } label: {
                Label("Back to This \(range.title)", systemImage: "arrow.uturn.backward")
                    .font(.body.weight(.medium))
                    .foregroundStyle(Color.ink)
                    .padding(.horizontal, 16)
                    .frame(height: 44)
                    .contentShape(Capsule())
                    .floatingGlass()
            }
            .buttonStyle(.plain)
            .padding(.bottom, 12)
            .accessibilityIdentifier("habits-back-to-now")
        }
    }

    private func move(_ snapshot: ProgressSnapshot, by step: Int) {
        let calendar = store.calendar
        let day = step < 0 ? snapshot.period.lowerBound.adding(days: -1, calendar: calendar)
            : snapshot.period.upperBound.adding(days: 1, calendar: calendar)
        anchor = store.period(range.kind, containing: day).contains(store.today()) ? nil : day
    }
}

/// Where Archived goes from Habits & Tasks.
struct ArchivedHabitsLink: Hashable {}

/// New Habit on an empty page: the one prominent action, opening Create New as + does on Today.
private struct NewHabitButton: View {
    @Binding var added: UUID?
    @State private var adding = false

    var body: some View {
        Button { adding = true } label: { Text("New Habit").foregroundStyle(Color.onInk) }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            .tint(.ink)
            .accessibilityIdentifier("habits-new")
            .sheet(isPresented: $adding) { NewItemView { added = $0 } }
    }
}

/// A row at the end of the list (Archived, What the squares mean): a card of its own, the symbol, the words and ›.
private struct EndRow: View {
    let symbol: String
    let title: String
    let subtitle: String?

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: symbol).font(.title3).foregroundStyle(.secondary).frame(width: 24)
            VStack(alignment: .leading, spacing: 0) {
                Text(title).foregroundStyle(.primary)
                if let subtitle { Text(subtitle).font(.subheadline).foregroundStyle(.secondary) }
            }
            Spacer(minLength: 8)
            Image(systemName: "chevron.right").font(.footnote.weight(.semibold)).foregroundStyle(.tertiary)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, subtitle == nil ? 14 : 15)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.card, in: RoundedRectangle(cornerRadius: 26, style: .continuous))
        .contentShape(RoundedRectangle(cornerRadius: 26, style: .continuous))
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isButton)
    }
}
