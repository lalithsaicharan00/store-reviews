"""Summarises a macOS `sample` report of the app: how busy the main thread was, and which of the app's own
functions took that time. Usage: analyze_sample.py <sample.txt> [top N]

Busy % = main-thread samples not waiting in the run loop, minus the time the UI test itself spent on the app's main
thread searching the screen (__XCTPerformOnMainRunLoop: element queries, snapshots), which a person never causes.
A smooth screen scrolling is about 10-20 % on GitHub's Mac.
Redraw % = time SwiftUI spent updating views (ViewGraphRootValueUpdater.render), whatever caused it.
Each app function's share is inclusive (its callees count too), counted once per stack even if it recurses.
"""
import re
import sys

APP = re.compile(r"\(in Habits(?:\.debug\.dylib)?\)")
SKIP = re.compile(r"\$main|entry_point|protocol witness|body\.getter")
FRAME = re.compile(r"^([\s+!:|]*)(\d+) (.*)$")


def main(path, top=8):
    text = open(path, errors="replace").read()
    graph = text.split("Call graph:", 1)[1].split("Total number in stack", 1)[0].splitlines()
    start = next(i for i, l in enumerate(graph) if "Main Thread" in l or "com.apple.main-thread" in l)
    end = next((i for i in range(start + 1, len(graph)) if re.match(r"\s{4}\d+ Thread_", graph[i])), len(graph))
    main_lines = graph[start:end]
    total = int(re.search(r"(\d+) Thread_", main_lines[0]).group(1))
    idle = sum(int(m.group(1)) for l in main_lines if (m := re.search(r"(\d+) mach_msg2_trap", l)))

    shares, stack, redraw, harness = {}, [], 0, 0  # stack: (depth, name) of the frames above the current line
    for line in main_lines[1:]:
        m = FRAME.match(line)
        if not m:
            continue
        depth, count, rest = len(m.group(1)), int(m.group(2)), m.group(3)
        while stack and stack[-1][0] >= depth:
            stack.pop()
        name = re.sub(r"\s+\(in .*", "", rest).strip()
        name = re.sub(r"\s+\+ \d+.*", "", name)
        first = not any(n == name for _, n in stack)
        if APP.search(rest) and first and not SKIP.search(name):
            shares[name] = shares.get(name, 0) + count
        if first and name.startswith("ViewGraphRootValueUpdater.render"):
            redraw += count
        if first and name.startswith("__XCTPerformOnMainRunLoop") and not any("__XCTPerformOnMainRunLoop" in n for _, n in stack):
            harness += count
        stack.append((depth, name))

    busy = 100 * (total - idle - harness) / max(total - harness, 1)
    print(f"busy={busy:.1f}")
    print(f"redraw={100 * redraw / max(total, 1):.1f}")
    for name, count in sorted(shares.items(), key=lambda kv: -kv[1])[:top]:
        print(f"{100 * count / max(total, 1):5.1f}%  {name[:110]}")


if __name__ == "__main__":
    main(sys.argv[1], int(sys.argv[2]) if len(sys.argv) > 2 else 8)
