import SwiftUI

struct Routine: Identifiable {
    let id = UUID()
    var emoji: String
    var name: String
    var time: String
    var done: Int
    var total: Int
    /// Minutes after midnight; nil for Anytime and All day.
    var start: Int? = nil
    var isComplete: Bool { done >= total }
}

@Observable
final class HomeModel {
    var routines: [Routine] = [
        Routine(emoji: "☀️", name: "Morning", time: "7:00 AM", done: 4, total: 5, start: 420),
        Routine(emoji: "🏃", name: "Running", time: "7:30 AM", done: 2, total: 3, start: 450),
        Routine(emoji: "🥑", name: "Nutrition", time: "Anytime", done: 3, total: 4),
        Routine(emoji: "💧", name: "Hydration", time: "All day", done: 6, total: 8),
        Routine(emoji: "🐶", name: "Dog Walk", time: "5:30 PM", done: 2, total: 2, start: 1050),
        Routine(emoji: "🧘", name: "Mindfulness", time: "6:00 PM", done: 1, total: 2, start: 1080),
        Routine(emoji: "📚", name: "Reading", time: "9:00 PM", done: 1, total: 2, start: 1260),
        Routine(emoji: "🌙", name: "Wind Down", time: "10:00 PM", done: 0, total: 3, start: 1320),
    ]

    var done: Int { routines.reduce(0) { $0 + $1.done } }
    var total: Int { routines.reduce(0) { $0 + $1.total } }
    var progress: Double { total == 0 ? 0 : Double(done) / Double(total) }

    /// The one routine whose play button leads: the latest one that has started and
    /// isn't finished; before the first starts, the next one coming; then anything left.
    var upNextID: Routine.ID? {
        let parts = Calendar.current.dateComponents([.hour, .minute], from: .now)
        let now = (parts.hour ?? 0) * 60 + (parts.minute ?? 0)
        let open = routines.filter { !$0.isComplete }
        let timed = open.filter { $0.start != nil }
        if let current = timed.filter({ $0.start! <= now }).max(by: { $0.start! < $1.start! }) { return current.id }
        if let next = timed.min(by: { $0.start! < $1.start! }) { return next.id }
        return open.first?.id
    }
}

struct HomeView: View {
    @State private var model = HomeModel()
    @State private var day = Date()
    @State private var editing: Routine.ID?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                ProgressHero(done: model.done, total: model.total, isToday: Calendar.current.isDateInToday(day))

                VStack(alignment: .leading, spacing: 14) {
                    HStack(alignment: .firstTextBaseline, spacing: 10) {
                        Text("Your Routines")
                            .appFont(28, .black, relativeTo: .title)
                        Text("\(model.routines.count)")
                            .appFont(15, .heavy)
                            .foregroundStyle(Theme.inkSoft)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 3)
                            .background(Theme.ink.opacity(0.07), in: .capsule)
                    }

                    VStack(spacing: 12) {
                        let upNext = model.upNextID
                        ForEach(model.routines) { routine in
                            RoutineRow(routine: routine, isUpNext: routine.id == upNext, onTick: { tick(routine.id) })
                                .contextMenu {
                                    Button("Change Emoji") { editing = routine.id }
                                }
                        }
                    }
                }
            }
            .foregroundStyle(Theme.ink)
            .padding(.horizontal, 20)
            .padding(.top, 8)
            .padding(.bottom, 40)
        }
        .scrollIndicators(.hidden)
        .background(Theme.background)
        .safeAreaInset(edge: .top, spacing: 0) {
            Header(day: $day)
                .background(alignment: .top) {
                    // Cream behind the header, fading out so rows slide softly under it.
                    VStack(spacing: 0) {
                        Theme.background.ignoresSafeArea(edges: .top)
                        LinearGradient(colors: [Theme.background, Theme.background.opacity(0)],
                                       startPoint: .top, endPoint: .bottom)
                            .frame(height: 24)
                    }
                    .padding(.bottom, -24)
                    .allowsHitTesting(false)
                }
        }
        .preferredColorScheme(.light)
        .sheet(item: Binding(
            get: { editing.flatMap { id in model.routines.first { $0.id == id } } },
            set: { editing = $0?.id }
        )) { routine in
            EmojiPickerSheet(routine: routine) { newEmoji in
                if let i = model.routines.firstIndex(where: { $0.id == routine.id }) {
                    model.routines[i].emoji = newEmoji
                }
            }
        }
    }

    private func tick(_ id: Routine.ID) {
        guard let i = model.routines.firstIndex(where: { $0.id == id }) else { return }
        withAnimation(.snappy) {
            let r = model.routines[i]
            model.routines[i].done = r.isComplete ? 0 : r.done + 1
        }
    }
}

// MARK: - Header: menu · Today and the date · settings

struct Header: View {
    @Binding var day: Date

    var body: some View {
        HStack {
            Menu {
                Button("Edit Routines") {}
                Button("Change Order") {}
                Button("Hide Completed") {}
            } label: {
                StickerButtonLabel {
                    MenuIcon().stroke(Theme.ink, style: StrokeStyle(lineWidth: 2.8, lineCap: .round))
                }
            }
            .accessibilityLabel("Menu")

            Spacer()

            Menu {
                ForEach(-3...3, id: \.self) { offset in
                    let date = Calendar.current.date(byAdding: .day, value: offset, to: .now)!
                    Button(offset == 0 ? "Today" : date.formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated))) {
                        day = date
                    }
                }
            } label: {
                // One short line: "Today  Fri 27 Nov ⌄"; any other day just "Thu 26 Nov ⌄".
                HStack(spacing: 7) {
                    if Calendar.current.isDateInToday(day) {
                        Text("Today")
                            .appFont(18, .black, relativeTo: .headline)
                            .foregroundStyle(Theme.ink)
                    }
                    Text(day.formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated)))
                        .appFont(18, Calendar.current.isDateInToday(day) ? .bold : .black, relativeTo: .headline)
                        .foregroundStyle(Calendar.current.isDateInToday(day) ? Theme.inkSoft : Theme.ink)
                    ChevronDown()
                        .stroke(Theme.ink, style: StrokeStyle(lineWidth: 2.4, lineCap: .round, lineJoin: .round))
                        .frame(width: 11, height: 8)
                        .padding(.leading, 1)
                }
                .lineLimit(1)
                .padding(.horizontal, 18)
                .frame(height: 50)
                .background(.white, in: .capsule)
                .overlay(Capsule().strokeBorder(Theme.ink.opacity(0.07), lineWidth: 1))
                .shadow(color: Theme.ink.opacity(0.08), radius: 10, y: 4)
                .contentShape(.capsule)
            }
            .accessibilityLabel("Choose a day")

            Spacer()

            Button {} label: {
                StickerButtonLabel { SettingsIcon() }
            }
            .buttonStyle(SquishStyle())
            .accessibilityLabel("Settings")
        }
        .padding(.horizontal, 20)
        .padding(.top, 4)
        .padding(.bottom, 10)
    }
}

// MARK: - Today's progress: big number, a sticker that cheers, three stars

struct ProgressHero: View {
    let done: Int
    let total: Int
    var isToday = true
    private let stars: [Double] = [0.6, 0.8, 1.0]

    private var progress: Double { total == 0 ? 0 : Double(done) / Double(total) }
    private var starsReached: Int { stars.filter { progress >= $0 - 0.0001 }.count }

    private var mood: String { ["🌱", "⭐️", "🔥", "🏆"][starsReached] }

    private var message: String {
        guard let next = stars.first(where: { progress < $0 - 0.0001 }) else { return "Three stars. What a day!" }
        let needed = Int((next * Double(total)).rounded(.up)) - done
        let which = ["first", "second", "third"][stars.firstIndex(of: next)!]
        return "\(needed) more \(needed == 1 ? "habit" : "habits") to your \(which == "first" ? "first" : "next") star"
    }

    // Three levels: a small label, the big number, then a quieter line that says what's next.
    var body: some View {
        VStack(alignment: .leading, spacing: 26) {
            VStack(alignment: .leading, spacing: 6) {
                HStack(alignment: .top, spacing: 16) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(isToday ? "Today’s progress" : "Progress")
                            .appFont(15, .bold, relativeTo: .subheadline)
                            .foregroundStyle(Theme.inkSoft)
                        Text(progress, format: .percent.precision(.fractionLength(0)))
                            .appFont(56, .black, relativeTo: .largeTitle)
                            .contentTransition(.numericText(value: progress))
                            .monospacedDigit()
                    }
                    Spacer(minLength: 8)
                    StickerEmoji(emoji: mood, size: 56)
                        .rotationEffect(.degrees(-10))
                        .padding(.top, 10)
                        .padding(.trailing, 2)
                        .id(mood)
                        .transition(.scale(scale: 0.4).combined(with: .opacity))
                }
                // Full width under the number and sticker, so it stays on one line.
                Text(message)
                    .appFont(17, .semibold)
                    .foregroundStyle(Theme.ink.opacity(0.78))
                    .fixedSize(horizontal: false, vertical: true)
                    .contentTransition(.opacity)
            }
            StarProgressBar(progress: progress, stars: stars)
        }
        .padding(.horizontal, 24)
        .padding(.top, 24)
        .padding(.bottom, 20)
        .background(Theme.progressCard, in: .rect(cornerRadius: 30, style: .continuous))
        .animation(.spring(response: 0.45, dampingFraction: 0.7), value: done)
    }
}

struct StarProgressBar: View {
    let progress: Double
    let stars: [Double]
    private let badge: CGFloat = 36

    var body: some View {
        VStack(spacing: 8) {
            GeometryReader { geo in
                // The bar ends under the last star's centre, so 100 % sits on the end.
                let width = geo.size.width - badge / 2
                ZStack(alignment: .leading) {
                    Capsule().fill(.white)
                        .frame(width: width, height: 18)
                    Capsule()
                        .fill(LinearGradient(colors: [Theme.barStart, Theme.barEnd], startPoint: .leading, endPoint: .trailing))
                        .frame(width: max(12, (width - 6) * progress), height: 12)
                        .padding(.leading, 3)
                    ForEach(stars, id: \.self) { mark in
                        StarBadge(reached: progress >= mark - 0.0001, size: badge)
                            .position(x: width * mark, y: badge / 2)
                    }
                }
                .frame(height: badge)
            }
            .frame(height: badge)

            GeometryReader { geo in
                let width = geo.size.width - badge / 2
                ForEach(stars, id: \.self) { mark in
                    Text(mark, format: .percent.precision(.fractionLength(0)))
                        .appFont(12, .heavy, relativeTo: .caption)
                        .foregroundStyle(Theme.inkSoft)
                        .fixedSize()
                        .position(x: width * mark, y: 8)
                }
            }
            .frame(height: 16)
        }
        .accessibilityElement()
        .accessibilityLabel("Today’s progress")
        .accessibilityValue("\(Int(progress * 100)) percent, \(stars.filter { progress >= $0 }.count) of 3 stars")
    }
}

struct StarBadge: View {
    let reached: Bool
    let size: CGFloat

    var body: some View {
        ZStack {
            Circle().fill(reached ? Theme.star : .white)
            Circle().strokeBorder(.white, lineWidth: 3)
            StarShape()
                .softFill(reached ? .white : Theme.ink.opacity(0.16), corner: 3)
                .frame(width: size * 0.42, height: size * 0.42)
        }
        .frame(width: size, height: size)
        .shadow(color: Theme.ink.opacity(reached ? 0.22 : 0.08), radius: reached ? 5 : 3, y: 2)
        .scaleEffect(reached ? 1.1 : 1)
        .rotationEffect(.degrees(reached ? -12 : 0))
        .animation(.spring(response: 0.4, dampingFraction: 0.5), value: reached)
    }
}

// MARK: - A routine: one row, one look, always the same spacing

struct RoutineRow: View {
    let routine: Routine
    var isUpNext = false
    let onTick: () -> Void

    var body: some View {
        let deep = PaleColor.deep(for: routine.emoji)

        HStack(spacing: 14) {
            StickerEmoji(emoji: routine.emoji, size: 42)
                .frame(width: 56, height: 56)

            VStack(alignment: .leading, spacing: 5) {
                Text(routine.name)
                    .appFont(21, .heavy, relativeTo: .title3)
                    .lineLimit(1)
                ((isUpNext
                    ? Text("Up next  ·  ").foregroundStyle(Theme.ink).fontWeight(.heavy)
                    : Text(""))
                + Text(routine.time)
                    .foregroundStyle(Theme.inkSoft))
                    .appFont(15, .semibold, relativeTo: .subheadline)
                    .contentTransition(.numericText())
                    .lineLimit(1)
                HabitPips(done: routine.done, total: routine.total, color: deep)
                    .padding(.top, 3)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            PlayButton(isComplete: routine.isComplete, isPrimary: isUpNext)
        }
        .padding(.leading, 14)
        .padding(.trailing, 16)
        .padding(.vertical, 16)
        .background(PaleColor.fill(for: routine.emoji), in: .rect(cornerRadius: 28, style: .continuous))
        .contentShape(.rect(cornerRadius: 28, style: .continuous))
        .onTapGesture(perform: onTick)
        .animation(.easeInOut(duration: 0.35), value: routine.emoji)
    }
}

/// One pip per habit in the routine, filled as each is done.
struct HabitPips: View {
    let done: Int
    let total: Int
    let color: Color

    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<total, id: \.self) { i in
                Capsule()
                    .fill(i < done ? color : color.opacity(0.18))
                    .frame(width: total > 6 ? 12 : 18, height: 6)
            }
        }
        .animation(.snappy, value: done)
        .accessibilityElement()
        .accessibilityLabel("\(done) of \(total) habits done")
    }
}

/// Every routine can be played from its row. Only the one up next is the main
/// action (dark and raised); the rest are quiet white buttons in the same place.
struct PlayButton: View {
    let isComplete: Bool
    let isPrimary: Bool

    var body: some View {
        Button {
            // The routine player comes later; for now the button only shows where it goes.
        } label: {
            ZStack {
                Circle().fill(isPrimary ? Theme.ink : Color.white.opacity(0.75))
                if isComplete {
                    CheckMark()
                        .stroke(Theme.inkSoft, style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                        .frame(width: 17, height: 13)
                } else {
                    PlayTriangle()
                        .softFill(isPrimary ? .white : Theme.ink.opacity(0.85), corner: isPrimary ? 4 : 3)
                        .frame(width: isPrimary ? 17 : 14, height: isPrimary ? 19 : 16)
                        .offset(x: 1.5)
                }
            }
            .frame(width: isPrimary ? 56 : 46, height: isPrimary ? 56 : 46)
            .shadow(color: Theme.ink.opacity(isPrimary ? 0.28 : 0), radius: 7, y: 4)
            .frame(width: 56, height: 56) // same slot either way, so rows line up
            .contentShape(.circle)
        }
        .buttonStyle(SquishStyle())
        .animation(.spring(response: 0.4, dampingFraction: 0.7), value: isPrimary)
        .accessibilityLabel(isComplete ? "Routine done, play again" : "Play routine")
    }
}

// MARK: - Try any emoji and watch the card follow it

struct EmojiPickerSheet: View {
    let routine: Routine
    let onPick: (String) -> Void
    @Environment(\.dismiss) private var dismiss
    @State private var choice: String

    init(routine: Routine, onPick: @escaping (String) -> Void) {
        self.routine = routine
        self.onPick = onPick
        _choice = State(initialValue: routine.emoji)
    }

    private let emojis = Array("☀️🌅🏃🚴🏊🧘🏋️🤸⚽️🎾🥑🍎🍓🍋🥦🥕🍉🫐☕️🍵💧🧃📚✍️🎨🎸🎹🧠💊🦷🛏️🌙⭐️🔥❤️💜💙💚🧡🖤🤍🐶🐱🌿🌸🌻🍀🌊⛰️🧹🧺💰📈🎯⏰📵🙏").map(String.init)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text("Pick an emoji").appFont(26, .black, relativeTo: .title)
                    Spacer()
                    Button { onPick(choice); dismiss() } label: {
                        Text("Done")
                            .appFont(17, .heavy)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 20)
                            .frame(height: 44)
                            .background(Theme.ink, in: .capsule)
                    }
                    .buttonStyle(SquishStyle())
                }

                RoutineRow(routine: Routine(emoji: choice, name: routine.name, time: routine.time,
                                            done: routine.done, total: routine.total), onTick: {})
                    .allowsHitTesting(false)

                if let hue = EmojiHue.hue(of: choice) {
                    Text("Hue \(Int(hue.rounded()))°  ·  every card OKLCH L 0.935, C 0.030")
                        .appFont(14, .semibold)
                        .foregroundStyle(Theme.inkSoft)
                } else {
                    Text("No main colour found, so a neutral card")
                        .appFont(14, .semibold)
                        .foregroundStyle(Theme.inkSoft)
                }

                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 6), spacing: 8) {
                    ForEach(emojis, id: \.self) { e in
                        Button {
                            withAnimation(.easeInOut(duration: 0.3)) { choice = e }
                        } label: {
                            Text(e)
                                .font(.system(size: 30))
                                .frame(maxWidth: .infinity, minHeight: 52)
                                .background(PaleColor.fill(for: e), in: .circle)
                                .overlay(Circle().strokeBorder(Theme.ink.opacity(choice == e ? 0.7 : 0), lineWidth: 2.5))
                        }
                        .buttonStyle(SquishStyle())
                    }
                }
            }
            .foregroundStyle(Theme.ink)
            .padding(20)
            .padding(.top, 8)
        }
        .background(Theme.background)
        .presentationDetents([.large])
        .presentationCornerRadius(32)
    }
}

#Preview { HomeView() }
