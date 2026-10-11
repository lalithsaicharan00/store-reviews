import SwiftUI
import WidgetKit

/// Test launches only (`-face-gallery`): the watch face's complications drawn in the app, at their real sizes, from the
/// snapshot the app works out now (`HabitStore.widgetSnapshot`, as `WidgetPublisher` writes it) and the same views the
/// complications use (WatchShared/FaceViews.swift). XCUITest can't photograph a watch face; this lets the screenshot
/// review check what each family shows (E1–E5, G7). The real face is checked on the user's Apple Watch (U9).
struct FaceGallery: View {
    @Environment(HabitStore.self) private var store

    var body: some View {
        let now = Date.now
        var snapshot = store.widgetSnapshot(now: now)
        if HideNames.isOn { snapshot = snapshot.withoutNames() }
        let frame = snapshot.frame(at: now)
        let entry = FaceEntry(date: now, snapshot: snapshot, frame: frame)
        let first = entry.today.first(where: { $0.type == "amount" || $0.type == "count" })?.id
        let check = entry.today.first(where: { $0.type == "check" })?.id
        let quit = frame?.items.first(where: { $0.type == "quit" })?.id
        return ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Watch face").font(.headline)
                tile(TodayFace(entry: entry, family: .accessoryRectangular), width: 170, height: 58)
                HStack(spacing: 6) {
                    ForEach([first, check, quit].compactMap { $0 }, id: \.self) { id in
                        tile(HabitFace(entry: FaceEntry(date: now, snapshot: snapshot, frame: frame, habitID: id), family: .accessoryCircular),
                             width: 50, height: 50, round: true)
                    }
                }
                tile(TodayFace(entry: entry, family: .accessoryInline), width: 170, height: 22)
                Text("Log from the face").font(.headline)
                tile(LogFace(entry: entry), width: 170, height: 58)
                Text("Smart Stack").font(.headline)
                tile(TodayFace(entry: entry, family: .accessoryRectangular), width: 170, height: 58)
                tile(HabitFace(entry: FaceEntry(date: now, snapshot: snapshot, frame: frame, habitID: first), family: .accessoryRectangular),
                     width: 170, height: 58)
                tile(TodayFace(entry: entry, family: .accessoryCircular), width: 50, height: 50, round: true)
            }
            .padding(.horizontal, 4)
        }
        .accessibilityIdentifier("face-gallery")
    }

    private func tile(_ content: some View, width: CGFloat, height: CGFloat, round: Bool = false) -> some View {
        content
            .frame(width: width, height: height)
            .padding(4)
            .background(RoundedRectangle(cornerRadius: round ? 30 : 12).fill(Color.white.opacity(0.08)))
    }
}
