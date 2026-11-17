import SwiftUI

// MARK: - Text styles
//
// Every text style in Figma's "03 · Text styles" is Apple's own (`iOS/Large Title/Regular` … `iOS/Caption 2/Semibold`,
// and `iOS/Accessibility 1/…`, which is the same style at a larger text size): the app writes `.font(.body)`,
// `.font(.subheadline.weight(.semibold))` and so on, and iOS gives the size, line height and Dynamic Type. Nothing of
// ours stands in for them.
//
// Apple has no style for the two below (Figma's `iOS/Custom/…`), so they are defined here, once. Each grows with the
// person's text size like the Apple style it follows, up to a cap that keeps it on the screen.

enum CustomText {
    /// `iOS/Custom/Clock`: SF Pro Rounded Medium 36 (an amount in the routine player). Grows with Title.
    static let clockSize: CGFloat = 36
    static let clockMaxSize: CGFloat = 52

    /// Figma's Timer ring: SF Pro Light 64, tabular figures, the timer's elapsed time. Grows with Large Title, never
    /// past `timerMaxSize`; an hour-long clock shrinks to fit the ring.
    static let timerSize: CGFloat = 64
    static let timerMaxSize: CGFloat = 80

    /// `iOS/Custom/Amount`: SF Pro Bold 56, the typed amount on Log, How Much and Limit. Grows with Large Title;
    /// a screen may cap it lower where room is short (`RecordParts.Gaps.numberSize`).
    static let amountSize: CGFloat = 56

    /// The clock at `scaled` (an `@ScaledMetric` of `clockSize`), never past `clockMaxSize`.
    static func clock(_ scaled: CGFloat) -> Font {
        .system(size: min(scaled, clockMaxSize), weight: .medium, design: .rounded).monospacedDigit()
    }

    /// The timer's clock at `scaled` (an `@ScaledMetric` of `timerSize`), never past `timerMaxSize`.
    static func timer(_ scaled: CGFloat) -> Font {
        .system(size: min(scaled, timerMaxSize), weight: .light).monospacedDigit()
    }

    /// The amount's face at `size`; How long's Hours, Minutes and Seconds boxes use it at their own, smaller size.
    static func amount(_ size: CGFloat) -> Font {
        .system(size: size, weight: .bold).monospacedDigit()
    }
}
