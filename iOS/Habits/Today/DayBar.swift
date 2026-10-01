import SwiftUI

/// The centre of the bottom bar: a progress ring, "Today ⌄" and "6/15". Tapping it opens the calendar.
struct DayLabel: View {
    let label: String
    let done: Int
    let total: Int

    var body: some View {
        HStack(spacing: 10) {
            MiniRing(progress: total == 0 ? 0 : Double(done) / Double(total)).frame(width: 20, height: 20)
            HStack(spacing: 5) {
                Text(label).font(.body.weight(.semibold))
                Image(systemName: "chevron.down").font(.footnote.weight(.bold))
            }
            Text("\(done)/\(total)").font(.subheadline.weight(.semibold).monospacedDigit()).foregroundStyle(.secondary)
                .frame(minWidth: 40, alignment: .leading)
        }
        .foregroundStyle(Color.ink)
        .lineLimit(1)
        .minimumScaleFactor(0.8)
        // A fixed width, so ‹ and › and the label never move as the day changes.
        .frame(width: 196)
    }
}

/// One cell of a month grid: the weekday letters, the blanks around the month, and its days, in one lazy grid.
/// One identity space for all of them: with plain numbers, weekday 1 and day 1 were the same cell to the grid, which
/// kept one, so days 1–6 never drew (seen 1 Oct 2026 on the habit page; the same in Today's calendar's first row).
enum MonthGridCell: Hashable {
    case weekday(Int), blank(Int), day(Int)

    static func month(leading: Int, days: Int, trailing: Int = 0) -> [MonthGridCell] {
        var cells: [MonthGridCell] = (0..<7).map(weekday)
        cells += (0..<leading).map(blank)
        cells += (1...max(days, 1)).map(day)
        cells += (0..<max(trailing, 0)).map { blank(leading + $0) }
        return cells
    }
}

/// A native SwiftUI month grid with the same completion totals as the bottom bar.
struct CalendarSheet: View {
    let selected: LocalDay
    let today: LocalDay
    let onPick: (LocalDay?) -> Void
    @State private var month: LocalDay
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss

    init(day: LocalDay, today: LocalDay, onPick: @escaping (LocalDay?) -> Void) {
        selected = day
        self.today = today
        self.onPick = onPick
        _month = State(initialValue: LocalDay(year: day.year, month: day.month, day: 1))
    }

    private var calendar: Calendar { store.calendar }
    private var monthDate: Date { month.date(calendar: calendar) }
    private var leading: Int { (calendar.component(.weekday, from: monthDate) - calendar.firstWeekday + 7) % 7 }
    private var days: Int { calendar.range(of: .day, in: .month, for: monthDate)?.count ?? 0 }
    private var cells: Int { ((leading + days + 6) / 7) * 7 }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    HStack(spacing: 4) {
                        Button("Previous month", systemImage: "chevron.left") { moveMonth(-1) }
                            .labelStyle(.iconOnly).frame(width: 44, height: 44)
                        Text(monthDate.formatted(.dateTime.month(.wide).year()))
                            .font(.title3.weight(.semibold)).lineLimit(1).minimumScaleFactor(0.8)
                            .frame(maxWidth: .infinity)
                            .accessibilityIdentifier("calendar-month")
                        Button("Next month", systemImage: "chevron.right") { moveMonth(1) }
                            .labelStyle(.iconOnly).frame(width: 44, height: 44)
                    }
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 7), spacing: 8) {
                        ForEach(MonthGridCell.month(leading: leading, days: days, trailing: cells - leading - days), id: \.self) { cell in
                            switch cell {
                            case .weekday(let offset):
                                Text(calendar.veryShortStandaloneWeekdaySymbols[(calendar.firstWeekday - 1 + offset) % 7])
                                    .font(.caption.weight(.semibold)).foregroundStyle(.secondary)
                                    .frame(maxWidth: .infinity).accessibilityHidden(true)
                            case .blank: Color.clear.frame(height: 44).accessibilityHidden(true)
                            case .day(let number): dayButton(LocalDay(year: month.year, month: month.month, day: number))
                            }
                        }
                    }
                    Text("Tap any day to open it. Past days can be logged, with no limit on how far back. Later days open as a preview.")
                        .font(.footnote).foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 4)
                }.padding(.horizontal, 16).padding(.bottom, 20)
            }
            .background(Color(.systemBackground))
            // Back to Today: only here, at the bottom, and only while another day is open (the user, 29 Sep).
            // Its space is always kept, so nothing shifts when it appears.
            .safeAreaInset(edge: .bottom) {
                // Only while another day is open; the empty space of its height stays, so nothing shifts
                // (and VoiceOver never finds an invisible button).
                ZStack {
                    Color.clear.frame(height: 44)
                    if selected != today {
                        BackToTodayButton(id: "calendar-back-to-today", primary: false) { pick(today) }
                    }
                }
                .padding(.bottom, 8)
            }
            .onPerfCommand { action in
                if action == .previousMonth { moveMonth(-1) } else if action == .nextMonth { moveMonth(1) }
            }
            .navigationTitle("Go to a day")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) { Button("Done") { dismiss() } }
            }
        }
    }

    private func dayButton(_ day: LocalDay) -> some View {
        let score = store.todayScore(on: day)
        let summary = (done: score.done, total: score.planned)
        let future = day > today
        // Part credit fills the ring part of the way (a 6 of 8 glasses day), as on Progress (report §16.4).
        let progress = score.fraction
        return Button { pick(day) } label: {
            DayRing(fraction: progress, planned: summary.total > 0, isFuture: future, label: String(day.day),
                    bold: day == today || day == selected, selected: day == selected,
                    full: summary.total > 0 && summary.done == summary.total)
            // A dot under days with a note, so notes can be found again (users show: Habit Hub's shading).
            .overlay(alignment: .bottom) {
                if store.hasNotes(on: day) {
                    Circle().fill(Color.secondary).frame(width: 4, height: 4).offset(y: 6)
                        .accessibilityHidden(true)
                }
            }
            .frame(maxWidth: .infinity, minHeight: 44)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(day.date(calendar: calendar).formatted(date: .complete, time: .omitted))
        .accessibilityValue((day == today ? "Today. " : "") + (summary.total == 0 ? "No habits scheduled" : future ? "Preview, \(summary.total) habits scheduled" : "\(summary.done) of \(summary.total) done"))
        .accessibilityAddTraits(day == selected ? [.isSelected] : [])
        .accessibilityIdentifier("calendar-day-\(day.year)-\(day.month)-\(day.day)")
    }

    private func moveMonth(_ amount: Int) {
        guard let date = calendar.date(byAdding: .month, value: amount, to: monthDate) else { return }
        month = LocalDay(date, calendar: calendar)
    }

    private func pick(_ day: LocalDay) {
        onPick(day == today ? nil : day)
        dismiss()
    }
}

/// "Back to Today": primary (filled) above the day bar on Today, secondary (bordered) in the calendar sheet
/// (the user, 29 Sep). Shown only while another day is open; where it sits, its space is always kept.
struct BackToTodayButton: View {
    var id = "back-to-today"
    var primary = true
    let action: () -> Void

    var body: some View {
        if primary {
            Button(action: action) {
                Label("Back to Today", systemImage: "arrow.uturn.backward")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(Color.onInk)
                    .padding(.horizontal, 18)
                    .frame(height: 44)
                    .background(Capsule().fill(Color.ink).shadow(color: .black.opacity(0.15), radius: 6, y: 2))
            }
            .buttonStyle(.plain)
            .accessibilityIdentifier(id)
        } else {
            Button(action: action) {
                Label("Back to Today", systemImage: "arrow.uturn.backward")
                    .font(.subheadline.weight(.semibold))
                    .padding(.horizontal, 6)
                    .frame(minHeight: 36)
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .tint(Color.ink)
            .accessibilityIdentifier(id)
        }
    }
}
