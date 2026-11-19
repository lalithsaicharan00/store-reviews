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
    let goToDate: () -> Void
    let searchNotes: () -> Void
    @Environment(HabitStore.self) private var store
    /// Months folded or opened by hand while the page is open (a month's default is open for the newest two).
    @State private var toggled: Set<LocalDay> = []
    @State private var withNotes = false

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
                Button(action: goToDate) {
                    Label("Go to Date…", systemImage: "calendar")
                }
                .buttonStyle(.bordered)
                .tint(Color.ink)
                .foregroundStyle(Color.primary)
                .accessibilityIdentifier("history-go-to-date")
                Spacer(minLength: 0)
            }
            .controlSize(.small)
            .buttonBorderShape(.capsule)
            .font(.subheadline)
            .pageItem()
            let shown = withNotes ? noteMonths : months
            ForEach(Array(shown.enumerated()), id: \.element.id) { index, month in
                let isOpen = (index < 2) != toggled.contains(month.first)
                HistoryMonthCard(month: month, color: habit.color, isOpen: isOpen, open: open) {
                    withAnimation(.snappy(duration: 0.25)) {
                        if toggled.contains(month.first) { toggled.remove(month.first) } else { toggled.insert(month.first) }
                    }
                }
                .pageItem()
            }
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

/// History's Add (Figma): Ink, floating at the bottom right over the page, as the app's main action there. It opens
/// the same Add screen as everywhere (U22), on today, where the date can be changed to any day.
struct HistoryAddButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Label("Add", systemImage: "plus").foregroundStyle(Color.onInk)
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .controlSize(.large)
        .tint(Color.ink)
        .fontWeight(.semibold)
        .accessibilityIdentifier("history-add-entry")
    }
}

/// One month: its name and how it went on the goal's own clock, then a row per day, folding from the header.
struct HistoryMonthCard: View {
    let month: HistoryMonth
    let color: HabitColor
    let isOpen: Bool
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
                    HistoryDayRow(day: day, color: color) { open(day.day) }
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
    let action: () -> Void

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
            .contentShape(Rectangle())
        }
        .buttonStyle(PageRowStyle())
        .accessibilityElement(children: .combine)
        .accessibilityHint("Opens the day")
        .accessibilityIdentifier("habit-day-\(day.day.key)")
    }
}

/// Go to Date (research History D): any day from the habit's start to today, logged or not. Tapping a day opens it.
struct GoToDateSheet: View {
    let habit: Habit
    let pick: (LocalDay) -> Void
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var date = Date.now

    var body: some View {
        let calendar = store.calendar
        let end = store.today().date(calendar: calendar)
        let first = (habit.kind == .quit ? store.quitStartDay(of: habit) : store.startDay(of: habit)).date(calendar: calendar)
        NavigationStack {
            VStack(spacing: 0) {
                DatePicker("Date", selection: $date, in: min(first, end)...max(first, end), displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .padding(.horizontal, WeekSpacing.card)
                    .accessibilityIdentifier("go-to-date-picker")
                Spacer(minLength: 0)
            }
            .onChange(of: date) { pick(LocalDay(date, calendar: calendar)) }
            .navigationTitle("Go to Date")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) { Button("Cancel") { dismiss() } }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Open") { pick(LocalDay(date, calendar: calendar)) }.fontWeight(.semibold)
                }
            }
        }
        .presentationDetents([.large])
    }
}
