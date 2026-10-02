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

/// What each mark means, for the marks this week shows (the user: "maintain what each status means").
struct WeekLegend: View {
    let kinds: [WeekLegendKind]
    /// Quit habits' filled mark is a clean day; others' is done.
    let hasQuit: Bool
    let hasOthers: Bool

    var body: some View {
        FlowLayout(spacing: WeekSpacing.card, lineSpacing: WeekSpacing.tight) {
            ForEach(kinds) { kind in
                HStack(spacing: 6) {
                    WeekLegendMark(kind: kind).frame(width: 16, height: 16)
                    Text(words(kind)).font(.footnote).foregroundStyle(.secondary)
                }
                .accessibilityElement(children: .combine)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Key")
        .accessibilityIdentifier("progress-legend")
    }

    private func words(_ kind: WeekLegendKind) -> String {
        switch kind {
        case .done: hasQuit && !hasOthers ? "Clean day" : hasQuit ? "Done or clean" : "Done"
        case .part: "Part done"
        case .notDone: "Not done"
        case .open: "Still open today"
        case .over: "Over the limit"
        case .slip: "Slip"
        case .skipped: "Skipped"
        case .paused: "Paused"
        case .notDue: "Not due"
        case .comingUp: "Coming up"
        }
    }
}

/// A legend's mark: the same drawing as the strip's, smaller and in a neutral colour.
private struct WeekLegendMark: View {
    let kind: WeekLegendKind

    var body: some View {
        let day: (HabitStore.DayMark, Double, Bool, Bool) = switch kind {
        case .done: (.done, 1, false, false)
        case .part: (.some, 0.5, false, false)
        case .notDone: (.missed, 0, false, false)
        case .open: (.open, 0, false, false)
        case .over: (.missed, 0, true, false)
        case .slip: (.missed, 0, false, true)
        case .skipped: (.skipped, 0, false, false)
        case .paused: (.paused, 0, false, false)
        case .notDue: (.notItsDay, 0, false, false)
        case .comingUp: (.upcoming, 0, false, false)
        }
        WeekMark(mark: day.0, fraction: day.1, over: day.2, slip: day.3, color: .gray, size: 16)
    }
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

/// One day's mark. Every state differs by shape, not only colour (report §4.4): a filled circle with a check, a part
/// ring, an empty ring, a dashed ring, a sign on a grey disc, a small dot, a faint ring, or nothing. Never red.
struct WeekMark: View {
    let mark: HabitStore.DayMark
    var fraction: Double = 0
    var over = false
    var slip = false
    let color: HabitColor
    var size: CGFloat = 28

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
                    Circle().fill(tint)
                    Image(systemName: "checkmark").font(.system(size: size * 0.44, weight: .bold))
                        .foregroundStyle(color.checkInk)
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
                    Circle().fill(Color.secondary.opacity(0.5)).frame(width: max(4, size / 7), height: max(4, size / 7))
                case .upcoming:
                    Circle().strokeBorder(tint.opacity(0.4), lineWidth: line)
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
    /// The check on a filled mark: white where white stands out from the colour (3:1 or more, WCAG 1.4.11);
    /// on the light colours (yellow, orange, green, mint, teal, cyan), where white falls to 1.6–2.6:1, a deep shade of
    /// the same colour instead, never black (the user, 2 Oct 2026: black checks look poor). The deep shades reach about
    /// 4:1 or more against their fill.
    var checkInk: Color {
        switch self {
        case .red, .pink, .purple, .indigo, .blue, .brown, .gray: .white
        case .orange, .yellow, .green, .mint, .teal, .cyan: color.mix(with: .black, by: 0.62)
        }
    }
}

/// Lays its children out in rows, wrapping to the next line when a row is full: the legend's items.
struct FlowLayout: Layout {
    var spacing: CGFloat = 8
    var lineSpacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let width = proposal.width ?? .infinity
        var x: CGFloat = 0, y: CGFloat = 0, line: CGFloat = 0, widest: CGFloat = 0
        for view in subviews {
            let size = view.sizeThatFits(.unspecified)
            if x > 0 && x + size.width > width { y += line + lineSpacing; x = 0; line = 0 }
            x += size.width + spacing
            line = max(line, size.height)
            widest = max(widest, x - spacing)
        }
        return CGSize(width: min(widest, width), height: y + line)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var x = bounds.minX, y = bounds.minY, line: CGFloat = 0
        for view in subviews {
            let size = view.sizeThatFits(.unspecified)
            if x > bounds.minX && x + size.width > bounds.maxX { y += line + lineSpacing; x = bounds.minX; line = 0 }
            view.place(at: CGPoint(x: x, y: y), proposal: ProposedViewSize(size))
            x += size.width + spacing
            line = max(line, size.height)
        }
    }
}
