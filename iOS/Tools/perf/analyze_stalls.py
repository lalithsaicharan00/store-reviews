"""Reads one speed run's record from the app (MainThreadMeter + PerfDriver): stall lines "<start> <ms>" and marker
lines "# WINDOW name|start|end", "# OPEN name|start|end", "# NOTE text", "# DONE".
Usage: analyze_stalls.py <perf-stalls.txt>

Prints, for each measured window:
  window=<name>|<hitch>|<longest>|<freezes>
    hitch   ms per second spent past the frame budget (16.7 ms): Apple's hitch-time ratio. Under 5 is smooth,
            5-10 is noticeable, over 10 is a lag people feel
    longest the longest single stall, ms
    freezes stalls of 100 ms or more (a visible freeze)
and for each screen opening: open=<name>: longest stall <ms> ms. Notes come out as note=<text>.
Timed work ("# TIME name|ms", MainThreadMeter.time) comes out as time=<name>|<count>|<total ms>|<longest ms>.
"""
import sys

FRAME = 1000 / 60


def main(path):
    try:
        lines = open(path, errors="replace").read().splitlines()
    except OSError:
        print("note=no record from the app")
        return
    stalls, windows, opens = [], [], []
    timed = {}
    for line in lines:
        if line.startswith("# TIME "):
            name, ms = line[7:].rsplit("|", 1)
            timed.setdefault(name, []).append(float(ms))
            continue
        if line.startswith("# WINDOW ") or line.startswith("# OPEN "):
            kind, rest = line[2:].split(" ", 1)
            name, a, b = rest.rsplit("|", 2)
            (windows if kind == "WINDOW" else opens).append((name, float(a), float(b)))
        elif line.startswith("# NOTE "):
            print("note=" + line[7:])
        elif line.startswith("# ERROR "):
            print("note=ERROR: " + line[8:])
        elif not line.startswith("#") and len(line.split()) == 2:
            start, ms = map(float, line.split())
            stalls.append((start, ms))
    if not any(l.startswith("# DONE") for l in lines):
        print("note=the run didn't finish")

    def within(a, b):
        return [ms for start, ms in stalls if a <= start < b]

    for name, a, b in windows:
        spans = within(a, b)
        hitch = sum(max(0, ms - FRAME) for ms in spans) / max(b - a, 1)
        print(f"window={name}|{hitch:.1f}|{max(spans, default=0):.0f}|{sum(ms >= 100 for ms in spans)}")
    for name, a, b in opens:
        print(f"open={name}: longest stall {max(within(a - 0.05, b), default=0):.0f} ms")
    for name, values in sorted(timed.items(), key=lambda kv: -sum(kv[1])):
        print(f"time={name}|{len(values)}|{sum(values):.0f}|{max(values):.1f}")


if __name__ == "__main__":
    main(sys.argv[1])
