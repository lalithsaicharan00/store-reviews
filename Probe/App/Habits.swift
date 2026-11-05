import SwiftUI

struct HabitCardP: View {
    let name: String; let sub: String; let symbol: String; let color: Color; let head: String; let foot: String
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center, spacing: 12) {
                HeroIcon(symbol: symbol, color: color, size: 30)
                VStack(alignment: .leading, spacing: 0) { Text(name).font(.headline); Text(sub).font(.subheadline).foregroundStyle(.secondary) }
                Spacer()
                Menu { Button("Edit") { } } label: { Image(systemName: "ellipsis").font(.body.weight(.semibold)).frame(width: 30, height: 30).background(Circle().fill(Color(.tertiarySystemFill))) }
            }
            VStack(alignment: .leading, spacing: 2) { Text(head).font(.title3.bold()); Text(foot).font(.subheadline).foregroundStyle(.secondary) }
            HStack(spacing: 6) {
                ForEach(0..<7) { i in
                    VStack(spacing: 4) {
                        Text(["Sun","Mon","Tue","Wed","Thu","Fri","Sat"][i]).font(.caption).foregroundStyle(.secondary)
                        RoundedRectangle(cornerRadius: 8).fill(i < 5 ? color : Color(.tertiarySystemFill)).frame(height: 36)
                            .overlay(i < 5 ? Image(systemName: "checkmark").font(.footnote.weight(.bold)).foregroundStyle(.white) : nil)
                    }
                }
            }
        }
        .padding(16).background(RoundedRectangle(cornerRadius: 26).fill(Color(.secondarySystemGroupedBackground)))
    }
}

struct HabitsPage: View {
    var header = 0 // 0 segmented in bar, 1 title menu, 2 large title + segmented below
    @State private var tab = 0
    @State private var period = 0
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    if header == 2 { Picker("", selection: $tab) { Text("Habits").tag(0); Text("Tasks").tag(1) }.pickerStyle(.segmented) }
                    Picker("", selection: $period) { Text("Week").tag(0); Text("Month").tag(1); Text("Year").tag(2) }.pickerStyle(.segmented)
                    Text("Morning").font(.subheadline.weight(.semibold)).padding(.top, 8).padding(.leading, 4)
                    HabitCardP(name: "Stretch", sub: "10 min a day", symbol: "figure.flexibility", color: .teal, head: "Reached on 5 of 5 days so far", foot: "58 min this week")
                    HabitCardP(name: "Skincare", sub: "4 steps a day", symbol: "sparkles", color: skinPurple, head: "Every step on 5 of 6 days so far", foot: "22 steps this week")
                    HabitCardP(name: "Meds", sub: "Once a day", symbol: "pills.fill", color: medsRed, head: "Done on 5 of 6 days so far", foot: "5 days in a row")
                }.padding(.horizontal, 16)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle(header == 2 ? "Habits" : "")
            .navigationBarTitleDisplayMode(header == 2 ? .large : .inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) { Button { } label: { Image(systemName: "line.3.horizontal") } }
                if header == 0 { ToolbarItem(placement: .principal) { Picker("", selection: $tab) { Text("Habits").tag(0); Text("Tasks").tag(1) }.pickerStyle(.segmented).frame(width: 160) } }
                if header == 1 { ToolbarItem(placement: .principal) { Menu { Button("Habits", systemImage: "checkmark") { }; Button("Tasks") { } } label: { HStack(spacing: 4) { Text("Habits").font(.headline); Image(systemName: "chevron.down").font(.caption.weight(.bold)).foregroundStyle(.secondary) }.foregroundStyle(.primary) } } }
                ToolbarItem(placement: .topBarTrailing) { Button { } label: { Image(systemName: "magnifyingglass") } }
                ToolbarItem(placement: .topBarTrailing) { Button { } label: { Image(systemName: "plus") } }
                ToolbarItem(placement: .bottomBar) { Button { } label: { Image(systemName: "chevron.left") } }
                ToolbarSpacer(.flexible, placement: .bottomBar)
                ToolbarItem(placement: .bottomBar) { Button { } label: { VStack(spacing: 0) { Text("This Week").font(.subheadline.weight(.semibold)); Text("18–24 Oct").font(.caption2).foregroundStyle(.secondary) } } }
                ToolbarSpacer(.flexible, placement: .bottomBar)
                ToolbarItem(placement: .bottomBar) { Button { } label: { Image(systemName: "chevron.right") }.disabled(true) }
            }
        }
    }
}
