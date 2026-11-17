import SwiftUI

/// Figma's Streaks page (1034:74), from the Overall record's See All Streaks: the habit (its 28 icon, its name, "Since
/// 2 Sep 2026"), then one card with "3 runs" and each run of 3 days (or weeks …) or more, longest first, as a Run row,
/// then a footnote. The same page as Android's `StreaksPage`. Worked out once per data change (S5), never in `body`.
struct StreaksPage: View {
    let habit: Habit
    @Environment(HabitStore.self) private var store
    @State private var list: StreakList?
    @State private var loaded: Int?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: WeekSpacing.card) {
                HStack(spacing: 12) {
                    HabitIcon(symbol: habit.symbol, color: habit.color, size: 28)
                    Text(habit.name).font(.body).lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    if let list { Text(list.since).font(.subheadline).foregroundStyle(.secondary).lineLimit(1) }
                }
                .padding(.horizontal, 4)
                .accessibilityElement(children: .combine)
                if let list {
                    VStack(alignment: .leading, spacing: WeekSpacing.card) {
                        Text(list.rows.isEmpty ? "None yet" : list.count).font(.body)
                            .accessibilityAddTraits(.isHeader)
                        ForEach(list.rows) { row in
                            RunRow(row: row, color: habit.color)
                        }
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.card, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
                    Text(list.note).font(.footnote).foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding(.horizontal, WeekSpacing.card)
            .padding(.top, WeekSpacing.tight)
            .padding(.bottom, 40)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(list?.title ?? "Streaks")
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("streaks-page")
        .onAppear(perform: load)
        .onChange(of: store.dataVersion) { load() }
    }

    private func load() {
        guard loaded != store.dataVersion else { return }
        loaded = store.dataVersion
        list = store.streakList(habit)
    }
}

/// One run on the Streaks page (Figma's Run row): its length (Body) and dates (Subheadline, Secondary Label) on one
/// baseline, then an 8-point bar on Tertiary System Fill. The longest run fills the track and a shorter one its share;
/// the run going on now is in the habit's colour, an earlier one in its Fill.
private struct RunRow: View {
    let row: StreakRow
    let color: HabitColor

    var body: some View {
        VStack(alignment: .leading, spacing: WeekSpacing.tight) {
            HStack(alignment: .firstTextBaseline, spacing: 12) {
                Text(row.length).font(.body).monospacedDigit()
                Spacer(minLength: 0)
                Text(row.dates).font(.subheadline).foregroundStyle(.secondary).monospacedDigit()
                    .multilineTextAlignment(.trailing)
            }
            ZStack(alignment: .leading) {
                Capsule().fill(Color(.tertiarySystemFill))
                Capsule().fill(row.isCurrent ? color.color : color.fill)
                    .scaleEffect(x: max(0.02, min(1, row.fraction)), y: 1, anchor: .leading)
            }
            .frame(height: 8)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(row.spoken)
        .accessibilityIdentifier(row.isCurrent ? "run-current" : "run")
    }
}

/// The Streaks page's words, worked out in the store.
struct StreakList {
    /// "Streaks", or "Runs" for a limit.
    let title: String
    /// "Since 2 Sep 2026".
    let since: String
    /// "3 runs".
    let count: String
    let rows: [StreakRow]
    let note: String
}

struct StreakRow: Identifiable {
    let id: Int
    /// "23 days".
    let length: String
    /// "30 Sep – today · now".
    let dates: String
    /// The run's length against the longest: its share of the track.
    let fraction: Double
    let isCurrent: Bool
    let spoken: String
}

extension HabitStore {
    /// Every run of 3 or more in today's goal's unit, longest first (newest first among equals), with its dates: the
    /// same list as Android's `streakList`. Skipped and paused days don't end a run (`runs`).
    func streakList(_ habit: Habit) -> StreakList {
        let today = today()
        let rule = rule(habit, on: today)
        let unit = rule.frequency.streakUnit
        let runs = runs(of: habit, today: today).filter { $0.length >= 3 }
            .sorted { ($0.length, $0.start) > ($1.length, $1.start) }
        let longest = Double(runs.first?.length ?? 1)
        let rows = runs.enumerated().map { index, run in
            let words = HabitCopy.number(Double(run.length)) + " " + unit.word(run.length)
            let end = run.isCurrent ? today : run.end
            let dates = run.isCurrent
                ? (run.start == today ? "Today" : daySpan(run.start...run.start, today: today) + " – today") + " · now"
                : daySpan(run.start...end, today: today)
            return StreakRow(id: index, length: words, dates: dates, fraction: Double(run.length) / longest, isCurrent: run.isCurrent,
                             spoken: words + ", " + spokenSpan(run.start...end, today: today) + (run.isCurrent ? ", going on now" : ""))
        }
        let since = "Since " + startDay(of: habit).date(calendar: calendar).formatted(.dateTime.day().month(.abbreviated).year())
        return StreakList(title: rule.atMost ? "Runs" : "Streaks", since: since,
                          count: rows.count == 1 ? "1 run" : "\(rows.count) runs", rows: rows,
                          note: "Runs of 3 \(unit.word(3)) or more, longest first. Skipped and paused days don’t end a run.")
    }
}
