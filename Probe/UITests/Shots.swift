enum Shots {
    static let probes: [Shot] = [
        Shot(name: "logRows", variant: "logRows"),
        Shot(name: "logBig", variant: "logBig"),
        Shot(name: "logEdit", variant: "logEdit"),
        Shot(name: "slip", variant: "slip"),
        Shot(name: "logRowsAX", variant: "logRowsAX"),
        Shot(name: "logBigAX", variant: "logBigAX"),
        Shot(name: "viewAX", variant: "viewAX"),
        Shot(name: "durWheelAX", variant: "durWheelAX"),
    ]
    static let calendar = Shot(name: "calendar", bundle: "com.apple.mobilecal", steps: [.tap("Add"), .wait(2), .shot("new-event")])
    static let contacts = Shot(name: "contacts", bundle: "com.apple.MobileAddressBook", steps: [.tap("Add"), .wait(2), .shot("new-contact")])
    static let health = Shot(name: "health", bundle: "com.apple.Health", steps: [.tap("Allow"), .tap("Continue"), .tap("Browse"), .shot("browse")])
    static let reminders = Shot(name: "reminders", bundle: "com.apple.reminders", steps: [.tap("New Reminder"), .wait(1), .shot("new"), .tap("Details"), .wait(1), .shot("details")])
}
