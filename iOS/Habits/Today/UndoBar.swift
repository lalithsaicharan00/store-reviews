import SwiftUI

/// "Water: +1 glass · Undo", at the bottom of Today for a few seconds after a tap logs something (report "Undo After
/// Logging", 29 Sep). Users show undo must be a visible button (shake-to-undo and long-press-only undo are the
/// complaints), must take back exactly the wrong entry rather than reset the day, and must never become a question
/// before every tap. The same pill as the routine player's "saved · Undo".
struct UndoBar: View {
    let offer: HabitStore.UndoOffer
    @Environment(HabitStore.self) private var store

    /// Long enough to notice a wrong tap (a bar that vanished too fast is a complaint too); longer with VoiceOver.
    private var shownFor: Duration { UIAccessibility.isVoiceOverRunning ? .seconds(20) : .seconds(6) }

    var body: some View {
        HStack(spacing: 12) {
            if let milestone = offer.milestone {
                // A milestone this tap reached: its words on top, what was logged under them. No pop-up, sound or
                // confetti, and the next tap is never in the way (Milestones, 30 Sep).
                Label {
                    VStack(alignment: .leading, spacing: 1) {
                        Text(milestone).font(.subheadline.weight(.semibold))
                        Text(offer.text).font(.caption).foregroundStyle(.secondary)
                    }
                    .lineLimit(1)
                } icon: {
                    Image(systemName: "checkmark.seal.fill").foregroundStyle(.orange)
                }
                .accessibilityIdentifier("today-milestone")
            } else {
                Label(offer.text, systemImage: "checkmark.circle")
                    .font(.subheadline)
                    .lineLimit(1)
            }
            Spacer(minLength: 8)
            Button("Undo") { store.undo(offer) }
                .font(.subheadline.weight(.semibold))
                .frame(minWidth: 44, minHeight: 44)
                .contentShape(Rectangle())
                .accessibilityIdentifier("today-undo")
        }
        .padding(.leading, 16)
        .padding(.trailing, 8)
        .padding(.vertical, offer.milestone == nil ? 0 : 4)
        .frame(minHeight: 44)
        // A solid pill with a soft shadow, as in the player: a material one vanished on the light background.
        .background(Capsule().fill(Color(.secondarySystemGroupedBackground)).shadow(color: .black.opacity(0.12), radius: 8, y: 2))
        .padding(.horizontal, 16)
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("undo-bar")
        .onAppear {
            let said = offer.milestone.map { "\($0). \(offer.text)" } ?? offer.text
            AccessibilityNotification.Announcement("\(said). Undo available.").post()
        }
        .task(id: offer.id) {
            try? await Task.sleep(for: shownFor)
            if store.undoOffer?.id == offer.id { withAnimation(.snappy) { store.undoOffer = nil } }
        }
    }
}
