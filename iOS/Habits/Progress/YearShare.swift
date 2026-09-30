import SwiftUI
import UniformTypeIdentifiers

/// A shareable picture of a year (report §25.1 Phase 3; users ask for a picture reviewing the whole year). Drawn
/// only when shared, from the year's own numbers, with no names of habits on it. Free, like every statistic.
nonisolated struct YearShareItem: Transferable {
    let title: String
    let summary: String
    let dots: YearDots
    /// Month letters, in grid order.
    let letters: [String]

    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(exportedContentType: .png) { item in
            let data = await MainActor.run { item.png() }
            guard let data else { throw CocoaError(.fileWriteUnknown) }
            return data
        }
        .suggestedFileName { "Year \($0.title).png" }
    }

    /// The picture as PNG data, at 3× for a sharp share.
    @MainActor func png() -> Data? {
        let renderer = ImageRenderer(content: YearShareCard(item: self))
        renderer.scale = 3
        return renderer.uiImage?.pngData()
    }
}

/// The picture: the year, its grid of days and one line of numbers, in the app's own ink on white.
struct YearShareCard: View {
    let item: YearShareItem

    var body: some View {
        let dot: CGFloat = 7, gap: CGFloat = 2
        let step = dot + gap
        VStack(alignment: .leading, spacing: 12) {
            Text(item.title).font(.system(size: 34, weight: .bold))
            ZStack(alignment: .topLeading) {
                ForEach(Array(zip(item.dots.months, item.letters)), id: \.0.id) { month, letter in
                    Text(letter).font(.system(size: 11, weight: .semibold)).foregroundStyle(.secondary)
                        .offset(x: CGFloat(month.column) * step)
                }
            }
            .frame(width: CGFloat(item.dots.columns) * step, height: 14, alignment: .topLeading)
            ZStack(alignment: .topLeading) {
                DotCells(cells: item.dots.full, dot: dot, gap: gap).fill(Color.black.opacity(0.85))
                DotCells(cells: item.dots.high, dot: dot, gap: gap).fill(Color.black.opacity(0.55))
                DotCells(cells: item.dots.low, dot: dot, gap: gap).fill(Color.black.opacity(0.3))
                DotCells(cells: item.dots.ring, dot: dot, gap: gap).stroke(Color.black.opacity(0.35), lineWidth: 1)
            }
            .frame(width: CGFloat(item.dots.columns) * step, height: 7 * step, alignment: .topLeading)
            Text(item.summary).font(.system(size: 17, weight: .medium)).foregroundStyle(.secondary)
        }
        .padding(28)
        .background(Color.white)
        .environment(\.colorScheme, .light)
    }
}

extension HabitStore {
    /// The share picture's item for a Year snapshot; nil for other ranges.
    func yearShareItem(_ snapshot: ProgressSnapshot) -> YearShareItem? {
        guard snapshot.range == .year, let dots = snapshot.yearDots else { return nil }
        let letters = dots.months.map { $0.first.date(calendar: calendar).formatted(.dateTime.month(.narrow)) }
        let tally = snapshot.tally
        let summary = tally.planned == 0 ? "Nothing planned yet"
            : "\(tally.done) of \(tally.planned) done · \(tally.fullDays == 1 ? "1 full day" : "\(tally.fullDays) full days")"
        return YearShareItem(title: snapshot.title, summary: summary, dots: dots, letters: letters)
    }
}
