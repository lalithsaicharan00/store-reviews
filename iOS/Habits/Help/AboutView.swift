import SwiftUI

/// ≡ → About: the version, the name in one line, privacy in plain words, and the open-source acknowledgements the
/// libraries' licences ask for. No links to pages that don't exist yet (the website is Build Plan #72).
struct AboutView: View {
    /// The libraries inside the app (`Core/build.gradle.kts`), with their licences.
    private static let libraries: [(name: String, licence: String)] = [
        ("Kotlin standard library", "Apache License 2.0 · JetBrains"),
        ("kotlinx.coroutines", "Apache License 2.0 · JetBrains"),
        ("AndroidX Room", "Apache License 2.0 · Google"),
        ("AndroidX SQLite", "Apache License 2.0 · Google"),
        ("SQLite", "Public domain"),
    ]

    var body: some View {
        List {
            Section {
                VStack(spacing: 6) {
                    Text(Onboarding.appName)
                        .font(.title2.weight(.bold))
                    Text("Version \(Support.appVersion)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .accessibilityIdentifier("about-version")
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
            }
            Section("The Name") {
                Text("A habit doesn't need a perfect record. It needs to happen often enough.")
            }
            Section("Privacy") {
                Text("No ads and no tracking. An account is optional: without one, your habits stay on this iPhone and nothing leaves it unless you share it.")
            }
            Section {
                ForEach(Self.libraries, id: \.name) { library in
                    VStack(alignment: .leading, spacing: 2) {
                        Text(library.name)
                        Text(library.licence).font(.subheadline).foregroundStyle(.secondary)
                    }
                    .accessibilityElement(children: .combine)
                }
            } header: {
                Text("Acknowledgements")
            } footer: {
                Text("\(Onboarding.appName) is built with these open-source libraries. Thank you to the people who make them.")
            }
        }
        .navigationTitle("About")
        .navigationBarTitleDisplayMode(.inline)
    }
}
