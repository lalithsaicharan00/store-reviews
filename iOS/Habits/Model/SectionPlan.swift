import Foundation

/// What adding a time of day, or changing one's times, does to the others (the user, 3 Oct 2026): a new time of day
/// whose times fall across existing ones **splits** them. Morning 9–12 and Afternoon 12–5 with a new Mid Morning
/// 11–2 become Morning 9–11, Mid Morning 11–2, Afternoon 2–5. Worked out here, without saving, so the form can show
/// exactly how the day will look and ask before anything is split.
///
/// Times of day still have only a start (the latest also an end); each ends where the next begins. So the plan moves
/// starts: one that falls inside the new times moves to its end, and the one the new times start in ends there.
struct SectionPlan {
    /// One timed section as it will be, with how it was (nil for the new one).
    struct Row: Identifiable, Equatable {
        let id: String
        let name: String
        let start: Int
        let end: Int
        let oldStart: Int?
        let oldEnd: Int?
        /// The one being added or edited.
        let isSubject: Bool

        var changed: Bool { oldStart != start || oldEnd != end }
        var range: String { "\(DaySection.clock(start))–\(DaySection.clock(end))" }
        var oldRange: String? {
            guard let oldStart, let oldEnd else { return nil }
            return "\(DaySection.clock(oldStart))–\(DaySection.clock(oldEnd))"
        }
    }

    /// Every timed section after the change, by start.
    let rows: [Row]
    /// Why it can't be saved, if it can't.
    let problem: String?
    /// The whole list to save (Anytime included).
    let sections: [DaySection]

    /// The other sections whose times change: these are split, and the person is asked first.
    var split: [Row] { rows.filter { !$0.isSubject && $0.changed } }
    var subject: Row? { rows.first(where: \.isSubject) }

    /// - Parameters:
    ///   - sections: the saved list.
    ///   - subject: the section being added (a new ID) or edited (its ID), with its new name.
    ///   - start, end: clock minutes; an end at or before the start is after midnight.
    ///   - defaultEnd: where the latest section ends when it has no end of its own.
    static func make(sections: [DaySection], subject: DaySection, start: Int, end: Int, defaultEnd: Int = 24 * 60) -> SectionPlan {
        let timed = sections.filter { !$0.isAnytime }.sorted { $0.start! < $1.start! }
        let before = ranges(timed, defaultEnd: defaultEnd)
        let was = Dictionary(before.map { ($0.section.id, ($0.start, $0.end)) }, uniquingKeysWith: { a, _ in a })

        // Take the subject out. Its old times go to the section before it (as they would if it were deleted); if it
        // was the latest, the one before it keeps the day's end.
        var rest = timed.filter { $0.id != subject.id }
        if let old = before.first(where: { $0.section.id == subject.id }), old.section.id == timed.last?.id,
           let last = rest.indices.last {
            rest[last].end = old.end
        }

        let s = start
        let e = end > start ? end : end + 24 * 60
        var placed: [(section: DaySection, start: Int, end: Int)] = []
        var covered: [String] = []
        for range in ranges(rest, defaultEnd: defaultEnd) {
            if range.start < s {
                // Starts before: it now ends where the new times begin (or earlier, as it was).
                placed.append((range.section, range.start, min(range.end, s)))
            } else if range.start < e {
                // Starts inside the new times: it moves to their end, unless they cover all of it.
                if range.end <= e { covered.append(range.section.name) } else { placed.append((range.section, e, range.end)) }
            } else {
                placed.append(range)
            }
        }
        // The section the new times start in keeps the rest of the day only when it's the latest; otherwise the new
        // section runs on until the next one starts, since a time of day ends where the next begins.
        let next = placed.filter { $0.start >= e }.min { $0.start < $1.start }
        let subjectEnd = next?.start ?? e
        // Before the first section, the new one runs on until the first starts; after the last, the last runs on until
        // the new one starts. Both follow from "each ends where the next begins".
        if let i = placed.indices.filter({ placed[$0].start < s }).max(by: { placed[$0].start < placed[$1].start }) {
            placed[i].end = s
        }
        placed.append((subject, s, subjectEnd))
        placed.sort { $0.start < $1.start }

        let rows = placed.map { item in
            Row(id: item.section.id, name: item.section.id == subject.id ? subject.name : item.section.name,
                start: item.start, end: item.end, oldStart: was[item.section.id]?.0, oldEnd: was[item.section.id]?.1,
                isSubject: item.section.id == subject.id)
        }

        var problem: String?
        if !covered.isEmpty {
            problem = "That covers all of \(HabitCopy.join(covered)). Choose shorter times, or delete \(covered.count == 1 ? "it" : "them") first."
        } else if e - s < 15 {
            problem = "Give it at least 15 minutes."
        } else if e - s > 24 * 60 {
            problem = "It can't be longer than a day."
        }

        // Starts as planned; only the latest keeps its own end (`HabitStore.saveSections` tidies the rest).
        var list = [sections.first(where: \.isAnytime) ?? DaySection.defaults[0]]
        for (i, item) in placed.enumerated() {
            var section = item.section
            if section.id == subject.id { section.name = subject.name }
            section.start = item.start % (24 * 60)
            section.end = i == placed.count - 1 ? item.end : nil
            list.append(section)
        }
        return SectionPlan(rows: rows, problem: problem, sections: list)
    }

    /// Each timed section with its start and end: the next one's start, or the latest's own end.
    private static func ranges(_ timed: [DaySection], defaultEnd: Int) -> [(section: DaySection, start: Int, end: Int)] {
        timed.enumerated().map { i, section in
            (section, section.start!, i + 1 < timed.count ? timed[i + 1].start! : (section.end ?? defaultEnd))
        }
    }
}

extension DaySection {
    /// "Starts 6 AM" under a time of day's name on Today: the start only, with ":00" left out on the hour (the user,
    /// 3 Oct 2026). Worked out once per time and kept, so a header never formats a date while drawing (Rulebook S8).
    static func startsText(_ minutes: Int) -> String {
        if let known = startsCache[minutes] { return known }
        var text = clock(minutes)
        // "6:00 AM" → "6 AM"; a 24-hour "06:00" has no space after it and stays as it is.
        if minutes % 60 == 0, let range = text.range(of: ":00"), range.upperBound < text.endIndex,
           text[range.upperBound].isWhitespace {
            text.removeSubrange(range)
        }
        let result = "Starts " + text
        startsCache[minutes] = result
        return result
    }

    @MainActor private static var startsCache: [Int: String] = [:]
}
