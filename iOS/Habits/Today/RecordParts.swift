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

    /// The Add screen's one-line title, and the words on History's Add button (U21). Title case, as every title.
    var addTitle: String {
        switch self {
        case .amount, .time: "Add Log"
        case .check: "Add a Check"
        case .dayDone: "Mark a Day Done"
        case .steps: "Tick Steps"
        case .slip: "Add Slip"
        }
    }

    /// The Add screen's confirm word, in the bar (Figma's Log screen: plain glass, as Add, Save and Done everywhere).
    var addButton: String {
        switch self {
        case .amount, .time, .check, .slip: "Add"
        case .dayDone: "Mark Done"
        case .steps: "Save"
        }
    }
}

// MARK: - The card: the habit, then When

/// The habit this record is for, as on Day details: its icon in a 32 circle and its name (Figma's Log screen). Shown,
/// never changeable here. A `Label`, so the line under it starts at the name.
struct RecordHabitRow: View {
    let habit: Habit

    var body: some View {
        Label {
            Text(habit.name).lineLimit(1).truncationMode(.tail)
        } icon: {
            HabitIcon(symbol: habit.symbol, color: habit.color, size: 32)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Habit, \(habit.name)")
        .accessibilityIdentifier("record-habit")
    }
}

/// When (Finished for a session): iOS's compact date and time pickers side by side, the capsules saying they can be
/// changed. Any day from the habit's start to today, never the future; the time inside that day, never later than now.
/// Their pop-ups (the calendar, the time wheel) are iOS's own.
struct RecordDateRow: View {
    @Binding var day: LocalDay
    let range: ClosedRange<LocalDay>
    @Binding var time: Date
    let timeRange: ClosedRange<Date>
    let title: String
    @Environment(HabitStore.self) private var store

    var body: some View {
        let c = store.calendar
        let dates = range.lowerBound.date(calendar: c)...range.upperBound.date(calendar: c)
        let date = Binding(get: { day.date(calendar: c) }, set: { day = LocalDay($0, calendar: c) })
        LabeledContent(title) {
            HStack(spacing: 6) {
                DatePicker("Date", selection: date, in: dates, displayedComponents: .date)
                    .labelsHidden()
                    .accessibilityIdentifier("record-date")
                DatePicker("Time", selection: $time, in: timeRange, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                    .accessibilityIdentifier("record-time")
            }
        }
        .environment(\.calendar, c).environment(\.timeZone, c.timeZone)
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
        .font(CustomText.amount(size))
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
            .font(compact ? .subheadline : .body)
            .foregroundStyle(.secondary)
            .accessibilityHidden(true)
    }
}

/// HOW LONG, chosen on a wheel as Clock's timer is (Figma's Log screen, Duration): hours and minutes in one band,
/// seconds too on a log that has them (a timer's). The minutes and seconds go round; the hours don't. UIKit's picker,
/// because two SwiftUI wheels draw two bands (Rulebook, Repeat on a date). It writes the draft's strings, so saving and
/// checking are the typed fields' own.
struct DurationWheel: UIViewRepresentable {
    let draft: ProgressValueDraft
    var showsSeconds = false

    func makeCoordinator() -> Coordinator { Coordinator(self) }

    func makeUIView(context: Context) -> DurationPickerView {
        let picker = DurationPickerView(units: showsSeconds ? ["hours", "min", "s"] : ["hours", "min"])
        picker.dataSource = context.coordinator
        picker.delegate = context.coordinator
        picker.accessibilityIdentifier = "record-duration"
        picker.setContentHuggingPriority(.defaultLow, for: .horizontal)
        picker.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        context.coordinator.showDraft(in: picker)
        return picker
    }

    func updateUIView(_ picker: DurationPickerView, context: Context) { context.coordinator.parent = self }

    final class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate, UIPickerViewAccessibilityDelegate {
        var parent: DurationWheel
        /// How many times the minutes and seconds repeat, so they seem to go round; the wheel goes back to the middle
        /// after each turn.
        private static let laps = 100
        private let hourCount: Int

        init(_ parent: DurationWheel) {
            self.parent = parent
            hourCount = max(24, (Int(parent.draft.hours) ?? 0) + 1)
        }

        private var keys: [ReferenceWritableKeyPath<ProgressValueDraft, String>] {
            parent.showsSeconds ? [\.hours, \.minutes, \.seconds] : [\.hours, \.minutes]
        }

        private func current(_ component: Int) -> Int {
            let text = parent.draft[keyPath: keys[component]]
            return Int((Double(text) ?? 0).rounded(.down))
        }

        private func middleRow(for value: Int) -> Int { 60 * (Self.laps / 2) + value }

        func showDraft(in picker: UIPickerView) {
            for component in keys.indices {
                let value = current(component)
                picker.selectRow(component == 0 ? min(value, hourCount - 1) : middleRow(for: value % 60),
                                 inComponent: component, animated: false)
            }
        }

        func numberOfComponents(in pickerView: UIPickerView) -> Int { keys.count }

        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            component == 0 ? hourCount : 60 * Self.laps
        }

        func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
            keys.count == 3 ? 92 : 112
        }

        func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
            DurationPickerView.rowHeight
        }

        func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int,
                        reusing view: UIView?) -> UIView {
            let width = self.pickerView(pickerView, widthForComponent: component)
            let cell = view as? DurationPickerView.Row ?? DurationPickerView.Row()
            cell.frame = CGRect(x: 0, y: 0, width: width, height: DurationPickerView.rowHeight)
            let value = component == 0 ? row : row % 60
            cell.number.text = String(value)
            // Read whole by VoiceOver, and the wheel's value for a UI test's `adjust(toPickerWheelValue:)`.
            cell.accessibilityLabel = "\(value) " + (value == 1 ? ["hour", "minute", "second"] : ["hours", "minutes", "seconds"])[component]
            return cell
        }

        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            let value = component == 0 ? row : row % 60
            parent.draft.binding(keys[component]).wrappedValue = String(value)
            if component > 0 { pickerView.selectRow(middleRow(for: value), inComponent: component, animated: false) }
        }

        func pickerView(_ pickerView: UIPickerView, accessibilityLabelForComponent component: Int) -> String? {
            ["Hours", "Minutes", "Seconds"][component]
        }
    }
}

/// The wheel itself, with the units fixed beside the band as Clock's timer has them ("0 hours  5 min").
final class DurationPickerView: UIPickerView {
    static let rowHeight: CGFloat = 34
    /// Where the number ends inside its column; the unit starts just after it.
    static let numberShare: CGFloat = 0.42
    private var unitLabels: [UILabel] = []

    /// A row: the number, right-aligned up to the unit's place.
    final class Row: UIView {
        let number = UILabel()
        override init(frame: CGRect) {
            super.init(frame: frame)
            number.font = UIFontMetrics(forTextStyle: .title2).scaledFont(for: .systemFont(ofSize: 22))
            number.adjustsFontForContentSizeCategory = true
            number.textAlignment = .right
            addSubview(number)
        }
        required init?(coder: NSCoder) { fatalError() }
        override func layoutSubviews() {
            super.layoutSubviews()
            number.frame = CGRect(x: 0, y: 0, width: bounds.width * DurationPickerView.numberShare, height: bounds.height)
        }
    }

    init(units: [String]) {
        super.init(frame: .zero)
        for unit in units {
            let label = UILabel()
            label.text = unit
            label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: .systemFont(ofSize: 17, weight: .semibold))
            label.adjustsFontForContentSizeCategory = true
            label.isAccessibilityElement = false
            addSubview(label)
            unitLabels.append(label)
        }
    }

    required init?(coder: NSCoder) { fatalError() }

    override func layoutSubviews() {
        super.layoutSubviews()
        // Each unit sits just after its column's number, in the band. The column is found from its shown row, so the
        // place is UIKit's own, whatever spacing it puts between columns.
        for (component, label) in unitLabels.enumerated() where component < numberOfComponents {
            guard let row = view(forRow: selectedRow(inComponent: component), forComponent: component) else { continue }
            let frame = row.convert(row.bounds, to: self)
            let size = label.sizeThatFits(bounds.size)
            label.frame = CGRect(x: frame.minX + frame.width * Self.numberShare + 6, y: bounds.midY - size.height / 2,
                                 width: size.width, height: size.height)
            bringSubviewToFront(label)
        }
    }
}

/// A saved session's length as words, large: "2 min 42 s", "1 h 5 min" (Figma's Log screen, Duration, View).
struct DurationText: View {
    let minutes: Double

    var body: some View {
        Text(Self.words(minutes))
            .font(.largeTitle.bold())
            .lineLimit(1).minimumScaleFactor(0.5)
            .frame(maxWidth: .infinity)
            .accessibilityLabel(Self.spoken(minutes))
            .accessibilityIdentifier("record-duration")
    }

    /// "2 min 42 s"; seconds keep their decimals ("10.24 s"); "0 min" for nothing.
    static func words(_ minutes: Double) -> String {
        let total = (minutes * 6000).rounded() / 100
        let whole = Int(total / 60)
        let h = whole / 60, m = whole % 60
        let s = total - Double(whole) * 60
        var parts: [String] = []
        if h > 0 { parts.append("\(h) h") }
        if m > 0 { parts.append("\(m) min") }
        if s > 0 { parts.append(HabitCopy.number(s) + " s") }
        return parts.isEmpty ? "0 min" : parts.joined(separator: " ")
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

/// A screen's actions at the bottom, full width, riding above the keyboard (or the home indicator). Only App Lock's
/// pages use it now: the record screens' Add, Save and Edit are in the navigation bar (Figma, 17 Nov 2026).
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
            guard v > 0 else { return (nil, "Enter more than zero.") }
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

extension View {
    /// The back control is the chevron alone (the user, 4 Oct 2026). iOS 26's back button already is, and keeps the
    /// title centred as Figma draws it; before 26 the editor role drops the previous title, at the cost of a leading one.
    @ViewBuilder func backChevronOnly() -> some View {
        if #available(iOS 26, *) { self } else { toolbarRole(.editor) }
    }
}
