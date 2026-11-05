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
        default: Text("Probe index")
        }
    }
}
