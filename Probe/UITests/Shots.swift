enum Shots {
    static let probes: [Shot] = [
        Shot(name: "timerA", variant: "timerA"),
        Shot(name: "timerB", variant: "timerB"),
        Shot(name: "timerC", variant: "timerC"),
        Shot(name: "timerD", variant: "timerD"),
        Shot(name: "timerE", variant: "timerE"),
    ]
    static let apple: [Shot] = [
        Shot(name: "clock", bundle: "com.apple.mobiletimer", steps: [.tap("Timers"), .shot("timers"), .tap("Timer"), .shot("timer"), .tap("Start"), .wait(2), .shot("running")]),
        Shot(name: "reminders", bundle: "com.apple.reminders"),
        Shot(name: "calendar", bundle: "com.apple.mobilecal", steps: [.tap("Add"), .wait(1), .shot("new-event")]),
        Shot(name: "contacts", bundle: "com.apple.MobileAddressBook"),
    ]
}
