#!/bin/bash
# Build the debug app, then UNINSTALL and install it.
#
# Why not `adb install -r`: on the Pixel 10 emulator a replace-install reported Success while the phone kept running
# the previous APK, so a change looked as though it had never been made (Rulebook T22, 23 Oct 2026). Uninstalling
# first costs a second and never lies.
#
# Anything you pass is handed to Gradle (`--no-build-cache`, `-Pfoo=bar`, …).
set -e
cd "$(dirname "$0")"
: "${JAVA_HOME:=C:\Program Files\Java\jdk-26.0.1}"
export JAVA_HOME
ADB="${ADB:-$LOCALAPPDATA/Android/Sdk/platform-tools/adb.exe}"
[ -x "$ADB" ] || ADB="$(command -v adb)"

./gradlew :app:assembleDebug -Djava.net.preferIPv4Stack=true --offline "$@" 2>&1 | grep -E "^e: |FAILED|BUILD" || true
"$ADB" uninstall com.oftenenough.app >/dev/null 2>&1 || true
"$ADB" install app/build/outputs/apk/debug/app-debug.apk | tail -1
