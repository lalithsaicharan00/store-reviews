import SwiftUI
import Observation

// The pieces every record screen shares (7 October 2026 redesign: Add log, Log / Edit log, Add a check, Mark a day
// done, Tick steps, Add slip; Rulebook U18, U19, U22). Built from native parts: Form sections, LabeledContent rows,
// compact DatePickers, the system's bordered buttons. Typing redraws only the field being typed in (Rulebook S11).

// MARK: - What a habit records, and the words for it

/// One rule per kind of habit (design decisions §8): the Add screen's title, History's Add button, and the shape of
/// the record. Never written for one habit, and never from the habit's name (U21).
enum RecordKind: Equatable {
    /// An amount: "Add log", typed with the decimal pad.
    case amount
    /// A time habit: "Add log", hours, minutes and seconds.
    case time
    /// A check counted several times (a day, or N a week, month or year): "Add a check", one check per add.
    case check
    /// A check done once a day, a day of "N days a week", or a task: "Mark a day done".
    case dayDone
    /// A checklist: "Tick steps".
    case steps
    /// A quit habit: "Add slip".
    case slip

    init(_ habit: Habit, on day: LocalDay, store: HabitStore) {
        let rule = store.rule(habit, on: day)
        switch rule.kind {
        case .amount: self = .amount
        case .duration: self = .time
        case .check: self = store.countsUp(habit, on: day) ? .check : .dayDone
        case .task: self = .dayDone
        case .checklist: self = .steps
        case .quit: self = .slip
        }
    }

    /// The Add screen's one-line title, and the words on History's Add button (U21).
    var addTitle: String {
        switch self {
        case .amount, .time: "Add log"
        case .check: "Add a check"
        case .dayDone: "Mark a day done"
        case .steps: "Tick steps"
        case .slip: "Add slip"
        }
    }

    /// The one filled button at the bottom of the Add screen.
    var addButton: String {
        switch self {
        case .amount, .time, .check, .slip: "Add"
        case .dayDone: "Mark done"
        case .steps: "Save"
        }
    }
}

/// The words for a day, the way people say them.
enum DayWords {
    /// "Today", "Yesterday", or "Mon, 29 Sep".
    static func day(_ day: LocalDay, today: LocalDay, calendar: Calendar) -> String {
        if day == today { return "Today" }
        if day == today.adding(days: -1, calendar: calendar) { return "Yesterday" }
        return short(day, calendar: calendar)
    }

    /// "Today" or "Yesterday" beside a date picker; nothing for other days (the picker says the date).
    static func relative(_ day: LocalDay, today: LocalDay, calendar: Calendar) -> String? {
        if day == today { return "Today" }
        if day == today.adding(days: -1, calendar: calendar) { return "Yesterday" }
        return nil
    }

    /// "Today, 7 Oct", "Yesterday, 6 Oct", "Sun, 4 Oct": a record's fixed date.
    static func withDate(_ day: LocalDay, today: LocalDay, calendar: Calendar) -> String {
        let date = day.date(calendar: calendar)
        if let word = relative(day, today: today, calendar: calendar) {
            return word + ", " + date.formatted(.dateTime.day().month(.abbreviated))
        }
        return short(day, calendar: calendar)
    }

    /// "Tue, 6 Oct".
    static func short(_ day: LocalDay, calendar: Calendar) -> String {
        day.date(calendar: calendar).formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated))
    }

    /// "9:40 PM", in the given calendar's zone.
    static func clock(_ date: Date, calendar: Calendar) -> String {
        date.formatted(Date.FormatStyle(date: .omitted, time: .shortened, calendar: calendar, timeZone: calendar.timeZone))
    }
}

// MARK: - The card: Habit, Date, Time

/// "Habit · [icon] Water": which habit this record is for, shown and never changeable here (decision log step 8).
struct RecordHabitRow: View {
    let habit: Habit

    var body: some View {
        LabeledContent("Habit") {
            HStack(spacing: 6) {
                HabitIcon(symbol: habit.symbol, color: habit.color, size: 22)
                Text(habit.name).lineLimit(1).truncationMode(.tail)
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Habit, \(habit.name)")
        .accessibilityIdentifier("record-habit")
    }
}

/// The record's date: "Today" in words beside a compact date picker (any day from the habit's start to today, never
/// the future); on the iPhone SE with the keyboard up, the time picker shares the row (`compact`).
struct RecordDateRow: View {
    @Binding var day: LocalDay
    let range: ClosedRange<LocalDay>
    @Binding var time: Date
    let timeRange: ClosedRange<Date>
    let timeTitle: String
    /// Date and Time in one row, without the "Today" word (the iPhone SE with the keyboard up).
    var compact = false
    @Environment(HabitStore.self) private var store

    var body: some View {
        let c = store.calendar
        let dates = range.lowerBound.date(calendar: c)...range.upperBound.date(calendar: c)
        let date = Binding(get: { day.date(calendar: c) }, set: { day = LocalDay($0, calendar: c) })
        if compact {
            LabeledContent("Date") {
                HStack(spacing: 8) {
                    DatePicker("Date", selection: date, in: dates, displayedComponents: .date)
                        .labelsHidden()
                        .accessibilityIdentifier("record-date")
                    DatePicker(timeTitle, selection: $time, in: timeRange, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .accessibilityLabel(timeTitle)
                        .accessibilityIdentifier("record-time")
                }
            }
            .environment(\.calendar, c).environment(\.timeZone, c.timeZone)
        } else {
            LabeledContent("Date") {
                HStack(spacing: 8) {
                    if let word = DayWords.relative(day, today: store.today(), calendar: c) {
                        Text(word).foregroundStyle(.secondary)
                    }
                    DatePicker("Date", selection: date, in: dates, displayedComponents: .date)
                        .labelsHidden()
                        .accessibilityIdentifier("record-date")
                }
            }
            .environment(\.calendar, c).environment(\.timeZone, c.timeZone)
            DatePicker(timeTitle, selection: $time, in: timeRange, displayedComponents: .hourAndMinute)
                .environment(\.calendar, c).environment(\.timeZone, c.timeZone)
                .accessibilityIdentifier("record-time")
        }
    }
}

// MARK: - The main thing: an amount, or how long

/// Which field of a record has the keyboard.
enum RecordField: Hashable { case amount, hours, minutes, seconds }

/// The amount as one large number, centred, that is the field itself (design decisions §6): a currency symbol before
/// the digits ("£15"); the field is as wide as what's typed, so the number stays centred while typing. Its own view,
/// reading the typed text, so a keystroke redraws only this (Rulebook S11).
struct AmountNumberField: View {
    let draft: ProgressValueDraft
    let currency: String?
    let size: CGFloat
    var keyboard: UIKeyboardType = .decimalPad
    var focus: FocusState<RecordField?>.Binding
    let label: String

    var body: some View {
        let text = draft.amount
        HStack(alignment: .firstTextBaseline, spacing: 2) {
            if let currency { Text(currency).accessibilityHidden(true) }
            // The hidden text gives the field the width of what's typed (plus room for the cursor); the field fills it.
            ZStack {
                Text(text.isEmpty ? "0" : text).hidden().padding(.horizontal, 4)
                TextField("0", text: draft.binding(\.amount))
                    .keyboardType(keyboard)
                    .multilineTextAlignment(.center)
                    .focused(focus, equals: .amount)
                    .accessibilityLabel(label)
                    .accessibilityIdentifier("record-amount")
            }
            .frame(minWidth: size * 0.7)
        }
        .font(.system(size: size, weight: .bold).monospacedDigit())
        .lineLimit(1)
        .frame(maxWidth: .infinity)
    }
}

/// The unit under the number, which never moves while typing; only "glass" / "glasses" changes, when the typed number
/// becomes or stops being one (`ProgressValueDraft.isOne`).
struct AmountUnitLine: View {
    let draft: ProgressValueDraft
    let unit: String
    var compact = false

    var body: some View {
        Text(HabitCopy.unitWord(draft.isOne ? 1 : 2, unit))
            .font(compact ? .body : .title3)
            .foregroundStyle(.secondary)
            .accessibilityHidden(true)
    }
}

/// HOW LONG: hours, minutes and seconds, three tap-to-type fields side by side, each its own small view (S11). Whole
/// hours and minutes; seconds may have decimals ("1.23").
struct DurationFields: View {
    let draft: ProgressValueDraft
    let size: CGFloat
    var focus: FocusState<RecordField?>.Binding

    var body: some View {
        HStack(spacing: 8) {
            part("hours", key: \.hours, field: .hours, keyboard: .numberPad, id: "record-hours", label: "Hours")
            part("min", key: \.minutes, field: .minutes, keyboard: .numberPad, id: "record-minutes", label: "Minutes")
            part("sec", key: \.seconds, field: .seconds, keyboard: .decimalPad, id: "record-seconds", label: "Seconds")
        }
    }

    private func part(_ title: String, key: ReferenceWritableKeyPath<ProgressValueDraft, String>, field: RecordField,
                      keyboard: UIKeyboardType, id: String, label: String) -> some View {
        VStack(spacing: 4) {
            DraftTextField(draft: draft, key: key, placeholder: "0", keyboard: keyboard)
                .multilineTextAlignment(.center)
                .font(.system(size: size, weight: .bold).monospacedDigit())
                .lineLimit(1)
                .focused(focus, equals: field)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                .accessibilityLabel(label)
                .accessibilityIdentifier(id)
            Text(title).font(.subheadline).foregroundStyle(.secondary).accessibilityHidden(true)
        }
    }
}

/// A saved time habit's length, read only: the same three boxes as when typing, without fields.
struct DurationBoxes: View {
    let minutes: Double
    let size: CGFloat

    var body: some View {
        let parts = Self.parts(minutes)
        HStack(spacing: 8) {
            box(parts.hours, "hours")
            box(parts.minutes, "min")
            box(parts.seconds, "sec")
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(Self.spoken(minutes))
        .accessibilityIdentifier("record-duration")
    }

    private func box(_ value: String, _ title: String) -> some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.system(size: size, weight: .bold).monospacedDigit())
                .lineLimit(1).minimumScaleFactor(0.5)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
            Text(title).font(.subheadline).foregroundStyle(.secondary)
        }
    }

    /// The draft's own split, so the view and the edit fields agree ("0", "15", "00", or "30.5" seconds).
    static func parts(_ minutes: Double) -> (hours: String, minutes: String, seconds: String) {
        let draft = ProgressValueDraft(kind: .duration, value: minutes)
        let seconds = draft.seconds == "0" ? "00" : draft.seconds.count == 1 ? "0" + draft.seconds : draft.seconds
        return (draft.hours, draft.minutes, seconds)
    }

    /// "15 minutes", "1 hour 2 minutes 30 seconds", for VoiceOver.
    static func spoken(_ minutes: Double) -> String {
        let total = (minutes * 6000).rounded() / 100
        let whole = Int(total / 60)
        let h = whole / 60, m = whole % 60
        let s = total - Double(whole) * 60
        var parts: [String] = []
        if h > 0 { parts.append("\(h) \(h == 1 ? "hour" : "hours")") }
        if m > 0 { parts.append("\(m) \(m == 1 ? "minute" : "minutes")") }
        if s > 0 { parts.append(HabitCopy.number(s) + (s == 1 ? " second" : " seconds")) }
        return parts.isEmpty ? "0 minutes" : parts.joined(separator: " ")
    }
}

// MARK: - The bottom place

/// The screen's actions at the bottom, full width, riding above the keyboard (or the home indicator): one filled
/// button (Add, Save, Mark done), or Delete | Edit on a record's view (U18, U19). Nothing else on the screen is filled.
struct RecordBottomBar<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        HStack(spacing: 8) { content }
            .padding(.horizontal, 16)
            .padding(.top, 8)
            .padding(.bottom, 8)
            .frame(maxWidth: .infinity)
            .background(Color(.systemGroupedBackground))
    }
}

/// "Delete log": red text on the ordinary bordered button, never a red fill (U19; Apple HIG: the destructive role's
/// colour, not the prominent style). Always asks first.
struct RecordDeleteButton: View {
    let title: String
    let id: String
    let action: () -> Void

    var body: some View {
        Button(role: .destructive, action: action) {
            Text(title).fontWeight(.semibold).foregroundStyle(.red).frame(maxWidth: .infinity, minHeight: DayButton.labelHeight)
        }
        .buttonStyle(.bordered)
        .tint(.ink)
        .controlSize(.regular)
        .accessibilityIdentifier(id)
    }
}

/// The ✕ that leaves an Add screen or edit mode: an icon, named Cancel (U18).
struct RecordCancelButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) { Image(systemName: "xmark") }
            .accessibilityLabel("Cancel")
            .accessibilityIdentifier("record-cancel")
    }
}

/// How tall the screen around a record is, read once when it changes, never per row (S6): the iPhone SE puts Date and
/// Time in one row while typing, and the footer hides while typing where it would reach the button.
struct ScreenRoom: Equatable {
    var height: CGFloat = 800
    /// An iPhone SE-sized sheet (4.7-inch).
    var isSmall: Bool { height < 700 }
    /// The key window's height: 667 pt on the iPhone SE, 812 on a mini, 852 on a 6.1-inch iPhone.
    static func windowHeight() -> CGFloat {
        let windows = UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }.flatMap(\.windows)
        return (windows.first(where: \.isKeyWindow) ?? windows.first)?.bounds.height ?? 852
    }

    /// Room for the footer above the keyboard: only the largest iPhones (Plus and Pro Max). The design kept it on the
    /// 6.1-inch, but iOS 26's 52-pt rows leave no room there: on a 6.3-inch the footer and the amount reached under
    /// Add (SmallScreenUITests on the default simulator, run 37624448992, 7 Oct 2026).
    var keepsFooterWhileTyping: Bool { Self.windowHeight() >= 920 }

    /// The gaps a record screen uses (design decisions §3): the minimum on the SE with the keyboard up, where the card,
    /// the amount and the button must all fit above the keyboard (measured on the SE simulator, 7 Oct 2026: with the
    /// standard Form gaps the button covered the amount by 22 pt).
    struct Gaps { let top: CGFloat; let section: CGFloat; let cardPadding: CGFloat; let numberSize: CGFloat }
    func gaps(typing: Bool) -> Gaps {
        isSmall && typing ? Gaps(top: 8, section: 8, cardPadding: 0, numberSize: 40)
            : isSmall ? Gaps(top: 16, section: 20, cardPadding: 8, numberSize: 48)
            : typing ? Gaps(top: 8, section: 16, cardPadding: 4, numberSize: 56)
            : Gaps(top: 18, section: 28, cardPadding: 12, numberSize: 64)
    }
}

extension View {
    /// Reports the sheet's full height (the keyboard and the bars included, so it doesn't change while typing) into
    /// `room`, only when it changes by a point or more.
    func measuresRoom(_ room: Binding<ScreenRoom>) -> some View {
        onGeometryChange(for: CGFloat.self) { proxy in
            (proxy.size.height + proxy.safeAreaInsets.top + proxy.safeAreaInsets.bottom).rounded()
        } action: { height in
            if abs(height - room.wrappedValue.height) >= 1 { room.wrappedValue.height = height }
        }
    }
}

// MARK: - Typing

/// One of a draft's text fields in its own view (2 Oct 2026). The binding is made, and the typed text read, here, so a
/// keystroke redraws this field, never the screen around it (PERFORMANCE.md rule 11). Modifiers put on it (focus,
/// alignment, accessibility) reach the field inside.
struct DraftTextField: View {
    let draft: ProgressValueDraft
    let key: ReferenceWritableKeyPath<ProgressValueDraft, String>
    let placeholder: String
    let keyboard: UIKeyboardType

    var body: some View {
        TextField(placeholder, text: draft.binding(key)).keyboardType(keyboard)
    }
}

/// Only the native fields read these strings. The screen reads the validation flag, the problem and whether anything
/// changed, each set only when it changes; nothing else rebuilds for every character.
@Observable final class ProgressValueDraft {
    let kind: HabitKind
    var amount: String
    var hours: String
    var minutes: String
    var seconds: String
    var isValid: Bool
    /// Whether the typed amount is exactly one (the unit line says "glass", not "glasses"). Set only when it changes.
    var isOne: Bool
    /// Why the text can't be saved, said near the field (never silently clamped or rounded); nil when it can, or
    /// while a field is simply empty.
    var problem: String?
    /// Set once, on the first keystroke that changes a field, and never cleared: a screen starts asking before it's
    /// closed then. A flag that followed every keystroke back and forth redrew the screen and its navigation bar each
    /// time (Entry editor typing 26–40 ms/s against 1–11 before, CI 4 Oct 2026; Rulebook S11). `differs` says whether
    /// there's really anything to lose.
    var edited = false
    @ObservationIgnored private var opened: [String] = []

    init(kind: HabitKind, value: Double? = nil) {
        self.kind = kind
        amount = value.map(GoalNumber.text) ?? ""
        let totalSeconds = ((value ?? 0) * 6000).rounded() / 100
        let wholeMinutes = Int(totalSeconds / 60)
        hours = String(wholeMinutes / 60)
        minutes = String(wholeMinutes % 60)
        seconds = GoalNumber.text(totalSeconds - Double(wholeMinutes) * 60)
        isValid = false
        isOne = false
        isValid = self.value != nil
        isOne = self.value == 1
        opened = [amount, hours, minutes, seconds]
    }

    var value: Double? { check().value }

    /// Whether any field differs from what the draft opened with. Read on a tap, never while drawing.
    var differs: Bool { [amount, hours, minutes, seconds] != opened }

    private func check() -> (value: Double?, problem: String?) {
        if kind == .quit { return (1, nil) }
        if kind == .duration {
            if [hours, minutes, seconds].allSatisfy({ $0.trimmingCharacters(in: .whitespaces).isEmpty }) { return (nil, nil) }
            // An empty part counts as zero: typing only the minutes is enough.
            func part(_ text: String) -> String { text.trimmingCharacters(in: .whitespaces).isEmpty ? "0" : text }
            guard let h = GoalNumber.parse(part(hours), decimals: 0) else { return (nil, "Hours are a whole number.") }
            guard let m = GoalNumber.parse(part(minutes), decimals: 0) else { return (nil, "Minutes are a whole number.") }
            guard m < 60 else { return (nil, "Minutes go up to 59.") }
            guard let s = GoalNumber.parse(part(seconds)) else { return (nil, "Seconds take up to 2 decimal places.") }
            guard s < 60 else { return (nil, "Seconds go up to 59.99.") }
            let v = h * 60 + m + s / 60
            guard v > 0 else { return (nil, "A session is longer than zero.") }
            return v <= GoalNumber.maximum ? (v, nil) : (nil, "That's longer than a log can hold.")
        }
        if amount.trimmingCharacters(in: .whitespaces).isEmpty { return (nil, nil) }
        let whole = kind == .check
        guard let v = GoalNumber.parse(amount, decimals: whole ? 0 : 2) else {
            return (nil, whole ? "Checks are a whole number." : "Use a number with up to 2 decimal places.")
        }
        return v > 0 ? (v, nil) : (nil, "Enter more than zero.")
    }

    func binding(_ key: ReferenceWritableKeyPath<ProgressValueDraft, String>) -> Binding<String> {
        Binding(get: { self[keyPath: key] }, set: { text in
            guard self[keyPath: key] != text else { return }
            self[keyPath: key] = text
            let (value, problem) = self.check()
            let valid = value != nil
            if valid != self.isValid { self.isValid = valid }
            if (value == 1) != self.isOne { self.isOne = value == 1 }
            if problem != self.problem { self.problem = problem }
            if !self.edited && self.differs { self.edited = true }
        })
    }
}

// MARK: - A log in words

extension Entry {
    func description(for habit: Habit) -> String {
        if let stepID { return habit.steps.first { $0.id == stepID }?.name ?? "Checklist step" }
        switch habit.kind {
        case .amount(let unit, _): return HabitCopy.amount(value, unit)
        case .duration: return value < 1 ? "\(HabitCopy.number(value * 60)) sec" : Format.minutes(value)
        case .quit: return "Slip"
        case .check: return value == 1 ? "Check" : HabitCopy.amount(value, habit.checkUnit ?? "checks")
        case .task: return "Done"
        case .checklist: return "Step checked"
        }
    }

    /// Says what Undo takes back, before it's tapped (the user, 3 Oct 2026; report "Today's Rows"): always this one
    /// entry, never the day. "Undo +1 glass", "Undo 20 min", "Undo +1", "Undo Done", "Undo Slip", "Undo Cleanser".
    /// A step's is "Undo Last Step", never the step's own name: a long name pushed Today's after-log buttons off the
    /// row (the user, 9 Oct 2026). Where one step's own row is shown, `undoSpoken(for:)` names it for VoiceOver.
    func undoLabel(for habit: Habit) -> String {
        if stepID != nil { return "Undo Last Step" }
        switch habit.kind {
        case .amount: return "Undo +" + description(for: habit)
        case .duration: return "Undo " + description(for: habit)
        case .check where habit.frequency.isDayBased && habit.goal > 1:
            return "Undo +" + (habit.checkUnit.map { HabitCopy.amount(value, $0) } ?? HabitCopy.number(value))
        case .check, .task: return "Undo Done"
        case .quit: return "Undo Slip"
        case .checklist: return "Undo"
        }
    }

    /// VoiceOver's name for Undo on this log's own row (Day details' logs), where the step is the one beside it.
    func undoSpoken(for habit: Habit) -> String {
        if let stepID, let step = habit.steps.first(where: { $0.id == stepID }) { return "Undo " + step.name }
        return undoLabel(for: habit)
    }

    /// Whether this log has a fact of its own to see and correct in the Log view (U19): an amount, a time, a slip's
    /// moment, or an older record holding several checks. A single check, a step or a task is corrected where it's shown,
    /// with its own named Undo.
    func opensRecord(for habit: Habit) -> Bool {
        guard stepID == nil else { return false }
        switch habit.kind {
        case .amount, .duration, .quit: return true
        case .check: return value != 1
        case .task, .checklist: return false
        }
    }

    /// "Logged with Log manually.": where it came from, in the Log view's footer. Nil for old logs whose origin was
    /// never recorded.
    func originLine(slip: Bool) -> String? {
        guard let source else { return nil }
        let verb = slip ? "Recorded" : "Logged"
        switch source {
        case .manual: return slip ? "Recorded with Record a slip." : "Logged with Log manually."
        case .today: return "\(verb) from Today."
        case .routine: return "\(verb) in the routine player."
        case .reminder: return "\(verb) from a reminder."
        case .timer: return "\(verb) with the timer."
        case .daySheet: return "\(verb) in Day details."
        case .shortcut: return "\(verb) with Siri or Shortcuts."
        case .widget: return "\(verb) from a widget."
        }
    }
}

extension HabitStore {
    /// A log's clock time where it was recorded, with that zone's name when it isn't the phone's own.
    func clockText(of entry: Entry) -> String {
        let c = recordingCalendar(for: entry)
        let text = DayWords.clock(entry.createdAt, calendar: c)
        return c.timeZone == calendar.timeZone ? text : text + " " + (c.timeZone.abbreviation(for: entry.createdAt) ?? entry.timeZone)
    }

    /// A day's logs (no checklist steps), newest first by their time; logs at the same moment newest-made first.
    /// One day's handful, sorted when that day's logs change.
    func dayLogs(of habit: Habit, on day: LocalDay) -> [Entry] {
        let list = entries(of: habit.id, on: day)
        return list.indices.filter { list[$0].stepID == nil }
            .sorted { list[$0].createdAt != list[$1].createdAt ? list[$0].createdAt > list[$1].createdAt : $0 > $1 }
            .map { list[$0] }
    }
}
