"""Summarises a macOS `sample` report of the app: how busy the main thread was, and which of the app's own
functions took that time. Usage: analyze_sample.py <sample.txt> [top N]

Busy % = main-thread samples not waiting in the run loop (minus any UI-test screen searching, __XCTPerformOnMainRunLoop;
the speed runs no longer attach a UI test, 30 Sep).
Redraw % = time SwiftUI spent updating views (ViewGraphRootValueUpdater.render), whatever caused it.
Each app function's share is inclusive (its callees count too), counted once per stack even if it recurses.
Then the shared Kotlin core's own functions the same way ("kotlin"), and the main thread's time stopped for the Kotlin
collector ("kotlin-gc": suspended at a safepoint or collecting on the main thread), so a speed run shows what the shared
habit rules cost (Current Work 92).
"""
import re
import sys

APP = re.compile(r"\(in Habits(?:\.debug\.dylib)?\)")
SKIP = re.compile(r"^main$|\$main|entry_point|protocol witness|body\.getter")
GC = re.compile(r"SuspendIfRequested|suspendIfRequested|SafePoint|safePoint|GCScheduler|PerformFullGC|ScheduleAndWaitFullGC|kotlin::gc::")
FRAME = re.compile(r"^([\s+!:|]*)(\d+) (.*)$")


def main(path, top=8):
    text = open(path, errors="replace").read()
    graph = text.split("Call graph:", 1)[1].split("Total number in stack", 1)[0].splitlines()
    start = next((i for i, l in enumerate(graph) if "Main Thread" in l or "com.apple.main-thread" in l), None)
    if start is None:
        print("busy=?\nredraw=?")
        return
    end = next((i for i in range(start + 1, len(graph)) if re.match(r"\s{4}\d+ Thread_", graph[i])), len(graph))
    main_lines = graph[start:end]
    total = int(re.search(r"(\d+) Thread_", main_lines[0]).group(1))
    idle = sum(int(m.group(1)) for l in main_lines if (m := re.search(r"(\d+) mach_msg2_trap", l)))

    shares, kotlin, stack, redraw, harness, gc = {}, {}, [], 0, 0, 0
    selfs = {}  # where the samples land: each frame's own count less its callees', by name and library
    parents = []  # (depth, key) of the frames above, for the self counts  # stack: (depth, name) of the frames above the current line
    for line in main_lines[1:]:
        m = FRAME.match(line)
        if not m:
            continue
        depth, count, rest = len(m.group(1)), int(m.group(2)), m.group(3)
        while stack and stack[-1][0] >= depth:
            stack.pop()
        while parents and parents[-1][0] >= depth:
            parents.pop()
        lib = re.search(r"\(in ([^)]+)\)", rest)
        key = re.sub(r"\s+\+ \d+.*", "", re.sub(r"\s+\(in .*", "", rest).strip())[:90] + (f"  [{lib.group(1)}]" if lib else "")
        if parents:
            selfs[parents[-1][1]] = selfs.get(parents[-1][1], 0) - count
        selfs[key] = selfs.get(key, 0) + count
        parents.append((depth, key))
        name = re.sub(r"\s+\(in .*", "", rest).strip()
        name = re.sub(r"\s+\+ \d+.*", "", name)
        first = not any(n == name for _, n in stack)
        if APP.search(rest) and first and not SKIP.search(name):
            shares[name] = shares.get(name, 0) + count
        if first and name.startswith("kfun:"):
            short = re.sub(r"\{\}.*$", "", re.sub(r"\(.*", "", name))
            if not any(short == re.sub(r"\{\}.*$", "", re.sub(r"\(.*", "", n)) for _, n in stack):
                kotlin[short] = kotlin.get(short, 0) + count
        if GC.search(name) and not any(GC.search(n) for _, n in stack):
            gc += count
        if first and name.startswith("ViewGraphRootValueUpdater.render"):
            redraw += count
        in_harness = any("__XCTPerformOnMainRunLoop" in n for _, n in stack)
        if first and name.startswith("__XCTPerformOnMainRunLoop") and not in_harness:
            harness += count
        # The test waiting inside its own work is already counted as idle; don't take it off twice.
        if in_harness and "mach_msg2_trap" in name:
            harness -= count
        stack.append((depth, name))

    busy = 100 * (total - idle - harness) / max(total - harness, 1)
    print(f"busy={busy:.1f}")
    print(f"redraw={100 * redraw / max(total, 1):.1f}")
    for name, count in sorted(shares.items(), key=lambda kv: -kv[1])[:top]:
        print(f"{100 * count / max(total, 1):5.1f}%  {name[:110]}")
    if kotlin or gc:
        print(f"{100 * gc / max(total, 1):5.1f}%  kotlin-gc (main thread stopped for the Kotlin collector)")
    for name, count in sorted(kotlin.items(), key=lambda kv: -kv[1])[:top + 4]:
        print(f"{100 * count / max(total, 1):5.1f}%  kotlin {name[:100]}")
    busy_self = [(k, v) for k, v in selfs.items() if "mach_msg2_trap" not in k and v > 0]
    for name, count in sorted(busy_self, key=lambda kv: -kv[1])[:top + 8]:
        print(f"{100 * count / max(total, 1):5.1f}%  self {name}")


if __name__ == "__main__":
    main(sys.argv[1], int(sys.argv[2]) if len(sys.argv) > 2 else 8)
