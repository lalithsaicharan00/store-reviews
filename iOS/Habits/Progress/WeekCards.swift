import SwiftUI

// The Week view's pieces (report "Weekly Habit Cards — What Each Card Shows"; the user, 2 Oct 2026). Every number
// comes from the snapshot; nothing here walks history or builds a formatter (PERFORMANCE.md rules 5 and 8).
//
// Spacing, on an 8-point grid, with space inside a group always smaller than the space around it (proximity):
//   2   name ↔ goal (one label)              4   headline ↔ detail, mark ↔ its value
//   8   tabs ↔ dates, weekday ↔ mark          16  card padding, gap between cards, header ↔ numbers, numbers ↔ strip
//   24  the controls above ↔ the first card
enum WeekSpacing {
    static let label: CGFloat = 2
    static let pair: CGFloat = 4
    static let tight: CGFloat = 8
    static let card: CGFloat = 16
    static let section: CGFloat = 24
}

/// The dates of the week (or the month), with ‹ and ›. The one part of the page that stays at the top while the cards scroll: the
/// dates say which week every card shows, and ‹ › are how weeks are compared (report §3). Week, Month, Year and the
/// group chips scroll away, so the bar is one 44-point row (NN/g: keep a sticky header small).
struct WeekPeriodBar: View {
    let title: String
    let caption: String?
    var noun = "week"
    let canGoBack: Bool
    let canGoForward: Bool
    let move: (Int) -> Void

    var body: some View {
        HStack(spacing: 0) {
            Button("Previous \(noun)", systemImage: "chevron.left") { move(-1) }
                .labelStyle(.iconOnly)
                .frame(width: 44, height: 44)
                .disabled(!canGoBack)
                .accessibilityIdentifier("progress-previous")
            Spacer(minLength: WeekSpacing.tight)
            VStack(spacing: 0) {
                Text(title).font(.headline).monospacedDigit().lineLimit(1).minimumScaleFactor(0.8)
                    .accessibilityIdentifier("progress-period")
                if let caption {
                    Text(caption).font(.caption).foregroundStyle(.secondary)
                        .accessibilityIdentifier("progress-period-caption")
                }
            }
            Spacer(minLength: WeekSpacing.tight)
            Button("Next \(noun)", systemImage: "chevron.right") { move(1) }
                .labelStyle(.iconOnly)
                .frame(width: 44, height: 44)
                .disabled(!canGoForward)
                .accessibilityIdentifier("progress-next")
        }
        .buttonStyle(.borderless)
        .font(.body.weight(.semibold))
        .padding(.horizontal, WeekSpacing.tight)
        .padding(.vertical, WeekSpacing.pair)
        .frame(maxWidth: .infinity)
        // Opaque, the page's own colour: cards slide under it cleanly.
        .background(Color(.systemGroupedBackground))
    }
}

/// Figma's Habit history card (978:1598), one per habit or task on Week, Month and Year: the header (a 32 icon, the
/// name in Headline on one line, the goal under it, and room on the right for the card's More button, which the page
/// lays over it), then the summary (Title 3 Semibold) with one more fact (Subheadline), then the days as Day cells.
/// 16 inside and between, corners 26. The whole card opens Habit details.
struct WeekCardView: View {
    let card: ProgressWeekCard
    let columns: [WeekColumn]
    /// Month: the grid's layout; nil on Week.
    var month: MonthLayout? = nil
    /// Year: the heat map's layout; nil on Week and Month.
    var year: YearLayout? = nil
    /// Room for the More button laid over the header's end.
    var moreRoom: CGFloat = 0
    @Environment(\.dynamicTypeSize) private var typeSize

    var body: some View {
        VStack(alignment: .leading, spacing: WeekSpacing.card) {
            HStack(alignment: .center, spacing: 12) {
                HabitIcon(symbol: card.habit.symbol, color: card.habit.color, size: 32)
                VStack(alignment: .leading, spacing: 0) {
                    // One line: a long name ends in "…" (the user, 2 Oct 2026).
                    Text(card.habit.name).font(.headline).foregroundStyle(.primary)
                        .lineLimit(1).truncationMode(.tail)
                    Text(card.goal).font(.subheadline).foregroundStyle(.secondary).lineLimit(1)
                }
                Spacer(minLength: moreRoom)
            }
            VStack(alignment: .leading, spacing: WeekSpacing.label) {
                if let start = card.runStart {
                    QuitRunClock(start: start)
                } else {
                    Text(card.headline).font(.title3.weight(.semibold)).monospacedDigit()
                        .foregroundStyle(card.isQuit ? Color(.systemGray) : Color.primary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                if let detail = card.detail {
                    Text(detail).font(.subheadline).foregroundStyle(.secondary).monospacedDigit()
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            // From the accessibility sizes up, the days give way to the words, which carry the meaning (report §9).
            if let year, !typeSize.isAccessibilitySize, card.days.count >= year.shown {
                HeatYear(layout: year, cells: card.days.prefix(year.shown).map(\.heat), color: card.habit.color)
            } else if !typeSize.isAccessibilitySize && columns.count == card.days.count {
                if let month {
                    MonthCardGrid(layout: month, columns: columns, days: card.days, color: card.habit.color)
                } else {
                    WeekCardStrip(columns: columns, days: card.days, color: card.habit.color)
                }
            }
        }
        .padding(WeekSpacing.card)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.card, in: CardShape.shape)
        .contentShape(CardShape.shape)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(card.accessibility)
        .accessibilityHint("Opens the habit")
        .accessibilityAddTraits(.isButton)
    }
}

/// How a month sits in its grid: the empty places before the 1st, and the weekday letters in the person's order.
struct MonthLayout: Hashable {
    let lead: Int
    let letters: [String]
}

/// A month on a card (the user, 2 Oct 2026: for seeing patterns; Figma's Month): the weekday letters, then the
/// month's weeks as Day cells of 36, edge to edge, 6 between rows; days outside the month are empty. No dates inside
/// (the user, 3 Oct 2026): the sign says what happened; the habit's page has the dated calendar. One `Canvas`.
struct MonthCardGrid: View {
    let layout: MonthLayout
    let columns: [WeekColumn]
    let days: [WeekCardDay]
    let color: HabitColor

    var body: some View {
        let todayIndex = columns.firstIndex { $0.isToday }
        let todayColumn = todayIndex.map { (layout.lead + $0) % 7 }
        VStack(spacing: WeekSpacing.tight) {
            HeatColumns(count: 7) { i in
                DayName(text: i < layout.letters.count ? layout.letters[i] : "", isToday: i == todayColumn)
            }
            HeatMonth(lead: layout.lead, cells: days.map(\.heat), todayIndex: todayIndex, color: color)
                .equatable()
        }
        .accessibilityHidden(true)
    }
}

/// Sun–Sat (in the person's order), Figma's Week: the weekday names, then seven Day cells of 36, edge to edge. The day's
/// own amount is in the card's words and the habit's page, not on the cell (the user, 3 Oct 2026).
struct WeekCardStrip: View {
    let columns: [WeekColumn]
    let days: [WeekCardDay]
    let color: HabitColor

    var body: some View {
        VStack(spacing: WeekSpacing.tight) {
            HeatColumns(count: columns.count) { i in
                DayName(text: columns[i].short, isToday: columns[i].isToday)
            }
            HeatRow(cells: days.map(\.heat), todayIndex: columns.firstIndex { $0.isToday }, color: color)
                .equatable()
        }
        .accessibilityHidden(true)
    }
}

/// A weekday over its cells: Footnote in Secondary Label; today's Caption 1 Semibold in Label (Figma's day names).
private struct DayName: View {
    let text: String
    let isToday: Bool

    var body: some View {
        Text(text)
            .font(isToday ? .caption.weight(.semibold) : .footnote)
            .foregroundStyle(isToday ? Color.primary : Color.secondary)
            .lineLimit(1).minimumScaleFactor(0.8)
            .fixedSize(horizontal: true, vertical: false)
            .frame(height: 16)
    }
}

// Marks and icons are drawn in the habit's iOS colour (`HabitColor.color`), as in Figma (the user, 17 Nov 2026). The
// darker set at one lightness (`HabitColor.mark`, OKLCH 0.64, 2 Oct 2026) was retired.

/// The history card's More button (Figma: Edit habit, Pause…, Archive, Delete). Its sheets and its question belong to
/// it, so the page around it keeps no state for them (S6); one sheet for all of them (S10). Delete asks with Cancel and
/// Delete only, and says that archiving keeps the history (D9).
struct HistoryCardMore: View {
    let habit: Habit
    @Environment(HabitStore.self) private var store
    @State private var sheet: Sheet?
    @State private var deleting = false

    /// The button's square: a 44-point target round the symbol.
    static let size: CGFloat = 44

    enum Sheet: String, Identifiable { case edit, pause; var id: String { rawValue } }

    var body: some View {
        let noun = habit.kind == .task ? "Task" : "Habit"
        Menu {
            Button("Edit \(noun)", systemImage: "pencil") { sheet = .edit }
            if !habit.archived && store.canPause(habit) {
                Button("Pause…", systemImage: "pause.circle") { sheet = .pause }
            }
            if !habit.archived {
                Button("Archive", systemImage: "archivebox") { store.archive([habit]) }
            }
            Button("Delete", systemImage: "trash", role: .destructive) { deleting = true }
        } label: {
            // iOS's More button (Figma's More button): ellipsis.circle.fill, hierarchical, Title 2, in Ink.
            Image(systemName: "ellipsis.circle.fill")
                .font(.title2)
                .symbolRenderingMode(.hierarchical)
                .foregroundStyle(Color.ink)
                .frame(width: Self.size, height: Self.size)
                .contentShape(Rectangle())
        }
        .accessibilityLabel("More")
        .accessibilityIdentifier("progress-more-\(habit.name)")
        .sheet(item: $sheet) { sheet in
            switch sheet {
            case .edit: EditHabitSheet(habit: habit)
            case .pause: PauseSheet(habit: habit)
            }
        }
        .alert("Delete \(habit.name)?", isPresented: $deleting) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) { store.delete([habit]) }
        } message: {
            Text("Its history and notes are deleted too, and this can't be undone. Archiving stops it and keeps its history.")
        }
    }
}
