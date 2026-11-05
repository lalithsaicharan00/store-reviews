enum Shots {
    static let probes: [Shot] = [
        Shot(name: "logRows", variant: "logRows"),
        Shot(name: "logBig", variant: "logBig"),
        Shot(name: "logRowsNoKb", variant: "logRowsNoKb", steps: [.tapIndex("Date", 0), .wait(1), .shot("date-open"), .tapAt(0.5, 0.95), .tapIndex("Time", 1), .wait(1), .shot("time-open")]),
        Shot(name: "logEdit", variant: "logEdit"),
        Shot(name: "durWheel", variant: "durWheel"),
        Shot(name: "durTwo", variant: "durTwo"),
        Shot(name: "slip", variant: "slip"),
        Shot(name: "view0", variant: "view0", steps: [.tap("Delete Log"), .wait(1), .shot("dialog")]),
        Shot(name: "view1", variant: "view1"),
        Shot(name: "view2", variant: "view2"),
        Shot(name: "viewDur", variant: "viewDur"),
        Shot(name: "viewAlert", variant: "viewAlert"),
    ]
    static let calendar = Shot(name: "calendar", bundle: "com.apple.mobilecal", steps: [.tap("Add"), .wait(2), .shot("new-event")])
    static let contacts = Shot(name: "contacts", bundle: "com.apple.MobileAddressBook", steps: [.tap("Add"), .wait(2), .shot("new-contact")])
    static let health = Shot(name: "health", bundle: "com.apple.Health")
    static let reminders = Shot(name: "reminders", bundle: "com.apple.reminders", steps: [.tap("New Reminder"), .wait(1), .shot("new"), .tap("Details"), .wait(1), .shot("details")])
}
