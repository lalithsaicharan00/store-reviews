# iOS

The iPhone app (SwiftUI). Apple Watch and widget extensions will live here too.

Not started yet. The throwaway SwiftUI prototype used for the Figma screenshots lives in
`Research/Temp/today-native/ios/` (untracked).

- **Shared core:** Kotlin Multiplatform, compiled to a Kotlin/Native framework and called from Swift. UI stays SwiftUI; domain rules have written specifications and shared fixtures. See the [accepted architecture decision](<../Architecture/Shared Core Decision.md>). Implementation has not started.
- **Platform:** iOS 26, SwiftUI, native components only (inset-grouped List, bottom toolbar, SF Symbols).
- **Signing during development:** Personal Team `5RR56C2WTA` (free Apple ID). Switch to the paid
  developer account before TestFlight / release.
- **Test device:** iPhone 16 (Developer Mode on).
