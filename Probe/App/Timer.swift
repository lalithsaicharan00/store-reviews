import SwiftUI

// A: Clock app grammar — full screen, ring around the clock, two round buttons.
struct TimerA: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HabitIdentity(size: 56)
                    .padding(.top, 8)
                Spacer(minLength: 16)
                Ring(progress: 0.67, width: 10) {
                    VStack(spacing: 4) {
                        Text("6:42").font(.system(size: 72, weight: .light)).monospacedDigit()
                        Text("of 10 min").font(.title3).foregroundStyle(.secondary)
                    }
                }
                .frame(width: 290, height: 290)
                Spacer(minLength: 16)
                HStack {
                    ClockButton(title: "Log Time", tint: Color(.systemGray), prominent: false)
                    Spacer()
                    ClockButton(title: "Pause", tint: habitGreen, prominent: true)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            }
            .navigationTitle("Timer")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) { Button { } label: { Image(systemName: "xmark") } }
                ToolbarItem(placement: .topBarTrailing) { Button("Today") { } }
            }
        }
    }
}

// B/C: sheet, centred identity, Today as a small bordered button, linear bar or ring, glass buttons at the bottom.
struct TimerB: View {
    let ring: Bool
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                if ring {
                    Ring(progress: 0.67, width: 8) {
                        VStack(spacing: 2) {
                            Text("6:42").font(.system(size: 60, weight: .regular)).monospacedDigit()
                            Text("of 10 min").font(.body).foregroundStyle(.secondary)
                        }
                    }
                    .frame(width: 240, height: 240)
                    VStack(spacing: 10) {
                        Text("Stretch").font(.title2.bold())
                        TodayButton()
                    }
                } else {
                    HabitIcon(size: 96)
                    VStack(spacing: 10) {
                        Text("Stretch").font(.title.bold())
                        TodayButton()
                    }
                    VStack(spacing: 12) {
                        HStack(alignment: .firstTextBaseline, spacing: 6) {
                            Text("6:42").font(.system(size: 56, weight: .regular)).monospacedDigit()
                            Text("of 10 min").font(.body).foregroundStyle(.secondary)
                        }
                        ProgressView(value: 0.67).tint(habitGreen).padding(.horizontal, 32)
                    }
                    .padding(.top, 12)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .safeAreaInset(edge: .bottom) {
                HStack(spacing: 12) {
                    Button { } label: { Text("Log Time…").frame(maxWidth: .infinity) }
                        .buttonStyle(.glass)
                    Button { } label: { Label("Pause", systemImage: "pause.fill").frame(maxWidth: .infinity) }
                        .buttonStyle(.glassProminent)
                }
                .controlSize(.large)
                .padding(.horizontal, 20)
                .padding(.bottom, 8)
            }
            .navigationTitle("Timer")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) { Button { } label: { Image(systemName: "xmark") } }
            }
        }
    }
}

// D: list grammar — the clock is the hero; Today and Log Time are rows of one inset section, like Day details.
struct TimerD: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack(spacing: 14) {
                        HabitIcon(size: 72)
                        Text("Stretch").font(.title2.bold())
                        HStack(alignment: .firstTextBaseline, spacing: 6) {
                            Text("6:42").font(.system(size: 64, weight: .regular)).monospacedDigit()
                            Text("of 10 min").foregroundStyle(.secondary)
                        }
                        ProgressView(value: 0.67).tint(habitGreen)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                }
                Section {
                    Label("Log Time…", systemImage: "square.and.pencil")
                    HStack { Label("Day Details", systemImage: "calendar"); Spacer(); Text("Today").foregroundStyle(.secondary); Image(systemName: "chevron.right").font(.footnote.weight(.semibold)).foregroundStyle(.tertiary) }
                }
            }
            .safeAreaInset(edge: .bottom) {
                Button { } label: { Label("Pause", systemImage: "pause.fill").frame(maxWidth: .infinity) }
                    .buttonStyle(.borderedProminent).controlSize(.large).buttonBorderShape(.capsule)
                    .padding(.horizontal, 20).padding(.bottom, 8)
            }
            .navigationTitle("Timer")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) { Button { } label: { Image(systemName: "xmark") } }
            }
        }
    }
}

// E: name as the title, ⋯ menu, ring, round Clock-style buttons in a sheet.
struct TimerE: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Spacer()
                Ring(progress: 0.67, width: 10) {
                    VStack(spacing: 6) {
                        Image(systemName: "figure.flexibility").font(.title).foregroundStyle(habitGreen)
                        Text("6:42").font(.system(size: 64, weight: .light)).monospacedDigit()
                        Text("of 10 min").foregroundStyle(.secondary)
                    }
                }
                .frame(width: 270, height: 270)
                Spacer()
                HStack {
                    ClockButton(title: "Log Time", tint: Color(.systemGray), prominent: false)
                    Spacer()
                    ClockButton(title: "Pause", tint: ink, prominent: true)
                }
                .padding(.horizontal, 28)
                .padding(.bottom, 20)
            }
            .navigationTitle("Stretch")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) { Button { } label: { Image(systemName: "xmark") } }
                ToolbarItem(placement: .topBarTrailing) { Button("Today") { } }
            }
        }
    }
}

struct HabitIcon: View {
    let size: CGFloat
    var body: some View {
        Circle().fill(habitGreen).frame(width: size, height: size)
            .overlay(Image(systemName: "figure.flexibility").font(.system(size: size * 0.48, weight: .medium)).foregroundStyle(.white))
    }
}

struct HabitIdentity: View {
    let size: CGFloat
    var body: some View {
        VStack(spacing: 10) {
            HabitIcon(size: size)
            Text("Stretch").font(.title2.bold())
            TodayButton()
        }
    }
}

struct TodayButton: View {
    var body: some View {
        Button { } label: {
            HStack(spacing: 4) { Text("Today"); Image(systemName: "chevron.right").font(.caption.weight(.semibold)) }
        }
        .buttonStyle(.bordered).controlSize(.small).buttonBorderShape(.capsule)
    }
}

struct Ring<Inner: View>: View {
    let progress: Double
    let width: CGFloat
    @ViewBuilder let inner: () -> Inner
    var body: some View {
        ZStack {
            Circle().stroke(habitGreen.opacity(0.18), lineWidth: width)
            Circle().trim(from: 0, to: progress).stroke(habitGreen, style: StrokeStyle(lineWidth: width, lineCap: .round)).rotationEffect(.degrees(-90))
            inner()
        }
    }
}

/// The Clock app's round timer buttons: a tinted disc with a thin ring around it.
struct ClockButton: View {
    let title: String
    let tint: Color
    let prominent: Bool
    var body: some View {
        Button { } label: {
            ZStack {
                Circle().fill(tint.opacity(prominent ? 1 : 0.22)).frame(width: 82, height: 82)
                Circle().stroke(tint.opacity(prominent ? 1 : 0.22), lineWidth: 2).frame(width: 90, height: 90)
                Text(title).font(.callout.weight(.medium)).foregroundStyle(prominent ? .white : .primary)
            }
        }
        .buttonStyle(.plain)
    }
}

// Round 2: E's body with the header options and every state.
enum TimerState { case running, paused, goalMet, overLimit }

struct TimerF: View {
    var header: Int = 0          // 0: title + subtitle, Day Details word; 1: title + subtitle, ⋯ menu
    var state: TimerState = .running
    var body: some View {
        let limit = state == .overLimit
        let tint: Color = limit ? Color(.systemGray) : habitGreen
        NavigationStack {
            VStack(spacing: 0) {
                Spacer()
                ZStack {
                    Circle().stroke(tint.opacity(0.18), lineWidth: 10)
                    Circle().trim(from: 0, to: state == .goalMet || limit ? 1 : 0.67)
                        .stroke(tint, style: StrokeStyle(lineWidth: 10, lineCap: .round)).rotationEffect(.degrees(-90))
                    VStack(spacing: 6) {
                        Image(systemName: limit ? "iphone" : "figure.flexibility").font(.title).foregroundStyle(limit ? Color(red: 1, green: 45/255, blue: 85/255) : habitGreen)
                        Text(limit ? "31:20" : state == .goalMet ? "10:12" : "6:42").font(.system(size: 64, weight: .light)).monospacedDigit()
                            .minimumScaleFactor(0.5).lineLimit(1)
                        Text(limit ? "of 30 min max" : "of 10 min").foregroundStyle(.secondary)
                    }
                    .padding(.horizontal, 24)
                }
                .frame(width: 270, height: 270)
                Group {
                    switch state {
                    case .running: Text(" ")
                    case .paused: Text("Paused")
                    case .goalMet: Label("Goal met", systemImage: "checkmark.circle.fill")
                    case .overLimit: Text("Over the limit")
                    }
                }
                .font(.subheadline.weight(.semibold)).foregroundStyle(.secondary)
                .padding(.top, 20)
                Spacer()
                HStack {
                    ClockButton(title: "Log Time", tint: Color(.systemGray), prominent: false)
                    Spacer()
                    ClockButton(title: state == .paused ? "Resume" : "Pause", tint: state == .goalMet ? habitGreen : ink, prominent: true)
                }
                .padding(.horizontal, 28)
                .padding(.bottom, 20)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) { Button { } label: { Image(systemName: "xmark") } }
                ToolbarItem(placement: .principal) {
                    VStack(spacing: 0) {
                        Text(limit ? "Social media" : "Stretch").font(.headline)
                        Text("Today").font(.caption).foregroundStyle(.secondary)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    if header == 0 { Button("Day Details") { } }
                    else { Menu { Button("Day Details", systemImage: "calendar") { }; Button("Log Time…", systemImage: "square.and.pencil") { } } label: { Image(systemName: "ellipsis") } }
                }
            }
        }
    }
}
