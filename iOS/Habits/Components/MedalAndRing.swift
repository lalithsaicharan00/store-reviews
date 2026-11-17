import SwiftUI

// MARK: - Medal

/// Figma's Medal (Progress and milestones): a nine-point star with soft corners, the milestone reached written on it.
/// iOS has no such shape (an SF Symbol seal is round-toothed and can't carry a number), so this is ours, drawn from
/// the same outline as Android's `Medal.kt` (a 72-point box), so both phones show one medal.
nonisolated struct MedalShape: Shape {
    func path(in rect: CGRect) -> Path {
        let scale = min(rect.width, rect.height) / 72
        let transform = CGAffineTransform(translationX: rect.midX - 36 * scale, y: rect.midY - 36 * scale)
            .scaledBy(x: scale, y: scale)
        return Self.outline.applying(transform)
    }

    /// The outline in its 72-point box, worked out once.
    private static let outline: Path = {
        var p = Path()
        p.move(to: CGPoint(x: 32.063, y: 2.563))
        p.addCurve(to: CGPoint(x: 39.931, y: 2.563), control1: CGPoint(x: 34.454, y: 1.004), control2: CGPoint(x: 37.54, y: 1.004))
        p.addLine(to: CGPoint(x: 45.181, y: 5.988))
        p.addCurve(to: CGPoint(x: 48.252, y: 7.105), control1: CGPoint(x: 46.105, y: 6.591), control2: CGPoint(x: 47.156, y: 6.973))
        p.addLine(to: CGPoint(x: 54.475, y: 7.857))
        p.addCurve(to: CGPoint(x: 60.502, y: 12.914), control1: CGPoint(x: 57.308, y: 8.199), control2: CGPoint(x: 59.672, y: 10.183))
        p.addLine(to: CGPoint(x: 62.322, y: 18.912))
        p.addCurve(to: CGPoint(x: 63.956, y: 21.742), control1: CGPoint(x: 62.642, y: 19.968), control2: CGPoint(x: 63.202, y: 20.936))
        p.addLine(to: CGPoint(x: 68.24, y: 26.318))
        p.addCurve(to: CGPoint(x: 69.606, y: 34.065), control1: CGPoint(x: 70.191, y: 28.401), control2: CGPoint(x: 70.727, y: 31.44))
        p.addLine(to: CGPoint(x: 67.145, y: 39.83))
        p.addCurve(to: CGPoint(x: 66.578, y: 43.049), control1: CGPoint(x: 66.712, y: 40.846), control2: CGPoint(x: 66.518, y: 41.947))
        p.addLine(to: CGPoint(x: 66.919, y: 49.308))
        p.addCurve(to: CGPoint(x: 62.985, y: 56.121), control1: CGPoint(x: 67.074, y: 52.158), control2: CGPoint(x: 65.531, y: 54.83))
        p.addLine(to: CGPoint(x: 57.394, y: 58.955))
        p.addCurve(to: CGPoint(x: 54.891, y: 61.056), control1: CGPoint(x: 56.41, y: 59.454), control2: CGPoint(x: 55.553, y: 60.173))
        p.addLine(to: CGPoint(x: 51.129, y: 66.07))
        p.addCurve(to: CGPoint(x: 43.736, y: 68.76), control1: CGPoint(x: 49.415, y: 68.353), control2: CGPoint(x: 46.516, y: 69.408))
        p.addLine(to: CGPoint(x: 37.631, y: 67.338))
        p.addCurve(to: CGPoint(x: 34.363, y: 67.338), control1: CGPoint(x: 36.556, y: 67.088), control2: CGPoint(x: 35.438, y: 67.088))
        p.addLine(to: CGPoint(x: 28.258, y: 68.76))
        p.addCurve(to: CGPoint(x: 20.866, y: 66.07), control1: CGPoint(x: 25.479, y: 69.408), control2: CGPoint(x: 22.579, y: 68.353))
        p.addLine(to: CGPoint(x: 17.103, y: 61.056))
        p.addCurve(to: CGPoint(x: 14.6, y: 58.955), control1: CGPoint(x: 16.441, y: 60.173), control2: CGPoint(x: 15.584, y: 59.454))
        p.addLine(to: CGPoint(x: 9.009, y: 56.121))
        p.addCurve(to: CGPoint(x: 5.075, y: 49.308), control1: CGPoint(x: 6.463, y: 54.83), control2: CGPoint(x: 4.92, y: 52.158))
        p.addLine(to: CGPoint(x: 5.416, y: 43.049))
        p.addCurve(to: CGPoint(x: 4.849, y: 39.83), control1: CGPoint(x: 5.476, y: 41.947), control2: CGPoint(x: 5.282, y: 40.846))
        p.addLine(to: CGPoint(x: 2.388, y: 34.065))
        p.addCurve(to: CGPoint(x: 3.754, y: 26.318), control1: CGPoint(x: 1.267, y: 31.44), control2: CGPoint(x: 1.803, y: 28.401))
        p.addLine(to: CGPoint(x: 8.038, y: 21.742))
        p.addCurve(to: CGPoint(x: 9.672, y: 18.912), control1: CGPoint(x: 8.793, y: 20.936), control2: CGPoint(x: 9.352, y: 19.968))
        p.addLine(to: CGPoint(x: 11.493, y: 12.914))
        p.addCurve(to: CGPoint(x: 17.519, y: 7.857), control1: CGPoint(x: 12.322, y: 10.183), control2: CGPoint(x: 14.686, y: 8.199))
        p.addLine(to: CGPoint(x: 23.743, y: 7.105))
        p.addCurve(to: CGPoint(x: 26.813, y: 5.988), control1: CGPoint(x: 24.838, y: 6.973), control2: CGPoint(x: 25.889, y: 6.591))
        p.addLine(to: CGPoint(x: 32.063, y: 2.563))
        p.closeSubpath()
        return p
    }()
}

/// A milestone medal at one of Figma's sizes: Large 104 (the pop-up), Medium 72 (the latest plate), 52 (a badge),
/// Small 40 (a row), and 16 with no number (a band or ribbon). The habit's Medal gradient, a white inner ring (the same
/// star at 0.82) and the number in white. The shadow sits on the star alone (S10). A picture: VoiceOver reads what's
/// beside it.
struct Medal: View {
    let number: String?
    let size: CGFloat
    let color: HabitColor

    init(number: String? = nil, size: CGFloat, color: HabitColor) {
        self.number = number
        self.size = size
        self.color = color
    }

    var body: some View {
        let k = size / 72
        ZStack {
            MedalShape()
                .fill(color.medal)
                .shadow(color: .black.opacity(0.2), radius: 3 * k, y: 2 * k)
            if size >= 24 {
                MedalShape()
                    .stroke(Color.white.opacity(0.6), lineWidth: ring)
                    .frame(width: size * 0.82, height: size * 0.82)
            }
            if let number, size >= 24 {
                Text(number)
                    .font(.system(size: digits(number), weight: size >= 52 ? .bold : .regular))
                    .monospacedDigit()
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.6)
                    .padding(.horizontal, size * 0.14)
            }
        }
        .frame(width: size, height: size)
        .accessibilityHidden(true)
    }

    /// Figma's inner ring: 2.2 on Large, 1.8 on Medium, 1.2 on Small.
    private var ring: CGFloat { size >= 100 ? 2.2 : size >= 64 ? 1.8 : 1.2 }

    /// Title 1 (28) on Large, Title 2 (22) on Medium, Body (17) below; a longer number shrinks as on Android (three
    /// digits ×0.8, four or more ×0.62). Fixed sizes: the number is part of the picture, and the star doesn't grow.
    private func digits(_ number: String) -> CGFloat {
        let base: CGFloat = size >= 100 ? 28 : size >= 64 ? 22 : 17
        return base * (number.count >= 4 ? 0.62 : number.count == 3 ? 0.8 : 1)
    }
}

// MARK: - Progress ring

/// Figma's Progress ring, the app's own (iOS's `ProgressView` has no ring on iPhone, and `Gauge`'s circular styles are
/// the Watch's and widgets' fixed sizes): a track in a system fill and the progress in the habit's colour from the top,
/// clockwise, with round ends, and whatever goes in the middle. 48 and 5 thick by default (Next milestone); the timer
/// draws the same ring at 260 and 10 on System Fill. No `GeometryReader`: the ring is a trimmed circle inset by half
/// its line, so it never draws past its frame.
struct ProgressRing<Label: View>: View {
    let fraction: Double
    let tint: Color
    var size: CGFloat = 48
    var lineWidth: CGFloat = 5
    var track: Color = Color(.tertiarySystemFill)
    @ViewBuilder var label: Label

    var body: some View {
        ZStack {
            Circle().inset(by: lineWidth / 2).stroke(track, lineWidth: lineWidth)
            Circle().inset(by: lineWidth / 2)
                .trim(from: 0, to: min(max(fraction, 0), 1))
                .stroke(tint, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
            label
        }
        .frame(width: size, height: size)
    }
}

extension ProgressRing where Label == EmptyView {
    init(fraction: Double, tint: Color, size: CGFloat = 48, lineWidth: CGFloat = 5,
         track: Color = Color(.tertiarySystemFill)) {
        self.init(fraction: fraction, tint: tint, size: size, lineWidth: lineWidth, track: track) { EmptyView() }
    }
}
