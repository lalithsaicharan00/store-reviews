import SwiftUI

enum Variants {
    @ViewBuilder static func view(_ v: String) -> some View {
        switch v {
        case "timerA": Presenter(style: .cover) { TimerA() }
        case "timerB": Presenter(style: .sheet) { TimerB(ring: false) }
        case "timerC": Presenter(style: .sheet) { TimerB(ring: true) }
        case "timerD": Presenter(style: .sheet) { TimerD() }
        case "timerE": Presenter(style: .sheet) { TimerE() }
        case "timerF": Presenter(style: .sheet) { TimerF() }
        case "timerG": Presenter(style: .sheet) { TimerF(header: 1) }
        case "timerPaused": Presenter(style: .sheet) { TimerF(state: .paused) }
        case "timerGoal": Presenter(style: .sheet) { TimerF(state: .goalMet) }
        case "timerLimit": Presenter(style: .sheet) { TimerF(state: .overLimit) }
        case "timerBig": Presenter(style: .sheet) { TimerF().dynamicTypeSize(.accessibility1) }
        case "timerFull": Presenter(style: .cover) { TimerF() }
        case "logRows": Presenter(style: .sheet) { LogEntryRows() }
        case "logBig": Presenter(style: .sheet) { LogEntryRows(bigNumber: true) }
        case "logRowsNoKb": Presenter(style: .sheet) { LogEntryRows(focusOnAppear: false) }
        case "logEdit": Presenter(style: .sheet) { LogEntryRows(editing: true) }
        case "durWheel": Presenter(style: .sheet) { LogEntryRows(kind: .duration, durationStyle: 0) }
        case "durTwo": Presenter(style: .sheet) { LogEntryRows(kind: .duration, durationStyle: 1) }
        case "slip": Presenter(style: .sheet) { LogEntryRows(kind: .slip) }
        case "view0": LogView()
        case "view1": LogView(deleteStyle: 1)
        case "view2": LogView(deleteStyle: 2)
        case "viewDur": LogView(kind: .duration)
        case "viewAlert": LogDeleteAlert()
        case "logRowsAX": Presenter(style: .sheet) { LogEntryRows().dynamicTypeSize(.accessibility1) }
        case "logBigAX": Presenter(style: .sheet) { LogEntryRows(bigNumber: true).dynamicTypeSize(.accessibility1) }
        case "viewAX": LogView().dynamicTypeSize(.accessibility1)
        case "durWheelAX": Presenter(style: .sheet) { LogEntryRows(kind: .duration, durationStyle: 0).dynamicTypeSize(.accessibility1) }
        case "noteForm": Presenter(style: .sheet) { NoteEntry() }
        case "noteFormEmpty": Presenter(style: .sheet) { NoteEntry(typed: false) }
        case "noteFull": Presenter(style: .sheet) { NoteEntry(fullSheet: true) }
        case "noteView": NoteView()
        case "pCheck": PlayerCheck()
        case "pCheckBar": PlayerCheck(header: 1)
        case "pCheckDay": PlayerCheck(dayButton: true)
        case "pTime": PlayerTime()
        case "pList": PlayerChecklist()
        case "pEnd": PlayerEnd()
        case "pCheckAX": PlayerCheck().dynamicTypeSize(.accessibility1)
        case "h0": HabitsPage(header: 0)
        case "h1": HabitsPage(header: 1)
        case "h2": HabitsPage(header: 2)
        default: Text("Probe index")
        }
    }
}
