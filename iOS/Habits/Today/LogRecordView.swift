import SwiftUI

/// One saved record: view first, then edit (7 October 2026 redesign; Rulebook U19). A log row opens **Log** (a slip
/// **Slip**): one card with Habit, Date (fixed) and Time; the value (an amount as one large number, a session's
/// hours, minutes and seconds, a slip's time zone); "Logged with …"; and **Delete log | Edit** at the bottom. **Edit**
/// switches to **Edit log** / **Edit slip**: ✕ leaves edit mode (asking first if anything changed), the time becomes a
/// picker inside that log's own day, the value has the keyboard with the number selected, and **Save**, always on,
/// sits above the keyboard and returns to the view. Only this record changes: other logs, the note and a skip stay.
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
    @ScaledMetric(relativeTo: .largeTitle) private var numberSize: CGFloat = 48
    @ScaledMetric(relativeTo: .title) private var durationSize: CGFloat = 32

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
                LabeledContent("Date", value: DayWords.withDate(entry.day, today: store.today(), calendar: store.calendar))
                    .accessibilityIdentifier("record-date")
                if editing {
                    DatePicker(timed ? "Finished at" : "Time", selection: $time, in: timeRange(entry), displayedComponents: .hourAndMinute)
                        .environment(\.calendar, c).environment(\.timeZone, c.timeZone)
                        .accessibilityIdentifier("record-time")
                } else {
                    LabeledContent(timed ? "Finished at" : "Time", value: store.clockText(of: entry))
                        .accessibilityIdentifier("record-time")
                }
                if isSlip {
                    LabeledContent("Time zone", value: c.timeZone.localizedName(for: .generic, locale: .current) ?? entry.timeZone)
                }
            } footer: {
                if isSlip { footer(entry) }
            }
            valueSection(entry, ruled: ruled, gaps: gaps)
        }
        .contentMargins(.top, gaps.top, for: .scrollContent)
        .listSectionSpacing(gaps.section)
        .selectsNumbersOnFocus()
        .scrollDismissesKeyboard(.interactively)
        .measuresRoom($room)
        .analyticsScreen(nil)
        // The back control is the chevron alone (the user, 4 Oct 2026).
        .toolbarRole(.editor)
        .navigationTitle(editing ? "Edit \(noun)" : (isSlip ? "Slip" : "Log"))
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
            }
        }
        .safeAreaInset(edge: .bottom) {
            RecordBottomBar {
                if editing {
                    DayButton("Save", prominent: true, id: "record-save") { save(entry) }
                } else {
                    RecordDeleteButton(title: "Delete \(noun)", id: "record-delete") { focus = nil; confirmingDelete = true }
                    DayButton("Edit", prominent: true, id: "record-edit") { startEditing(entry) }
                }
            }
        }
        .alert("Delete this \(noun)?", isPresented: $confirmingDelete) {
            Button("Cancel", role: .cancel) {}
            Button(isSlip ? "Delete Slip" : "Delete Log", role: .destructive) {
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
            Button("Discard Changes", role: .destructive) { editing = false }
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
                    DurationFields(draft: draft, size: min(durationSize, 44), focus: $focus).padding(.vertical, 6)
                } else {
                    DurationBoxes(minutes: entry.value, size: min(durationSize, 44)).padding(.vertical, 6)
                }
            } header: {
                Text("How long")
            } footer: {
                if !editing || draft.problem != nil || focus == nil || room.keepsFooterWhileTyping { footer(entry) }
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
                            .font(.system(size: min(numberSize, gaps.numberSize), weight: .bold).monospacedDigit())
                            .lineLimit(1).minimumScaleFactor(0.5)
                            .accessibilityLabel(check ? HabitCopy.amount(entry.value, raw) : entry.description(for: ruled))
                            .accessibilityIdentifier("record-value")
                        if currency == nil && !raw.isEmpty {
                            Text(HabitCopy.unitWord(entry.value, raw)).font(.title3).foregroundStyle(.secondary)
                                .accessibilityHidden(true)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, gaps.cardPadding)
            } header: {
                Text(check ? "Checks" : "Amount")
            } footer: {
                if !editing || draft.problem != nil || focus == nil || room.keepsFooterWhileTyping { footer(entry) }
            }
        }
    }

    /// The view says where the log came from; edit mode says why a value can't be saved, or what changes.
    @ViewBuilder private func footer(_ entry: Entry) -> some View {
        if editing {
            if let problem = draft.problem {
                Text(problem).accessibilityIdentifier("record-problem")
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
        // The value has the keyboard, its number selected, so typing replaces it (minutes for a session).
        switch store.rule(habit, on: entry.day).kind {
        case .quit: break
        case .duration: focus = .minutes
        default: focus = .amount
        }
    }

    private func changed(_ entry: Entry) -> Bool { draft.differs || time != entry.createdAt }

    private func save(_ entry: Entry) {
        guard changed(entry) else { focus = nil; editing = false; return }
        guard let value = isSlip ? 1 : draft.value else {
            // Nothing saved; the footer says why (never a greyed-out Save).
            if draft.problem == nil, !isSlip { focus = store.rule(habit, on: entry.day).kind == .duration ? .minutes : .amount }
            return
        }
        focus = nil
        store.editEntry(entry.id, value: value, at: time != entry.createdAt ? time : nil)
        editing = false
    }

    /// Names the one record and its day, and says what stays (row 18 of the design).
    private func deleteMessage(_ entry: Entry, ruled: Habit) -> String {
        let clock = store.clockText(of: entry)
        if isSlip { return "The slip at \(clock) is removed, and your quit run is worked out again." }
        let from = entry.day == store.today() ? "today" : DayWords.short(entry.day, calendar: store.calendar).replacingOccurrences(of: ",", with: "")
        return "\(entry.description(for: ruled)) at \(clock) is removed from \(from). Your other logs stay."
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
            } header: {
                Text(habit.name + " · " + DayLogRow.count(logs.count, habit: ruled))
            } footer: {
                Text(Self.total(logs, habit: ruled)).accessibilityIdentifier("all-logs-footer")
            }
        }
        .accessibilityIdentifier("all-logs")
        .analyticsScreen(nil)
        .toolbarRole(.editor)
        .navigationTitle(DayLogRow.title(ruled, day: day, store: store))
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: logs.isEmpty) { _, empty in if empty { dismiss() } }
    }

    /// "4 glasses in all. Tap a log to see, change or delete it."
    static func total(_ logs: [Entry], habit: Habit) -> String {
        let sum = logs.reduce(0) { $0 + $1.value }
        switch habit.kind {
        case .amount(let unit, _): return HabitCopy.amount(sum, unit) + " in all. Tap a log to see, change or delete it."
        case .duration: return Format.minutes(sum) + " in all. Tap a log to see, change or delete it."
        case .quit: return "Tap a slip to see, change or delete it."
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
        case .quit: return isToday ? "Slips today" : "Slips on " + short
        case .check: return isToday ? "Checks today" : "Checks on " + short
        default: return isToday ? "Today's logs" : "Logs for " + short
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
