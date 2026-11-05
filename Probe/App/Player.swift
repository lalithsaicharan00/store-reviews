import SwiftUI

let medsRed = Color(red: 1, green: 0.27, blue: 0.23)
let skinPurple = Color(red: 0.75, green: 0.35, blue: 0.95)

struct PlayerShell<Content: View, Bottom: View>: View {
    var header = 0   // 0: title menu + "1 of 3" subtitle; 1: title menu + progress bar under the bar
    var index = 1
    @ViewBuilder let content: () -> Content
    @ViewBuilder let bottom: () -> Bottom
    var body: some View {
        NavigationStack {
            content()
                .background(Color(.systemGroupedBackground))
                .safeAreaInset(edge: .top, spacing: 0) {
                    if header == 1 {
                        ProgressView(value: Double(index), total: 3).tint(ink).padding(.horizontal, 20).padding(.vertical, 6)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) { Button { } label: { Image(systemName: "xmark") } }
                    ToolbarItem(placement: .principal) {
                        Button { } label: {
                            VStack(spacing: 0) {
                                HStack(spacing: 4) { Text("Morning").font(.headline); Image(systemName: "chevron.down").font(.caption.weight(.bold)).foregroundStyle(.secondary) }
                                if header == 0 { Text("\(index) of 3").font(.caption).foregroundStyle(.secondary) }
                            }.foregroundStyle(.primary)
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu {
                            Button("Day Details", systemImage: "calendar") { }
                            Button("Go to First Unfinished", systemImage: "arrow.uturn.backward") { }
                            Button("Change Order", systemImage: "arrow.up.arrow.down") { }
                            Divider()
                            Button("End Routine", systemImage: "stop.circle") { }
                        } label: { Image(systemName: "ellipsis") }
                    }
                    ToolbarItem(placement: .bottomBar) { Button { } label: { Image(systemName: "chevron.left") } }
                    ToolbarSpacer(.flexible, placement: .bottomBar)
                    ToolbarItem(placement: .bottomBar) { bottom() }
                    ToolbarSpacer(.flexible, placement: .bottomBar)
                    ToolbarItem(placement: .bottomBar) { Button { } label: { Image(systemName: "chevron.right") } }
                }
        }
    }
}

struct HeroIcon: View {
    let symbol: String; let color: Color; var size: CGFloat = 96
    var body: some View { Circle().fill(color).frame(width: size, height: size).overlay(Image(systemName: symbol).font(.system(size: size*0.42, weight: .semibold)).foregroundStyle(.white)) }
}

struct PlayerCheck: View {
    var header = 0
    var dayButton = false
    var body: some View {
        PlayerShell(header: header) {
            VStack(spacing: 0) {
                Spacer()
                HeroIcon(symbol: "pills.fill", color: medsRed)
                Text("Meds").font(.title.bold()).padding(.top, 20)
                Text("With breakfast").foregroundStyle(.secondary).padding(.top, 4)
                if dayButton { Button("Day Details") { }.buttonStyle(.bordered).controlSize(.small).buttonBorderShape(.capsule).padding(.top, 12) }
                Text("Not done").font(.title2).foregroundStyle(.secondary).padding(.top, 28)
                Spacer(); Spacer()
            }.frame(maxWidth: .infinity)
        } bottom: {
            Button { } label: { Label("Mark Done", systemImage: "checkmark") }.buttonStyle(.glassProminent)
        }
    }
}

struct PlayerTime: View {
    var running = false
    var body: some View {
        PlayerShell(index: 2) {
            VStack(spacing: 16) {
                Spacer()
                Text("Morning stretch").font(.title2.bold())
                Text("Neck, shoulders and back, slowly").foregroundStyle(.secondary).lineLimit(1)
                ZStack {
                    Circle().stroke(Color.teal.opacity(0.18), lineWidth: 10)
                    Circle().trim(from: 0, to: 0.4).stroke(Color.teal, style: StrokeStyle(lineWidth: 10, lineCap: .round)).rotationEffect(.degrees(-90))
                    VStack(spacing: 4) {
                        Image(systemName: "figure.flexibility").font(.title).foregroundStyle(Color.teal)
                        Text("4:00").font(.system(size: 64, weight: .light)).monospacedDigit()
                        Text("of 10 min").foregroundStyle(.secondary)
                    }
                }.frame(width: 250, height: 250).padding(.top, 8)
                Spacer(); Spacer()
            }.frame(maxWidth: .infinity)
        } bottom: {
            Button { } label: { Label(running ? "Pause" : "Start", systemImage: running ? "pause.fill" : "play.fill") }.buttonStyle(.glassProminent)
        }
    }
}

struct PlayerChecklist: View {
    @State private var done: Set<Int> = [0, 1]
    let steps = ["Cleanser", "Toner", "Serum", "Eye cream", "Moisturiser", "Sunscreen", "Lip balm", "Hand cream"]
    var body: some View {
        PlayerShell(index: 3) {
            List {
                Section {
                    VStack(spacing: 10) {
                        HeroIcon(symbol: "sparkles", color: skinPurple, size: 64)
                        Text("Skincare").font(.title2.bold())
                        Text("After the shower").foregroundStyle(.secondary)
                        HStack { ProgressView(value: 2, total: 8).tint(skinPurple); Text("2 of 8 steps").font(.subheadline).foregroundStyle(.secondary) }.padding(.top, 6)
                    }.frame(maxWidth: .infinity).padding(.vertical, 8)
                }
                Section {
                    ForEach(steps.indices, id: \.self) { i in
                        HStack(spacing: 12) {
                            Image(systemName: done.contains(i) ? "checkmark.circle.fill" : "circle").font(.title2).foregroundStyle(done.contains(i) ? skinPurple : Color(.tertiaryLabel))
                            Text(steps[i]).foregroundStyle(done.contains(i) ? .secondary : .primary)
                        }
                    }
                }
            }
        } bottom: {
            Text("2 of 8").foregroundStyle(.secondary).font(.subheadline)
        }
    }
}

struct PlayerEnd: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack(spacing: 12) {
                        Image(systemName: "checkmark.circle.fill").font(.system(size: 72)).foregroundStyle(ink)
                        Text("Morning is done").font(.title.bold())
                        Text("All 3 done today.").foregroundStyle(.secondary)
                    }.frame(maxWidth: .infinity).padding(.vertical, 12)
                }.listRowBackground(Color.clear)
                Section("Done") {
                    HStack { HeroIcon(symbol: "pills.fill", color: medsRed, size: 30); VStack(alignment: .leading) { Text("Meds"); Text("Done").font(.subheadline).foregroundStyle(.secondary) } }
                    HStack { HeroIcon(symbol: "figure.flexibility", color: .teal, size: 30); VStack(alignment: .leading) { Text("Stretch"); Text("10/10 min").font(.subheadline).foregroundStyle(.secondary) } }
                }
            }
            .navigationTitle("Morning").navigationBarTitleDisplayMode(.inline)
            .toolbar { ToolbarItem(placement: .topBarLeading) { Button { } label: { Image(systemName: "xmark") } } }
            .safeAreaInset(edge: .bottom) { Button { } label: { Text("Done").frame(maxWidth: .infinity) }.buttonStyle(.borderedProminent).controlSize(.large).padding(.horizontal, 20) }
        }
    }
}
