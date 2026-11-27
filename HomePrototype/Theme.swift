import SwiftUI

// One look of our own, drawn by hand, so Android can draw exactly the same.

enum Theme {
    static let background = Color(red: 0.984, green: 0.973, blue: 0.953) // warm cream
    static let ink = Color(red: 0.13, green: 0.12, blue: 0.11)            // warm near-black
    static let inkSoft = ink.opacity(0.58)
    static let progressCard = Color(red: 0.925, green: 0.914, blue: 0.894) // warm grey
    static let star = Color(red: 1.0, green: 0.78, blue: 0.20)
    static let barStart = Color(red: 1.0, green: 0.71, blue: 0.20)
    static let barEnd = Color(red: 1.0, green: 0.48, blue: 0.16)
}

// MARK: - Type: chunky and rounded, and it grows with the phone's text size

private struct AppFont: ViewModifier {
    @ScaledMetric private var size: CGFloat
    private let weight: Font.Weight

    init(size: CGFloat, weight: Font.Weight, relativeTo style: Font.TextStyle) {
        _size = ScaledMetric(wrappedValue: size, relativeTo: style)
        self.weight = weight
    }

    func body(content: Content) -> some View {
        content.font(.system(size: size, weight: weight, design: .rounded))
    }
}

extension View {
    /// The app's type scale: hero 60, title 28, card title 21, body 17, meta 15.
    func appFont(_ size: CGFloat, _ weight: Font.Weight = .bold, relativeTo style: Font.TextStyle = .body) -> some View {
        modifier(AppFont(size: size, weight: weight, relativeTo: style))
    }
}

// MARK: - Icons, drawn as paths (no system symbols)

/// Two bars, the second shorter: the app's menu.
struct MenuIcon: Shape {
    func path(in r: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: r.minX + r.width * 0.14, y: r.minY + r.height * 0.36))
        p.addLine(to: CGPoint(x: r.minX + r.width * 0.86, y: r.minY + r.height * 0.36))
        p.move(to: CGPoint(x: r.minX + r.width * 0.14, y: r.minY + r.height * 0.64))
        p.addLine(to: CGPoint(x: r.minX + r.width * 0.58, y: r.minY + r.height * 0.64))
        return p
    }
}

/// Two sliders: the app's settings.
struct SettingsIcon: View {
    var color: Color = Theme.ink
    var lineWidth: CGFloat = 2.6

    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width, h = geo.size.height
            let knob = w * 0.30
            ZStack {
                Path { p in
                    p.move(to: CGPoint(x: w * 0.12, y: h * 0.32)); p.addLine(to: CGPoint(x: w * 0.88, y: h * 0.32))
                    p.move(to: CGPoint(x: w * 0.12, y: h * 0.68)); p.addLine(to: CGPoint(x: w * 0.88, y: h * 0.68))
                }
                .stroke(color, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                knobView(knob).position(x: w * 0.64, y: h * 0.32)
                knobView(knob).position(x: w * 0.36, y: h * 0.68)
            }
        }
    }

    private func knobView(_ size: CGFloat) -> some View {
        Circle().fill(.white)
            .overlay(Circle().stroke(color, lineWidth: lineWidth))
            .frame(width: size, height: size)
    }
}

struct ChevronDown: Shape {
    func path(in r: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: r.minX, y: r.minY + r.height * 0.3))
        p.addLine(to: CGPoint(x: r.midX, y: r.maxY - r.height * 0.2))
        p.addLine(to: CGPoint(x: r.maxX, y: r.minY + r.height * 0.3))
        return p
    }
}

/// A play triangle with soft corners (fill it, then stroke it with a round join).
struct PlayTriangle: Shape {
    func path(in r: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: r.minX + r.width * 0.12, y: r.minY))
        p.addLine(to: CGPoint(x: r.maxX, y: r.midY))
        p.addLine(to: CGPoint(x: r.minX + r.width * 0.12, y: r.maxY))
        p.closeSubpath()
        return p
    }
}

struct CheckMark: Shape {
    func path(in r: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: r.minX, y: r.midY + r.height * 0.05))
        p.addLine(to: CGPoint(x: r.minX + r.width * 0.36, y: r.maxY - r.height * 0.1))
        p.addLine(to: CGPoint(x: r.maxX, y: r.minY + r.height * 0.12))
        return p
    }
}

struct StarShape: Shape {
    func path(in r: CGRect) -> Path {
        var p = Path()
        let c = CGPoint(x: r.midX, y: r.midY + r.height * 0.04)
        let outer = min(r.width, r.height) / 2
        let inner = outer * 0.48
        for i in 0..<10 {
            let radius = i.isMultiple(of: 2) ? outer : inner
            let angle = Double(i) * .pi / 5 - .pi / 2
            let pt = CGPoint(x: c.x + cos(angle) * radius, y: c.y + sin(angle) * radius)
            i == 0 ? p.move(to: pt) : p.addLine(to: pt)
        }
        p.closeSubpath()
        return p
    }
}

extension Shape {
    /// Fill and round the corners in one go (a soft, friendly shape).
    func softFill(_ color: Color, corner: CGFloat) -> some View {
        ZStack {
            fill(color)
            stroke(color, style: StrokeStyle(lineWidth: corner, lineJoin: .round))
        }
    }
}

// MARK: - Buttons

/// A white round "sticker" button, used for the menu and settings.
struct StickerButtonLabel<Icon: View>: View {
    @ViewBuilder var icon: Icon

    var body: some View {
        icon
            .frame(width: 22, height: 22)
            .frame(width: 50, height: 50)
            .background(.white, in: .circle)
            .overlay(Circle().strokeBorder(Theme.ink.opacity(0.07), lineWidth: 1))
            .shadow(color: Theme.ink.opacity(0.08), radius: 10, y: 4)
            .contentShape(.circle)
    }
}

/// Squashes a little on press, like a real button.
struct SquishStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.spring(response: 0.25, dampingFraction: 0.6), value: configuration.isPressed)
    }
}
