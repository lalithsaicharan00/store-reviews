#!/bin/sh
# Xcode Cloud runs this after cloning. The "Build Kotlin Core" phase needs Java for Gradle 9 (17 or newer, CI uses 21).
# The phase finds this Java by its path: what a script exports doesn't reach the build.
set -e
HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_CLEANUP=1 brew install openjdk@21
"$(brew --prefix openjdk@21)/libexec/openjdk.jdk/Contents/Home/bin/java" -version
