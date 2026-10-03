import SwiftUI

// The habit page's shared parts and its History tab (the user, 3 Oct 2026; checklist "Habit Details Page — Build").
// Spacing is `WeekSpacing`'s scale (2, 4, 8, 16, 24), the same as Progress, with space inside a group always smaller than
// the space around it. Every number comes from the store, worked out once per data change (`HabitPageModel`).

/// History · Notes · Progress: three jobs, one control (research IA).
enum HabitTab: String, CaseIterable, Identifiable, Hashable {
    case history, notes, progress
    var id: Self { self }
    var title: String {
        switch self {
        case .history: "History"
        case .notes: "Notes"
        case .progress: "Progress"
        }
    }

    /// A task has no Progress: its history and notes are all there is.
    static func tabs(for habit: Habit) -> [HabitTab] { habit.kind == .task ? [.history, .notes] : allCases }
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
    private(set) var record: HabitOverall?
    private(set) var tracks: [MilestoneTrack] = []
    private(set) var notes: [NoteMonth] = []
    @ObservationIgnored private var historyKey: Key?
    @ObservationIgnored private var recordKey: Key?
    @ObservationIgnored private var notesKey: Key?

    func load(_ key: Key, tab: HabitTab, store: HabitStore) {
        switch tab {
        case .history:
            guard key != historyKey else { return }
            historyKey = key
            history = perfTimed("Habit page: history") { store.history(of: key.habit, today: key.today) }
        case .progress:
            guard key != recordKey, key.habit.kind != .task else { return }
            recordKey = key
            let record = perfTimed("Habit page: overall record") { store.habitRecord(of: key.habit, today: key.today) }
            self.record = record
            tracks = perfTimed("Habit page: milestones") { store.milestoneTracks(of: key.habit, record: record, today: key.today) }
        case .notes:
            guard key != notesKey else { return }
            notesKey = key
            notes = NoteMonth.group(store.notes(of: key.habit), calendar: store.calendar)
        }
    }
}

/// One month of notes, newest first.
struct NoteMonth: Hashable, Identifiable {
    struct Note: Hashable, Identifiable {
        let day: LocalDay
        let text: String
        var id: LocalDay { day }
    }
    let first: LocalDay
    let title: String
    let notes: [Note]
    /// Never the same as a History month's id: both tabs share one lazy stack, and equal ids there showed History's
    /// card under Notes (3 Oct 2026; lesson L11).
    var id: String { "notes-" + first.key }

    static func group(_ notes: [(day: LocalDay, text: String)], calendar: Calendar) -> [NoteMonth] {
        let names = calendar.standaloneMonthSymbols
        var months: [NoteMonth] = []
        for note in notes {
            let first = LocalDay(year: note.day.year, month: note.day.month, day: 1)
            let item = Note(day: note.day, text: note.text)
            if let last = months.last, last.first == first {
                months[months.count - 1] = NoteMonth(first: first, title: last.title, notes: last.notes + [item])
            } else {
                months.append(NoteMonth(first: first, title: names[first.month - 1] + " \(first.year)", notes: [item]))
            }
        }
        return months
    }
}

extension View {
    /// A card on the habit page: 16-point padding, the app's card colour and corner (as Progress's cards).
    func pageCard(padding: CGFloat = WeekSpacing.card) -> some View {
        self.padding(padding)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.card, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
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
        VStack(alignment: .leading, spacing: WeekSpacing.label) {
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

/// History (research History, revised): Add Entry and Go to Date always in view, then one card per month, newest
/// first, each folding (the user, 3 Oct 2026). This month and last month start open; older months start folded.
struct HabitHistoryTab: View {
    let habit: Habit
    let months: [HistoryMonth]
    let open: (LocalDay) -> Void
    let addEntry: () -> Void
    let goToDate: () -> Void
    /// Months folded or opened by hand while the page is open (a month's default is open for the newest two).
    @State private var toggled: Set<LocalDay> = []

    var body: some View {
        HStack(spacing: WeekSpacing.tight) {
            Button(action: addEntry) {
                Label("Add Entry", systemImage: "plus")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .accessibilityIdentifier("history-add-entry")
            Button(action: goToDate) {
                Label("Go to Date", systemImage: "calendar")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .accessibilityIdentifier("history-go-to-date")
        }
        .controlSize(.large)
        .font(.body.weight(.semibold))
        .pageItem()
        // What the squares mean, folded or open, shared with Progress (the user, 3 Oct 2026).
        HeatKeySection()
            .pageItem()
        if months.isEmpty {
            Text("Nothing recorded yet. Days appear here once they're planned or logged.")
                .font(.subheadline).foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .pageCard()
                .pageItem()
        }
        ForEach(Array(months.enumerated()), id: \.element.id) { index, month in
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
                HStack(alignment: .center, spacing: WeekSpacing.tight) {
                    VStack(alignment: .leading, spacing: WeekSpacing.label) {
                        Text(month.title).font(.headline).foregroundStyle(.primary)
                        if !month.summary.isEmpty {
                            Text(month.summary).font(.subheadline).foregroundStyle(.secondary).monospacedDigit()
                        }
                    }
                    Spacer(minLength: WeekSpacing.tight)
                    // An accordion's chevron: down while folded, up while open (Design Rules).
                    Image(systemName: "chevron.down")
                        .font(.footnote.weight(.semibold)).foregroundStyle(.secondary)
                        .rotationEffect(.degrees(isOpen ? 180 : 0))
                }
                .padding(WeekSpacing.card)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .accessibilityElement(children: .combine)
            .accessibilityValue(isOpen ? "Open" : "Folded")
            .accessibilityHint(isOpen ? "Folds the month" : "Shows the month's days")
            .accessibilityIdentifier("history-month-\(month.first.key)")
            if isOpen {
                Divider().padding(.leading, WeekSpacing.card)
                ForEach(month.days) { day in
                    HistoryDayRow(day: day, color: color) { open(day.day) }
                    if day.id != month.days.last?.id {
                        Divider().padding(.leading, WeekSpacing.card + HeatSize.smallest + 12)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.card, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

/// One day: its square, the date (with Today or Yesterday), what was recorded, a note mark, and a chevron.
struct HistoryDayRow: View {
    let day: HistoryDay
    let color: HabitColor
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                HeatSquare(cell: day.heat, color: color, size: HeatSize.smallest, isToday: day.relative == "Today")
                    .equatable()
                VStack(alignment: .leading, spacing: WeekSpacing.label) {
                    HStack(spacing: 6) {
                        Text(day.title).font(.body.weight(.medium)).foregroundStyle(.primary)
                        if let relative = day.relative {
                            Text(relative).font(.subheadline).foregroundStyle(.secondary)
                        }
                    }
                    Text(day.detail).font(.subheadline).foregroundStyle(.secondary).monospacedDigit()
                        .lineLimit(2)
                }
                Spacer(minLength: WeekSpacing.tight)
                if day.hasNote {
                    Image(systemName: "note.text").font(.subheadline).foregroundStyle(.secondary)
                        .accessibilityLabel("Has a note")
                }
                Image(systemName: "chevron.right").font(.footnote.weight(.semibold)).foregroundStyle(.tertiary)
            }
            .padding(.horizontal, WeekSpacing.card)
            .padding(.vertical, 10)
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
