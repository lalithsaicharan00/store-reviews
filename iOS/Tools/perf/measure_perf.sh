#!/bin/bash
# Speed runs (30 Sep 2026). Launches the app on the simulator with NO UI test attached, once per scenario:
#   -perf-history  a year of history          -perf-meter  record main-thread stalls (MainThreadMeter)
#   -perf-drive X  the app uses itself: scrolls, taps, switches days and months, types, moves through a routine (PerfDriver)
# XCTest isn't used here because its screen reading runs on the app's main thread (up to 79 % of it in the first run).
# `sample` runs during each measured window and names the app's slowest functions. Writes a Markdown summary.
# Usage (from iOS/): Tools/perf/measure_perf.sh <simulator id> <out dir>
# Needs a build from `xcodebuild build-for-testing ... -derivedDataPath DerivedData`.
set -u
SIM="$1"; OUT="$2"; mkdir -p "$OUT"
HERE="$(cd "$(dirname "$0")" && pwd)"
BUNDLE=com.lalithsaicharan.habits
SCENARIOS="${PERF_SCENARIOS:-scroll-today tap-today all-habits habit-page calendar new-habit player}"
SUMMARY="$OUT/perf-summary.md"
OPENS="$OUT/opens.txt"; : > "$OPENS"

APP=$(ls -d DerivedData/Build/Products/Debug-iphonesimulator/Habits.app 2>/dev/null | head -1)
[ -n "$APP" ] || { echo "No Habits.app in DerivedData" > "$SUMMARY"; exit 1; }
xcrun simctl install "$SIM" "$APP"
DATA=$(xcrun simctl get_app_container "$SIM" "$BUNDLE" data)
REC="$DATA/tmp/perf-stalls.txt"

{
  echo "| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |"
  echo "|---|---|---|---|---|---|"
} > "$SUMMARY"

for S in $SCENARIOS; do
  xcrun simctl terminate "$SIM" "$BUNDLE" > /dev/null 2>&1
  sleep 1
  rm -f "$REC"
  LAUNCH=$(xcrun simctl launch "$SIM" "$BUNDLE" -uitest -perf-history -perf-meter -perf-drive "$S" 2>&1)
  PID=$(echo "$LAUNCH" | sed -n 's/.*: *\([0-9][0-9]*\)$/\1/p' | tail -1)
  WAITED=0
  until grep -q "^# MEASURING" "$REC" 2>/dev/null || [ $WAITED -ge 90 ]; do sleep 1; WAITED=$((WAITED + 1)); done
  [ -n "$PID" ] && sample "$PID" 10 1 -file "$OUT/sample-$S.txt" > /dev/null 2>&1
  until grep -q "^# DONE" "$REC" 2>/dev/null || [ $WAITED -ge 180 ]; do sleep 1; WAITED=$((WAITED + 1)); done
  cp "$REC" "$OUT/stalls-$S.txt" 2>/dev/null
  xcrun simctl terminate "$SIM" "$BUNDLE" > /dev/null 2>&1

  RESULT=$(python3 "$HERE/analyze_stalls.py" "$OUT/stalls-$S.txt")
  echo "$RESULT" | sed -n 's/^open=/- /p' >> "$OPENS"
  BUSY=""; TOP=""
  if [ -s "$OUT/sample-$S.txt" ]; then
    SAMPLED=$(python3 "$HERE/analyze_sample.py" "$OUT/sample-$S.txt" 4)
    BUSY="$(echo "$SAMPLED" | sed -n 's/^busy=//p') %"
    TOP=$(echo "$SAMPLED" | tail -n +3 | sed 's/^ *//' | paste -sd ';' - | sed 's/;/<br>/g')
  fi
  WINDOWS=$(echo "$RESULT" | grep '^window=')
  if [ -z "$WINDOWS" ]; then
    NOTE=$(echo "$RESULT" | sed -n 's/^note=//p' | paste -sd ' ' -)
    echo "| $S | not measured (${NOTE:-no record: did the app start?}) | | | | |" >> "$SUMMARY"
  fi
  echo "$WINDOWS" | while IFS='|' read -r NAME HITCH LONGEST FREEZES; do
    [ -n "$NAME" ] && echo "| ${NAME#window=} | $HITCH | $LONGEST ms | $FREEZES | $BUSY | ${TOP:-(none above noise)} |" >> "$SUMMARY"
  done
done

{
  echo
  echo "Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):"
  echo
  cat "$OPENS"
} >> "$SUMMARY"

cat "$SUMMARY"
