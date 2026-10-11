#!/bin/bash
# End to end on paired simulators (Current Work 82; Architecture 12 §6): an iPhone and an Apple Watch simulator paired
# with `simctl pair`, the iPhone app (with the Watch app inside) on one and the Watch app on the other, both test
# launches with their own in-memory databases (D8) that still link to each other (`-pair-test`, simulator Debug builds
# only). Both run their pair drivers at once (Habits/App/PairDriver.swift, Watch/App/WatchPairDriver.swift):
#   the iPhone adds two habits and logs +1 → the Watch's first fill brings them;
#   the Watch logs +1 twice from a routine while the iPhone app is open → the iPhone sees 3 glasses;
#   the Watch starts a timer and the iPhone stops it → one log on both, no timer running.
# Each app writes its steps to tmp/pair.txt; this script prints both and fails unless both end "# PAIR DONE ok".
# Usage (from iOS/, after the iPhone build): Tools/ci/watch_pair.sh <out dir>. On CI: [watch-pair].
set -u
OUT="$1"; mkdir -p "$OUT"
PHONE_APP=DerivedDataPhone/Build/Products/Debug-iphonesimulator/Habits.app
WATCH_APP="$PHONE_APP/Watch/OftenEnoughWatch.app"
PHONE_BUNDLE=com.oftenenough.app
WATCH_BUNDLE=com.oftenenough.app.watchkitapp
[ -d "$WATCH_APP" ] || { echo "No Watch app inside $PHONE_APP" | tee "$OUT/pair.md"; exit 1; }

runtime() { xcrun simctl list runtimes available -j | python3 -c "import json,sys; r=[x for x in json.load(sys.stdin)['runtimes'] if x.get('platform')=='$1']; print(r[-1]['identifier'])"; }
# By name, first one this Xcode has: never a match on part of a name (an old model the runtime can't run).
devicetype() { xcrun simctl list devicetypes -j | python3 -c "import json,sys; t={x['name']: x['identifier'] for x in json.load(sys.stdin)['devicetypes']}; print(next(t[n] for n in sys.argv[1:] if n in t))" "$@"; }

# Every step has a time limit and is written to the report as it happens: when a step hangs, the report says which
# (the whole check twice ran out its 20 minutes with nothing written, runs 38108830332 and 38112417583).
bounded() { local limit=$1; shift; "$@" & local pid=$!; ( sleep "$limit"; kill "$pid" 2>/dev/null ) & local guard=$!; wait "$pid" 2>/dev/null; local code=$?; kill "$guard" 2>/dev/null; return $code; }
STARTED=$(date +%s)
echo "Paired simulators: setting up" > "$OUT/pair.md"
step() {
  local limit=$1 name=$2; shift 2
  if bounded "$limit" "$@" >> "$OUT/setup.txt" 2>&1; then
    echo "- $(( $(date +%s) - STARTED )) s: $name" >> "$OUT/pair.md"
  else
    echo "- $(( $(date +%s) - STARTED )) s: $name FAILED or took over $limit s" >> "$OUT/pair.md"
  fi
}
PHONE=$(xcrun simctl create "Pair iPhone" "$(devicetype "iPhone 17" "iPhone 16")" "$(runtime iOS)")
WATCH=$(xcrun simctl create "Pair Watch" "$(devicetype "Apple Watch Series 10 (46mm)" "Apple Watch Series 11 (46mm)")" "$(runtime watchOS)")
PAIR=$(xcrun simctl pair "$WATCH" "$PHONE" 2>>"$OUT/setup.txt")
echo "- iPhone $PHONE, Watch $WATCH, pair ${PAIR:-none}" >> "$OUT/pair.md"
step 180 "booted the iPhone" sh -c "xcrun simctl boot '$PHONE'; xcrun simctl bootstatus '$PHONE' -b"
step 180 "booted the Watch" sh -c "xcrun simctl boot '$WATCH'; xcrun simctl bootstatus '$WATCH' -b"
step 60 "activated the pair" xcrun simctl pair_activate "$PAIR"
xcrun simctl list pairs >> "$OUT/setup.txt" 2>&1
step 180 "installed the iPhone app" xcrun simctl install "$PHONE" "$PHONE_APP"
step 180 "installed the Watch app" xcrun simctl install "$WATCH" "$WATCH_APP"
sleep 10
step 60 "launched the iPhone app" xcrun simctl launch "$PHONE" "$PHONE_BUNDLE" -uitest -empty -pair-test -pair-drive
sleep 5
step 60 "launched the Watch app" xcrun simctl launch "$WATCH" "$WATCH_BUNDLE" -uitest -pair-test -pair-drive
cat "$OUT/pair.md" "$OUT/setup.txt"

PDATA=$(xcrun simctl get_app_container "$PHONE" "$PHONE_BUNDLE" data 2>/dev/null)
WDATA=$(xcrun simctl get_app_container "$WATCH" "$WATCH_BUNDLE" data 2>/dev/null)
WAITED=0
until { grep -q "^.*# PAIR DONE" "$PDATA/tmp/pair.txt" 2>/dev/null && grep -q "# PAIR DONE" "$WDATA/tmp/pair.txt" 2>/dev/null; } || [ $WAITED -ge 360 ]; do
  sleep 2; WAITED=$((WAITED + 2))
done
cp "$PDATA/tmp/pair.txt" "$OUT/iphone.txt" 2>/dev/null || echo "(the iPhone app wrote nothing)" > "$OUT/iphone.txt"
cp "$WDATA/tmp/pair.txt" "$OUT/watch.txt" 2>/dev/null || echo "(the Watch app wrote nothing)" > "$OUT/watch.txt"

OK=0
grep -q "# PAIR DONE ok" "$OUT/iphone.txt" && grep -q "# PAIR DONE ok" "$OUT/watch.txt" && OK=1
if [ $OK = 0 ]; then
  # What WatchConnectivity said, to tell a simulator limitation from our bug.
  bounded 90 sh -c "xcrun simctl spawn '$PHONE' log show --last 6m --style compact --predicate 'process == \"wcd\" OR process == \"Habits\"' 2>/dev/null | grep -iE 'wcsession|transfer|reachab|paired|install|error' | tail -120 > '$OUT/iphone-wc-log.txt'"
  bounded 90 sh -c "xcrun simctl spawn '$WATCH' log show --last 6m --style compact --predicate 'process == \"wcd\" OR process == \"OftenEnoughWatch\"' 2>/dev/null | grep -iE 'wcsession|transfer|reachab|paired|install|error' | tail -120 > '$OUT/watch-wc-log.txt'"
fi
STEPS=$(tail -n +2 "$OUT/pair.md")
{
  echo "Paired simulators: $([ $OK = 1 ] && echo "passed" || echo "FAILED") (waited ${WAITED} s)"
  echo
  echo "$STEPS"
  echo
  echo "iPhone:"; echo '```'; cat "$OUT/iphone.txt"; echo '```'
  echo "Watch:"; echo '```'; cat "$OUT/watch.txt"; echo '```'
  if [ $OK = 0 ]; then
    echo "WatchConnectivity on the iPhone (last lines):"; echo '```'; tail -40 "$OUT/iphone-wc-log.txt" 2>/dev/null; echo '```'
    echo "WatchConnectivity on the Watch (last lines):"; echo '```'; tail -40 "$OUT/watch-wc-log.txt" 2>/dev/null; echo '```'
  fi
} > "$OUT/pair.md"
cat "$OUT/pair.md"
[ $OK = 1 ]
