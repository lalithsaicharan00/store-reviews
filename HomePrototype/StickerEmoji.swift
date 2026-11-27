import SwiftUI

/// An Apple emoji drawn as a sticker: a white outline that follows its shape and a
/// soft shadow, so it stands out on a pale card.
struct StickerEmoji: View {
    let emoji: String
    var size: CGFloat = 44

    var body: some View {
        let outline = max(2, size * 0.075)
        let glyph = Text(emoji).font(.system(size: size))

        ZStack {
            // The outline: white copies of the emoji's silhouette, nudged in a ring.
            ForEach(0..<16, id: \.self) { i in
                let angle = Double(i) / 16 * 2 * .pi
                glyph
                    .brightness(1) // every pixel to white, keeping the emoji's shape
                    .offset(x: cos(angle) * outline, y: sin(angle) * outline)
            }
            glyph
        }
        .compositingGroup()
        .shadow(color: .black.opacity(0.16), radius: size * 0.09, x: 0, y: size * 0.06)
        .accessibilityHidden(true)
    }
}

#Preview {
    HStack(spacing: 20) {
        ForEach(["☀️", "🏋️", "🥑", "📚", "💧"], id: \.self) { StickerEmoji(emoji: $0) }
    }
    .padding(30)
    .background(Color(.systemGray6))
}
