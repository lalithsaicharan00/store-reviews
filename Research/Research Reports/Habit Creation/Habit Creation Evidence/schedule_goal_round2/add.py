"""add.py CODE PREFIX id id ...   (appends to codes.py, creating the code if needed)"""
import sys, re
code, pre, ids = sys.argv[1], sys.argv[2], sys.argv[3:]
s = open("codes.py").read()
if f'"{code}": [' not in s:
    s = s.rstrip().rstrip("}") + f' "{code}": [],\n}}\n'
m = re.search(rf'"{code}": \[(.*?)\],', s, re.S)
cur = m.group(1).strip()
new = ", ".join(f'"{pre}:{i}"' for i in ids)
s = s[:m.start(1)] + (cur + ", " if cur else "") + new + s[m.end(1):]
open("codes.py", "w").write(s)
