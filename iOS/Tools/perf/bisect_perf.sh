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
: > "$OUT/timed.txt"                           # variant|round|scenario|what|count|total ms|longest ms
: > "$OUT/long-stalls.txt"

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
      ANALYSIS=$(python3 "$HERE/analyze_stalls.py" "$OUT/stalls-$NAME-$S-$ROUND.txt")
      echo "$ANALYSIS" | sed -n 's/^window=//p' | while IFS='|' read -r W H L F; do
        echo "$NAME|$ROUND|$S|$W|$H|$L|$F" >> "$RESULTS"
      done
      # Long stalls, each with what the Kotlin collector last did (MainThreadMeter).
      grep '^# NOTE long stall' "$OUT/stalls-$NAME-$S-$ROUND.txt" 2>/dev/null | sed "s/^# NOTE /$NAME, $S round $ROUND: /" >> "$OUT/long-stalls.txt"
      # Timed work (perfTimed, "Count: …"), per variant: count, total and longest, summed over the rounds.
      echo "$ANALYSIS" | sed -n 's/^time=//p' | while IFS='|' read -r W C T L; do
        echo "$NAME|$ROUND|$S|$W|$C|$T|$L" >> "$OUT/timed.txt"
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
    import os
    timed_path = os.path.join(os.path.dirname(out), "timed.txt")
    timed, worder = {}, []
    if os.path.exists(timed_path):
        for line in open(timed_path):
            v, r, s, w, c, t, l = line.rstrip("\n").split("|")
            if w not in timed: timed[w] = {}; worder.append(w)
            a = timed[w].setdefault(v, [0, 0.0, 0.0])
            a[0] += int(c); a[1] += float(t); a[2] = max(a[2], float(l))
    if worder:
        o.write("\nTimed work, all rounds (count · total ms · longest ms):\n\n")
        o.write("| What | " + " | ".join(names) + " |\n|---|" + "---|" * len(names) + "\n")
        for w in worder:
            cells = [("{} · {:.0f} · {:.1f}".format(*timed[w][n]) if n in timed[w] else "–") for n in names]
            o.write(f"| {w} | " + " | ".join(cells) + " |\n")
    stalls_path = os.path.join(os.path.dirname(out), "long-stalls.txt")
    if os.path.exists(stalls_path) and os.path.getsize(stalls_path) > 0:
        o.write("\nLong stalls (250 ms or more), with what the Kotlin collector last did:\n\n")
        for line in open(stalls_path).read().splitlines()[:60]:
            o.write("- " + line + "\n")
print(open(out).read())
PY
