# Android platform facts — Google's own pages, read 12 Oct 2026

Read by Claude (Claude Code), 12 Oct 2026. Google's developer documentation unless marked "press". Version-scoped
(W2): each fact is what the page said on that date.

## Notifications and reminders
- **POST_NOTIFICATIONS (Android 13+):** notifications are off for new installs until the person allows them; an app
  targeting 13+ chooses when to ask. Google: ask in context after a user action, not at first launch; show a reason
  first when `shouldShowRequestPermissionRationale()` is true; check `areNotificationsEnabled()` before relying on it.
  https://developer.android.com/develop/ui/views/notifications/notification-permission
- **Exact alarms:** `SCHEDULE_EXACT_ALARM` is not pre-granted to fresh installs targeting 13+ ("set to denied by
  default" on Android 14); the person grants it in Settings (Alarms & reminders) and can revoke it, which stops the
  app and cancels its exact alarms. Listen for `ACTION_SCHEDULE_EXACT_ALARM_PERMISSION_STATE_CHANGED` and re-plan.
  `USE_EXACT_ALARM` is granted on install but only for apps whose core function is an alarm clock or calendar; Play
  refuses a release that declares it without qualifying.
  https://developer.android.com/develop/background-work/services/alarms/schedule ·
  https://developer.android.com/about/versions/14/changes/schedule-exact-alarms
- **Without exact alarms:** `set()` / `setAndAllowWhileIdle()` fire "within one hour" of the time on Android 12+;
  `setWindow()` has a 10-minute minimum window. `setExactAndAllowWhileIdle()` fires during Doze at most once per nine
  minutes per app; `setAlarmClock()` always fires on time and wakes the device from Doze (the system shows it as an
  alarm: the alarm-clock icon in the status bar, which reviews complain about).
- **Doze and App Standby:** network, jobs (so WorkManager) and ordinary alarms wait for maintenance windows that grow
  rarer. Google Play forbids asking for a direct battery-optimisation exemption unless Doze breaks the app's core
  function (allowed: chat that can't use FCM, safety apps, task automation, device companions); any app may open the
  general Battery Optimisation settings page (`ACTION_IGNORE_BATTERY_OPTIMIZATION_SETTINGS`).
  https://developer.android.com/training/monitoring-device-state/doze-standby
- **Phone makers that stop apps:** dontkillmyapp.com scores Huawei, Xiaomi, OnePlus and Samsung worst (5 of 5);
  Pixel/AOSP and Nokia 0. (Community site, not Google.) https://dontkillmyapp.com/
- **Full-screen alarms (Android 14):** for apps targeting 14+, `USE_FULL_SCREEN_INTENT` is limited to "calling and
  alarms only"; Google Play revokes it from other apps; people can switch it on and off; check
  `canUseFullScreenIntent()`. https://developer.android.com/about/versions/14/behavior-changes-14
- **Live Updates (Android 16):** a promoted ongoing notification (status-bar chip, top of the shade, lock screen) for
  something "ongoing, user-initiated and time-sensitive" with "a distinct start and end"; needs
  `POST_PROMOTED_NOTIFICATIONS`, `setRequestPromotedOngoing`, ongoing, a title, no custom views; the chip can show a
  chronometer. Not for alerts, promotions or "quick access to app features". A timer the person started toward a goal
  fits; an open-ended stopwatch is a weaker fit (our reading; the page doesn't name timers). Phone makers can add
  their own criteria. https://developer.android.com/develop/ui/compose/notifications/live-update

## Widgets (Jetpack Glance)
- Glance builds widgets with Compose-style Kotlin; actions run in the app's process (`actionRunCallback`, lambdas in
  a WorkManager worker); a widget can't start an activity through a trampoline on Android 12+ (use
  `actionStartActivity`). https://developer.android.com/develop/ui/compose/glance/user-interaction
- `CheckBox`, `Switch`, `RadioButton` are native from Android 12 (Glance backports them); `SizeMode.Responsive` picks
  from a few sizes; lists become a `ListView` (RemoteViews limits); system fonts only.
  https://developer.android.com/develop/ui/compose/glance/build-ui
- Widgets support dynamic colour from Android 12.

## Look and navigation
- **Dynamic colour (Android 12+):** the theme follows the wallpaper; brand colours can stay fixed or be "harmonised".
  Optional, not required. https://developer.android.com/develop/ui/views/theming/dynamic-colors
- **Themed icons (press):** Android 16 QPR2 (Dec 2025) tints icons that have no monochrome layer when the person turns
  icon theming on; apps can't opt out, and Play's distribution agreement now lets people restyle apps. Android
  Authority, 9to5Google (Aug–Dec 2025).
- **Edge-to-edge:** enforced when targeting API 35 on Android 15; for API 36 the opt-out is gone. Gesture bar
  transparent; three-button bar translucent with a scrim.
  https://developer.android.com/develop/ui/views/layout/edge-to-edge
- **Predictive back:** system animations (back-to-home, cross-activity) on by default from Android 15 for apps that
  support it, and by default for apps targeting API 36, where `onBackPressed` is no longer called. Use
  `OnBackPressedCallback` / Compose `BackHandler`; a callback that intercepts back suppresses the animation, so only
  enable it while there's something to protect (unsaved typing).
  https://developer.android.com/guide/navigation/custom-back/predictive-back-gesture
- **Large screens (API 36):** orientation, resizability and aspect-ratio locks are ignored on screens 600dp and wider
  (tablets, unfolded foldables): the app fills the window. https://developer.android.com/about/versions/16/behavior-changes-16

## Google Play
- **Target API:** new apps and updates must target **Android 16 (API 36)** from **31 Aug 2026** (extension to 1 Nov
  2026 on request). https://developer.android.com/google/play/requirements/target-sdk
  So everything above for API 36 applies to our first release.

## Data
- **Auto Backup:** up to 25 MB per app, in a hidden part of the person's Google Drive (not counted against quota),
  about daily when idle on Wi-Fi, only the latest copy kept, restored on reinstall or a new phone before first launch;
  end-to-end encrypted with the screen lock (Android 9+). Android 16 QPR2 adds **cross-platform transfer to and from
  iOS** (`<cross-platform-transfer platform="ios">` with our bundle and team IDs).
  https://developer.android.com/identity/data/autobackup
- **Health Connect:** the Android store for health data (steps, sleep, exercise, mindfulness…), per-type read/write
  permissions; Google Fit APIs end in 2026. https://developer.android.com/health-and-fitness/guides/health-connect
