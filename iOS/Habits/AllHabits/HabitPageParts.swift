import SwiftUI

// The habit page's shared parts and its History tab (the user, 3 Oct 2026; checklist "Habit Details Page — Build").
// Spacing is `WeekSpacing`'s scale (2, 4, 8, 16, 24), the same as Progress, with space inside a group always smaller than
// the space around it. Every number comes from the store, worked out once per data change (`HabitPageModel`).

/// History · Notes · Progress: three jobs, one control (research IA).
enum HabitTab: String, CaseIterable, Identifiable, Hashable {
    case progress, history
    var id: Self { self }
    var title: String {
        switch self {
        case .progress: "Progress"
        case .history: "History"
        }
    }

    /// Progress | History (Figma's Habit details page 1020:4052): Progress first, the tab the page opens on. A task
    /// has no Progress: its history is all there is.
    static func tabs(for habit: Habit) -> [HabitTab] { habit.kind == .task ? [.history] : allCases }
}

/// What the page shows, worked out when its data changes and kept while the page is open, so switching tabs never
/// works it out again (Rulebook S5). Each part is worked out the first time its tab is shown.
@Observable final class HabitPageModel {
    struct Key: Hashable {
        let habit: Habit
        let version: Int
        let today: LocalDay
    }

    private(set) var history: [HistoryMonth] = []
    /// History with only the days that have a note, for With Notes: "2 days with a note" under each month.
    private(set) var noteHistory: [HistoryMonth] = []
    private(set) var record: HabitOverall?
    private(set) var milestones = HabitMilestones.none
    /// Nothing logged yet (Figma's New habit, 1031:2743): Progress says so and keeps only this week and the key.
    /// A quit habit's progress is its clean run, so it's never "new".
    private(set) var isNew = false
    /// Nothing for History to list yet (Figma's History · empty, 1031:3300): no log, note, skip or pause on any day.
    /// A quit habit's clean days are its history, so it always has rows.
    private(set) var historyIsEmpty = false
    @ObservationIgnored private var historyKey: Key?
    @ObservationIgnored private var recordKey: Key?

    func load(_ key: Key, tab: HabitTab, store: HabitStore) {
        switch tab {
        case .history:
            guard key != historyKey else { return }
            historyKey = key
            history = perfTimed("Habit page: history") { store.history(of: key.habit, today: key.today) }
            noteHistory = history.compactMap { month in
                let days = month.days.filter { $0.note != nil }
                guard !days.isEmpty else { return nil }
                return HistoryMonth(first: month.first, title: month.title,
                                    summary: days.count == 1 ? "1 day with a note" : "\(days.count) days with a note", days: days)
            }
            historyIsEmpty = key.habit.kind != .quit && noteHistory.isEmpty && store.entries(of: key.habit.id).isEmpty
                && !history.contains { $0.days.contains { $0.heat == .off(.skipped) || $0.heat == .off(.paused) } }
        case .progress:
            guard key != recordKey, key.habit.kind != .task else { return }
            recordKey = key
            let record = perfTimed("Habit page: overall record") { store.habitRecord(of: key.habit, today: key.today) }
            self.record = record
            isNew = key.habit.kind != .quit && store.entries(of: key.habit.id).isEmpty
            milestones = perfTimed("Habit page: milestones") { store.habitMilestones(of: key.habit, record: record, today: key.today) }
        }
    }
}

extension View {
    /// A card on the habit page: 16-point padding, the app's card colour and corner (as Progress's cards). `vertical`
    /// sets the top and bottom apart from the sides (Year in Pixels: narrower sides, the same top and bottom).
    func pageCard(padding: CGFloat = WeekSpacing.card, vertical: CGFloat? = nil) -> some View {
        self.padding(.horizontal, padding)
            .padding(.vertical, vertical ?? padding)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.card, in: CardShape.shape)
    }

    /// One item of the page's lazy stack: the page's side margins and the gap under it.
    func pageItem() -> some View {
        padding(.horizontal, WeekSpacing.card)
            .padding(.bottom, WeekSpacing.card)
    }
}

/// A card's title and its scope under it ("Week" / "28 Sep – 4 Oct").
struct CardTitle: View {
    let title: String
    var subtitle: String? = nil

    var body: some View {
        // Figma's Period header: Headline over Subheadline, nothing between.
        VStack(alignment: .leading, spacing: 0) {
            Text(title).font(.headline).foregroundStyle(.primary)
            if let subtitle {
                Text(subtitle).font(.subheadline).foregroundStyle(.secondary)
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isHeader)
    }
}

/// A row that highlights while pressed, as a list row does.
struct PageRowStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? Color(.systemFill) : Color.clear)
    }
}

// MARK: - History

/// History (Figma 1046:7304): Search notes, With Notes and Go to Date…, then one card per month, newest first, each
/// folding (the user, 3 Oct 2026; this month and last month start open). A day's note shows under it, so the notes
/// have no tab of their own; With Notes keeps only the days that have one. Add floats over the page (`HistoryAddButton`).
/// Nothing yet: "Nothing Here Yet", and no search or filters, which would have nothing to work on.
struct HabitHistoryTab: View {
    let habit: Habit
    let months: [HistoryMonth]
    /// The same months with only the days that have a note (`HabitPageModel`), for With Notes.
    let noteMonths: [HistoryMonth]
    let open: (LocalDay) -> Void
    /// Scrolls the page to a month's card (nil: the newest, always on the page), then to a day's row in the middle
    /// (`HistoryDayRow.scrollID`).
    let scrollTo: (_ month: String?, _ day: String) -> Void
    let searchNotes: () -> Void
    /// Archived: a card saying so, with Restore, above everything else (Figma's History · archived).
    var restore: (() -> Void)? = nil
    @Environment(HabitStore.self) private var store
    /// Months folded or opened by hand while the page is open (a month's default is open for the newest two).
    @State private var toggled: Set<LocalDay> = []
    @State private var withNotes = false
    @State private var choosingDay = false
    /// The day Go to Date… found, lit in the habit's Fill for a moment so the eye finds it.
    @State private var lit: LocalDay?

    var body: some View {
        if months.isEmpty {
            ContentUnavailableView {
                Label("Nothing Here Yet", systemImage: "clock.arrow.circlepath")
            } description: {
                Text("Each day you log or write a note shows here, newest first. Add opens any day.")
            }
            .frame(minHeight: 420)
            .accessibilityIdentifier("history-empty")
        } else {
            let hasNotes = !noteMonths.isEmpty
            if let restore { archived(restore).pageItem() }
            if hasNotes {
                NotesSearchField(action: searchNotes)
                    .pageItem()
            }
            HStack(spacing: 8) {
                // A filter is one button that toggles: Bordered off, Prominent on (Figma's section 07).
                if hasNotes {
                    Button { withAnimation(.snappy(duration: 0.25)) { withNotes.toggle() } } label: {
                        Text("With Notes").foregroundStyle(withNotes ? Color.onInk : Color.primary)
                    }
                    .buttonStyle(FilterStyle(on: withNotes))
                    .accessibilityAddTraits(withNotes ? .isSelected : [])
                    .accessibilityIdentifier("history-with-notes")
                }
                Button { choosingDay = true } label: {
                    Label("Go to Date…", systemImage: "calendar")
                }
                .buttonStyle(.bordered)
                .tint(Color.ink)
                .foregroundStyle(Color.primary)
                .accessibilityIdentifier("history-go-to-date")
                .dayCalendar(isPresented: $choosingDay, habit: habit, pick: show)
                Spacer(minLength: 0)
            }
            .controlSize(.small)
            .buttonBorderShape(.capsule)
            .font(.subheadline)
            .pageItem()
            let shown = withNotes ? noteMonths : months
            ForEach(Array(shown.enumerated()), id: \.element.id) { index, month in
                let isOpen = (index < 2) != toggled.contains(month.first)
                HistoryMonthCard(month: month, color: habit.color, isOpen: isOpen, lit: lit, open: open) {
                    withAnimation(.snappy(duration: 0.25)) {
                        if toggled.contains(month.first) { toggled.remove(month.first) } else { toggled.insert(month.first) }
                    }
                }
                .pageItem()
            }
        }
    }

    /// "Archived today" or "Archived on 3 Sep": what's kept, and Restore (Figma 1150:329659). Nothing can be logged
    /// while it's archived, so the page has no Add, but every day still opens to read.
    private func archived(_ restore: @escaping () -> Void) -> some View {
        let day = store.archivedOn[habit.id]
        let when = day.map { $0 == store.today() ? "Archived today" : "Archived on \(DayWords.dayMonth($0, calendar: store.calendar))" }
        return CardNotice(symbol: "archivebox", title: when ?? "Archived", message: "Everything it recorded is kept. Restore it to log again.",
                          problem: false, id: "history-archived") {
            Button("Restore", action: restore)
                .controlSize(.small)
                .accessibilityIdentifier("history-restore")
        }
        .padding(WeekSpacing.card)
        .background(Color.card, in: CardShape.shape)
    }

    /// Go to Date… (Figma's flow 202): the day's month opens if it was folded, and With Notes goes off if the day has no
    /// note (Go to Date isn't a filter, but the day must be on the page); then the page scrolls the day to the middle
    /// and lights it for a moment, then the light fades. Nothing else changes.
    private func show(_ day: LocalDay) {
        guard let month = months.first(where: { $0.days.contains { $0.day == day } }) else { return }
        var still = Transaction()
        still.disablesAnimations = true
        withTransaction(still) {
            if withNotes, !noteMonths.contains(where: { $0.days.contains { $0.day == day } }) { withNotes = false }
            let shown = withNotes ? noteMonths : months
            if let index = shown.firstIndex(where: { $0.first == month.first }), (index < 2) == toggled.contains(month.first) {
                toggled.formSymmetricDifference([month.first])
            }
        }
        Task { @MainActor in
            await Task.yield()
            scrollTo(month.first == months.first?.first ? nil : month.id, HistoryDayRow.scrollID(day))
            try? await Task.sleep(for: .milliseconds(350))
            withAnimation(.easeIn(duration: 0.2)) { lit = day }
            try? await Task.sleep(for: .milliseconds(1200))
            withAnimation(.easeOut(duration: 0.6)) { if lit == day { lit = nil } }
        }
    }

    /// Bordered off, Prominent on, both in Ink (the app's filter, as Habits' With notes was drawn in Figma).
    private struct FilterStyle: PrimitiveButtonStyle {
        let on: Bool
        func makeBody(configuration: Configuration) -> some View {
            if on {
                Button(role: configuration.role, action: configuration.trigger) { configuration.label }
                    .buttonStyle(.borderedProminent).tint(Color.ink)
            } else {
                Button(role: configuration.role, action: configuration.trigger) { configuration.label }
                    .buttonStyle(.bordered).tint(Color.ink)
            }
        }
    }
}

/// History's Search notes (Figma's Search field): a glass capsule that opens the notes search, where iOS's own field
/// takes over with the keyboard up (`NotesSearchPage`).
struct NotesSearchField: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 9) {
                Image(systemName: "magnifyingglass").foregroundStyle(.primary)
                Text("Search notes").foregroundStyle(.secondary)
                Spacer(minLength: 0)
            }
            .font(.body)
            .padding(.horizontal, 13)
            .frame(height: 44)
            .contentShape(Capsule())
        }
        .buttonStyle(.plain)
        .floatingGlass()
        .accessibilityLabel("Search notes")
        .accessibilityIdentifier("history-search-notes")
    }
}

/// History's Add (Figma's flow 203): Ink, floating at the bottom right over the page. It asks which day first, in the
/// calendar, and opens that day's Day details, where +1, Log and Add a Note all are, so one Add covers logs and notes.
struct HistoryAddButton: View {
    let habit: Habit
    let open: (LocalDay) -> Void
    @State private var choosing = false

    var body: some View {
        Button { choosing = true } label: {
            Label("Add", systemImage: "plus").foregroundStyle(Color.onInk)
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .controlSize(.large)
        .tint(Color.ink)
        .fontWeight(.semibold)
        .accessibilityIdentifier("history-add-entry")
        .dayCalendar(isPresented: $choosing, habit: habit, pick: open)
    }
}

/// One month: its name and how it went on the goal's own clock, then a row per day, folding from the header.
struct HistoryMonthCard: View {
    let month: HistoryMonth
    let color: HabitColor
    let isOpen: Bool
    /// Go to Date's day, lit for a moment.
    var lit: LocalDay? = nil
    let open: (LocalDay) -> Void
    let toggle: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: toggle) {
                HStack(alignment: .center, spacing: 16) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(month.title).font(.body).foregroundStyle(.primary)
                        if !month.summary.isEmpty {
                            Text(month.summary).font(.subheadline).foregroundStyle(.secondary).monospacedDigit()
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    // A disclosure's chevron, as iOS's own: right while folded, down while open (Figma's month header).
                    Image(systemName: "chevron.right")
                        .font(.footnote.weight(.semibold)).foregroundStyle(.tertiary)
                        .rotationEffect(.degrees(isOpen ? 90 : 0))
                }
                .padding(.horizontal, WeekSpacing.card)
                .padding(.vertical, 15)
                .frame(minHeight: 72)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .accessibilityElement(children: .combine)
            .accessibilityValue(isOpen ? "Open" : "Folded")
            .accessibilityHint(isOpen ? "Folds the month" : "Shows the month's days")
            .accessibilityIdentifier("history-month-\(month.first.key)")
            if isOpen {
                Divider().padding(.horizontal, WeekSpacing.card)
                ForEach(month.days) { day in
                    HistoryDayRow(day: day, color: color, lit: lit == day.day) { open(day.day) }
                        .id(HistoryDayRow.scrollID(day.day))
                    if day.id != month.days.last?.id {
                        // From the row's text to 16 before the edge.
                        Divider().padding(.leading, WeekSpacing.card + 36 + 16).padding(.trailing, WeekSpacing.card)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.card, in: CardShape.shape)
        .clipShape(CardShape.shape)
    }
}

/// One day (Figma's Day row): its square, the date, what was recorded (with Today or Yesterday first), the day's note
/// under it in two lines at most, and a chevron. The row opens the day.
struct HistoryDayRow: View {
    let day: HistoryDay
    let color: HabitColor
    var lit = false
    let action: () -> Void

    /// The row's place on the page, for Go to Date's scroll.
    static func scrollID(_ day: LocalDay) -> String { "history-day-" + day.key }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                HeatSquare(cell: day.heat, color: color, size: HeatSize.smallest, isToday: day.relative == "Today")
                    .equatable()
                    .frame(width: 36, height: 36)
                VStack(alignment: .leading, spacing: 0) {
                    Text(day.title).font(.body).foregroundStyle(.primary)
                    Text(day.line).font(.subheadline).foregroundStyle(.secondary).monospacedDigit()
                        .lineLimit(2)
                    if let note = day.note {
                        HStack(alignment: .firstTextBaseline, spacing: 8) {
                            Image(systemName: "note.text").foregroundStyle(.secondary)
                            Text(note).foregroundStyle(.primary).lineLimit(2)
                        }
                        .font(.subheadline)
                        .padding(.top, 4)
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel("Note: " + note)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Image(systemName: "chevron.right").font(.footnote.weight(.semibold)).foregroundStyle(.tertiary)
            }
            .padding(.horizontal, WeekSpacing.card)
            .padding(.vertical, 15)
            .frame(minHeight: 72)
            .background(lit ? color.fill : Color.clear)
            .contentShape(Rectangle())
        }
        .buttonStyle(PageRowStyle())
        .accessibilityElement(children: .combine)
        .accessibilityHint("Opens the day")
        .accessibilityIdentifier("habit-day-\(day.day.key)")
    }
}
