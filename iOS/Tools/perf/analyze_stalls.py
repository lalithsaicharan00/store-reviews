"""Reads the app's main-thread stalls (MainThreadMeter, tmp/perf-stalls.txt) for one speed test's log.
Usage: analyze_stalls.py <perf-stalls.txt> <test log>

Prints, for the test's measured window (PERF-WINDOW):
  hitch=   ms per second spent past the frame budget (16.7 ms), Apple's hitch-time ratio: under 5 is smooth,
           5-10 is noticeable, over 10 is a lag people feel
  longest= the longest single stall, ms
  freezes= stalls of 100 ms or more (a visible freeze)
and for each screen opening (PERF-OPEN): the longest stall between the tap and the screen being there.
"""
import re
import sys

FRAME = 1000 / 60


def main(stall_path, log_path):
    try:
        stalls = [tuple(map(float, l.split())) for l in open(stall_path) if len(l.split()) == 2]
    except OSError:
        stalls = None  # the app didn't record: don't report a clean result
    log = open(log_path, errors="replace").read()

    def within(a, b):
        return [ms for start, ms in stalls or [] if a <= start <= b]

    window = re.search(r"^PERF-WINDOW ([\d.]+) ([\d.]+)", log, re.M)
    if window and stalls is None:
        print("hitch=no stall record from the app")
    elif window:
        a, b = float(window.group(1)), float(window.group(2))
        spans = within(a, b)
        print(f"hitch={sum(max(0, ms - FRAME) for ms in spans) / max(b - a, 1):.1f}")
        print(f"longest={max(spans, default=0):.0f}")
        print(f"freezes={sum(ms >= 100 for ms in spans)}")
    for m in re.finditer(r"^PERF-OPEN (.+)\|([\d.]+)\|([\d.]+)$", log, re.M):
        spans = within(float(m.group(2)) - 0.05, float(m.group(3)))
        print(f"open={m.group(1)}: longest stall {max(spans, default=0):.0f} ms")


if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2])
