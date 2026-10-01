#!/bin/bash
# Checks the speed rules in iOS/PERFORMANCE.md that can be checked by reading the code. Runs anywhere (Linux cloud
# sessions too) in a second: run it before every push that touches iOS/. CI runs it before building.
# Usage (from the repo root or iOS/): iOS/Tools/perf/check_rules.sh
cd "$(dirname "$0")/../.." || exit 2
FAIL=0
fail() { echo "SPEED RULE BROKEN: $1"; echo "    $2"; FAIL=1; }

# 1. The phone build is optimised (the user installs the Debug configuration from Xcode).
P=Habits.xcodeproj/project.pbxproj
grep -q 'SWIFT_OPTIMIZATION_LEVEL = "-Onone"' "$P" &&
  fail "Debug builds Swift with -Onone" "PERFORMANCE.md rule 1: the phone runs Debug; keep SWIFT_OPTIMIZATION_LEVEL = \"-O\""
[ "$(grep -c 'KOTLIN_FRAMEWORK_BUILD_TYPE = release' "$P")" -ge 2 ] ||
  fail "The Kotlin core isn't built as release in both configurations" "PERFORMANCE.md rule 1"

SWIFT=$(find Habits HabitsLiveActivity Shared -name '*.swift')

# 2. A TimelineView anchored at .now or .distantPast redraws nonstop (froze the app, 28 Sep).
grep -nE 'periodic\(from: *(\.now|\.distantPast|Date\(\))' $SWIFT &&
  fail "TimelineView anchored at .now/.distantPast" "PERFORMANCE.md rule 4: anchor it at a fixed date"

# 3. Only small views tick. Each file allowed a TimelineView is listed here with what ticks in it.
# Progress's quit row (a once-a-minute clock in one Text) and the habit page's "This run" tile (one Text) tick alone.
ALLOWED="Habits/Today/TodayRows.swift Habits/Today/TimerBar.swift Habits/Today/RoutinePlayer.swift HabitsLiveActivity/HabitTimerLiveActivity.swift Habits/Progress/ProgressScreen.swift Habits/Progress/HabitPagePhase2.swift"
for f in $(grep -lE '^[^/]*TimelineView *\(' $SWIFT); do
  case " $ALLOWED " in *" $f "*) ;; *)
    fail "New TimelineView in $f" "PERFORMANCE.md rule 3: only the small view showing the time may tick; never a screen or list. If it is one row's clock, add the file to ALLOWED in this script";;
  esac
done

# 4. A new identity on every redraw rebuilds the view and its whole subtree each time.
grep -nE '\.id\((UUID\(\)|Date\(\)|\.now)' $SWIFT &&
  fail ".id(UUID()) / .id(Date())" "PERFORMANCE.md rule 6: give views stable identities"

# 5. Entries change only through HabitStore.insertEntry/removeEntry/replaceEntry, which keep the indexes and remembered numbers right.
grep -nE '_ = entries\.remove|withAnimation *\{ *entries\.|entries\.removeAll' Habits/Model/HabitStore.swift &&
  fail "HabitStore changes entries directly" "PERFORMANCE.md rule 5: use insertEntry / removeEntry(at:) / replaceEntry(_:at:)"

# 6. In a List with a selection, NavigationLink(value:) only selects the row: the page never opens (30 Sep).
for f in $(grep -l 'List(selection:' $SWIFT); do
  grep -n 'NavigationLink(value:' "$f" && fail "NavigationLink(value:) in a List with selection ($f)" "Use NavigationLink { Destination() } label: { … }"
done

# 7. Timers in views: a ticking publisher redraws its screen every tick.
grep -nE 'Timer\.publish|Timer\.scheduledTimer' $SWIFT &&
  fail "Timer in app code" "PERFORMANCE.md rule 3: sleep in a .task until the next moment that matters instead"

# 8. A shadow that's sometimes clear still renders offscreen on every row.
grep -nE '\.shadow\(color: .*: *\.clear' $SWIFT &&
  fail "Conditional clear shadow" "PERFORMANCE.md rule 10: apply the shadow only when it shows, on a shape"

if [ $FAIL = 0 ]; then echo "Speed rules: all checks passed"; fi
exit $FAIL
