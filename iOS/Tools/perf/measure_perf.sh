#!/bin/bash
# Runs each speed test in PerformanceUITests; reads the app's own stall record (MainThreadMeter) for each test's
# window and samples the app meanwhile (which functions take the time). Writes a Markdown summary.
# Usage (from iOS/): Tools/perf/measure_perf.sh <simulator id> <out dir>
# Needs a build from `xcodebuild build-for-testing ... -derivedDataPath DerivedData`.
set -u
SIM="$1"; OUT="$2"; mkdir -p "$OUT"
HERE="$(cd "$(dirname "$0")" && pwd)"
TESTS="${PERF_TESTS:-testScrollToday testTapToday testScrollAllHabits testScrollHabitPage testCalendarMonths testNewHabitForm testRoutinePlayer}"
SUMMARY="$OUT/perf-summary.md"
OPENS="$OUT/opens.txt"; : > "$OPENS"

{
  echo "| Screen | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | SwiftUI redraw | Most time in the app's own code |"
  echo "|---|---|---|---|---|---|"
} > "$SUMMARY"

for T in $TESTS; do
  LOG="$OUT/$T.log"
  xcodebuild test-without-building -project Habits.xcodeproj -scheme Habits -destination "id=$SIM" \
    -derivedDataPath DerivedData -only-testing:HabitsUITests/PerformanceUITests/$T > "$LOG" 2>&1 &
  RUN=$!
  # Sample once the screen is open (the test prints PERF-READY), or 45 s after the app starts if that never shows.
  # The app from the previous test may still be closing, so wait for a new process.
  OLD=$(pgrep -n -f "Habits\.app/Habits( |$)"); PID=""; WAITED=0; SINCE=0
  while [ $WAITED -lt 300 ]; do
    NOW=$(pgrep -n -f "Habits\.app/Habits( |$)")
    [ -n "$NOW" ] && [ "$NOW" != "$OLD" ] && PID=$NOW
    grep -q "PERF-READY" "$LOG" && break
    kill -0 $RUN 2>/dev/null || break
    [ -n "$PID" ] && SINCE=$((SINCE + 1)) && [ $SINCE -ge 45 ] && break
    sleep 1; WAITED=$((WAITED + 1))
  done
  PID=$(pgrep -n -f "Habits\.app/Habits( |$)")
  if [ -n "$PID" ] && kill -0 $RUN 2>/dev/null; then
    sleep 2
    sample "$PID" 15 1 -file "$OUT/sample-$T.txt" > /dev/null 2>&1
  fi
  wait $RUN; STATUS=$?
  # The app's container holds its stall record (the file keeps every test's; each test reads its own window).
  DATA=$(xcrun simctl get_app_container "$SIM" com.lalithsaicharan.habits data 2>/dev/null)
  STALLS=$(python3 "$HERE/analyze_stalls.py" "$DATA/tmp/perf-stalls.txt" "$LOG")
  echo "$STALLS" | sed -n 's/^open=/- /p' >> "$OPENS"
  HITCH=$(echo "$STALLS" | sed -n 's/^hitch=//p')
  LONGEST=$(echo "$STALLS" | sed -n 's/^longest=//p')
  FREEZES=$(echo "$STALLS" | sed -n 's/^freezes=//p')
  REDRAW=""; TOP=""
  if [ -s "$OUT/sample-$T.txt" ]; then
    RESULT=$(python3 "$HERE/analyze_sample.py" "$OUT/sample-$T.txt" 4)
    REDRAW="$(echo "$RESULT" | sed -n 's/^redraw=//p') %"
    TOP=$(echo "$RESULT" | tail -n +3 | sed 's/^ *//' | paste -sd ';' - | sed 's/;/<br>/g')
  fi
  if [ -n "$HITCH" ]; then
    echo "| $T | $HITCH | $LONGEST ms | $FREEZES | $REDRAW | ${TOP:-(none above noise)} |" >> "$SUMMARY"
  else
    echo "| $T | not measured (test exit $STATUS; see $T.log) | | | | |" >> "$SUMMARY"
  fi
done

{
  echo
  echo "Opening a screen (longest stall between the tap and the screen being there; under 100 ms feels instant):"
  echo
  cat "$OPENS"
  grep -h "PERF-OPEN-FAILED" "$OUT"/test*.log | sed 's/^PERF-OPEN-FAILED /- did not open: /'
} >> "$SUMMARY"

cat "$SUMMARY"
