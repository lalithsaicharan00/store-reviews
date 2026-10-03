import SwiftUI

/// One day, from a ring on Progress (report §7.4): what was planned and how each habit went, week goals logged that
/// day, and the day's notes. It never logs; "Show on Today" opens the day on Today, where logging happens.
struct ProgressDaySheet: View {
    let day: LocalDay
    /// The group Progress is showing; the sheet shows that group's habits (nil is All).
    var group: UUID? = nil
    let onShowOnToday: () -> Void
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        let detail = store.progressDayDetail(on: day, group: group)
        let groupName = group.flatMap { id in store.groups.first { $0.id == id }?.name }
        let calendar = store.calendar
        NavigationStack {
            List {
                Section {
                    Text(summary(detail)).font(.headline).monospacedDigit()
                        .accessibilityIdentifier("progress-day-summary")
                } header: {
                    if let groupName { Text(groupName) }
                }
                if let note = detail.dayNote {
                    Section("Note for the Day") { Text(note) }
                }
                if !detail.rows.isEmpty {
                    Section {
                        ForEach(detail.rows) { DayDetailRow(row: $0) }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle(day.date(calendar: calendar).formatted(.dateTime.weekday(.wide).day().month(.wide)))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) { Button("Done") { dismiss() } }
            }
            .safeAreaInset(edge: .bottom) {
                Button {
                    onShowOnToday()
                    dismiss()
                } label: {
                    Label("Show on Today", systemImage: "arrow.uturn.backward")
                        .font(.subheadline.weight(.semibold))
                        .padding(.horizontal, 6)
                        .frame(minHeight: 36)
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                .tint(Color.ink)
                .padding(.bottom, 8)
                .accessibilityIdentifier("progress-show-on-today")
            }
        }
        .presentationDetents([.medium, .large])
        .presentationBackground(Color(.systemGroupedBackground))
        .presentationDragIndicator(.visible)
    }

    /// "5 of 6 done · 1 part done"; today adds "so far".
    private func summary(_ detail: ProgressDayDetail) -> String {
        let score = detail.score
        guard score.planned > 0 else { return "Nothing was planned on this day." }
        var text = "\(score.done) of \(score.planned) done"
        if score.partCount > 0 { text += " · \(score.partCount) part done" }
        return detail.isToday ? text + " so far" : text
    }
}

/// "How It's Counted" (report §7.5): every number on Progress in a plain sentence, and the legend, so no number reads
/// as broken.
struct ProgressExplainer: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List {
                Section {
                    explain("Done", "Each habit you planned and finished that day. A habit you do 3 times a day counts once, when all 3 are done; until then its ring fills part of the way.")
                    explain("Percentage", "Done out of planned, for days up to today. Today counts once it's done.")
                    explain("Full days", "Days when everything you planned was done. In View Options you can count a day as full at 80% or 60% done instead.")
                    explain("Weekly goals met", "Weeks where you reached a “3 times a week” or “20 km a week” goal. The week in progress counts once it's met.")
                    explain("Weekly goals, day by day", "A day you log a weekly or monthly goal counts as done. Days you don't log it never count against you.")
                    explain("Limits", "A “no more than” habit counts when the day is over: within the limit is done, over it isn't. Today never counts yet.")
                    explain("What isn't counted", "Days that aren't one of a habit's days, skipped days, paused days, days before a habit started or after it was archived. None of these count for or against you.")
                    explain("Partial", "Some of the goal was reached. The ring fills part of the way; it isn't counted as done.")
                }
                Section("Marks") {
                    legend(.done, "Done")
                    legend(.some, "Partial", fraction: 0.5)
                    legend(.missed, "Not done")
                    legend(.open, "Today, still open")
                    legend(.missed, "Over the limit", over: true)
                    legend(.skipped, "Skipped")
                    legend(.paused, "Paused")
                    legend(.upcoming, "Coming up")
                    Text("Blank: not scheduled, or before it started").foregroundStyle(.secondary)
                }
            }
            .navigationTitle("How It's Counted")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) { Button("Done") { dismiss() } }
            }
        }
        .presentationDetents([.large])
    }

    private func explain(_ title: String, _ text: String) -> some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(title).font(.subheadline.weight(.semibold))
            Text(text).font(.subheadline).foregroundStyle(.secondary)
        }
        .padding(.vertical, 2)
        .accessibilityElement(children: .combine)
    }

    private func legend(_ mark: HabitStore.DayMark, _ name: String, fraction: Double = 0, over: Bool = false) -> some View {
        HStack(spacing: 12) {
            DayMarkView(mark: mark, fraction: fraction, over: over, color: .ink, size: 16).frame(width: 22)
            Text(name)
        }
        .accessibilityElement(children: .combine)
    }
}
