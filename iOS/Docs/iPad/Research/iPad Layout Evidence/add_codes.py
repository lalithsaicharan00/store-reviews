"""Append a batch of hand codes to CODED in coded.py. Usage: python -I add_codes.py <batch label> <codes.json>
The json maps review key -> list of codes."""
import json, sys, os
HERE = os.path.dirname(os.path.abspath(__file__))
label, path = sys.argv[1], sys.argv[2]
add = json.load(open(path, encoding='utf-8'))
src = open(os.path.join(HERE, 'coded.py'), encoding='utf-8').read()
marker = "}\n# Not about the iPad"
assert src.count(marker) == 1
body = f"    # {label}\n" + ''.join(f"    {k!r}: {v!r},\n" for k, v in add.items())
src = src.replace(marker, body + marker)
open(os.path.join(HERE, 'coded.py'), 'w', encoding='utf-8').write(src)
print(label, len(add))
