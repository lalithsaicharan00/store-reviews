enum Shots {
    static let probes: [Shot] = [
        Shot(name: "timerF", variant: "timerF"),
        Shot(name: "timerG", variant: "timerG", steps: [.tap("More"), .shot("menu")]),
        Shot(name: "timerPaused", variant: "timerPaused"),
        Shot(name: "timerGoal", variant: "timerGoal"),
        Shot(name: "timerLimit", variant: "timerLimit"),
        Shot(name: "timerBig", variant: "timerBig"),
        Shot(name: "timerFull", variant: "timerFull"),
    ]
    static let apple: [Shot] = [
        Shot(name: "clock", bundle: "com.apple.mobiletimer", steps: [.tap("Timers"), .shot("timers"), .tap("Timer"), .shot("timer"), .tap("Start"), .wait(2), .shot("running")]),
        Shot(name: "reminders", bundle: "com.apple.reminders"),
        Shot(name: "calendar", bundle: "com.apple.mobilecal", steps: [.tap("Add"), .wait(1), .shot("new-event")]),
        Shot(name: "contacts", bundle: "com.apple.MobileAddressBook"),
    ]
}
