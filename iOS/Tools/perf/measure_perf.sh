#!/bin/bash
# Runs each speed test in PerformanceUITests and samples the app while it runs; writes a Markdown summary.
# Usage (from iOS/): Tools/perf/measure_perf.sh <simulator id> <out dir>
# Needs a build from `xcodebuild build-for-testing ... -derivedDataPath DerivedData`.
set -u
SIM="$1"; OUT="$2"; mkdir -p "$OUT"
HERE="$(cd "$(dirname "$0")" && pwd)"
TESTS="testScrollToday testTapToday testScrollAllHabits testScrollHabitPage testCalendarMonths"
SUMMARY="$OUT/perf-summary.md"

{
  echo "| Screen | Main thread busy | SwiftUI redraw | Most time in the app's own code |"
  echo "|---|---|---|---|"
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
    sample "$PID" 20 1 -file "$OUT/sample-$T.txt" > /dev/null 2>&1
  fi
  wait $RUN; STATUS=$?
  if [ -s "$OUT/sample-$T.txt" ]; then
    RESULT=$(python3 "$HERE/analyze_sample.py" "$OUT/sample-$T.txt" 4)
    BUSY=$(echo "$RESULT" | sed -n 's/^busy=//p')
    REDRAW=$(echo "$RESULT" | sed -n 's/^redraw=//p')
    TOP=$(echo "$RESULT" | tail -n +3 | sed 's/^ *//' | paste -sd ';' - | sed 's/;/<br>/g')
    echo "| $T | $BUSY % | $REDRAW % | ${TOP:-(none above noise)} |" >> "$SUMMARY"
  else
    echo "| $T | not measured (test exit $STATUS; see $T.log) | | |" >> "$SUMMARY"
  fi
done

# Apple's scroll hitch ratio: milliseconds of dropped frames per second of scrolling.
xcodebuild test-without-building -project Habits.xcodeproj -scheme Habits -destination "id=$SIM" \
  -derivedDataPath DerivedData -only-testing:HabitsUITests/PerformanceUITests/testScrollHitches > "$OUT/testScrollHitches.log" 2>&1
{
  echo
  echo "Scroll hitches on Today (Apple's measure; under 5 ms/s is smooth, over 10 is visible stutter):"
  echo
  grep -E "measured \[" "$OUT/testScrollHitches.log" | sed -E 's/.*measured \[([^]]*)\] average: ([0-9.]+).*/- \1: **\2**/' | sort -u
  grep -q "measured \[" "$OUT/testScrollHitches.log" || echo "- not reported (see testScrollHitches.log)"
} >> "$SUMMARY"
cat "$SUMMARY"
