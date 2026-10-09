#!/bin/bash
# Speed bisect (8 Oct 2026, Current Work 49): several builds measured side by side on ONE simulator in ONE job, so they
# can be compared (Rulebook S2: hosted runs vary 2-3x between machines; the same pager measured 5.7 and 61 ms/s in two
# runs, L22). Each round runs every scenario on every variant, in a rotated order so a machine that slows down during
# the job doesn't favour one variant. Launches exactly as measure_perf_driver.sh does (no profiler, no XCTest).
# Usage (from iOS/): Tools/perf/bisect_perf.sh <simulator id> <out dir> <apps dir> "<variants>" "<scenarios>" <rounds>
#   variants: name=ref[+arg+arg…] … ; the app for a variant is <apps dir>/<ref>/Habits.app; the args are added to the
#   launch (PerfSwitches: `+-perf-switch+no-sound`).
# Writes <out dir>/bisect-summary.md: per measured window, each variant's hitch ms/s per round and the median.
set -u
SIM="$1"; OUT="$2"; APPS="$3"; VARIANTS="$4"; SCENARIOS="$5"; ROUNDS="${6:-2}"
HERE="$(cd "$(dirname "$0")" && pwd)"
BUNDLE=com.oftenenough.app
mkdir -p "$OUT"
RESULTS="$OUT/results.txt"; : > "$RESULTS"   # variant|round|scenario|window|hitch|longest|freezes

NAMES=(); for V in $VARIANTS; do NAMES+=("${V%%=*}"); done
COUNT=${#NAMES[@]}
spec_of() { for V in $VARIANTS; do [ "${V%%=*}" = "$1" ] && { echo "${V#*=}"; return; }; done; }

INSTALLED=""
for ROUND in $(seq 1 "$ROUNDS"); do
  for S in $SCENARIOS; do
    for I in $(seq 0 $((COUNT - 1))); do
      NAME="${NAMES[$(( (I + ROUND - 1) % COUNT ))]}"
      SPEC=$(spec_of "$NAME"); REF="${SPEC%%+*}"
      ARGS=(); if [ "$SPEC" != "$REF" ]; then IFS='+' read -r -a ARGS <<< "${SPEC#*+}"; fi
      if [ "$INSTALLED" != "$REF" ]; then
        xcrun simctl terminate "$SIM" "$BUNDLE" > /dev/null 2>&1
        xcrun simctl install "$SIM" "$APPS/$REF/Habits.app" || { echo "install $REF failed"; continue; }
        INSTALLED="$REF"
      fi
      DATA=$(xcrun simctl get_app_container "$SIM" "$BUNDLE" data)
      REC="$DATA/tmp/perf-stalls.txt"
      xcrun simctl terminate "$SIM" "$BUNDLE" > /dev/null 2>&1
      sleep 1
      rm -f "$REC"
      xcrun simctl launch "$SIM" "$BUNDLE" -uitest -perf-history -perf-meter -perf-drive "$S" ${ARGS[@]+"${ARGS[@]}"} > /dev/null 2>&1
      WAITED=0
      until grep -q "^# DONE" "$REC" 2>/dev/null || [ $WAITED -ge 180 ]; do sleep 1; WAITED=$((WAITED + 1)); done
      cp "$REC" "$OUT/stalls-$NAME-$S-$ROUND.txt" 2>/dev/null
      xcrun simctl terminate "$SIM" "$BUNDLE" > /dev/null 2>&1
      python3 "$HERE/analyze_stalls.py" "$OUT/stalls-$NAME-$S-$ROUND.txt" | sed -n 's/^window=//p' | while IFS='|' read -r W H L F; do
        echo "$NAME|$ROUND|$S|$W|$H|$L|$F" >> "$RESULTS"
      done
      echo "round $ROUND $S $NAME done ($WAITED s)"
    done
  done
done

python3 - "$RESULTS" "$OUT/bisect-summary.md" "${NAMES[@]}" <<'PY'
import sys, statistics
results, out, names = sys.argv[1], sys.argv[2], sys.argv[3:]
rows = {}
order = []
for line in open(results):
    v, r, s, w, h, l, f = line.rstrip("\n").split("|")
    key = w
    if key not in rows: rows[key] = {}; order.append(key)
    rows[key].setdefault(v, []).append((float(h), float(l), int(f)))
with open(out, "w") as o:
    o.write("Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.\n\n")
    o.write("| Window | " + " | ".join(names) + " |\n|---|" + "---|" * len(names) + "\n")
    for key in order:
        cells = []
        for n in names:
            vals = rows[key].get(n, [])
            if not vals: cells.append("–"); continue
            each = ", ".join(f"{h:g} ({l:g}, {f})" for h, l, f in vals)
            cells.append(f"**{statistics.median(h for h, _, _ in vals):.1f}**<br>{each}")
        o.write(f"| {key} | " + " | ".join(cells) + " |\n")
print(open(out).read())
PY
