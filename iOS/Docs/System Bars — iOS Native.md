# System Bars — iOS Native

Written by Claude (Claude Code), 5 November 2026, at the user's request: "update this section, system bars. These are native Android ones … update it with iOS ones. So here we have a Google Drive icon, but as you know, Google Drive is only for Android, and we need iCloud in iOS."

Figma: file `zLgBjb7M7Fp6UN0pg7J3a8`, section `04 · System bars & icons` (node `1299:2425`) on the design system page.

## Where each part comes from

- **The drawings:** Apple's own, from its **iOS and iPadOS 26** Figma kit. Figma's libraries list it, so it can be read without being added to the file: `search_design_system` with the kit's library key, then `importComponentByKeyAsync`. The pieces were copied in as plain vectors, so this file has no link to the kit.
- **The sizes:** measured on the user's iPhone 16, iOS 26.6, with a blank test app (`Research/Temp/ios-bars/`, git-ignored): screen 393 × 852, status bar 54, top safe area 59, bottom safe area 34.
- **Why the iOS 26 kit and not iOS 27:** it matches the user's phone, down to the outlined battery. The iOS 27 kit is also there and draws a filled battery with a smaller Dynamic Island on the iPhone 18 Pro. Colours and text were measured on iOS 26.6 too.

| Component | Size | What's in it |
|---|---|---|
| Status bar (`552:27`) | 360 × 54 | Time in SF Pro Semibold 17/22, tracking 0; Apple's signal, Wi-Fi and battery; Dynamic Island 125 × 37 |
| Home Indicator (`552:30`, was Gesture navigation) | 360 × 34 | One 144 × 5 bar, 8 above the bottom edge |
| iCloud logo (`554:20`, was Google Drive logo) | 24 × 24 | Apple's `icloud` symbol, unmodified, in Label |

**Not measured:** a screenshot of the phone leaves out both the Dynamic Island and the Home Indicator, so those two sizes are the kit's. The kit draws the bar at 144 wide on a 402-wide screen.

**iCloud:** `Image(systemName: "icloud")`, the outline the app already uses. Apple's rule, in the SF Symbols metadata on this Mac: the symbol "may not be modified and may only be used to refer to Apple's iCloud service." The kit has no iCloud component. The vector was read from this Mac's symbol set by `Research/Temp/ios-bars/sym2.swift`, which uses a private CoreUI call, so it's for design work only and never goes in the app.

**On dark screens** the time, signal, Wi-Fi, battery and bar are `iOS/Standard/White`, set on that screen's copy. These are Home screen (native), the two Widgets search frames, and the Lock screen's Home Indicator.

## What changed on the screens

The status bar grew by 18 and the bottom bar by 10, so a screen has 28 less room inside its 800. Frames stayed 360 × 800.

- **About 150 screens with a flexible area** took it up by themselves.
- **70 hand-placed screens:** the top bar and content moved down 18. 12 long pages grew by 28 rather than lose content, and 4 fixed content areas shrank by 28.
- **5 "Top" frames** (status bar plus top bar) went from 100 to 118.
- **145 sheets and overlays** that reached the status bar moved down 18. Those reaching the bottom edge lost the same height.
- **6 keyboards** moved up 10.
- **Navigation drawer:** its top padding went from 36 to 54.
- **Copied Android bars:** 18 status bars, 24 gesture bars and 5 loose handles became the components.

Looked at by eye: Today, Day details, a keyboard screen, the drawer, New habit, Home screen, Lock screen, Notification shade, the widget search. Not every screen was looked at.

## Still open

- **The screens are Android's 360 × 800; the iPhone 16 is 393 × 852.** The 52 points of extra height would more than cover the 28 these bars took, and every width would become true. The components are built to stretch (time left, island centred, signal right), so they'd follow.
- **Google Drive is still in the flows:** 51 pieces of text across Settings 19, Onboarding 14, Plus 10 and Today 8, plus 3 on the design system page. These are real journeys ("Allow Google Drive", "Your Google Drive is full"), not a swapped logo. The iPhone backs up to iCloud only (Rulebook D4), so these flows need redesigning for iCloud.
- ~~The Icon component is still Material Symbols.~~ **Done the same day:** every icon is an SF Symbol ([Icons](<Icons — iOS Native.md>)). The count here was far too low: it was about 24,000 pieces of text and 184 glyphs, since this one missed copies inside copies.
- **Android's own system screens remain:** the Gboard keyboard, Alarms & reminders, Save a file, the Notification shade and the Lock screen's layout.
- **The rest of Apple's kit hasn't been compared with this file.** It wasn't opened for the colour and text work, and now it can be: its Keyboard, Alert and Tab Bar are all there.

## Checking this in Figma

- **Copies can hold their own height.** 110 status bars and 247 indicators kept their old height after the main component changed, so read every instance's height afterwards.
- **A colour set on a copy's child is lost when that child is deleted.** Status bars on dark screens went black, so look at the dark screens after rebuilding a component.
- **A script that throws is rolled back whole:** read the state, then run it again.
- **`devicectl device capture screenshot` takes whatever is open on the phone.** Launch a blank app first, delete anything captured by mistake, and don't keep the pictures.
