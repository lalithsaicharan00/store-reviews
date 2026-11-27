import SwiftUI
import UIKit

/// Pale card colours that all look equally light and equally soft, whatever the hue.
///
/// How: find the emoji's main hue, then build the colour in OKLCH with one fixed
/// lightness (L) and one fixed chroma (C) for every card. OKLCH is perceptual, so
/// equal L and C read as equally light and equally colourful to the eye, which
/// HSB/RGB can't promise (yellow at the same HSB looks far brighter than blue).
enum PaleColor {
    // Light mode: L 0.935 / C 0.030 is the most chroma every hue can share at that
    // lightness inside sRGB (blue runs out first, at about 0.031).
    static let lightFill = (L: 0.935, C: 0.030)
    // Dark mode: the same idea on a dark card.
    static let darkFill = (L: 0.30, C: 0.045)

    /// The card colour for an emoji, light and dark.
    static func fill(for emoji: String) -> Color {
        let hue = EmojiHue.hue(of: emoji)
        return Color(uiColor: UIColor { traits in
            let spec = traits.userInterfaceStyle == .dark ? darkFill : lightFill
            return OKLCH(L: spec.L, C: hue == nil ? 0 : spec.C, h: hue ?? 0).uiColor
        })
    }

    /// The emoji's own main colour, before it's made pale (for the debug preview).
    static func source(for emoji: String) -> Color {
        guard let hue = EmojiHue.hue(of: emoji) else { return Color(.systemGray3) }
        return Color(uiColor: OKLCH(L: 0.70, C: 0.15, h: hue).uiColor)
    }
}

// MARK: - OKLCH ↔ sRGB (Björn Ottosson's OKLab)

struct OKLCH {
    var L: Double
    var C: Double
    var h: Double // degrees

    /// sRGB colour; if this chroma doesn't fit in sRGB, chroma is lowered until it does
    /// (lightness and hue are kept, so the card still looks as light as the others).
    var uiColor: UIColor {
        var c = C
        var rgb = Self.linearRGB(L: L, C: c, h: h)
        var steps = 0
        while !Self.inGamut(rgb), steps < 30 {
            c *= 0.9
            rgb = Self.linearRGB(L: L, C: c, h: h)
            steps += 1
        }
        return UIColor(red: Self.encode(rgb.0), green: Self.encode(rgb.1), blue: Self.encode(rgb.2), alpha: 1)
    }

    private static func linearRGB(L: Double, C: Double, h: Double) -> (Double, Double, Double) {
        let a = C * cos(h * .pi / 180)
        let b = C * sin(h * .pi / 180)
        let l_ = L + 0.3963377774 * a + 0.2158037573 * b
        let m_ = L - 0.1055613458 * a - 0.0638541728 * b
        let s_ = L - 0.0894841775 * a - 1.2914855480 * b
        let l = l_ * l_ * l_, m = m_ * m_ * m_, s = s_ * s_ * s_
        return (
            4.0767416621 * l - 3.3077115913 * m + 0.2309699292 * s,
            -1.2684380046 * l + 2.6097574011 * m - 0.3413193965 * s,
            -0.0041960863 * l - 0.7034186147 * m + 1.7076147010 * s
        )
    }

    private static func inGamut(_ c: (Double, Double, Double)) -> Bool {
        let e = 0.0001
        return [c.0, c.1, c.2].allSatisfy { $0 >= -e && $0 <= 1 + e }
    }

    private static func encode(_ x: Double) -> CGFloat {
        let v = min(max(x, 0), 1)
        return CGFloat(v <= 0.0031308 ? 12.92 * v : 1.055 * pow(v, 1 / 2.4) - 0.055)
    }

    /// OKLab a, b and chroma from an sRGB pixel (0…1, not premultiplied).
    static func lab(r: Double, g: Double, b: Double) -> (L: Double, a: Double, b: Double) {
        func lin(_ x: Double) -> Double { x <= 0.04045 ? x / 12.92 : pow((x + 0.055) / 1.055, 2.4) }
        let R = lin(r), G = lin(g), B = lin(b)
        let l = cbrt(0.4122214708 * R + 0.5363015253 * G + 0.0514459929 * B)
        let m = cbrt(0.2119034982 * R + 0.6806995451 * G + 0.1073969566 * B)
        let s = cbrt(0.0883024619 * R + 0.2817188376 * G + 0.6299787005 * B)
        return (
            0.2104542553 * l + 0.7936177850 * m - 0.0040720468 * s,
            1.9779984951 * l - 2.4285922050 * m + 0.4505937099 * s,
            0.0259040371 * l + 0.7827717662 * m - 0.8086757660 * s
        )
    }
}

// MARK: - The emoji's main hue, worked out on the phone at run time

enum EmojiHue {
    private static var cache: [String: Double?] = [:]

    /// The hue (degrees) that covers most of the emoji's colourful pixels, or nil for
    /// an emoji with no real colour (⚪️ 🖤 🏳️), which gets a neutral grey card.
    static func hue(of emoji: String) -> Double? {
        if let cached = cache[emoji] { return cached }
        let result = compute(emoji)
        cache[emoji] = result
        return result
    }

    private static func compute(_ emoji: String) -> Double? {
        // A person or hand (any emoji that takes a skin tone): look past the skin to
        // the clothes or objects, if they have colour. Otherwise use everything.
        let isPerson = emoji.unicodeScalars.contains { $0.properties.isEmojiModifierBase }
        if isPerson, let hue = compute(emoji, skipSkin: true) { return hue }
        return compute(emoji, skipSkin: false)
    }

    private static func compute(_ emoji: String, skipSkin: Bool) -> Double? {
        let side = 64
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        let image = UIGraphicsImageRenderer(size: CGSize(width: side, height: side), format: format).image { _ in
            let text = emoji as NSString
            let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 52)]
            let size = text.size(withAttributes: attrs)
            text.draw(at: CGPoint(x: (CGFloat(side) - size.width) / 2, y: (CGFloat(side) - size.height) / 2),
                      withAttributes: attrs)
        }
        guard let cg = image.cgImage else { return nil }

        var pixels = [UInt8](repeating: 0, count: side * side * 4)
        guard let ctx = CGContext(data: &pixels, width: side, height: side, bitsPerComponent: 8,
                                  bytesPerRow: side * 4, space: CGColorSpaceCreateDeviceRGB(),
                                  bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else { return nil }
        ctx.draw(cg, in: CGRect(x: 0, y: 0, width: side, height: side))

        // Hue histogram, weighted by how colourful each pixel is, so a big grey or
        // white area doesn't win, and opposite hues (🍉's red and green) don't cancel.
        let bins = 36
        var weight = [Double](repeating: 0, count: bins)
        var sumA = [Double](repeating: 0, count: bins)
        var sumB = [Double](repeating: 0, count: bins)
        var opaque = 0.0
        for i in stride(from: 0, to: pixels.count, by: 4) {
            let alpha = Double(pixels[i + 3]) / 255
            guard alpha > 0.5 else { continue }
            opaque += 1
            let lab = OKLCH.lab(r: Double(pixels[i]) / 255 / alpha,
                                g: Double(pixels[i + 1]) / 255 / alpha,
                                b: Double(pixels[i + 2]) / 255 / alpha)
            let chroma = (lab.a * lab.a + lab.b * lab.b).squareRoot()
            guard chroma > 0.04 else { continue }
            var hue = atan2(lab.b, lab.a) * 180 / .pi
            if hue < 0 { hue += 360 }
            // Every skin tone, the default yellow included, sits between orange and yellow.
            if skipSkin, (35...105).contains(hue) { continue }
            let bin = min(Int(hue / 360 * Double(bins)), bins - 1)
            let w = chroma * chroma
            weight[bin] += w
            sumA[bin] += lab.a / chroma * w
            sumB[bin] += lab.b / chroma * w
        }
        // Past the skin, even small colourful parts (🏃's shoes) count.
        guard opaque > 0, weight.reduce(0, +) / opaque > (skipSkin ? 0.0003 : 0.0015) else { return nil }

        // The strongest window of three neighbouring bins, then its mean hue.
        var best = 0
        var bestWeight = -1.0
        for i in 0..<bins {
            let w = weight[(i + bins - 1) % bins] + weight[i] + weight[(i + 1) % bins]
            if w > bestWeight { bestWeight = w; best = i }
        }
        var a = 0.0, b = 0.0
        for j in [-1, 0, 1] {
            let k = (best + j + bins) % bins
            a += sumA[k]; b += sumB[k]
        }
        var hue = atan2(b, a) * 180 / .pi
        if hue < 0 { hue += 360 }
        return hue
    }
}
