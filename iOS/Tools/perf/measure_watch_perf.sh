#!/bin/bash
# Speed runs on the Apple Watch simulator (Current Work 82; Rulebook S2): the Watch app drives itself, with no UI test
# attached, once per scenario (Watch/App/WatchPerf.swift), and records its own main-thread stalls (MainThreadMeter).
# The same record format and analysis as the iPhone's (analyze_stalls.py).
#   launch               cold launch to a usable Today, twice (the second with the system's caches warm)
#   tap-today            +1 and ✓ on Today (a year of history)
#   scroll-today         Today with 30 habits and a year of history
#   day-details          opening Day details, and +1 there
#   crown                turning the Crown in Log manually
#   routine              paging a routine
#   incoming-batch       a 5,000-change batch from the iPhone arriving while Today is on screen
#   complication         writing the complication snapshot
#   first-fill-extreme   the first fill of an extreme account (25,000 logs a year for 15 years) on the Watch simulator
# Usage (from iOS/): Tools/perf/measure_watch_perf.sh <watch simulator id> <out dir>. On CI: [watch-perf].
set -u
SIM="$1"; OUT="$2"; mkdir -p "$OUT"
HERE="$(cd "$(dirname "$0")" && pwd)"
BUNDLE=com.oftenenough.app.watchkitapp
SCENARIOS="${WATCH_PERF_SCENARIOS:-launch tap-today scroll-today day-details crown routine incoming-batch complication first-fill-extreme}"
SUMMARY="$OUT/perf-summary.md"
OPENS="$OUT/opens.txt"; : > "$OPENS"
NOTES="$OUT/notes.txt"; : > "$NOTES"

APP=$(ls -d DerivedData/Build/Products/Debug-watchsimulator/OftenEnoughWatch.app 2>/dev/null | head -1)
[ -n "$APP" ] || { echo "No OftenEnoughWatch.app in DerivedData" > "$SUMMARY"; exit 1; }
xcrun simctl install "$SIM" "$APP"
DATA=$(xcrun simctl get_app_container "$SIM" "$BUNDLE" data)
REC="$DATA/tmp/perf-stalls.txt"

{
  echo "| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms |"
  echo "|---|---|---|---|"
} > "$SUMMARY"

fixture() {
  case "$1" in
    scroll-today) echo "many";;
    first-fill-extreme|complication|incoming-batch) echo "design";;
    *) echo "design";;
  esac
}

FAIL=0
for S in $SCENARIOS; do
  ROUNDS=1; [ "$S" = "launch" ] && ROUNDS=2
  for ROUND in $(seq 1 $ROUNDS); do
    xcrun simctl terminate "$SIM" "$BUNDLE" > /dev/null 2>&1
    sleep 1
    rm -f "$REC"
    START=$(python3 -c 'import time; print(f"{time.time():.3f}")')
    LAUNCH=$(xcrun simctl launch "$SIM" "$BUNDLE" -uitest -perf-meter -perf-history -perf-drive "$S" -watch-fixture "$(fixture "$S")" -clock-hour 10 2>&1)
    echo "$LAUNCH" > "$OUT/launch-$S-$ROUND.txt"
    LIMIT=200; [ "$S" = "first-fill-extreme" ] && LIMIT=1500
    WAITED=0
    until grep -q "^# DONE" "$REC" 2>/dev/null || [ $WAITED -ge $LIMIT ]; do sleep 1; WAITED=$((WAITED + 1)); done
    cp "$REC" "$OUT/stalls-$S-$ROUND.txt" 2>/dev/null
    READY=$(sed -n 's/^# READY //p' "$OUT/stalls-$S-$ROUND.txt" 2>/dev/null | head -1)
    if [ "$S" = "launch" ] && [ -n "$READY" ]; then
      python3 -c "print(f'- Launch to a usable Today (round $ROUND{\" , cold\" if $ROUND == 1 else \", warm\"}): {($READY - $START) * 1000:.0f} ms')" >> "$OPENS"
    fi
    grep '^# NOTE ' "$OUT/stalls-$S-$ROUND.txt" 2>/dev/null | sed 's/^# NOTE /- /' >> "$NOTES"
    grep '^# ERROR ' "$OUT/stalls-$S-$ROUND.txt" 2>/dev/null | sed 's/^# ERROR /- ERROR: /' >> "$NOTES"
    if ! grep -q "^# DONE" "$OUT/stalls-$S-$ROUND.txt" 2>/dev/null || grep -q "^# ERROR" "$OUT/stalls-$S-$ROUND.txt" 2>/dev/null; then FAIL=1; fi
    RESULT=$(python3 "$HERE/analyze_stalls.py" "$OUT/stalls-$S-$ROUND.txt")
    echo "$RESULT" | sed -n 's/^open=/- /p' >> "$OPENS"
    echo "$RESULT" | grep '^window=' | while IFS='|' read -r NAME HITCH LONGEST FREEZES; do
      echo "| ${NAME#window=} | $HITCH | $LONGEST ms | $FREEZES |" >> "$SUMMARY"
    done
  done
  xcrun simctl terminate "$SIM" "$BUNDLE" > /dev/null 2>&1
done

{
  echo
  echo "Targets (Rulebook S): hitch time under 5 ms/s, no freeze of 100 ms or more. Simulator numbers; the Watch has the final word."
  echo
  echo "Openings (longest stall in the 1.5 s after the command) and launches:"
  echo
  cat "$OPENS"
  echo
  echo "Notes (storage and the first fill):"
  echo
  cat "$NOTES"
} >> "$SUMMARY"
cat "$SUMMARY"
exit "$FAIL"
