import SwiftUI

/// One group chip: "● Health 5". Chosen chips are filled; a group with nothing that day is quieter; an empty group is
/// a hollow dot and "–" (report 18).
struct GroupChip: View {
    enum Look { case normal, quiet, empty }
    let title: String
    var color: HabitColor?
    var count: String?
    var selected = false
    var look: Look = .normal
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                if let color {
                    Circle()
                        .fill(look == .empty ? Color.clear : color.color)
                        .overlay { Circle().strokeBorder(color.color, lineWidth: 1.5) }
                        .frame(width: 9, height: 9)
                }
                Text(title).lineLimit(1)
                if let count {
                    Text(count).monospacedDigit()
                        .foregroundStyle(selected ? Color.onInk.opacity(0.8) : .secondary)
                }
            }
            .font(.subheadline.weight(selected ? .semibold : .regular))
            .foregroundStyle(selected ? Color.onInk : look == .normal ? Color.primary : Color.secondary)
            .padding(.horizontal, 12)
            .frame(minHeight: 34)
            .background(selected ? Color.ink : Color(.tertiarySystemFill), in: Capsule())
            .contentShape(Capsule())
        }
        .buttonStyle(.plain)
        .frame(minHeight: 44)
        .accessibilityAddTraits(selected ? .isSelected : [])
    }
}

/// "+ New Group": dashed, so it's never mistaken for a group to filter by (report 17).
struct NewGroupChip: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Label("New Group", systemImage: "plus")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding(.horizontal, 12)
                .frame(minHeight: 34)
                .overlay(Capsule().strokeBorder(Color.secondary.opacity(0.6), style: StrokeStyle(lineWidth: 1, dash: [4, 3])))
                .contentShape(Capsule())
        }
        .buttonStyle(.plain)
        .frame(minHeight: 44)
        .accessibilityIdentifier("group-new")
    }
}

/// The chip row: All, then the groups in their order, empty groups last. Counts are optional (Progress has none).
struct GroupChipRow: View {
    /// The chosen group; nil is All.
    let selection: UUID?
    /// Each group's count for the chips ("5", "0"); nil hides the numbers. A group missing from it is empty ("–").
    var counts: [UUID?: Int]?
    var showNew = false
    let onSelect: (UUID?) -> Void
    var onEmpty: ((HabitGroup) -> Void)?
    var onNew: (() -> Void)?
    @Environment(HabitStore.self) private var store

    var body: some View {
        let groups = store.groups
        let full = counts.map { counts in groups.filter { counts[$0.id] != nil } } ?? groups
        let empty = counts == nil ? [] : groups.filter { counts?[$0.id] == nil }
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                GroupChip(title: "All", count: counts?[UUID?.none].map(String.init), selected: selection == nil) { onSelect(nil) }
                    .accessibilityLabel(counts?[UUID?.none].map { "All, \($0) " + ($0 == 1 ? "habit" : "habits") } ?? "All")
                    .accessibilityIdentifier("group-chip-all")
                ForEach(full) { group in
                    let n = counts?[group.id]
                    GroupChip(title: group.name, color: group.color, count: n.map(String.init), selected: selection == group.id,
                              look: n == 0 ? .quiet : .normal) { onSelect(group.id) }
                        .accessibilityLabel(group.name + (n.map { ", \($0) " + ($0 == 1 ? "habit" : "habits") } ?? ""))
                        .accessibilityIdentifier("group-chip-\(group.name)")
                }
                ForEach(empty) { group in
                    GroupChip(title: group.name, color: group.color, count: "–", look: .empty) { onEmpty?(group) }
                        .accessibilityLabel("\(group.name), no habits yet")
                        .accessibilityHint("Opens the group to add habits")
                        .accessibilityIdentifier("group-chip-\(group.name)")
                }
                if showNew, let onNew { NewGroupChip(action: onNew) }
            }
            .padding(.vertical, 2)
        }
        .scrollClipDisabled()
    }
}
