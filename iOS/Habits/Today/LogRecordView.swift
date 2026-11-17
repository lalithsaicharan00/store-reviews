import SwiftUI

/// One saved record: view first, then edit (Figma's Log screen, View; Rulebook U19). A log row opens **Log** (a slip
/// **Slip**): Back and Edit in the bar; one card with the habit and When ("Today  2:05 PM", plain words: only being
/// viewed); the value (an amount as one large number, a session as "2 min 42 s"); where it came from; and **Delete Log**
/// as a red row of its own, asking first in iOS's alert. **Edit** switches to **Edit Log** / **Edit Slip**: ✕ and Save in
/// the bar, ✕ asking first if anything changed; the time is iOS's compact picker inside that log's own day; an amount
/// has the keyboard with its number selected, a session the wheel. Only this record changes: other logs, the note and a skip stay.
/// The day never changes here: moving a log to another day needs the same record moved between days atomically, which
/// doesn't exist yet (D7).
struct LogRecordView: View {
    let habit: Habit
    let entryID: UUID
    /// The day the log belongs to, for finding it.
    let day: LocalDay
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var editing = false
    @State private var draft = ProgressValueDraft(kind: .check)
    @State private var time = Date.distantPast
    @State private var confirmingDelete = false
    @State private var confirmingDiscard = false
    @State private var room = ScreenRoom()
    @FocusState private var focus: RecordField?
    @ScaledMetric(relativeTo: .largeTitle) private var numberSize = CustomText.amountSize

    init(habit: Habit, entry: Entry) {
        self.habit = habit
        self.entryID = entry.id
        self.day = entry.day
    }

    private var isSlip: Bool { habit.kind == .quit }
    private var noun: String { isSlip ? "slip" : "log" }

    var body: some View {
        // Speed runs count how often the whole screen is drawn: once per letter typed would be the S11 mistake.
        let _ = perfTimed("Entry editor: whole editor drawn") { () }
        if let entry = store.entries(of: habit.id, on: day).first(where: { $0.id == entryID }) {
            content(entry)
        } else {
            // Deleted: nothing to show. Never dismissed from here: the row that opened it has gone too, and SwiftUI
            // takes the screen away with it; a second dismiss closed Day details itself (CI, 7 Oct 2026).
            Color(.systemGroupedBackground)
        }
    }

    private func content(_ entry: Entry) -> some View {
        let c = store.recordingCalendar(for: entry)
        let ruled = store.rule(habit, on: entry.day)
        let timed = ruled.kind == .duration
        let gaps = room.gaps(typing: editing && focus != nil)
        return Form {
            Section {
                RecordHabitRow(habit: habit)
                // The day stays the log's own: moving a log to another day isn't built (D7).
                LabeledContent(timed ? "Finished" : "When") {
                    HStack(spacing: 8) {
                        Text(dayWord(entry)).accessibilityIdentifier("record-date")
                        if editing {
                            DatePicker("Time", selection: $time, in: timeRange(entry), displayedComponents: .hourAndMinute)
                                .labelsHidden()
                                .environment(\.calendar, c).environment(\.timeZone, c.timeZone)
                                .accessibilityIdentifier("record-time")
                        } else {
                            Text(store.clockText(of: entry)).accessibilityIdentifier("record-time")
                        }
                    }
                }
            } footer: {
                if isSlip { footer(entry) }
            }
            valueSection(entry, ruled: ruled, gaps: gaps)
            if !editing {
                Section {
                    Button(isSlip ? "Delete Slip" : "Delete Log", role: .destructive) {
                        focus = nil
                        confirmingDelete = true
                    }
                    .foregroundStyle(.red)
                    .accessibilityIdentifier("record-delete")
                }
            }
        }
        .contentMargins(.top, gaps.top, for: .scrollContent)
        .listSectionSpacing(gaps.section)
        .selectsNumbersOnFocus()
        .scrollDismissesKeyboard(.interactively)
        .measuresRoom($room)
        .analyticsScreen(nil)
        // The back control is the chevron alone (the user, 4 Oct 2026).
        .backChevronOnly()
        .navigationTitle(editing ? (isSlip ? "Edit Slip" : "Edit Log") : (isSlip ? "Slip" : "Log"))
        .navigationBarTitleDisplayMode(.inline)
        // In edit mode ✕ replaces the back chevron, and the edge swipe can't throw the draft away.
        .navigationBarBackButtonHidden(editing)
        .toolbar {
            if editing {
                ToolbarItem(placement: .cancellationAction) {
                    RecordCancelButton {
                        focus = nil
                        if changed(entry) { confirmingDiscard = true } else { editing = false }
                    }
                }
                // Always on (never a greyed-out Save, U19): a value that can't be saved says why in the footer.
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { save(entry) }.accessibilityIdentifier("record-save")
                }
            } else {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Edit") { startEditing(entry) }.accessibilityIdentifier("record-edit")
                }
            }
        }
        // Figma's Alert, Destructive: iOS's own, naming the one record and what stays.
        .alert("Delete this \(noun)?", isPresented: $confirmingDelete) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
                // Back first, then the log goes, once the screen has left: removing it first also removed the row this
                // screen was opened from, SwiftUI took the screen away for that, and this dismiss then closed Day
                // details as well (CI, 7 Oct 2026). The write follows as for any change (S7).
                dismiss()
                let id = entry.id
                Task { @MainActor in
                    try? await Task.sleep(for: .milliseconds(450))
                    store.undoEntry(id)
                }
            }
        } message: {
            Text(deleteMessage(entry, ruled: ruled))
        }
        // The app's own question for leaving with changes (U19), as an alert: a dialog anchored to the toolbar
        // sometimes never appeared (CI, 5 Oct 2026).
        .alert("Discard your changes to this \(noun)?", isPresented: $confirmingDiscard) {
            Button("Keep Editing", role: .cancel) {}
            Button("Discard", role: .destructive) { editing = false }
        } message: {
            Text("The \(noun) stays as it was.")
        }
        .onPerfCommand { action in
            switch action {
            case .editEntry: startEditing(entry)
            case .saveEntry: if editing { save(entry) }
            default: break
            }
        }
    }

    // MARK: The value

    @ViewBuilder private func valueSection(_ entry: Entry, ruled: Habit, gaps: ScreenRoom.Gaps) -> some View {
        switch ruled.kind {
        case .quit:
            EmptyView()
        case .duration:
            Section {
                if editing {
                    // Seconds only on a log that has them (a timer's), so editing never drops them.
                    DurationWheel(draft: draft, showsSeconds: (Double(draft.seconds) ?? 0) > 0)
                        .frame(height: 216)
                        .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                } else {
                    DurationText(minutes: entry.value).padding(.vertical, 6)
                }
            } header: {
                Text("How long")
            } footer: {
                footer(entry)
            }
        default:
            let check = ruled.kind == .check
            let raw = check ? (ruled.checkUnit ?? "checks") : HabitCopy.unit(of: ruled).trimmingCharacters(in: .whitespaces)
            let currency = HabitCopy.currencies.contains(raw) ? raw : nil
            Section {
                VStack(spacing: 2) {
                    if editing {
                        AmountNumberField(draft: draft, currency: currency, size: min(numberSize, gaps.numberSize),
                                          keyboard: check ? .numberPad : .decimalPad, focus: $focus,
                                          label: raw.isEmpty || currency != nil ? "Amount" : "Amount, in \(raw)")
                        if currency == nil && !raw.isEmpty { AmountUnitLine(draft: draft, unit: raw, compact: gaps.cardPadding == 0) }
                    } else {
                        Text((currency ?? "") + HabitCopy.number(entry.value))
                            .font(CustomText.amount(min(numberSize, gaps.numberSize)))
                            .lineLimit(1).minimumScaleFactor(0.5)
                            .accessibilityLabel(check ? HabitCopy.amount(entry.value, raw) : entry.description(for: ruled))
                            .accessibilityIdentifier("record-value")
                        if currency == nil && !raw.isEmpty {
                            Text(HabitCopy.unitWord(entry.value, raw)).font(.body).foregroundStyle(.secondary)
                                .accessibilityHidden(true)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, gaps.cardPadding)
            } header: {
                Text(check ? "Checks" : "Amount")
            } footer: {
                footer(entry)
            }
        }
    }

    /// The view says where the log came from; edit mode says why a value can't be saved, or what changes.
    @ViewBuilder private func footer(_ entry: Entry) -> some View {
        if editing {
            if let problem = draft.problem {
                Text(problem).foregroundStyle(.red).accessibilityIdentifier("record-problem")
            } else {
                Text(isSlip ? "Changing the time updates your quit run." : "Only this \(noun) changes. Other logs stay as they are.")
            }
        } else if let origin = entry.originLine(slip: isSlip) {
            Text(origin).accessibilityIdentifier("record-origin")
        }
    }

    // MARK: Editing

    /// Inside the log's own day as the app counts it, in the zone it was recorded in; never later than now (or than
    /// the time it already has); a slip never before its quit run began.
    private func timeRange(_ entry: Entry) -> ClosedRange<Date> {
        let bounds = store.dayBounds(entry.day, calendar: store.recordingCalendar(for: entry))
        var lower = bounds.lowerBound
        if isSlip { lower = max(lower, min(habit.quitSince ?? habit.createdAt, habit.createdAt)) }
        lower = min(lower, entry.createdAt)
        let upper = max(lower, min(bounds.upperBound, max(store.clock(), entry.createdAt)))
        return lower...upper
    }

    private func startEditing(_ entry: Entry) {
        draft = ProgressValueDraft(kind: store.rule(habit, on: entry.day).kind, value: entry.value)
        time = entry.createdAt
        editing = true
        // An amount has the keyboard, its number selected, so typing replaces it; a session is the wheel.
        switch store.rule(habit, on: entry.day).kind {
        case .quit, .duration: break
        default: focus = .amount
        }
    }

    private func changed(_ entry: Entry) -> Bool { draft.differs || time != entry.createdAt }

    private func save(_ entry: Entry) {
        guard changed(entry) else { focus = nil; editing = false; return }
        guard let value = isSlip ? 1 : draft.value else {
            // Nothing saved; the footer says why (never a greyed-out Save).
            if draft.problem == nil, !isSlip, store.rule(habit, on: entry.day).kind != .duration { focus = .amount }
            return
        }
        focus = nil
        store.editEntry(entry.id, value: value, at: time != entry.createdAt ? time : nil)
        editing = false
    }

    /// Names the one record and its day, and says what stays (row 18 of the design).
    private func deleteMessage(_ entry: Entry, ruled: Habit) -> String {
        let clock = store.clockText(of: entry)
        if isSlip { return "The slip at \(clock) will be removed, and your quit run is worked out again." }
        let from = entry.day == store.today() ? "today" : DayWords.short(entry.day, calendar: store.calendar).replacingOccurrences(of: ",", with: "")
        return "\(entry.description(for: ruled)) at \(clock) will be removed from \(from). Your other logs stay."
    }

    /// "Today", "Yesterday", or the date: the log's day in words, beside its time.
    private func dayWord(_ entry: Entry) -> String {
        DayWords.relative(entry.day, today: store.today(), calendar: store.calendar)
            ?? DayWords.short(entry.day, calendar: store.calendar).replacingOccurrences(of: ",", with: "")
    }
}

/// All logs: every log of one day, newest first, one line each, pushed inside Day details from "All N logs ›"
/// (design decisions §5). A tap opens the Log view; a check keeps its own Undo. No swipe to delete (U14), no add button,
/// no Close. With no logs left it goes back to Day details.
struct AllLogsView: View {
    let habit: Habit
    let day: LocalDay
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        let ruled = store.rule(habit, on: day)
        let logs = store.dayLogs(of: habit, on: day)
        List {
            Section {
                ForEach(logs) { entry in
                    DayLogRow(entry: entry, habit: ruled)
                }
            } footer: {
                Text(Self.total(logs, habit: ruled)).accessibilityIdentifier("all-logs-footer")
            }
        }
        // The list starts just under the bar, as Figma draws it: with no header, iOS's own first gap is empty room.
        .contentMargins(.top, 4, for: .scrollContent)
        .accessibilityIdentifier("all-logs")
        .analyticsScreen(nil)
        .backChevronOnly()
        .navigationTitle(DayLogRow.title(ruled, day: day, store: store))
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: logs.isEmpty) { _, empty in if empty { dismiss() } }
    }

    /// "4 glasses in all. Tap a log to change or delete it."
    static func total(_ logs: [Entry], habit: Habit) -> String {
        let sum = logs.reduce(0) { $0 + $1.value }
        switch habit.kind {
        case .amount(let unit, _): return HabitCopy.amount(sum, unit) + " in all. Tap a log to change or delete it."
        case .duration: return Format.minutes(sum) + " in all. Tap a log to change or delete it."
        case .quit: return "Tap a slip to change or delete it."
        case .check where logs.contains { $0.value != 1 }:
            return HabitCopy.amount(sum, habit.checkUnit ?? "checks") + " in all. Undo takes back that one check."
        default: return "Undo takes back that one check."
        }
    }
}

/// One log on one line: what it was on the left, its time on the right, then a chevron to its Log view, or, for a single
/// check, its own named Undo (U19). Day details and All logs share it.
struct DayLogRow: View {
    let entry: Entry
    let habit: Habit
    @Environment(HabitStore.self) private var store

    var body: some View {
        if entry.opensRecord(for: habit) {
            NavigationLink {
                LogRecordView(habit: habit, entry: entry)
            } label: {
                line
            }
            .accessibilityIdentifier("entry-\(entry.id)")
        } else {
            HStack(spacing: 12) {
                line
                Button("Undo") { store.undoEntry(entry.id) }
                    .fontWeight(.semibold)
                    .buttonStyle(.borderless)
                    .accessibilityLabel(entry.undoSpoken(for: habit) + " at " + store.clockText(of: entry))
                    .accessibilityIdentifier("undo-entry-\(entry.id)")
            }
        }
    }

    private var line: some View {
        HStack(spacing: 12) {
            Text(entry.description(for: habit)).foregroundStyle(.primary).lineLimit(1)
            Spacer(minLength: 8)
            Text(store.clockText(of: entry)).foregroundStyle(.secondary).monospacedDigit().lineLimit(1)
        }
        // 44-pt rows, as designed: the list's own insets made them 51 on iOS 26 (measured on the SE, 7 Oct 2026). The
        // same trim as Today's step rows.
        .padding(.vertical, -4)
        .accessibilityElement(children: .combine)
    }

    /// "Today's logs", "Checks today", "Slips today"; "Logs for Tue 6 Oct" on another day.
    static func title(_ habit: Habit, day: LocalDay, store: HabitStore) -> String {
        let isToday = day == store.today()
        let short = DayWords.short(day, calendar: store.calendar).replacingOccurrences(of: ",", with: "")
        switch habit.kind {
        case .quit: return isToday ? "Slips Today" : "Slips on " + short
        case .check: return isToday ? "Checks Today" : "Checks on " + short
        default: return isToday ? "Today’s Logs" : "Logs for " + short
        }
    }

    /// "4 logs", "1 check", "2 slips": the list's own noun.
    static func count(_ n: Int, habit: Habit) -> String {
        let noun: String
        switch habit.kind {
        case .quit: noun = n == 1 ? "slip" : "slips"
        case .check: noun = n == 1 ? "check" : "checks"
        default: noun = n == 1 ? "log" : "logs"
        }
        return "\(n) \(noun)"
    }
}
