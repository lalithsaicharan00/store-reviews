import SwiftUI

/// Picks the icon, and only the icon (colour is chosen on the form). Search, tap, done:
/// picking goes back to the form (users asked to return automatically). Pushed, like every page in the flow.
struct IconSheet: View {
    @Binding var symbol: String
    /// The habit's colour, to show the chosen icon as it will look.
    let color: HabitColor
    let onPick: () -> Void
    @Environment(\.dismiss) private var dismiss
    @State private var search = ""

    var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 22) {
                    ForEach(IconLibrary.groups, id: \.name) { group in
                        let symbols = group.symbols.filter { matches($0, group: group.name) }
                        if !symbols.isEmpty {
                            VStack(alignment: .leading, spacing: 10) {
                                Text(group.name).font(.subheadline.weight(.semibold)).foregroundStyle(.secondary)
                                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 6), spacing: 10) {
                                    ForEach(symbols, id: \.self) { s in
                                        Button {
                                            symbol = s
                                            onPick()
                                            dismiss()
                                        } label: {
                                            Image(systemName: s)
                                                .font(.system(size: 20, weight: .semibold))
                                                .foregroundStyle(s == symbol ? Color.white : Color.primary)
                                                .frame(width: 48, height: 48)
                                                .background(RoundedRectangle(cornerRadius: 13, style: .continuous)
                                                    .fill(s == symbol ? AnyShapeStyle(color.color.gradient) : AnyShapeStyle(Color(.tertiarySystemFill))))
                                        }
                                        .buttonStyle(.plain)
                                        .accessibilityLabel(IconLibrary.spokenName(s))
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(20)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Icon")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $search, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search icons")
    }

    private func matches(_ symbol: String, group: String) -> Bool {
        guard !search.isEmpty else { return true }
        let words = IconLibrary.keywords[symbol, default: []] + [symbol, group]
        return words.contains { $0.localizedCaseInsensitiveContains(search) }
    }
}

enum IconLibrary {
    struct Group { let name: String; let symbols: [String] }

    static let groups: [Group] = [
        Group(name: "Health", symbols: ["heart.fill", "pills.fill", "cross.case.fill", "drop.fill", "lungs.fill", "brain.head.profile", "bandage.fill", "mouth.fill", "eye.fill", "bed.double.fill", "allergens", "stethoscope"]),
        Group(name: "Fitness", symbols: ["figure.walk", "figure.run", "figure.flexibility", "figure.strengthtraining.traditional", "figure.yoga", "figure.pool.swim", "bicycle", "dumbbell.fill", "figure.hiking", "sportscourt.fill", "stopwatch.fill", "shoeprints.fill"]),
        Group(name: "Mind", symbols: ["figure.mind.and.body", "book.fill", "brain", "pencil", "text.book.closed.fill", "lightbulb.fill", "music.note", "paintpalette.fill", "guitars.fill", "headphones", "character.book.closed.fill", "sparkles"]),
        Group(name: "Home and Chores", symbols: ["house.fill", "washer.fill", "dishwasher.fill", "sink.fill", "refrigerator.fill", "trash.fill", "bed.double.fill", "leaf.fill", "pawprint.fill", "cart.fill", "tshirt.fill", "shower.fill"]),
        Group(name: "Work and Study", symbols: ["laptopcomputer", "briefcase.fill", "envelope.fill", "phone.fill", "calendar", "checklist", "clock.fill", "chart.bar.fill", "graduationcap.fill", "dollarsign.circle.fill", "person.2.fill", "bubble.left.fill"]),
        Group(name: "Faith and Reflection", symbols: ["hands.and.sparkles.fill", "book.closed.fill", "moon.stars.fill", "sun.max.fill", "sunrise.fill", "building.columns.fill", "heart.text.square.fill", "star.fill"]),
        Group(name: "Food", symbols: ["fork.knife", "cup.and.saucer.fill", "carrot.fill", "fish.fill", "takeoutbag.and.cup.and.straw.fill", "birthday.cake.fill", "mug.fill", "wineglass"]),
        Group(name: "Break a Habit", symbols: ["nosign", "smoke.fill", "iphone.slash", "gamecontroller.fill", "tv.fill", "cart.badge.minus", "hand.raised.fill", "bolt.slash.fill"]),
        Group(name: "Other", symbols: ["flame.fill", "bolt.fill", "target", "flag.fill", "gift.fill", "camera.fill", "globe", "airplane", "car.fill", "tree.fill", "plus.forwardslash.minus", "timer"]),
    ]

    /// Extra words for search and suggestions.
    static let keywords: [String: [String]] = [
        "drop.fill": ["water", "hydrate", "drink"], "pills.fill": ["meds", "medicine", "vitamin", "pill", "tablet"],
        "bed.double.fill": ["sleep", "bed", "nap"], "mouth.fill": ["teeth", "brush", "floss", "dentist"],
        "figure.walk": ["walk", "steps"], "figure.run": ["run", "jog"], "figure.yoga": ["yoga"],
        "figure.flexibility": ["stretch"], "figure.strengthtraining.traditional": ["gym", "workout", "lift", "weights"],
        "figure.pool.swim": ["swim"], "bicycle": ["bike", "cycle", "cycling"], "dumbbell.fill": ["exercise", "push-ups", "pushups"],
        "figure.mind.and.body": ["meditate", "meditation", "breathe", "mindful"], "book.fill": ["read", "reading", "book"],
        "pencil": ["write", "journal", "diary"], "music.note": ["music", "practice", "piano", "sing"],
        "graduationcap.fill": ["study", "learn", "homework", "class"], "character.book.closed.fill": ["language", "spanish", "french", "vocabulary"],
        "house.fill": ["home", "tidy", "clean"], "washer.fill": ["laundry", "wash"], "dishwasher.fill": ["dishes"],
        "sink.fill": ["sink", "kitchen"], "refrigerator.fill": ["fridge", "groceries"], "trash.fill": ["trash", "bins", "rubbish"],
        "leaf.fill": ["plants", "water plants", "garden"], "pawprint.fill": ["dog", "cat", "pet", "walk the dog"],
        "cart.fill": ["shop", "shopping"], "tshirt.fill": ["clothes", "iron"], "shower.fill": ["shower", "bath"],
        "envelope.fill": ["email", "inbox"], "phone.fill": ["call", "phone", "family"], "calendar": ["plan", "appointment", "dentist"],
        "dollarsign.circle.fill": ["money", "budget", "save", "invest"], "hands.and.sparkles.fill": ["pray", "prayer", "gratitude"],
        "book.closed.fill": ["bible", "quran", "scripture", "torah"], "building.columns.fill": ["church", "mosque", "temple"],
        "moon.stars.fill": ["night", "evening"], "sunrise.fill": ["morning", "wake"], "fork.knife": ["eat", "meal", "lunch", "dinner", "breakfast", "cook"],
        "carrot.fill": ["vegetables", "veggies", "healthy"], "fish.fill": ["fish"], "mug.fill": ["tea"], "cup.and.saucer.fill": ["coffee", "caffeine"],
        "wineglass": ["alcohol", "wine", "drinking", "beer"], "smoke.fill": ["smoking", "cigarette", "vape", "nicotine"],
        "iphone.slash": ["screen time", "social media", "scrolling", "doomscrolling"], "gamecontroller.fill": ["games", "gaming"], "tv.fill": ["tv", "netflix", "youtube"],
        "birthday.cake.fill": ["sugar", "sweets", "dessert"], "takeoutbag.and.cup.and.straw.fill": ["junk food", "fast food", "takeaway"],
        "heart.fill": ["health", "heart", "self-care"], "brain.head.profile": ["mental", "therapy", "mood"], "lungs.fill": ["breathing"],
        "eye.fill": ["eyes", "contacts"], "stethoscope": ["doctor", "check-up"], "flame.fill": ["streak", "challenge"],
        "laptopcomputer": ["work", "code", "computer"], "clock.fill": ["time", "early"], "person.2.fill": ["friends", "social"],
    ]

    static func spokenName(_ symbol: String) -> String {
        keywords[symbol]?.first ?? symbol.replacingOccurrences(of: ".fill", with: "").replacingOccurrences(of: ".", with: " ")
    }
}

/// Picks an icon from the habit's name, so the choice is optional.
enum IconSuggester {
    /// Longest keyword first, so "walk the dog" beats "walk". Sorted once, not on every letter typed (30 Sep).
    private static let candidates = IconLibrary.keywords.flatMap { symbol, keys in keys.map { ($0, symbol) } }
        .sorted { $0.0.count > $1.0.count }

    static func symbol(for name: String) -> String? {
        let text = name.lowercased()
        guard text.count >= 3 else { return nil }
        let words = Set(text.split(whereSeparator: { !$0.isLetter && $0 != "-" }).map(String.init))
        for (key, symbol) in candidates {
            if key.contains(" ") ? text.contains(key) : words.contains(key) || words.contains(key + "s") { return symbol }
        }
        return nil
    }
}
