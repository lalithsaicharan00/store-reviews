import SwiftUI

// MARK: - Colours
//
// The colour system (Ink, On Ink, a habit's colour and shades) is in Shared/Palette.swift.

extension Color {
    /// A card or row on a grouped page: `iOS/Grouped Background/Secondary System Grouped Background`.
    static let card = Color(.secondarySystemGroupedBackground)
}

/// A card's corner (Figma's cards, sections 10 and 11: radius 26, 16 inside), the one value every card on Progress and
/// a habit's page uses.
enum CardShape {
    static let radius: CGFloat = 26
    static var shape: RoundedRectangle { RoundedRectangle(cornerRadius: radius, style: .continuous) }
}

extension HabitColor {
    var name: String { rawValue.capitalized }
}

// MARK: - Habit icon

/// The habit's symbol, white on a circle in the habit's colour: Figma's Habit icon (32 on a row, 28 folded), the symbol
/// SF Pro Regular at 0.48 of the circle. The habit's iOS colour, solid (`iOS/Standard/System <Hue>`; 17 Nov 2026).
struct HabitIcon: View {
    let symbol: String
    let color: HabitColor
    var size: CGFloat = 32
    /// A ring in the card's colour, so overlapping icons stay apart (Figma's folded header: 2 pt).
    var ring: CGFloat = 0

    var body: some View {
        Image(systemName: symbol)
            .font(.system(size: size * 0.48, weight: .regular))
            .foregroundStyle(.white)
            .frame(width: size, height: size)
            .background {
                // Plain shapes, no shadow or blend: two layers per icon at most (S10).
                Circle().fill(color.color)
                if ring > 0 { Circle().strokeBorder(Color.card, lineWidth: ring) }
            }
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
            // Only when the fill is under it: a shadow, even a clear one, costs an offscreen pass per row (30 Sep).
            .modifier(Halo(on: onFill))
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

private struct Halo: ViewModifier {
    let on: Bool
    func body(content: Content) -> some View {
        if on { content.shadow(color: Color.card.opacity(0.9), radius: 2.5) } else { content }
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
    /// A tap that logs pops the button (a checklist's open/close chevron doesn't).
    var popsOnTap = true
    let action: () -> Void
    /// Taps that logged, so the pop plays once per tap and never on a redraw (another day, an undo elsewhere).
    @State private var pops = 0
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        Button {
            // Ticking a done check undoes it: no pop for that. "+" keeps popping past the goal.
            if popsOnTap && !reduceMotion && (!done || keepSymbolWhenDone) { pops &+= 1 }
            action()
        } label: {
            Group {
                if let text {
                    Text(text).font(.system(size: 13, weight: .bold).monospacedDigit()).lineLimit(1).minimumScaleFactor(0.7)
                } else {
                    Image(systemName: done && !keepSymbolWhenDone ? "checkmark" : symbol)
                        .font(.system(size: 14, weight: .bold))
                        .contentTransition(.symbolEffect(.replace))
                }
            }
                .foregroundStyle(done ? Color.white : Color.ink)
                .frame(width: 34, height: 34)
                .background(Circle().fill(done ? AnyShapeStyle(color.color) : AnyShapeStyle(Color(.tertiarySystemFill))))
                // The tick (research "Ticking Off…", §1): a quick press-in and spring back, about a third of a second,
                // on this 34-pt circle only. A transform, so nothing around it is laid out again.
                .keyframeAnimator(initialValue: 1.0, trigger: pops) { content, scale in
                    content.scaleEffect(scale)
                } keyframes: { _ in
                    KeyframeTrack {
                        CubicKeyframe(0.84, duration: 0.07)
                        SpringKeyframe(1.1, duration: 0.13, spring: .snappy)
                        SpringKeyframe(1.0, duration: 0.18, spring: .smooth)
                    }
                }
                .frame(width: 44, height: 44)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(label)
    }
}

/// A row background that fills from the left with the habit's colour as progress grows.
///
/// The colour layer is the row's full width, scaled from the leading edge: a change in progress is a transform the GPU
/// animates (the sweep after a tick), not a new layout or a geometry read on every row.
/// The colour is the habit's `Fill` (Shared/Palette.swift), opaque, so every hue fills as strongly as the others.
struct ProgressFill: View {
    let progress: Double
    let color: HabitColor

    var body: some View {
        Color.card.overlay {
            color.fill
                .scaleEffect(x: min(1, max(0, progress)), y: 1, anchor: .leading)
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

extension View {
    /// Figma's Floating button, Style=Glass: a button that floats over content on plain Liquid Glass, the same material as
    /// the toolbar under it (iOS has no floating action button). iOS 26 draws the glass; iOS 18 gets the nearest it has,
    /// a capsule of regular material.
    func floatingGlass() -> some View {
        modifier(FloatingGlass())
    }
}

private struct FloatingGlass: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 26, *) {
            content.glassEffect(.regular.interactive(), in: .capsule)
        } else {
            content
                .background(.regularMaterial, in: Capsule())
                .shadow(color: .black.opacity(0.12), radius: 8, y: 2)
        }
    }
}

// MARK: - Banner and card notice
//
// iOS has neither: no snack bar or toast, and no notice card (TipKit's TipView decides by itself when a tip stops
// showing, and a problem must stay until it's fixed). So these two are ours, drawn once here from Figma's section 09.
// Menus, sheets, alerts, `ContentUnavailableView` and `.redacted(reason: .placeholder)` are iOS's own: nothing of ours.

/// Figma's Banner: a short message floating where the person is, with at most two actions ("Note saved · Undo").
/// Subheadline in Label, its symbol 6 before the words, the actions Semibold 12 after them; 16 at the sides and 12 above
/// and below, so one line is 44 tall and a capsule. Two lines at most, then "…"; as wide as its words, never wider than
/// the room its place gives it. Solid card colour with a soft shadow: glass or material vanished on a light page
/// (29 Sep). The shadow is on the background shape alone, never the text (S10). Place it in an overlay so nothing under
/// it moves when it comes.
struct Banner<Actions: View>: View {
    let text: String
    var symbol = "checkmark.circle"
    @ViewBuilder var actions: Actions

    var body: some View {
        HStack(spacing: 12) {
            HStack(alignment: .firstTextBaseline, spacing: 6) {
                Image(systemName: symbol).accessibilityHidden(true)
                Text(text).lineLimit(2).fixedSize(horizontal: false, vertical: true)
            }
            .font(.subheadline)
            actions.font(.subheadline.weight(.semibold))
        }
        .foregroundStyle(.primary)
        .tint(.primary)
        .padding(.horizontal, 16).padding(.vertical, 12)
        .frame(minHeight: 44)
        .background {
            RoundedRectangle(cornerRadius: 22, style: .continuous).fill(Color.card)
                .shadow(color: .black.opacity(0.12), radius: 8, y: 2)
        }
    }
}

/// Figma's Card notice: a list card at the top of a page when something needs the person, in TipView's anatomy and our
/// neutral colours. A filled symbol at Title 2 in a 32 column (System Red for a problem, Secondary Label otherwise),
/// the title in Headline, the line in Subheadline, Secondary Label, 2 under it, and at most one fix, a Regular Bordered
/// button 10 under the words. The ✕ is Not Now, only on what can wait. It's the list's own row, with the list's own
/// background, corners and insets, so its words line up with the rows under it.
struct CardNotice<Fix: View>: View {
    let symbol: String
    let title: String
    let message: String
    var problem = true
    /// What VoiceOver and the UI tests find the words by.
    var id = ""
    /// Not Now: hides a notice that can wait. Nil for one that can't.
    var onClose: (() -> Void)? = nil
    var closeID = ""
    @ViewBuilder var fix: Fix

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: symbol)
                .symbolVariant(.fill)
                .font(.title2)
                .foregroundStyle(problem ? Color(.systemRed) : Color.secondary)
                .frame(width: 32)
                .accessibilityHidden(true)
            VStack(alignment: .leading, spacing: 10) {
                VStack(alignment: .leading, spacing: 2) {
                    // Room kept for the ✕, so the title never runs under it.
                    Text(title).font(.headline).padding(.trailing, onClose == nil ? 0 : 34)
                    Text(message).font(.subheadline).foregroundStyle(.secondary)
                }
                .fixedSize(horizontal: false, vertical: true)
                .accessibilityElement(children: .combine)
                .accessibilityIdentifier(id)
                fix
                    .buttonStyle(.bordered)
                    .tint(.ink)
                    .controlSize(.regular)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .overlay(alignment: .topTrailing) {
            if let onClose {
                Button(action: onClose) {
                    // Figma's Close button: Ink at 25 % behind an Ink ✕, as the More button is drawn.
                    Image(systemName: "xmark.circle.fill")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.ink, Color.ink.opacity(0.25))
                        .font(.title2)
                        .frame(width: 44, height: 44)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                // The circle sits in the corner; its 44 target reaches past it into the card's padding.
                .padding(.top, -9).padding(.trailing, -9)
                .accessibilityLabel("Not Now")
                .accessibilityIdentifier(closeID)
            }
        }
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
            let kept = old.count == limit ? old : String(new.prefix(limit))
            // Put back on the next turn, not inside this change. Set in the same turn, the value ends where the field
            // was last drawn, so SwiftUI sees no change and never redraws the field: typing fast (or a paste) left the
            // field showing 39 letters while 24 were kept (LongTextUITests, 3 Oct 2026).
            Task { @MainActor in if text.wrappedValue.count > limit { text.wrappedValue = kept } }
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

/// The iPhone's green switch, whatever tint surrounds it. `SwitchToggleStyle(tint:)` lost to a nearer `.tint(.ink)`:
/// the routine player's Show clock switch was near-white on near-white in dark mode (the user, 4 Oct 2026). The tint
/// set on the switch itself always wins.
struct AppSwitchStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Toggle(configuration).toggleStyle(.switch).tint(Color(.systemGreen))
    }
}

extension ToggleStyle where Self == AppSwitchStyle {
    static var appSwitch: AppSwitchStyle { AppSwitchStyle() }
}
