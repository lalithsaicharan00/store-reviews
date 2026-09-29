import AudioToolbox
import SwiftUI

// MARK: - Colours

extension Color {
    /// Charcoal in light mode, off-white in dark mode: the app's only system colour.
    static let ink = Color(UIColor { $0.userInterfaceStyle == .dark
        ? UIColor(red: 0.925, green: 0.925, blue: 0.935, alpha: 1)
        : UIColor(red: 0.153, green: 0.153, blue: 0.165, alpha: 1) })
    /// Text and icons on an ink fill.
    static let onInk = Color(UIColor { $0.userInterfaceStyle == .dark
        ? UIColor(red: 0.11, green: 0.11, blue: 0.12, alpha: 1)
        : .white })
    static let card = Color(.secondarySystemGroupedBackground)
}

extension HabitColor {
    var color: Color {
        switch self {
        case .red: .red
        case .orange: .orange
        case .yellow: .yellow
        case .green: .green
        case .mint: .mint
        case .teal: .teal
        case .cyan: .cyan
        case .blue: .blue
        case .indigo: .indigo
        case .purple: .purple
        case .pink: .pink
        case .brown: .brown
        case .gray: .gray
        }
    }

    var name: String { rawValue.capitalized }
}

// MARK: - Habit icon

/// The habit's symbol, white on a rounded tile in the habit's colour.
struct HabitIcon: View {
    let symbol: String
    let color: HabitColor
    var size: CGFloat = 32

    var body: some View {
        Image(systemName: symbol)
            .font(.system(size: size * 0.48, weight: .semibold))
            .foregroundStyle(.white)
            .frame(width: size, height: size)
            .background(RoundedRectangle(cornerRadius: size * 0.28, style: .continuous).fill(color.color.gradient))
            .accessibilityHidden(true)
    }
}

// MARK: - Row pieces

/// "🔥 6", "🔥 6×", "🔥 3 wk": the unit says what is counted. Tapping it says so in words.
struct StreakLabel: View {
    let count: Int
    var unit: StreakUnit = .days
    /// A faint halo keeps the number readable when the row's fill reaches under it.
    var onFill = false
    @State private var explaining = false

    var body: some View {
        Button { explaining = true } label: {
            HStack(spacing: 2) {
                Text("🔥").font(.caption)
                Text(unit.short(count)).font(.subheadline.weight(.semibold).monospacedDigit())
            }
            .lineLimit(1)
            .fixedSize()
            .foregroundStyle(.primary)
            .shadow(color: onFill ? Color.card.opacity(0.9) : .clear, radius: 2.5)
            .frame(minHeight: 44)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .popover(isPresented: $explaining) {
            Text(unit.explained(count))
                .font(.subheadline)
                .padding(.horizontal, 14).padding(.vertical, 10)
                .presentationCompactAdaptation(.popover)
        }
        .accessibilityLabel("Streak: \(unit.explained(count))")
    }
}

/// The one round button every row ends with. Solid in the habit's colour once done.
struct RoundActionButton: View {
    let symbol: String
    let done: Bool
    let color: HabitColor
    let label: String
    var keepSymbolWhenDone = false
    /// Text instead of the symbol, e.g. "+1", so the button says what one tap adds.
    var text: String? = nil
    let action: () -> Void
    @Environment(\.checkFeedback) private var feedback
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    /// Taps on this button, and when the last one was: feedback answers a tap, never a row that shows another day.
    @State private var taps = 0
    @State private var lastTap = Date.distantPast
    @State private var completions = 0

    private var justTapped: Bool { Date.now.timeIntervalSince(lastTap) < 1.5 }

    var body: some View {
        Button {
            lastTap = .now
            taps += 1
            action()
        } label: {
            Group {
                if let text {
                    Text(text).font(.system(size: 13, weight: .bold).monospacedDigit()).lineLimit(1).minimumScaleFactor(0.7)
                } else {
                    Image(systemName: done && !keepSymbolWhenDone ? "checkmark" : symbol)
                        .font(.system(size: 14, weight: .bold))
                        // One small bounce when it's done; nothing with Reduce Motion (C149). No confetti: users find it
                        // patronising and slow (Check-off Feedback report).
                        .symbolEffect(.bounce, value: reduceMotion ? 0 : completions)
                }
            }
                .foregroundStyle(done ? Color.white : Color.ink)
                .frame(width: 34, height: 34)
                .background(Circle().fill(done ? AnyShapeStyle(color.color) : AnyShapeStyle(Color(.tertiarySystemFill))))
                .frame(width: 44, height: 44)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(label)
        // A light click for every + (each tap logs), a firmer one when the habit is done; both off with Haptics off.
        .sensoryFeedback(.impact(weight: .light), trigger: taps) { _, _ in feedback.haptics && keepSymbolWhenDone }
        .sensoryFeedback(.success, trigger: done) { old, new in feedback.haptics && !old && new && justTapped }
        .onChange(of: done) { old, new in
            guard new, !old, justTapped else { return }
            completions += 1
            // A system sound: quiet, follows the ring/silent switch and doesn't stop the person's music.
            if feedback.sounds { AudioServicesPlaySystemSound(1057) }
        }
    }
}

/// Haptics and sound after a tap that logs, from Settings (Check-off Feedback report). Set at the app's root.
struct CheckFeedback: Equatable {
    var haptics = true
    var sounds = false
}

extension EnvironmentValues {
    @Entry var checkFeedback = CheckFeedback()
}

/// A row background that fills from the left with the habit's colour as progress grows.
struct ProgressFill: View {
    let progress: Double
    let color: HabitColor
    @Environment(\.colorScheme) private var scheme

    var body: some View {
        GeometryReader { g in
            ZStack(alignment: .leading) {
                Color.card
                color.color.opacity(scheme == .dark ? 0.26 : 0.15)
                    .frame(width: g.size.width * min(1, max(0, progress)))
            }
        }
    }
}

struct NowChip: View {
    var body: some View {
        Text("Now")
            .font(.caption.weight(.semibold))
            .foregroundStyle(Color.ink)
            .padding(.horizontal, 8).padding(.vertical, 3)
            .background(Capsule().fill(Color.ink.opacity(0.10)))
    }
}

/// A small progress ring in ink.
struct MiniRing: View {
    let progress: Double

    var body: some View {
        ZStack {
            if progress >= 1 {
                // A full ring reads as an empty "O"; a filled check reads as done.
                Image(systemName: "checkmark.circle.fill").resizable().scaledToFit().foregroundStyle(Color.ink)
            } else {
                Circle().stroke(Color(.systemFill), lineWidth: 3)
                Circle().trim(from: 0, to: min(1, progress))
                    .stroke(Color.ink, style: StrokeStyle(lineWidth: 3, lineCap: .round))
                    .rotationEffect(.degrees(-90))
            }
        }
        .accessibilityHidden(true)
    }
}

// MARK: - Formatting

enum Format {
    /// Numbers as entered: whole stays whole ("8"), decimals up to two places ("0.25", "2.5"),
    /// and from 1,000 the k suffix with at most one decimal ("1k", "5.2k", "12.5k").
    static func amount(_ v: Double) -> String {
        if abs(v) >= 1000 {
            let k = (v / 100).rounded() / 10
            return trimmed(k, places: 1) + "k"
        }
        return trimmed(v, places: 2)
    }

    /// Minutes as hours and minutes: "45 min", "1 h", "1 h 25 min". Never decimals or "k".
    static func minutes(_ v: Double) -> String {
        let total = Int(v.rounded())
        let h = total / 60, m = total % 60
        if h == 0 { return "\(m) min" }
        return m == 0 ? "\(h) h" : "\(h) h \(m) min"
    }

    /// A running timer's clock, counting up: "0:07", "7:42", "1:07:42". Minutes in, whole seconds out.
    static func clock(_ minutes: Double) -> String {
        let total = max(0, Int((minutes * 60).rounded(.down)))
        let h = total / 3600, m = total / 60 % 60, s = total % 60
        return h > 0 ? String(format: "%d:%02d:%02d", h, m, s) : String(format: "%d:%02d", m, s)
    }

    private static func trimmed(_ v: Double, places: Int) -> String {
        let f = NumberFormatter()
        f.minimumFractionDigits = 0
        f.maximumFractionDigits = places
        f.usesGroupingSeparator = false
        f.locale = .current
        return f.string(from: NSNumber(value: v)) ?? String(v)
    }

    /// "12d 11:23:07"
    static func elapsed(_ t: TimeInterval) -> String {
        let s = Int(t)
        return String(format: "%dd %02d:%02d:%02d", s / 86400, s % 86400 / 3600, s % 3600 / 60, s % 60)
    }

    static func days(_ t: TimeInterval) -> String {
        let d = Int(t / 86400)
        return d == 1 ? "1 day" : "\(d) days"
    }
}

// MARK: - Text fields and rows

extension View {
    /// Number fields select what's in them when tapped, so typing replaces "1" or "20" instead of
    /// inserting next to it ("31"), as in Settings and Health.
    func selectsNumbersOnFocus() -> some View {
        onReceive(NotificationCenter.default.publisher(for: UITextField.textDidBeginEditingNotification)) { note in
            guard let field = note.object as? UITextField, [.numberPad, .decimalPad].contains(field.keyboardType) else { return }
            DispatchQueue.main.async { field.selectAll(nil) }
        }
    }

    /// Stops typing or pasting past `limit` characters. Once full, more typing is ignored (nothing
    /// already written is lost); a long paste keeps its first `limit` characters.
    func limitText(_ text: Binding<String>, to limit: Int) -> some View {
        onChange(of: text.wrappedValue) { old, new in
            guard new.count > limit else { return }
            text.wrappedValue = old.count == limit ? old : String(new.prefix(limit))
        }
    }
}

/// A form row with a label and a value: the label always stays on one line, and the value
/// shortens with "…" rather than crowding it.
struct ValueRow<Value: View>: View {
    let title: String
    @ViewBuilder let value: Value

    var body: some View {
        HStack(spacing: 0) {
            Text(title).foregroundStyle(Color.primary).lineLimit(1).fixedSize()
            Spacer(minLength: 16)
            value.lineLimit(1).truncationMode(.tail)
        }
    }
}
