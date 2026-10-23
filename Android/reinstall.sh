#!/bin/bash
# Build the debug app, then UNINSTALL and install it.
#
# Why not `adb install -r`: on the Pixel 10 emulator a replace-install reported Success while the phone kept running
# the previous APK, so a change looked as though it had never been made (Rulebook T22, 23 Oct 2026). Uninstalling
# first costs a second and never lies. The build's own failure stops the script, so a stale APK is never installed.
#
# Anything you pass is handed to Gradle (`--no-build-cache`, `-Pfoo=bar`, …).
set -eo pipefail
cd "$(dirname "$0")"

# This PC's JAVA_HOME points at a javapath *file*, which Gradle refuses, so a real JDK is chosen unless JAVA_HOME
# already names a directory with a JVM in it.
if [ ! -f "$JAVA_HOME/lib/jvm.cfg" ]; then
    for jdk in "C:\Program Files\Java\jdk-26.0.1" "$PROGRAMFILES/Java/jdk-26.0.1"; do
        if [ -d "$jdk" ]; then JAVA_HOME="$jdk"; break; fi
    done
fi
export JAVA_HOME

ADB="${ADB:-$LOCALAPPDATA/Android/Sdk/platform-tools/adb.exe}"
[ -x "$ADB" ] || ADB="$(command -v adb)"

./gradlew :app:assembleDebug -Djava.net.preferIPv4Stack=true --offline "$@" | grep -E "^e: |FAILED|BUILD"
"$ADB" uninstall com.oftenenough.app >/dev/null 2>&1 || true
"$ADB" install app/build/outputs/apk/debug/app-debug.apk | tail -1
