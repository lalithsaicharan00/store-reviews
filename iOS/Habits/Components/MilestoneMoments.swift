import SwiftUI

// The moment a milestone is reached (Figma's Progress and milestones: Milestone bar, Milestone pop-up, Milestone
// ribbon), with the same keyframes as Android's (`MilestoneBar.kt`, `MilestonePopup.kt`, `MilestoneRibbon.kt`).
// iOS has none of these: they're ours, built from its parts (a sheet, buttons, text styles) and drawn with SwiftUI's
// own shapes. Each moves only inside itself, once (`Playback`), and rests at its end with Reduce Motion.

// MARK: - The moment

/// A milestone just reached by a tap, in the words the bar and the pop-up show.
struct MilestoneMoment: Identifiable, Equatable {
    /// The tap's entry: one moment per tap.
    let id: UUID
    let habitID: UUID
    let name: String
    let color: HabitColor
    /// On the medal: "7".
    let number: String
    /// "7 days in a row".
    let title: String
    /// The pop-up's title: "Your first milestone", "7 days in a row, again", or the title.
    let popupTitle: String
    /// "7 days in a row · Meds", "Meds · back to an earlier run", "Meds · reached today".
    let supporting: String
    /// The next one on the same track.
    let next: MilestoneNext

    /// The moment for a streak milestone of `value` in `unit`; `again` when an earlier run already reached it.
    init(entry: UUID, habit: Habit, value: Int, unit: StreakUnit, again: Bool) {
        id = entry
        habitID = habit.id
        name = habit.name
        color = habit.color
        number = "\(value)"
        title = unit.inARow(value)
        let first = !again && value == unit.nextMilestone(after: 0)
        popupTitle = first ? "Your first milestone" : again ? title + ", again" : title
        supporting = first ? "\(title) · \(habit.name)"
            : again ? "\(habit.name) · back to an earlier run" : "\(habit.name) · reached today"
        let k = unit.nextMilestone(after: value)
        // Figma's pop-up card (853:45930): "Next · 4 to go · now 3".
        let left = "\(k - value) to go · now \(value)"
        next = MilestoneNext(track: .inARow, target: k, number: "\(k)", title: unit.inARow(k),
                             pageTitle: "Next: " + unit.inARow(k), detail: "Next · " + left,
                             fraction: Double(value) / Double(k), spoken: "Next: \(unit.inARow(k)), \(left).")
    }
}

// MARK: - Milestone bar

/// Figma's Milestone bar: a milestone just reached on Today, rising over the bottom of the list for 5 seconds. The
/// habit's Bar gradient, 72 tall, 20 corners: a white medal with three sparkles, the milestone and the habit's name in
/// white, and See (the pop-up). A thin line counts down the time left; swiping it sideways puts it away.
///
/// Motion (1.15 s, from when it has risen): the medal pops (0.6 → 1), the sparkles appear one after another and
/// settle at 60 %, a sheen passes once. Only the medal and the sheen redraw while they move (S3, S6).
struct MilestoneBar: View {
    let moment: MilestoneMoment
    let onSee: () -> Void
    let onGone: () -> Void
    @State private var left = 1.0
    @State private var drag: CGFloat = 0
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    static let timeline = 1150.0
    static let risen = 250.0
    static let stay = 5.0

    private var shape: RoundedRectangle { RoundedRectangle(cornerRadius: 20, style: .continuous) }

    var body: some View {
        HStack(spacing: 12) {
            Playback(duration: Self.timeline) { ms in BarMedal(number: moment.number, color: moment.color, ms: ms) }
                .frame(width: 44, height: 44)
            VStack(alignment: .leading, spacing: 0) {
                Text(moment.title).font(.body)
                Text(moment.name).font(.subheadline).opacity(0.86)
            }
            .foregroundStyle(.white)
            .lineLimit(1)
            .frame(maxWidth: .infinity, alignment: .leading)
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("\(moment.name): \(moment.title)")
            Button(action: onSee) {
                Text("See").foregroundStyle(moment.color.increasedContrast)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.small)
            .tint(Color.card)
            .accessibilityIdentifier("milestone-bar-see")
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 14)
        .frame(minHeight: 72)
        .background {
            shape.fill(moment.color.bar)
                .shadow(color: .black.opacity(0.3), radius: 1.5, y: 1)
                .shadow(color: .black.opacity(0.15), radius: 4, y: 4)
        }
        .overlay {
            ZStack(alignment: .bottomLeading) {
                Playback(duration: Self.timeline) { ms in BarSheen(ms: ms) }
                Capsule().fill(.white.opacity(0.45))
                    .frame(height: 3)
                    .scaleEffect(x: left, y: 1, anchor: .leading)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 3)
            }
            .clipShape(shape)
            .allowsHitTesting(false)
            .accessibilityHidden(true)
        }
        .offset(x: drag)
        .gesture(
            DragGesture(minimumDistance: 12)
                .onChanged { drag = $0.translation.width }
                .onEnded { value in
                    if abs(value.translation.width) > 80 { onGone() } else { withAnimation(.snappy) { drag = 0 } }
                }
        )
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("milestone-bar")
        .accessibilityAction(.escape) { onGone() }
        .onAppear {
            guard !reduceMotion else { return }
            withAnimation(.linear(duration: Self.stay).delay(Self.risen / 1000)) { left = 0 }
        }
        .task {
            try? await Task.sleep(for: .milliseconds(Int(Self.risen + Self.stay * 1000)))
            onGone()
        }
    }
}

/// The bar's medal: the medal's star in white (40), the same star at 82 % as a fine line in the habit's Gradient Top,
/// the number in the habit's Increased Contrast, and Figma's three sparkles round it.
private struct BarMedal: View {
    let number: String
    let color: HabitColor
    let ms: Double

    /// Figma's sparkles in the 44 box: centre, size, and how strong each is at its brightest.
    private static let sparkles: [(CGPoint, CGFloat, Double)] = [
        (CGPoint(x: 41, y: 1), 10, 0.95), (CGPoint(x: -1.5, y: 33.5), 7, 0.8), (CGPoint(x: 43, y: 35), 6, 0.7),
    ]

    var body: some View {
        let pop = track(ms, Key(MilestoneBar.risen, 0.6, Ease.pop), Key(550, 1))
        ZStack {
            ZStack {
                MedalShape()
                    .fill(LinearGradient(colors: [.white, Color(red: 245 / 255, green: 245 / 255, blue: 247 / 255)],
                                         startPoint: .top, endPoint: .bottom))
                    .shadow(color: .black.opacity(0.35), radius: 1.65, y: 1.1)
                MedalShape()
                    .stroke(color.gradientTop, lineWidth: 0.83)
                    .frame(width: 33, height: 33)
                Text(number)
                    .font(.system(size: number.count >= 3 ? 12 : 15, weight: .semibold))
                    .monospacedDigit()
                    .foregroundStyle(color.increasedContrast)
                    .lineLimit(1)
                    .minimumScaleFactor(0.6)
                    .padding(.horizontal, 7)
            }
            .frame(width: 40, height: 40)
            .scaleEffect(pop)
            // 8 of room round the 44 box, for the sparkles that sit past its edge.
            Canvas { context, _ in
                for (i, (point, size, strength)) in Self.sparkles.enumerated() {
                    let o = 60 * Double(i)
                    let a = track(ms, Key(300 + o, 0, Ease.out), Key(500 + o, 1, Ease.inOut), Key(800 + o, 0.6))
                    guard a > 0 else { continue }
                    let k = track(ms, Key(300 + o, 0.01, Ease.pop), Key(550 + o, 1))
                    let centre = CGPoint(x: point.x + 8, y: point.y + 8)
                    context.fill(sparkle(at: centre, size: size * k), with: .color(.white.opacity(strength * a)))
                }
            }
            .frame(width: 60, height: 60)
        }
        .frame(width: 44, height: 44)
        .accessibilityHidden(true)
    }
}

/// The light that passes once over the bar: 56 × 130, tilted 20°, white at 28 % in its middle, 550–1150 ms.
private struct BarSheen: View {
    let ms: Double

    var body: some View {
        ZStack(alignment: .leading) {
            Color.clear
            if ms > 550 && ms < 1150 {
                Rectangle()
                    .fill(sheen(peak: 0.28))
                    .frame(width: 56, height: 130)
                    .rotationEffect(.degrees(20))
                    .offset(x: 150 + track(ms, Key(550, -240, Ease.inOut), Key(1150, 240)))
            }
        }
    }
}

// MARK: - Milestone pop-up

/// Figma's Milestone pop-up, opened by the bar's See: a sheet of one height (no handle) with a glass ✕, the medal's
/// stage (a glow, the Large medal spinning in, a burst ring, twelve dots and four sparkles), the milestone in Title 2
/// Bold and what it is under it, the next one on a card, and All Milestones.
///
/// Motion (1.3 s, as it opens): the glow grows in, the medal spins in from 25° and pops (0.3 → 1.12 → 1), the ring
/// bursts and the dots fly out in turn, the sparkles pop and settle at half, then the words, the card and the button
/// rise in turn. At rest with Reduce Motion. The sheet's own arrival is iOS's.
struct MilestonePopup: View {
    let moment: MilestoneMoment
    let onAll: () -> Void
    @Environment(\.dismiss) private var dismiss
    @State private var height: CGFloat = 480

    static let timeline = 1300.0

    var body: some View {
        Playback(duration: Self.timeline) { ms in
            VStack(spacing: 24) {
                VStack(spacing: 4) {
                    MedalStage(moment: moment, ms: ms)
                    Text(moment.popupTitle)
                        .font(.title2.weight(.bold))
                        .arrive(ms, at: 550, rising: 12)
                    Text(moment.supporting)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .arrive(ms, at: 630, rising: 12)
                }
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                NextMilestone(next: moment.next, color: moment.color)
                    .padding(16)
                    .background(Color(.secondarySystemGroupedBackground),
                                in: RoundedRectangle(cornerRadius: 26, style: .continuous))
                    .arrive(ms, at: 850, rising: 12)
                Button {
                    dismiss()
                    onAll()
                } label: {
                    Text("All Milestones").frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .tint(Color.ink)
                .accessibilityIdentifier("milestone-popup-all")
                .arrive(ms, at: 950, rising: 8)
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)
            .padding(.bottom, 24)
        }
        .overlay(alignment: .topLeading) { close.padding(16) }
        .onGeometryChange(for: CGFloat.self) { $0.size.height } action: { height = $0 }
        .presentationDetents([.height(height)])
        .presentationDragIndicator(.hidden)
        .accessibilityIdentifier("milestone-popup")
    }

    @ViewBuilder private var close: some View {
        let button = Button { dismiss() } label: {
            Image(systemName: "xmark").font(.body.weight(.semibold)).frame(width: 44, height: 44)
        }
        .accessibilityLabel("Close")
        .accessibilityIdentifier("milestone-popup-close")
        if #available(iOS 26, *) {
            button.buttonStyle(.glass).buttonBorderShape(.circle).tint(.primary)
        } else {
            button.buttonStyle(.bordered).buttonBorderShape(.circle).tint(.primary)
        }
    }
}

/// The pop-up's stage, 176 tall, everything placed from its centre 92 down: the glow (the habit's Milestone Band, 150
/// across, soft-edged), the Large medal 40 down, the burst ring (116, a 2.5 line in the habit's colour), twelve dots
/// (7 and 5 across in turn, its Gradient Top, every 30° from 15°) and four sparkles in its colour.
private struct MedalStage: View {
    let moment: MilestoneMoment
    let ms: Double

    /// Figma's sparkles, from the stage's centre (156, 92 in its 312-wide frame): centre and size.
    private static let sparkles: [(CGFloat, CGFloat, CGFloat)] = [(212, 42, 12), (92, 64, 9), (220, 120, 8), (108, 140, 10)]

    var body: some View {
        let colour = moment.color.color
        let band = moment.color.milestoneBand
        let pale = moment.color.gradientTop
        ZStack(alignment: .top) {
            Canvas { context, size in
                let centre = CGPoint(x: size.width / 2, y: 92)
                // The glow: Figma's 150 disc blurred 24, drawn as its soft edge (solid to 51, nothing by 99).
                let glow = track(ms, Key(200, 0, Ease.out), Key(600, 1))
                if glow > 0 {
                    let r = 99 * track(ms, Key(200, 0.6, Ease.out), Key(750, 1))
                    var layer = context
                    layer.opacity = glow
                    layer.fill(Circle().path(in: CGRect(x: centre.x - r, y: centre.y - r, width: 2 * r, height: 2 * r)),
                               with: .radialGradient(Gradient(stops: [.init(color: band, location: 0),
                                                                      .init(color: band, location: 0.52),
                                                                      .init(color: band.opacity(0), location: 1)]),
                                                     center: centre, startRadius: 0, endRadius: r))
                }
                // The burst ring.
                let ring = track(ms, Key(450, 0, Ease.out), Key(500, 0.6, Ease.out), Key(1000, 0))
                if ring > 0 {
                    let r = 58 * track(ms, Key(450, 0.8, Ease.out), Key(1000, 1.3))
                    context.stroke(Circle().path(in: CGRect(x: centre.x - r, y: centre.y - r, width: 2 * r, height: 2 * r)),
                                   with: .color(colour.opacity(ring)), lineWidth: 2.5)
                }
                // Twelve dots, each 10 ms after the one before, flying out to 64.
                for i in 0..<12 {
                    let start = 450 + 10 * Double(i)
                    let a = track(ms, Key(start, 0, Ease.out), Key(start + 80, 1, Ease.in), Key(start + 600, 0))
                    guard a > 0 else { continue }
                    let s = track(ms, Key(start, 0.6, Ease.out), Key(start + 150, 1, Ease.in), Key(start + 600, 0.3))
                    let out = track(ms, Key(start, 44, Ease.out), Key(start + 380, 64))
                    let angle = (15 + 30 * Double(i)) * .pi / 180
                    let r = (i.isMultiple(of: 2) ? 3.5 : 2.5) * s
                    let p = CGPoint(x: centre.x + cos(angle) * out, y: centre.y + sin(angle) * out)
                    context.fill(Circle().path(in: CGRect(x: p.x - r, y: p.y - r, width: 2 * r, height: 2 * r)),
                                 with: .color(pale.opacity(a)))
                }
                // Four sparkles, 100 ms apart.
                for (i, (x, y, d)) in Self.sparkles.enumerated() {
                    let start = 800 + 100 * Double(i)
                    let a = track(ms, Key(start, 0, Ease.out), Key(start + 150, 1, Ease.inOut), Key(start + 500, 0.5))
                    guard a > 0 else { continue }
                    let turn = track(ms, Key(start, 0, Ease.out), Key(start + 500, 45))
                    let k = track(ms, Key(start, 0.01, Ease.pop), Key(start + 200, 1.15, Ease.inOut), Key(start + 500, 0.85))
                    let p = CGPoint(x: centre.x + x - 156, y: centre.y + y - 92)
                    let star = sparkle(at: .zero, size: d * k)
                        .applying(CGAffineTransform(rotationAngle: turn * .pi / 180))
                        .applying(CGAffineTransform(translationX: p.x, y: p.y))
                    context.fill(star, with: .color(colour.opacity(a)))
                }
            }
            Medal(number: moment.number, size: 104, color: moment.color)
                .rotationEffect(.degrees(track(ms, Key(250, 25, Ease.out), Key(820, 0))))
                .scaleEffect(track(ms, Key(250, 0.3, Ease.out), Key(620, 1.12, Ease.inOut), Key(820, 1)))
                .padding(.top, 40)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 176)
        .accessibilityHidden(true)
    }
}

private extension View {
    /// Rises `rising` points and fades in from `start` ms: 250 ms to appear, 300 to settle.
    func arrive(_ ms: Double, at start: Double, rising: CGFloat) -> some View {
        opacity(track(ms, Key(start, 0, Ease.out), Key(start + 250, 1)))
            .offset(y: track(ms, Key(start, rising, Ease.arrive), Key(start + 300, 0)))
    }
}

// MARK: - Milestone ribbon

/// Figma's Milestone ribbon: a milestone in the routine player, a capsule that hugs its words, under the progress.
/// The habit's Milestone Band, a medal (16) and the milestone in Subheadline Semibold, the habit's Deep.
///
/// Motion (1.02 s, as it appears): the medal spins in from 35° and pops (0.01 → 1.3 → 1), the words slide in and fade
/// up, then a sheen passes once.
struct MilestoneRibbon: View {
    let text: String
    let color: HabitColor

    var body: some View {
        Playback(duration: 1020) { ms in
            HStack(spacing: 8) {
                Medal(size: 16, color: color)
                    .rotationEffect(.degrees(track(ms, Key(120, 35, Ease.out), Key(440, 0))))
                    .scaleEffect(track(ms, Key(120, 0.01, Ease.out), Key(300, 1.3, Ease.inOut), Key(440, 1)))
                Text(text)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(color.deep)
                    .lineLimit(1)
                    .offset(x: track(ms, Key(180, -8, Ease.arrive), Key(400, 0)))
                    .opacity(track(ms, Key(180, 0, Ease.arrive), Key(400, 1)))
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 6)
            .frame(minHeight: 32)
            .background(color.milestoneBand, in: Capsule())
            .overlay(alignment: .leading) {
                if ms > 420 && ms < 1020 {
                    Rectangle()
                        .fill(sheen(peak: 0.5))
                        .frame(width: 48, height: 80)
                        .rotationEffect(.degrees(20))
                        .offset(x: -120 + track(ms, Key(420, 0, Ease.inOut), Key(1020, 520)))
                        .allowsHitTesting(false)
                }
            }
            .clipShape(Capsule())
        }
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier("player-milestone")
    }
}
