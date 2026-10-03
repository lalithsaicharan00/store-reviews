#!/bin/bash
# Speed runs on a real iPhone (2 Oct 2026): the same PerfDriver scenarios as measure_perf_driver.sh, launched with
# devicectl instead of simctl, no profiler. The hosted simulator exaggerates some costs (the launch's first keyboard:
# 2.1 s there) and every page push (120-200 ms even for a blank page), so the phone has the final word.
#
# Safe for the person's data: `-uitest` runs on an in-memory database, signed out as its own store ("uitest"), with its
# own backup state and folder and no iCloud (AppModel, BackupCenter). It does overwrite the widgets' snapshot until the
# app's next normal launch, and resets Progress's view options and group filter; this script launches the app
# normally at the end so the widgets show the person's habits again.
#
# Usage (from iOS/, after a Debug device build with -derivedDataPath build-device; the iPhone unlocked, screen on):
#   Tools/perf/measure_perf_device.sh <device id> <out dir>
#   PERF_SCENARIOS="form-parts new-habit" Tools/perf/measure_perf_device.sh <device id> <out dir>
set -u
DEV="$1"; OUT="$2"; mkdir -p "$OUT"
HERE="$(cd "$(dirname "$0")" && pwd)"
BUNDLE=com.oftenenough.app
SCENARIOS="${PERF_SCENARIOS:-arrange form-parts new-habit menu-pages progress all-habits habit-page day-sheet typing-control scroll-today tap-today}"
APP="${PERF_APP:-build-device/Build/Products/Debug-iphoneos/Habits.app}"
SUMMARY="$OUT/perf-summary-device.md"
[ -d "$APP" ] || { echo "No app at $APP: build first (iOS/README.md)"; exit 1; }
xcrun devicectl device install app --device "$DEV" "$APP" > "$OUT/install.txt" 2>&1 || { echo "Install failed: see $OUT/install.txt"; exit 1; }

{
  echo "# Speed on the iPhone ($(date -u '+%Y-%m-%d %H:%M UTC'), $(git rev-parse --short HEAD 2>/dev/null))"
  echo
  echo "| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms |"
  echo "|---|---|---|---|"
} > "$SUMMARY"
OPENS="$OUT/opens-device.txt"; : > "$OPENS"
for S in $SCENARIOS; do
  rm -f "$OUT/stalls-$S.txt"
  if ! xcrun devicectl device process launch --device "$DEV" --terminate-existing "$BUNDLE" \
       -uitest -perf-history -perf-meter -perf-drive "$S" > "$OUT/launch-$S.txt" 2>&1; then
    echo "| $S | launch failed (see launch-$S.txt) | | |" >> "$SUMMARY"; continue
  fi
  WAITED=0
  until grep -q "^# DONE" "$OUT/stalls-$S.txt" 2>/dev/null || [ $WAITED -ge 300 ]; do
    sleep 5; WAITED=$((WAITED + 5))
    xcrun devicectl device copy from --device "$DEV" --domain-type appDataContainer --domain-identifier "$BUNDLE" \
      --source tmp/perf-stalls.txt --destination "$OUT/stalls-$S.txt" > /dev/null 2>&1
  done
  grep -q "^# DONE" "$OUT/stalls-$S.txt" 2>/dev/null || { echo "| $S | not finished in 300 s (phone locked?) | | |" >> "$SUMMARY"; continue; }
  RESULT=$(python3 "$HERE/analyze_stalls.py" "$OUT/stalls-$S.txt")
  echo "$RESULT" | sed -n 's/^open=/- /p' >> "$OPENS"
  echo "$RESULT" | grep '^window=' | while IFS='|' read -r NAME HITCH LONGEST FREEZES; do
    echo "| ${NAME#window=} | $HITCH | $LONGEST ms | $FREEZES |" >> "$SUMMARY"
  done
done
{
  echo
  echo "Opening a screen (longest stall in the 1.5 s after the command; compare with the blank page in menu-pages):"
  echo
  cat "$OPENS"
} >> "$SUMMARY"
# Back to normal: the person's own database, and the widgets republished from it.
xcrun devicectl device process launch --device "$DEV" --terminate-existing "$BUNDLE" > /dev/null 2>&1
cat "$SUMMARY"
