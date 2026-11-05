enum Shots {
    static let probes: [Shot] = [
        Shot(name: "pCheck", variant: "pCheck", steps: [.tap("More"), .wait(1), .shot("menu")]),
        Shot(name: "pCheckBar", variant: "pCheckBar"),
        Shot(name: "pCheckDay", variant: "pCheckDay"),
        Shot(name: "pTime", variant: "pTime"),
        Shot(name: "pList", variant: "pList", steps: [.swipeUp, .shot("scrolled")]),
        Shot(name: "pEnd", variant: "pEnd"),
        Shot(name: "pCheckAX", variant: "pCheckAX"),
    ]
    static let calendar = Shot(name: "calendar", bundle: "com.apple.mobilecal", steps: [.tap("Add"), .wait(2), .shot("new-event")])
    static let contacts = Shot(name: "contacts", bundle: "com.apple.MobileAddressBook", steps: [.tap("Add"), .wait(2), .shot("new-contact")])
    static let health = Shot(name: "health", bundle: "com.apple.Health", steps: [.tap("Allow"), .tap("Continue"), .tap("Browse"), .shot("browse")])
    static let reminders = Shot(name: "reminders", bundle: "com.apple.reminders", steps: [.tap("New Reminder"), .wait(1), .shot("new"), .tap("Details"), .wait(1), .shot("details")])
}
