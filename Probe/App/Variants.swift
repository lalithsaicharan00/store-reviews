import SwiftUI

enum Variants {
    @ViewBuilder static func view(_ v: String) -> some View {
        switch v {
        case "timerA": Presenter(style: .cover) { TimerA() }
        case "timerB": Presenter(style: .sheet) { TimerB(ring: false) }
        case "timerC": Presenter(style: .sheet) { TimerB(ring: true) }
        case "timerD": Presenter(style: .sheet) { TimerD() }
        case "timerE": Presenter(style: .sheet) { TimerE() }
        default: Text("Probe index")
        }
    }
}
