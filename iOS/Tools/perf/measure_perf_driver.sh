#!/bin/bash
# Speed runs (30 Sep 2026). Launches the app on the simulator with NO UI test attached, once per scenario:
#   -perf-history  a year of history          -perf-meter  record main-thread stalls (MainThreadMeter)
#   -perf-drive X  the app uses itself: scrolls, taps, switches days and months, types, moves through a routine (PerfDriver)
# XCTest isn't used here because its screen reading runs on the app's main thread (up to 79 % of it in the first run).
# `sample` runs through each scenario (opens included) and names the app's slowest functions. Writes a Markdown summary.
# Usage (from iOS/): Tools/perf/measure_perf_driver.sh <simulator id> <out dir>. On CI: [ios-perf] in the commit message.
# The older XCTest speed tests (measure_perf.sh, [ios-perf-xctest]) cover screens with no scenario here yet.
# Needs a build from `xcodebuild build-for-testing ... -derivedDataPath DerivedData`.
set -u
SIM="$1"; OUT="$2"; mkdir -p "$OUT"
HERE="$(cd "$(dirname "$0")" && pwd)"
BUNDLE=com.oftenenough.app
SCENARIOS="${PERF_SCENARIOS:-scroll-today tap-today groups arrange menu menu-pages all-habits habit-page habit-page-total habit-page-quit habit-edit progress progress-year calendar new-habit form-parts player day-sheet log-sheet add-screens notes typing-control widget-guide widget-log widget-publish privacy app-lock lock-keypad account backup-page backup-states onboarding}"
SUMMARY="$OUT/perf-summary.md"
OPENS="$OUT/opens.txt"; : > "$OPENS"
TIMED="$OUT/timed.txt"; : > "$TIMED"

APP=$(ls -d DerivedData/Build/Products/Debug-iphonesimulator/Habits.app 2>/dev/null | head -1)
[ -n "$APP" ] || { echo "No Habits.app in DerivedData" > "$SUMMARY"; exit 1; }
xcrun simctl install "$SIM" "$APP"
DATA=$(xcrun simctl get_app_container "$SIM" "$BUNDLE" data)
REC="$DATA/tmp/perf-stalls.txt"

{
  echo "| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |"
  echo "|---|---|---|---|---|---|"
} > "$SUMMARY"

# Apple's Bash 3.2 treats an empty array expansion as unbound with set -u.
# Both branches use explicit argument lists so consent-off launches are actually measured.
launch_scenario() {
  if [ "${PERF_ANALYTICS:-0}" = "1" ]; then
    xcrun simctl launch "$SIM" "$BUNDLE" -uitest -perf-history -perf-meter -perf-drive "$1" -perf-analytics
  else
    xcrun simctl launch "$SIM" "$BUNDLE" -uitest -perf-history -perf-meter -perf-drive "$1"
  fi
}
FAIL=0
for S in $SCENARIOS; do
  xcrun simctl terminate "$SIM" "$BUNDLE" > /dev/null 2>&1
  sleep 1
  rm -f "$REC"
  LAUNCH=$(launch_scenario "$S" 2>&1)
  echo "$LAUNCH" > "$OUT/launch-$S.txt"
  PID=$(echo "$LAUNCH" | sed -n 's/.*: *\([0-9][0-9]*\)$/\1/p' | tail -1)
  if [ -z "$PID" ]; then
    echo "**$S launch failed:** see launch-$S.txt; no timing measured." >> "$SUMMARY"
    FAIL=1
    continue
  fi
  # Measure without a profiler: sample's attach can suspend the app for >8 seconds on a busy
  # hosted Mac. Profile a separate launch below, so that suspension cannot enter these windows.
  WAITED=0
  until grep -q "^# DONE" "$REC" 2>/dev/null || [ $WAITED -ge 180 ]; do sleep 1; WAITED=$((WAITED + 1)); done
  cp "$REC" "$OUT/stalls-$S.txt" 2>/dev/null
  xcrun simctl terminate "$SIM" "$BUNDLE" > /dev/null 2>&1

  RESULT=$(python3 "$HERE/analyze_stalls.py" "$OUT/stalls-$S.txt")
  echo "$RESULT" | sed -n 's/^open=/- /p' >> "$OPENS"
  echo "$RESULT" | sed -n 's/^time=//p' | while IFS='|' read -r NAME COUNT TOTAL LONGEST; do
    echo "| $S | $NAME | $COUNT | $TOTAL ms | $LONGEST ms |" >> "$TIMED"
  done
  BUSY=""; TOP=""
  # Samples diagnose code; they are never mixed into the timing record above.
  case " ${PERF_PROFILE_SCENARIOS:-scroll-today new-habit day-sheet log-sheet notes} " in
    *" $S "*)
      rm -f "$REC"
      LAUNCH=$(launch_scenario "$S" 2>&1)
      PID=$(echo "$LAUNCH" | sed -n 's/.*: *\([0-9][0-9]*\)$/\1/p' | tail -1)
      case "$S" in day-sheet) SAMPLE_SECONDS=75;; log-sheet) SAMPLE_SECONDS=95;; *) SAMPLE_SECONDS=38;; esac
      if [ -n "$PID" ]; then
        sample "$PID" "$SAMPLE_SECONDS" 1 -file "$OUT/sample-$S.txt" > /dev/null 2>&1 &
        SAMPLER=$!
        WAITED=0
        until grep -q "^# DONE" "$REC" 2>/dev/null || [ $WAITED -ge 180 ]; do sleep 1; WAITED=$((WAITED + 1)); done
        wait "$SAMPLER" 2>/dev/null
        cp "$REC" "$OUT/profile-stalls-$S.txt" 2>/dev/null
      fi
      xcrun simctl terminate "$SIM" "$BUNDLE" > /dev/null 2>&1
      if [ -s "$OUT/sample-$S.txt" ]; then
        SAMPLED=$(python3 "$HERE/analyze_sample.py" "$OUT/sample-$S.txt" 4)
        BUSY="$(echo "$SAMPLED" | sed -n 's/^busy=//p') % (separate profile)"
        TOP=$(echo "$SAMPLED" | tail -n +3 | sed 's/^ *//' | paste -sd ';' - | sed 's/;/<br>/g')
      fi
      ;;
  esac
  if ! grep -q "^# DONE" "$OUT/stalls-$S.txt" 2>/dev/null || grep -q "^# ERROR" "$OUT/stalls-$S.txt" 2>/dev/null; then FAIL=1; fi
  if grep -q "^# ERROR" "$OUT/stalls-$S.txt" 2>/dev/null; then
    echo "**$S failed:** native keyboard input was unavailable or produced unexpected text; see stalls-$S.txt." >> "$SUMMARY"
  fi
  WINDOWS=$(echo "$RESULT" | grep '^window=')
  # A scenario that only opens screens (menu-pages, habit-edit) has no window: its opens are listed below the table.
  if [ -z "$WINDOWS" ] && ! echo "$RESULT" | grep -q '^open='; then
    FAIL=1
    NOTE=$(echo "$RESULT" | sed -n 's/^note=//p' | paste -sd ' ' -)
    echo "| $S | not measured (${NOTE:-no record: did the app start?}) | | | | |" >> "$SUMMARY"
  fi
  echo "$WINDOWS" | while IFS='|' read -r NAME HITCH LONGEST FREEZES; do
    [ -n "$NAME" ] && echo "| ${NAME#window=} | $HITCH | $LONGEST ms | $FREEZES | $BUSY | ${TOP:-(none above noise)} |" >> "$SUMMARY"
  done
done

{
  echo
  if [ "${PERF_ANALYTICS:-0}" = "1" ]; then
    echo "Analytics: synthetic optional consent enabled; real bounded queue, file persistence and native touch observer exercised. DEBUG delivery cannot reach the production project."
    echo
  fi
  echo "Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026)."
  echo
  echo "Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):"
  echo
  cat "$OPENS"
  if [ -s "$TIMED" ]; then
    echo
    echo "Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):"
    echo
    echo "| Scenario | What | Times | Total | Longest |"
    echo "|---|---|---|---|---|"
    cat "$TIMED"
  fi
} >> "$SUMMARY"

cat "$SUMMARY"
exit "$FAIL"
