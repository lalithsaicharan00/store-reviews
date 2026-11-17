import SwiftUI
import UIKit

// MARK: - Keyframes
//
// Figma's keyframes for the milestone bar, ribbon and pop-up ("Milestone · Motion"), the same tracks as Android's
// `Motion.kt`, so both phones move alike. The curves are SwiftUI's own `UnitCurve`s, with Figma's control points.

/// One keyframe: its time in milliseconds from the start of a timeline, its value, and the curve from it to the next.
struct Key {
    let at: Double
    let value: Double
    let curve: UnitCurve

    init(_ at: Double, _ value: Double, _ curve: UnitCurve = .linear) {
        self.at = at
        self.value = value
        self.curve = curve
    }
}

/// Figma's easings, as it names them.
enum Ease {
    /// CSS's ease-out.
    static let out = UnitCurve.bezier(startControlPoint: UnitPoint(x: 0, y: 0), endControlPoint: UnitPoint(x: 0.58, y: 1))
    /// CSS's ease-in.
    static let `in` = UnitCurve.bezier(startControlPoint: UnitPoint(x: 0.42, y: 0), endControlPoint: UnitPoint(x: 1, y: 1))
    /// CSS's ease-in-out.
    static let inOut = UnitCurve.bezier(startControlPoint: UnitPoint(x: 0.42, y: 0), endControlPoint: UnitPoint(x: 0.58, y: 1))
    /// Things that arrive: fast, then settling.
    static let arrive = UnitCurve.bezier(startControlPoint: UnitPoint(x: 0.05, y: 0.7), endControlPoint: UnitPoint(x: 0.1, y: 1))
    /// A pop, with a little overshoot (medals, sparkles).
    static let pop = UnitCurve.bezier(startControlPoint: UnitPoint(x: 0.45, y: 1.45), endControlPoint: UnitPoint(x: 0.8, y: 1))
}

/// A track's value `ms` milliseconds into its timeline: the first key's value before it, the last's after it.
func track(_ ms: Double, _ keys: Key...) -> Double {
    guard let first = keys.first, let last = keys.last else { return 0 }
    if ms <= first.at { return first.value }
    for (a, b) in zip(keys, keys.dropFirst()) where ms <= b.at {
        let f = min(max((ms - a.at) / max(b.at - a.at, 0.001), 0), 1)
        return a.value + (b.value - a.value) * a.curve.value(at: f)
    }
    return last.value
}

/// A timeline that plays once, from the moment the view first shows, and then rests at its end. `content` is given
/// the milliseconds played. SwiftUI's own linear animation moves the number (`Frame` is `Animatable`), so nothing
/// ticks: only the view inside redraws while it plays, and never again after (S3, S4). With Reduce Motion it's at
/// rest from the first frame.
struct Playback<Content: View>: View {
    let duration: Double
    let content: (Double) -> Content
    @State private var ms: Double

    /// `atRest`: shown at its end from the first frame (it played already, e.g. a row scrolled away and back).
    init(duration: Double, atRest: Bool = false, @ViewBuilder content: @escaping (Double) -> Content) {
        self.duration = duration
        self.content = content
        _ms = State(initialValue: atRest || UIAccessibility.isReduceMotionEnabled ? duration : 0)
    }

    var body: some View {
        Frame(ms: ms, content: content)
            .onAppear {
                guard ms < duration else { return }
                withAnimation(.linear(duration: duration / 1000)) { ms = duration }
            }
    }

    /// One frame of the timeline: SwiftUI hands it every value between 0 and the end while the animation runs.
    private struct Frame: View, Animatable {
        var ms: Double
        let content: (Double) -> Content

        nonisolated var animatableData: Double {
            get { ms }
            set { ms = newValue }
        }

        var body: some View { content(ms) }
    }
}

/// A four-pointed sparkle centred on `centre`, `size` across, as Figma's stars: four curves through the centre.
func sparkle(at centre: CGPoint, size: CGFloat) -> Path {
    let h = size / 2
    var p = Path()
    p.move(to: CGPoint(x: centre.x, y: centre.y - h))
    p.addQuadCurve(to: CGPoint(x: centre.x + h, y: centre.y), control: centre)
    p.addQuadCurve(to: CGPoint(x: centre.x, y: centre.y + h), control: centre)
    p.addQuadCurve(to: CGPoint(x: centre.x - h, y: centre.y), control: centre)
    p.addQuadCurve(to: CGPoint(x: centre.x, y: centre.y - h), control: centre)
    p.closeSubpath()
    return p
}

/// A sheen's band: white fading in and out across it, `peak` in its middle, for a light that passes once.
func sheen(peak: Double) -> LinearGradient {
    LinearGradient(colors: [.white.opacity(0), .white.opacity(peak), .white.opacity(0)], startPoint: .leading,
                   endPoint: .trailing)
}
