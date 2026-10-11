import AppIntents
import Foundation
import WidgetKit

/// A complication's ✓ or + (E2): the face changes at once to the app's own "after one tap" card (`WidgetItem.after`,
/// worked out by the app, U26), and the tap is written to the waiting-taps file the app shares (the iPhone's
/// `WidgetTaps`, the same format). The Watch app saves waiting taps, in order and each once (a + by its own ID, a ✓ as
/// the state it set), whenever it runs: on opening, on its background refresh (about four an hour with a complication
/// on the face), and when the iPhone's changes wake it. The tap is on disk from the moment it's made, never lost.
/// The system asks first when the tap may be accidental (`requestConfirmation`, `.lowConfidenceSource`).
struct WatchTapIntent: AppIntent {
    static let title: LocalizedStringResource = "Log from the watch face"
    static let isDiscoverable = false

    @Parameter(title: "Item") var item: String
    @Parameter(title: "Day") var day: String
    @Parameter(title: "Signature") var signature: String
    @Parameter(title: "Name") var name: String

    init() {}

    init(item: String, day: String, signature: String, name: String) {
        self.item = item
        self.day = day
        self.signature = signature
        self.name = name
    }

    func perform() async throws -> some IntentResult {
        try await requestConfirmation(conditions: .lowConfidenceSource, actionName: .add,
                                      dialog: IntentDialog(stringLiteral: name.isEmpty ? "Log this?" : "Log \(name)?"))
        guard let mode = WidgetDisk.applyTap(itemID: item, day: day, signature: signature) else { return .result() }
        WidgetTaps.append(WidgetTap(event: UUID().uuidString, item: item, day: day, mode: mode, signature: signature, at: .now))
        WidgetCenter.shared.reloadAllTimelines()
        return .result()
    }
}
