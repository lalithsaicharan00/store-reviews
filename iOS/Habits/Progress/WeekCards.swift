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
    /// A day's mark on a card's strip.
    static let mark: CGFloat = 28
}

/// The dates of the week, with ‹ and ›. The one part of the page that stays at the top while the cards scroll: the
/// dates say which week every card shows, and ‹ › are how weeks are compared (report §3). Week, Month, Year and the
/// group chips scroll away, so the bar is one 44-point row (NN/g: keep a sticky header small).
struct WeekPeriodBar: View {
    let title: String
    let caption: String?
    let canGoBack: Bool
    let canGoForward: Bool
    let move: (Int) -> Void

    var body: some View {
        HStack(spacing: 0) {
            Button("Previous week", systemImage: "chevron.left") { move(-1) }
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
            Button("Next week", systemImage: "chevron.right") { move(1) }
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

/// What each mark means (the user, 2 Oct 2026: there when wanted, not shown until asked). One quiet row under the group
/// chips, "What the marks mean ⌄"; tapping it opens every mark with its name and one plain sentence, and "Show less"
/// folds it again (progressive disclosure: the page stays clean, the meaning is one tap away and never hidden in a
/// menu). Every state is listed, not only this week's, so a mark that appears next week is already explained.
struct WeekKey: View {
    @State private var open = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        VStack(alignment: .leading, spacing: WeekSpacing.tight) {
            Button {
                if reduceMotion { open.toggle() } else { withAnimation(.easeInOut(duration: 0.2)) { open.toggle() } }
            } label: {
                HStack(spacing: WeekSpacing.tight) {
                    Image(systemName: "info.circle")
                    Text("What the marks mean")
                    Spacer(minLength: WeekSpacing.tight)
                    Text(open ? "Show less" : "Show")
                    Image(systemName: "chevron.down").font(.footnote.weight(.semibold))
                        .rotationEffect(.degrees(open ? 180 : 0))
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .frame(minHeight: 44)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .accessibilityLabel("What the marks mean")
            .accessibilityValue(open ? "Shown" : "Hidden")
            .accessibilityHint(open ? "Hides the key" : "Shows what each mark on the cards means")
            .accessibilityIdentifier("progress-key")
            if open {
                VStack(alignment: .leading, spacing: WeekSpacing.card) {
                    ForEach(WeekKeyEntry.habits) { KeyRow(entry: $0) }
                    Text("Quit habits").font(.footnote.weight(.semibold)).foregroundStyle(.secondary)
                        .padding(.top, WeekSpacing.pair)
                        .accessibilityAddTraits(.isHeader)
                    ForEach(WeekKeyEntry.quit) { KeyRow(entry: $0) }
                }
                .padding(WeekSpacing.card)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.card, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                .transition(.opacity)
                .accessibilityIdentifier("progress-key-list")
            }
        }
    }
}

/// One row of the key: the mark as the cards draw it, its name, and what it means.
private struct KeyRow: View {
    let entry: WeekKeyEntry

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            WeekMark(mark: entry.mark, fraction: entry.fraction, over: entry.over, slip: entry.slip, color: .gray, size: 22)
                .frame(width: 28, height: 22)
            VStack(alignment: .leading, spacing: WeekSpacing.label) {
                Text(entry.name).font(.subheadline.weight(.semibold))
                Text(entry.meaning).font(.footnote).foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .accessibilityElement(children: .combine)
    }
}

/// The key's entries, in the order people meet them. Words chosen to say what happened, never judge it: no "missed",
/// "failed" or "relapse" (Design Rules), and no two names that could mean the same day.
struct WeekKeyEntry: Identifiable {
    let name: String
    let meaning: String
    var mark: HabitStore.DayMark
    var fraction: Double = 0
    var over = false
    var slip = false
    var id: String { name }

    static let habits: [WeekKeyEntry] = [
        WeekKeyEntry(name: "Done", meaning: "The day's goal was reached.", mark: .done),
        WeekKeyEntry(name: "Partial", meaning: "Some of the day's goal was done. The ring fills to show how much.",
                     mark: .some, fraction: 0.6),
        WeekKeyEntry(name: "Not done", meaning: "A day it was due has ended without the goal reached.", mark: .missed),
        WeekKeyEntry(name: "Today, still open", meaning: "Today isn't over yet, so it doesn't count either way.", mark: .open),
        WeekKeyEntry(name: "Due later this week", meaning: "A day still to come when it's due.", mark: .upcoming),
        WeekKeyEntry(name: "Not scheduled", meaning: "Not one of its days, or nothing logged that day toward a weekly or monthly goal. Never counts against it.",
                     mark: .notItsDay),
        WeekKeyEntry(name: "Skipped", meaning: "You skipped it that day. Doesn't count either way.", mark: .skipped),
        WeekKeyEntry(name: "Paused", meaning: "The habit was paused. Doesn't count either way.", mark: .paused),
        WeekKeyEntry(name: "Over the limit", meaning: "A finished day that went above a “no more than” limit.", mark: .missed, over: true),
        WeekKeyEntry(name: "Before it started", meaning: "A blank space: days before the habit began.", mark: .before),
    ]
    static let quit: [WeekKeyEntry] = [
        WeekKeyEntry(name: "Clean day", meaning: "No slip was logged that day.", mark: .done),
        WeekKeyEntry(name: "Slip", meaning: "A slip was logged that day. A number under it shows when there was more than one.",
                     mark: .missed, slip: true),
    ]
}

/// One habit's card: icon, name on one line, the goal; the headline and at most one more fact; the week's strip.
struct WeekCardView: View {
    let card: ProgressWeekCard
    let columns: [WeekColumn]
    @Environment(\.dynamicTypeSize) private var typeSize

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 12) {
                HabitIcon(symbol: card.habit.symbol, color: card.habit.color, size: 40)
                VStack(alignment: .leading, spacing: WeekSpacing.label) {
                    // One line: a long name ends in "…" (the user, 2 Oct 2026).
                    Text(card.habit.name).font(.headline).foregroundStyle(.primary)
                        .lineLimit(1).truncationMode(.tail)
                    Text(card.goal).font(.subheadline).foregroundStyle(.secondary).lineLimit(1)
                }
                Spacer(minLength: WeekSpacing.tight)
                Image(systemName: "chevron.right").font(.footnote.weight(.semibold)).foregroundStyle(.tertiary)
                    .accessibilityHidden(true)
            }
            VStack(alignment: .leading, spacing: WeekSpacing.pair) {
                if let start = card.runStart {
                    QuitRunClock(start: start)
                } else {
                    Text(card.headline).font(.title3.weight(.semibold)).monospacedDigit()
                        .fixedSize(horizontal: false, vertical: true)
                }
                if let detail = card.detail {
                    Text(detail).font(.subheadline).foregroundStyle(.secondary).monospacedDigit()
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding(.top, WeekSpacing.card)
            // From the accessibility sizes up, the strip gives way to the words, which carry the meaning (report §9).
            if !typeSize.isAccessibilitySize && columns.count == card.days.count {
                WeekCardStrip(columns: columns, days: card.days, color: card.habit.color)
                    .padding(.top, WeekSpacing.card)
            }
        }
        .padding(WeekSpacing.card)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.card, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
        .contentShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(card.accessibility)
        .accessibilityHint("Opens the habit")
        .accessibilityAddTraits(.isButton)
    }
}

/// Sun–Sat (in the person's order): the weekday, the day's mark, and the day's own number under it when there is one.
struct WeekCardStrip: View {
    let columns: [WeekColumn]
    let days: [WeekCardDay]
    let color: HabitColor

    var body: some View {
        let values = days.contains { !$0.value.isEmpty }
        HStack(alignment: .top, spacing: 0) {
            ForEach(Array(days.enumerated()), id: \.element.id) { index, day in
                let column = columns[index]
                VStack(spacing: 0) {
                    Text(column.short)
                        .font(.caption.weight(column.isToday ? .semibold : .regular))
                        .foregroundStyle(column.isToday ? Color.primary : Color.secondary)
                        .underline(column.isToday)
                        .lineLimit(1).minimumScaleFactor(0.8)
                    WeekMark(mark: day.mark, fraction: day.fraction, over: day.over, slip: day.slip, color: color,
                             size: WeekSpacing.mark)
                        .padding(.top, WeekSpacing.tight)
                    if values {
                        Text(day.value.isEmpty ? " " : day.value)
                            .font(.caption2.weight(.medium)).monospacedDigit().foregroundStyle(.secondary)
                            .lineLimit(1).minimumScaleFactor(0.75)
                            .padding(.top, WeekSpacing.pair)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .accessibilityHidden(true)
    }
}

/// One day's mark. Every state differs by shape, not only colour (report §4.4): a filled circle with a white check, a
/// part ring, an empty ring, a dashed ring, a ring with ▲ or ×, a sign on a grey disc, a small ring (later this week),
/// a short dash (not scheduled), or nothing (before it started). Never red. `WeekKey` explains each one.
struct WeekMark: View {
    let mark: HabitStore.DayMark
    var fraction: Double = 0
    var over = false
    var slip = false
    let color: HabitColor
    var size: CGFloat = 28
    @Environment(\.colorScheme) private var scheme

    var body: some View {
        let tint = color.color
        let line = max(1.5, size / 14)
        ZStack {
            if slip {
                Circle().strokeBorder(Color.secondary, lineWidth: line)
                Image(systemName: "xmark").font(.system(size: size * 0.36, weight: .bold)).foregroundStyle(.secondary)
            } else {
                switch mark {
                case .done:
                    // One check everywhere: white, on the habit's colour deepened just enough for it (`markFill`).
                    Circle().fill(color.markFill(dark: scheme == .dark))
                    Image(systemName: "checkmark").font(.system(size: size * 0.44, weight: .bold))
                        .foregroundStyle(.white)
                case .some:
                    Circle().stroke(tint.opacity(0.25), lineWidth: line * 1.5).padding(line * 0.75)
                    Circle().trim(from: 0, to: max(0.08, min(1, fraction)))
                        .stroke(tint, style: StrokeStyle(lineWidth: line * 1.5, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                        .padding(line * 0.75)
                case .missed:
                    Circle().strokeBorder(Color.secondary.opacity(0.6), lineWidth: line)
                    if over {
                        Image(systemName: "arrowtriangle.up.fill").font(.system(size: size * 0.32))
                            .foregroundStyle(.secondary)
                    }
                case .open:
                    Circle().strokeBorder(Color.secondary, style: StrokeStyle(lineWidth: line, dash: [size / 9, size / 9]))
                case .skipped:
                    Circle().fill(Color(.tertiarySystemFill))
                    Image(systemName: "forward.fill").font(.system(size: size * 0.32)).foregroundStyle(.secondary)
                case .paused:
                    Circle().fill(Color(.tertiarySystemFill))
                    Image(systemName: "pause.fill").font(.system(size: size * 0.32)).foregroundStyle(.secondary)
                case .notItsDay:
                    // A short dash: "nothing asked of this day", unlike any ring, which is a day that counts.
                    Capsule().fill(Color.secondary.opacity(0.55)).frame(width: max(6, size * 0.3), height: max(1.5, size / 14))
                case .upcoming:
                    // Smaller than a day's ring, so a day still to come never looks like a day that ended undone.
                    Circle().strokeBorder(tint.opacity(0.6), lineWidth: line).frame(width: size * 0.45, height: size * 0.45)
                case .before:
                    Color.clear
                }
            }
        }
        .frame(width: size, height: size)
        .accessibilityHidden(true)
    }
}

extension HabitColor {
    /// The fill under a check: the habit's colour, deepened only as far as a white check needs to stand out from it
    /// (3:1, WCAG 1.4.11). The check is white on every colour (the user, 2 Oct 2026: one check colour everywhere,
    /// never black). Red, pink, purple, indigo, blue, brown and gray already reach 3:1 and stay as they are; the light
    /// colours are deepened by the least that reaches it, measured on the system colours in light and dark mode
    /// (orange 15/18 %, yellow 30/32 %, green 15/19 %, mint 17/30 %, teal 8/19 %, cyan 9/25 %, plus 2 points).
    func markFill(dark: Bool) -> Color {
        let deepen: Double = switch self {
        case .red, .pink, .purple, .indigo, .blue, .brown, .gray: 0
        case .orange: dark ? 0.20 : 0.17
        case .yellow: dark ? 0.34 : 0.32
        case .green: dark ? 0.21 : 0.17
        case .mint: dark ? 0.32 : 0.19
        case .teal: dark ? 0.21 : 0.10
        case .cyan: dark ? 0.27 : 0.11
        }
        return deepen == 0 ? color : color.mix(with: .black, by: deepen, in: .device)
    }
}
