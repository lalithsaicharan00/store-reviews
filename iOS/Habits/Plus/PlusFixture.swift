#if DEBUG
import Foundation

/// `PlusUITests` and `SmallScreenUITests` (`-uitest -free -empty -plus-fixture`): the free plan full, as in the Plus
/// mockups (Drink water, Read, Walk, Meditate, Vitamins), and one archived habit to bring back (Stretch).
enum PlusFixture {
    static func install(in store: HabitStore) async {
        guard store.habits.isEmpty else { return }
        let habits: [(String, String, HabitColor)] = [("Drink water", "drop.fill", .blue), ("Read", "book.fill", .orange),
                                                      ("Walk", "figure.walk", .green), ("Meditate", "brain.head.profile", .purple),
                                                      ("Vitamins", "pills.fill", .pink)]
        for (name, symbol, color) in habits {
            store.add(Habit(name: name, symbol: symbol, color: color, kind: .check, goal: 1))
        }
        var stretch = Habit(name: "Stretch", symbol: "figure.cooldown", color: .teal, kind: .check, goal: 1)
        stretch.archived = true
        store.add(stretch)
        await store.flush()
    }
}
#endif
