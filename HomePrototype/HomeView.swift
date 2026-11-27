import SwiftUI

struct Routine: Identifiable {
    let id = UUID()
    var emoji: String
    var name: String
    var time: String
    var done: Int
    var total: Int
}

@Observable
final class HomeModel {
    var routines: [Routine] = [
        Routine(emoji: "☀️", name: "Morning", time: "7:00 AM", done: 4, total: 5),
        Routine(emoji: "🏃", name: "Running", time: "7:30 AM", done: 2, total: 3),
        Routine(emoji: "🥑", name: "Nutrition", time: "Anytime", done: 3, total: 4),
        Routine(emoji: "📚", name: "Reading", time: "9:00 PM", done: 1, total: 2),
        Routine(emoji: "💧", name: "Hydration", time: "All day", done: 6, total: 8),
        Routine(emoji: "🧘", name: "Mindfulness", time: "6:00 PM", done: 1, total: 2),
        Routine(emoji: "🌙", name: "Wind Down", time: "10:00 PM", done: 0, total: 3),
        Routine(emoji: "🐶", name: "Dog Walk", time: "5:30 PM", done: 2, total: 2),
    ]

    var progress: Double {
        let total = routines.reduce(0) { $0 + $1.total }
        return total == 0 ? 0 : Double(routines.reduce(0) { $0 + $1.done }) / Double(total)
    }
    var doneCount: Int { routines.reduce(0) { $0 + $1.done } }
    var totalCount: Int { routines.reduce(0) { $0 + $1.total } }
}

struct HomeView: View {
    @State private var model = HomeModel()
    @State private var day = Date()
    @State private var editing: Routine.ID?

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    TodayProgressCard(progress: model.progress, done: model.doneCount, total: model.totalCount)

                    VStack(alignment: .leading, spacing: 14) {
                        Text("Your Routines")
                            .font(.title2.weight(.bold))
                        RoutineGrid(routines: model.routines,
                                    onTap: tick,
                                    onChangeEmoji: { editing = $0 })
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
                .padding(.bottom, 32)
            }
            .background(Color(.systemBackground))
            .navigationTitle("Today")
            .navigationSubtitle(day.formatted(.dateTime.weekday(.wide).day().month(.wide)))
            .navigationBarTitleDisplayMode(.inline)
            .toolbarTitleMenu {
                ForEach(-3...3, id: \.self) { offset in
                    let date = Calendar.current.date(byAdding: .day, value: offset, to: .now)!
                    Button {
                        day = date
                    } label: {
                        Text(offset == 0 ? "Today" : date.formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated)))
                        if Calendar.current.isDate(date, inSameDayAs: day) { Image(systemName: "checkmark") }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                        Button("Edit Routines", systemImage: "pencil") {}
                        Button("Change Order", systemImage: "arrow.up.arrow.down") {}
                        Button("Hide Completed", systemImage: "eye.slash") {}
                    } label: {
                        Image(systemName: "ellipsis")
                    }
                    .accessibilityLabel("More")
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {} label: { Image(systemName: "gearshape") }
                        .accessibilityLabel("Settings")
                }
            }
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
    }

    private func tick(_ id: Routine.ID) {
        guard let i = model.routines.firstIndex(where: { $0.id == id }) else { return }
        withAnimation(.snappy) {
            let r = model.routines[i]
            model.routines[i].done = r.done >= r.total ? 0 : r.done + 1
        }
    }
}

// MARK: - Today's progress, with stars at 60, 80 and 100 %

struct TodayProgressCard: View {
    let progress: Double
    let done: Int
    let total: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack(alignment: .firstTextBaseline) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Today’s Progress")
                        .font(.headline)
                    Text("\(done) of \(total) habits done")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Text(progress, format: .percent.precision(.fractionLength(0)))
                    .font(.system(.title, design: .rounded).weight(.bold))
                    .contentTransition(.numericText())
                    .monospacedDigit()
            }
            StarProgressBar(progress: progress)
        }
        .padding(20)
        .background(Color(.secondarySystemBackground), in: .rect(cornerRadius: 26, style: .continuous))
    }
}

struct StarProgressBar: View {
    let progress: Double
    private let stars: [Double] = [0.6, 0.8, 1.0]
    private let starSize: CGFloat = 30

    var body: some View {
        VStack(spacing: 6) {
            GeometryReader { geo in
                // The bar ends at the last star's centre, so the 100 % star sits on the end.
                let width = geo.size.width - starSize / 2
                ZStack(alignment: .leading) {
                    Capsule().fill(Color(.systemFill))
                        .frame(width: width, height: 10)
                    Capsule().fill(Color.primary)
                        .frame(width: max(10, width * progress), height: 10)
                    ForEach(stars, id: \.self) { mark in
                        StarMark(reached: progress >= mark - 0.0001, size: starSize)
                            .position(x: width * mark, y: starSize / 2)
                    }
                }
                .frame(height: starSize)
            }
            .frame(height: starSize)

            GeometryReader { geo in
                let width = geo.size.width - starSize / 2
                ForEach(stars, id: \.self) { mark in
                    Text(mark, format: .percent.precision(.fractionLength(0)))
                        .font(.caption2.weight(.medium))
                        .foregroundStyle(.secondary)
                        .fixedSize()
                        .position(x: width * mark, y: 7)
                }
            }
            .frame(height: 14)
        }
        .accessibilityElement()
        .accessibilityLabel("Today’s progress")
        .accessibilityValue("\(Int(progress * 100)) percent, \(stars.filter { progress >= $0 }.count) of 3 stars")
    }
}

struct StarMark: View {
    let reached: Bool
    let size: CGFloat

    var body: some View {
        ZStack {
            Circle()
                .fill(reached ? Color.yellow : Color(.secondarySystemBackground))
            Circle()
                .strokeBorder(reached ? Color.white : Color(.systemGray4), lineWidth: 2.5)
            Image(systemName: "star.fill")
                .font(.system(size: size * 0.45, weight: .bold))
                .foregroundStyle(reached ? Color.white : Color(.systemGray3))
        }
        .frame(width: size, height: size)
        .shadow(color: .black.opacity(reached ? 0.18 : 0), radius: 3, y: 1.5)
        .scaleEffect(reached ? 1.08 : 1)
        .animation(.spring(response: 0.35, dampingFraction: 0.55), value: reached)
    }
}

// MARK: - Routine cards, two columns of different heights

struct RoutineGrid: View {
    let routines: [Routine]
    let onTap: (Routine.ID) -> Void
    let onChangeEmoji: (Routine.ID) -> Void

    var body: some View {
        let left = routines.enumerated().filter { $0.offset % 2 == 0 }.map(\.element)
        let right = routines.enumerated().filter { $0.offset % 2 == 1 }.map(\.element)
        HStack(alignment: .top, spacing: 14) {
            column(left, tallFirst: true)
            column(right, tallFirst: false)
        }
    }

    private func column(_ items: [Routine], tallFirst: Bool) -> some View {
        VStack(spacing: 14) {
            ForEach(Array(items.enumerated()), id: \.element.id) { index, routine in
                let tall = (index % 2 == 0) == tallFirst
                RoutineCard(routine: routine, height: tall ? 196 : 156)
                    .onTapGesture { onTap(routine.id) }
                    .contextMenu {
                        Button("Change Emoji", systemImage: "face.smiling") { onChangeEmoji(routine.id) }
                    }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct RoutineCard: View {
    let routine: Routine
    let height: CGFloat

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top) {
                StickerEmoji(emoji: routine.emoji, size: 40)
                    .padding(.top, 2)
                Spacer()
                if routine.done >= routine.total {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.title3)
                        .foregroundStyle(.primary.opacity(0.75))
                        .transition(.scale.combined(with: .opacity))
                }
            }
            Spacer(minLength: 8)
            Text(routine.name)
                .font(.headline)
                .lineLimit(1)
            Text("\(routine.done) of \(routine.total) · \(routine.time)")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .contentTransition(.numericText())
                .lineLimit(1)
                .padding(.top, 2)
        }
        .padding(16)
        .frame(maxWidth: .infinity, minHeight: height, alignment: .leading)
        .background(PaleColor.fill(for: routine.emoji), in: .rect(cornerRadius: 26, style: .continuous))
        .contentShape(.rect(cornerRadius: 26, style: .continuous))
        .animation(.easeInOut(duration: 0.35), value: routine.emoji)
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isButton)
    }
}

// MARK: - Try any emoji and watch the card colour follow it

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
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    RoutineCard(routine: Routine(emoji: choice, name: routine.name, time: routine.time,
                                                 done: routine.done, total: routine.total),
                                height: 150)
                        .frame(width: 190)

                    if let hue = EmojiHue.hue(of: choice) {
                        HStack(spacing: 8) {
                            Circle().fill(PaleColor.source(for: choice)).frame(width: 14, height: 14)
                            Image(systemName: "arrow.right").font(.caption2)
                            Circle().fill(PaleColor.fill(for: choice)).frame(width: 14, height: 14)
                                .overlay(Circle().strokeBorder(Color(.separator)))
                            Text("Hue \(Int(hue.rounded()))° · OKLCH L 0.935, C 0.030")
                        }
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                    } else {
                        Text("No main colour found · neutral card")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }

                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 6), spacing: 8) {
                        ForEach(emojis, id: \.self) { e in
                            Button {
                                withAnimation(.easeInOut(duration: 0.3)) { choice = e }
                            } label: {
                                Text(e)
                                    .font(.system(size: 30))
                                    .frame(maxWidth: .infinity, minHeight: 50)
                                    .background(PaleColor.fill(for: e), in: .circle)
                                    .overlay(Circle().strokeBorder(Color.primary.opacity(choice == e ? 0.6 : 0), lineWidth: 2))
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(20)
            }
            .navigationTitle("Emoji")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(role: .close) { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { onPick(choice); dismiss() }
                        .fontWeight(.semibold)
                }
            }
        }
        .presentationDetents([.large])
    }
}

#Preview { HomeView() }
