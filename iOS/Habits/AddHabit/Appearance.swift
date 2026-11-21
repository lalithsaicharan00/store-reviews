import SwiftUI

/// Figma's Icon picker (1074:932), as Reminders' New List picks: ✕, Icon and Done in the bar, search, then the icons
/// by kind. A tap moves the ring; Done keeps it, ✕ leaves the icon as it was. So a person can look and change their
/// mind, which the old tap-and-close couldn't (the page's ✕ and Done, the user, 10 Nov 2026).
struct IconSheet: View {
    @Binding var symbol: String
    let onPick: () -> Void
    @Environment(\.dismiss) private var dismiss
    @State private var search = ""
    /// The icon with the ring: the habit's own until a tap, saved only by Done.
    @State private var chosen: String

    init(symbol: Binding<String>, onPick: @escaping () -> Void) {
        _symbol = symbol
        self.onPick = onPick
        _chosen = State(initialValue: symbol.wrappedValue)
    }

    /// Six to a row as Figma, each as wide as the row allows, 8 between rows.
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 6)

    var body: some View {
        ScrollView {
            // A lazy grid is fine here: it's in a ScrollView, never in a List or Form row (S13). Ids are the symbol
            // names, one type, and each group's are unique (S14).
            LazyVStack(alignment: .leading, spacing: 24) {
                ForEach(IconLibrary.groups, id: \.name) { group in
                    let symbols = group.symbols.filter { matches($0, group: group.name) }
                    if !symbols.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text(group.name)
                                .font(.subheadline.weight(.semibold))
                                .foregroundStyle(Color(.secondaryLabel))
                                .padding(.leading, 4)
                                .accessibilityAddTraits(.isHeader)
                            LazyVGrid(columns: columns, spacing: 8) {
                                ForEach(symbols, id: \.self) { s in
                                    IconChoice(symbol: s, selected: s == chosen) { chosen = s }
                                }
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
            .padding(.bottom, 24)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Icon")
        .navigationBarTitleDisplayMode(.inline)
        // iOS's own search field under the bar (Figma's glass capsule): it keeps the keyboard, Cancel and clearing.
        .searchable(text: $search, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search icons")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel", systemImage: "xmark") { dismiss() }
            }
            // Plain glass with a Semibold word, as Add and Save are (Rulebook, 5 Nov 2026).
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    symbol = chosen
                    onPick()
                    dismiss()
                }
                .fontWeight(.semibold)
                .accessibilityIdentifier("icon-done")
            }
        }
    }

    private func matches(_ symbol: String, group: String) -> Bool {
        guard !search.isEmpty else { return true }
        let words = IconLibrary.keywords[IconLibrary.filled(symbol), default: []] + [symbol, group]
        return words.contains { $0.localizedCaseInsensitiveContains(search) }
    }
}

/// Figma's Icon choice (4748:34294): a 38 grey circle (Tertiary System Fill) with the symbol in Ink, 20 pt Regular,
/// filled or outlined as the symbol is. The chosen one has the Colour swatch's ring, System Gray 3, 3 wide, 5 outside
/// the circle. The habit's colour isn't used here: it shows on the form.
struct IconChoice: View {
    let symbol: String
    let selected: Bool
    let action: () -> Void
    @ScaledMetric(relativeTo: .title3) private var tile: CGFloat = 38

    var body: some View {
        Button(action: action) {
            Image(systemName: symbol)
                .font(.title3)
                .foregroundStyle(Color.ink)
                .frame(width: tile, height: tile)
                .background(Circle().fill(Color(.tertiarySystemFill)))
                .overlay {
                    if selected { Circle().stroke(Color(.systemGray3), lineWidth: 3).padding(-5) }
                }
                .frame(width: tile + 10, height: tile + 10)
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(IconLibrary.spokenName(symbol))
        .accessibilityAddTraits(selected ? .isSelected : [])
    }
}

enum IconLibrary {
    struct Group { let name: String; let symbols: [String] }

    /// Figma's Icon picker: filled and outlined side by side where SF Symbols has both (each checked by name on the
    /// Mac, 21 Nov 2026), six to a row. Health, Fitness, Mind and Home are Figma's own lists (18, 12, 18, 18). The
    /// groups after them aren't drawn in Figma (its page is cut where it scrolls); they keep the app's icons, now
    /// paired, and Other holds the ones Figma's four left out, so no icon a name suggests goes missing.
    static let groups: [Group] = [
        Group(name: "Health", symbols: ["heart.fill", "heart", "drop.fill", "drop", "pills.fill", "pills",
                                        "moon.fill", "moon", "leaf.fill", "leaf", "cross.fill", "cross",
                                        "bandage.fill", "bandage", "syringe.fill", "syringe", "scalemass.fill", "figure.mind.and.body"]),
        Group(name: "Fitness", symbols: ["figure.walk", "figure.run", "figure.hiking", "figure.pool.swim", "figure.flexibility", "figure.rower",
                                         "dumbbell.fill", "dumbbell", "bicycle", "soccerball", "tennis.racket", "flame.fill"]),
        Group(name: "Mind", symbols: ["star.fill", "star", "book.fill", "book", "lightbulb.fill", "lightbulb",
                                      "graduationcap.fill", "graduationcap", "paintpalette.fill", "paintpalette",
                                      "character.book.closed.fill", "character.book.closed",
                                      "text.book.closed.fill", "text.book.closed", "pencil", "music.note", "brain.head.profile", "pianokeys"]),
        Group(name: "Home", symbols: ["house.fill", "house", "washer.fill", "washer", "bubbles.and.sparkles.fill", "bubbles.and.sparkles",
                                      "bed.double.fill", "bed.double", "shower.fill", "shower", "cart.fill", "cart",
                                      "pawprint.fill", "pawprint", "tree.fill", "tree", "dollarsign.circle.fill", "dollarsign.circle"]),
        Group(name: "Work and Study", symbols: ["briefcase.fill", "briefcase", "envelope.fill", "envelope", "phone.fill", "phone",
                                                "clock.fill", "clock", "chart.bar.fill", "chart.bar", "person.2.fill", "person.2",
                                                "bubble.left.fill", "bubble.left", "laptopcomputer", "calendar", "checklist"]),
        Group(name: "Faith and Reflection", symbols: ["hands.and.sparkles.fill", "hands.and.sparkles", "book.closed.fill", "book.closed",
                                                      "moon.stars.fill", "moon.stars", "sun.max.fill", "sun.max", "sunrise.fill", "sunrise",
                                                      "building.columns.fill", "building.columns", "heart.text.square.fill", "heart.text.square"]),
        Group(name: "Food", symbols: ["cup.and.saucer.fill", "cup.and.saucer", "carrot.fill", "carrot", "fish.fill", "fish",
                                      "takeoutbag.and.cup.and.straw.fill", "takeoutbag.and.cup.and.straw", "birthday.cake.fill", "birthday.cake",
                                      "mug.fill", "mug", "wineglass.fill", "wineglass", "fork.knife"]),
        Group(name: "Break a Habit", symbols: ["smoke.fill", "smoke", "gamecontroller.fill", "gamecontroller", "tv.fill", "tv",
                                               "hand.raised.fill", "hand.raised", "bolt.slash.fill", "bolt.slash",
                                               "nosign", "iphone.slash", "cart.badge.minus"]),
        Group(name: "Other", symbols: ["bolt.fill", "bolt", "flag.fill", "flag", "gift.fill", "gift", "camera.fill", "camera", "car.fill", "car",
                                       "mouth.fill", "mouth", "eye.fill", "eye", "lungs.fill", "lungs", "cross.case.fill", "cross.case",
                                       "allergens.fill", "allergens", "sportscourt.fill", "sportscourt", "stopwatch.fill", "stopwatch",
                                       "guitars.fill", "guitars", "dishwasher.fill", "dishwasher", "sink.fill", "sink",
                                       "refrigerator.fill", "refrigerator", "trash.fill", "trash", "tshirt.fill", "tshirt",
                                       "figure.yoga", "figure.strengthtraining.traditional", "shoeprints.fill", "brain", "headphones", "sparkles",
                                       "stethoscope", "target", "globe", "airplane", "flame", "plus.forwardslash.minus", "timer"]),
    ]

    /// The filled name a keyword is kept under: an outlined symbol finds the same words as its filled one.
    static func filled(_ symbol: String) -> String {
        symbol.hasSuffix(".fill") || keywords[symbol] != nil ? symbol : symbol + ".fill"
    }

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

    /// "water", or the name in words. An outlined icon says so, since it sits beside its filled one.
    static func spokenName(_ symbol: String) -> String {
        let base = keywords[filled(symbol)]?.first ?? symbol.replacingOccurrences(of: ".fill", with: "").replacingOccurrences(of: ".", with: " ")
        return !symbol.hasSuffix(".fill") && keywords[symbol] == nil && keywords[symbol + ".fill"] != nil ? base + ", outlined" : base
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
