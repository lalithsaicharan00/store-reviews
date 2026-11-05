import SwiftUI

let ink = Color(red: 0x30/255, green: 0x30/255, blue: 0x30/255)
let habitGreen = Color(red: 0x34/255, green: 0xC7/255, blue: 0x59/255)

@main
struct ProbeApp: App {
    var body: some Scene {
        WindowGroup {
            Root(variant: UserDefaults.standard.string(forKey: "variant") ?? "index")
                .tint(ink)
        }
    }
}

struct Root: View {
    let variant: String
    var body: some View { Variants.view(variant) }
}

/// A blank page that presents its variant the way the app would (sheet or full screen).
struct Presenter<Content: View>: View {
    enum Style { case sheet, cover }
    let style: Style
    @ViewBuilder let content: () -> Content
    @State private var shown = false
    var body: some View {
        Color(.systemGroupedBackground).ignoresSafeArea()
            .onAppear { shown = true }
            .sheet(isPresented: Binding(get: { shown && style == .sheet }, set: { shown = $0 })) {
                content().presentationDetents([.large])
            }
            .fullScreenCover(isPresented: Binding(get: { shown && style == .cover }, set: { shown = $0 })) {
                content()
            }
    }
}
