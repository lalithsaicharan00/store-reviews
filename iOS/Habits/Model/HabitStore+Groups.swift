import Foundation

/// A group of habits by area of life: Health, Work, Home (Build Plan #68; `Docs/Specs/Groups — What to Build.md`).
/// Personal organisation only: optional, never required, one per habit. It says *what area*; day sections say *when*.
/// Stored in the settings table (`groups`), members inside, so one write changes a group.
struct HabitGroup: Identifiable, Codable, Hashable, Sendable {
    var id = UUID()
    var name: String
    var color: HabitColor
    /// The habits in it. IDs of deleted habits are ignored wherever this is read.
    var habits: [UUID] = []

    /// A to Z, the default order until the person drags one (report 24).
    static func sortedAZ(_ list: [HabitGroup]) -> [HabitGroup] {
        list.sorted { $0.name.localizedStandardCompare($1.name) == .orderedAscending }
    }
}

/// The group each screen shows, remembered when the app reopens (Navigation, Round 3). Today and Progress keep their own:
/// Today is for doing, Progress for looking, and changing one shouldn't move the other.
enum GroupFilter {
    static let today = "today.group"
    static let progress = "progress.group"
}

extension HabitStore {
    /// The habit's group, if it has one.
    func group(of habitID: UUID) -> HabitGroup? {
        guard let id = groupOf[habitID] else { return nil }
        return groups.first { $0.id == id }
    }

    /// Whether a habit shows under a group filter; nil is All, which shows everything.
    func isInGroup(_ habit: Habit, _ groupID: UUID?) -> Bool {
        groupID == nil || groupOf[habit.id] == groupID
    }

    /// A group that still exists, from a saved choice (Today's or Progress's); a deleted group reads as All.
    func existingGroup(_ raw: String) -> UUID? {
        guard let id = UUID(uuidString: raw), groups.contains(where: { $0.id == id }) else { return nil }
        return id
    }

    /// The group's habits that aren't archived, in the habits' own order.
    func members(of group: HabitGroup) -> [Habit] {
        let ids = Set(group.habits)
        return habits.filter { ids.contains($0.id) && !$0.archived }
    }

    /// A colour for a new group: the first no group uses yet.
    func suggestedGroupColor() -> HabitColor {
        let used = Set(groups.map(\.color))
        return [HabitColor.green, .blue, .purple, .orange, .pink, .teal, .indigo, .red, .yellow, .mint, .cyan, .brown]
            .first { !used.contains($0) } ?? .green
    }

    /// How many habits a group's chip shows on a day (report 18): what the filter would show there, paused ones aside.
    /// Quit habits show on today only. Nil for a group with no habits at all ("–").
    func groupCount(_ groupID: UUID?, on day: LocalDay) -> Int? {
        let today = today()
        let list = habits.filter { !$0.archived && isInGroup($0, groupID) }
        if groupID != nil && list.isEmpty { return nil }
        return list.filter { habit in
            guard startDay(of: habit) <= day else { return false }
            if habit.kind == .quit { return day == today && !isPaused(habit, on: today) }
            return isDue(habit, on: day)
        }.count
    }
}
