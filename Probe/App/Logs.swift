import SwiftUI

enum LogKind { case amount, duration, slip }

struct HabitRowLabel: View {
    var name = "Water"; var symbol = "drop.fill"; var color = Color.blue
    var body: some View {
        HStack(spacing: 12) {
            Circle().fill(color).frame(width: 30, height: 30)
                .overlay(Image(systemName: symbol).font(.system(size: 15, weight: .semibold)).foregroundStyle(.white))
            Text(name)
        }
    }
}

// B1: Health's Add Data grammar — Date and Time are compact pickers in one section; the amount is a row.
struct LogEntryRows: View {
    var kind: LogKind = .amount
    var editing = false
    var bigNumber = false
    var durationStyle = 0 // 0: countdown wheel, 1: two wheels, 2: hours/minutes fields
    var focusOnAppear = true
    @State private var date = Calendar.current.date(bySettingHour: 14, minute: 5, second: 0, of: .now)!
    @State private var amount = "2"
    @State private var hours = 0
    @State private var minutes = 5
    @State private var interval: TimeInterval = 5 * 60
    @FocusState private var focused: Bool
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    switch kind {
                    case .amount: HabitRowLabel()
                    case .duration: HabitRowLabel(name: "Stretch", symbol: "figure.flexibility", color: habitGreen)
                    case .slip: HabitRowLabel(name: "Smoking", symbol: "smoke.fill", color: .gray)
                    }
                }
                Section {
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                    DatePicker(kind == .duration ? "Finished At" : "Time", selection: $date, displayedComponents: .hourAndMinute)
                }
                switch kind {
                case .amount:
                    if bigNumber {
                        Section {
                            VStack(spacing: 2) {
                                TextField("0", text: $amount).font(.system(size: 48, weight: .regular)).multilineTextAlignment(.center)
                                    .keyboardType(.decimalPad).focused($focused)
                                Text("glasses").foregroundStyle(.secondary)
                            }.padding(.vertical, 8)
                        } header: { Text("Amount") } footer: { Text(editing ? "Changes this log only." : "Adds a new log. Other logs stay as they are.") }
                    } else {
                        Section {
                            HStack {
                                Text("Amount")
                                Spacer()
                                TextField("0", text: $amount).multilineTextAlignment(.trailing).keyboardType(.decimalPad).focused($focused).frame(maxWidth: 120)
                                Text("glasses").foregroundStyle(.secondary)
                            }
                        } footer: { Text(editing ? "Changes this log only." : "Adds a new log. Other logs stay as they are.") }
                    }
                case .duration:
                    Section {
                        switch durationStyle {
                        case 0: CountdownPicker(interval: $interval).frame(height: 200)
                        case 1:
                            HStack(spacing: 0) {
                                Picker("Hours", selection: $hours) { ForEach(0..<24) { Text("\($0)").tag($0) } }.pickerStyle(.wheel)
                                Text("hours").padding(.trailing, 8)
                                Picker("Minutes", selection: $minutes) { ForEach(0..<60) { Text("\($0)").tag($0) } }.pickerStyle(.wheel)
                                Text("min")
                            }.frame(height: 200)
                        default:
                            HStack {
                                Text("How Long")
                                Spacer()
                                Text("5 min").foregroundStyle(.secondary)
                            }
                        }
                    } header: { Text("How Long") } footer: { Text("Adds one session. Other logs stay as they are.") }
                case .slip:
                    Section {} footer: { Text("A slip is recorded with its time. You can change or remove it later.") }
                }
            }
            .navigationTitle(editing ? "Edit Log" : (kind == .slip ? "Add Slip" : "Add Log"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) { Button { } label: { Image(systemName: "xmark") } }
                ToolbarItem(placement: .confirmationAction) { Button(editing ? "Save" : "Add") { }.fontWeight(.semibold) }
            }
            .onAppear { if focusOnAppear && kind == .amount { DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { focused = true } } }
        }
    }
}

struct CountdownPicker: UIViewRepresentable {
    @Binding var interval: TimeInterval
    func makeUIView(context: Context) -> UIDatePicker {
        let p = UIDatePicker()
        p.datePickerMode = .countDownTimer
        p.countDownDuration = interval
        return p
    }
    func updateUIView(_ v: UIDatePicker, context: Context) {}
}

// B2: a saved log, view first (Contacts / Calendar event grammar): Edit in the bar, Delete as a red row.
struct LogView: View {
    var kind: LogKind = .amount
    var deleteStyle = 0 // 0: leading red row, 1: centred red row (Calendar), 2: red row with trash symbol
    @State private var ask = false
    var body: some View {
        NavigationStack {
            Color.clear.navigationDestination(isPresented: .constant(true)) {
                Form {
                    Section {
                        switch kind {
                        case .amount: HabitRowLabel()
                        case .duration: HabitRowLabel(name: "Stretch", symbol: "figure.flexibility", color: habitGreen)
                        case .slip: HabitRowLabel(name: "Smoking", symbol: "smoke.fill", color: .gray)
                        }
                    }
                    Section {
                        LabeledContent("Date", value: "Today")
                        LabeledContent("Time", value: "2:05 PM")
                        if kind == .amount { LabeledContent("Amount", value: "2 glasses") }
                        if kind == .duration { LabeledContent("How Long", value: "2 min 42 s") }
                    } footer: {
                        Text(kind == .amount ? "Added by hand at 2:05 PM." : kind == .duration ? "From the timer. Started 2:09 PM." : "Your run started again from this slip.")
                    }
                    Section {
                        Button(role: .destructive) { ask = true } label: {
                            switch deleteStyle {
                            case 1: Text(kind == .slip ? "Delete Slip" : "Delete Log").frame(maxWidth: .infinity)
                            case 2: Label(kind == .slip ? "Delete Slip" : "Delete Log", systemImage: "trash")
                            default: Text(kind == .slip ? "Delete Slip" : "Delete Log")
                            }
                        }
                        .confirmationDialog("Delete this log?", isPresented: $ask, titleVisibility: .visible) {
                            Button("Delete Log", role: .destructive) { }
                        } message: { Text("2 glasses at 2:05 PM goes from today.") }
                    }
                }
                .navigationTitle(kind == .slip ? "Slip" : "Log")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar { ToolbarItem(placement: .topBarTrailing) { Button("Edit") { } } }
            }
        }
    }
}

struct LogDeleteAlert: View {
    @State private var ask = true
    var body: some View {
        LogView().alert("Delete this log?", isPresented: $ask) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) { }
        } message: { Text("2 glasses at 2:05 PM goes from today.") }
    }
}
