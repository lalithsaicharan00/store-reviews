import SwiftUI

/// One part's (or one checklist's) open state: nil follows Today's rule, true or false is the person's own choice.
/// A box per key, so changing one redraws only the view that reads that box, never all of Today (Build Plan #59).
@Observable final class FoldBox {
    var open: Bool?
}

/// Today's layout state that changes with taps but isn't data (Build Plan #58, #59; research "Ticking Off, Folding and
/// Small Settings", §2–3): which parts and checklists the person opened or folded, and whether done rows are being
/// held where they are.
///
/// **Holding.** Any log on Today holds every part's order and fold as last shown. Once the person pauses
/// (`pause` after the last log), done rows sink below the rest and finished parts fold, together, in one animation.
/// So nothing moves under a finger in the middle of a run of ticks, and a row finishes its fill and ✓ where it was
/// tapped (reviews: lists that move as you tick cause wrong taps; 10 of 243 read).
@Observable final class TodayLayout {
    /// How long Today waits after the last log before tidying: long enough for the next tick in a run, short enough
    /// that the list settles while the person is still looking (reasoned; research §2).
    static var pause: Duration {
        #if DEBUG
        // UI tests on GitHub's slow simulator take longer than 1.5 s between two taps, so they lengthen it
        // (`-today.settlePause 8`) to check that nothing moves before the pause.
        let seconds = UserDefaults.standard.double(forKey: "today.settlePause")
        if seconds > 0 { return .milliseconds(Int(seconds * 1000)) }
        #endif
        return .milliseconds(1500)
    }

    @ObservationIgnored private var boxes: [String: FoldBox] = [:]
    /// True from a log until the pause after the last one. Each part reads it, so the settle redraws the parts once.
    private(set) var holding = false
    /// Each part's rows and fold as last shown while not holding. Written while drawing, never observed.
    @ObservationIgnored var shownOrder: [String: [UUID]] = [:]
    @ObservationIgnored var shownOpen: [String: Bool] = [:]
    @ObservationIgnored private var release: Task<Void, Never>?

    func box(_ key: String) -> FoldBox {
        if let box = boxes[key] { return box }
        let box = FoldBox()
        boxes[key] = box
        return box
    }

    func steps(_ habit: UUID) -> FoldBox { box("steps-" + habit.uuidString) }

    /// The person opened or folded a part by hand.
    func setOpen(_ key: String, _ open: Bool, reduceMotion: Bool) {
        withAnimation(Motion.fold(reduceMotion)) { box(key).open = open }
    }

    /// Opens a part at once, without animation (revealing a new habit, a tapped notification).
    func open(_ key: String) {
        let box = box(key)
        if box.open != true { box.open = true }
    }

    /// Another day: every part follows the rule again, and nothing is held.
    func reset() {
        release?.cancel()
        release = nil
        if holding { holding = false }
        for (key, box) in boxes where !key.hasPrefix("steps-") && box.open != nil { box.open = nil }
    }

    /// A log on Today (a tick, +, a timer stopped, a sheet closed after logging, an undo): hold the order and folds,
    /// and tidy once the person pauses. Call it before the change, so the redraw it causes already holds.
    func hold(reduceMotion: Bool) {
        if !holding { holding = true }
        release?.cancel()
        release = Task { @MainActor [weak self] in
            try? await Task.sleep(for: TodayLayout.pause)
            guard !Task.isCancelled, let self else { return }
            withAnimation(Motion.settle(reduceMotion)) { self.holding = false }
        }
    }

    /// The rows to show for a part. `fresh` is the order Today's rule gives now; while holding, the order last shown
    /// is kept (with any row that's new since put at the end), so nothing moves until the pause.
    func order<Item: Identifiable>(_ part: String, fresh: [Item]) -> [Item] where Item.ID == UUID {
        guard holding, let shown = shownOrder[part] else {
            shownOrder[part] = fresh.map(\.id)
            return fresh
        }
        var byID: [UUID: Item] = [:]
        for item in fresh where byID[item.id] == nil { byID[item.id] = item }
        let kept = shown.compactMap { byID.removeValue(forKey: $0) }
        return kept + fresh.filter { byID[$0.id] != nil }
    }

    /// Whether a part is open. The person's own choice wins; otherwise Today's rule, except that while holding a part
    /// keeps the fold it was shown with (a part whose last habit was just ticked folds after the pause, not under the
    /// finger).
    func isOpen(_ part: String, rule: Bool) -> Bool {
        if let open = box(part).open { return open }
        if holding, let shown = shownOpen[part] { return shown }
        shownOpen[part] = rule
        return rule
    }
}
