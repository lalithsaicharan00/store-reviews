#!/bin/bash
# Records today's iPhone answers for the shared habit rules' golden cases (Current Work 92; Core/fixtures/README.md).
# The app runs on the simulator with no UI test attached (`-golden-record`), reads the inputs from its own container and
# writes one answer file per input file. Usage (from iOS/): Tools/golden/record.sh <simulator id> <inputs dir> <out dir>.
# Needs a build from `xcodebuild build-for-testing ... -derivedDataPath DerivedData`.
set -u
SIM="$1"; IN="$2"; OUT="$3"; mkdir -p "$OUT"
# simctl's --stdout and --stderr need absolute paths: a relative one made every launch "denied by service delegate"
# (runs 38203920942, 38205203490).
OUT="$(cd "$OUT" && pwd)"
BUNDLE=com.oftenenough.app
APP=$(ls -d DerivedData/Build/Products/Debug-iphonesimulator/Habits.app 2>/dev/null | head -1)
[ -n "$APP" ] || { echo "No Habits.app in DerivedData"; exit 1; }
xcrun simctl install "$SIM" "$APP"
DATA=$(xcrun simctl get_app_container "$SIM" "$BUNDLE" data)
GOLDEN="$DATA/tmp/golden"
rm -rf "$GOLDEN"; mkdir -p "$GOLDEN/in" "$GOLDEN/out"
cp "$IN"/*.json "$GOLDEN/in/"
ls -la "$GOLDEN/in"
xcrun simctl terminate "$SIM" "$BUNDLE" > /dev/null 2>&1
# A freshly booted simulator can refuse a launch while its home screen is still starting ("denied by service
# delegate (SBMainWorkspace)", run 38203920942): try again for up to five minutes.
for TRY in $(seq 1 30); do
  if xcrun simctl launch --stdout="$OUT/app-stdout.txt" --stderr="$OUT/app-stderr.txt" "$SIM" "$BUNDLE" -uitest -golden-record; then
    echo "Launched (try $TRY)"; break
  fi
  sleep 10
done
WAITED=0
LIMIT=${GOLDEN_LIMIT:-2400}
until grep -q "^# DONE" "$GOLDEN/done.txt" 2>/dev/null || [ $WAITED -ge "$LIMIT" ]; do
  sleep 10; WAITED=$((WAITED + 10))
  if [ $((WAITED % 120)) -eq 0 ]; then echo "… ${WAITED}s"; cat "$GOLDEN/done.txt" 2>/dev/null; fi
  # The app ended before it finished: say so rather than waiting the whole limit.
  # The simulator's app is a process on this Mac (a launchctl check inside the simulator missed it, run 38202879977).
  if [ $((WAITED % 60)) -eq 0 ] && ! pgrep -f "Habits.app/Habits" > /dev/null; then
    echo "The app is no longer running after ${WAITED}s"; sleep 5; break
  fi
done
cat "$GOLDEN/done.txt" 2>/dev/null
tail -50 "$OUT/app-stderr.txt" 2>/dev/null
# A crash says why in its report.
for f in $(ls -t ~/Library/Logs/DiagnosticReports/Habits* 2>/dev/null | head -2); do cp "$f" "$OUT/"; head -80 "$f"; done
cp "$GOLDEN"/out/*.json "$OUT/" 2>/dev/null
cp "$GOLDEN/done.txt" "$OUT/recorded.txt" 2>/dev/null
xcrun simctl terminate "$SIM" "$BUNDLE" > /dev/null 2>&1
grep -q "^# DONE" "$OUT/recorded.txt" 2>/dev/null && ! grep -q "FAILED" "$OUT/recorded.txt"
