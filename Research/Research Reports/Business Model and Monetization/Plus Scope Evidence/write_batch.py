"""Helper: write cls/batch-NN.txt from a dict of coded keys; every other key in the reading batch is NR."""
import re, sys, os
HERE = os.path.dirname(os.path.abspath(__file__))
def write(n, coded):
    src = open(f'{HERE}/../../../Temp/plus-scope/read/batch-{n:02d}.txt', encoding='utf-8').read()
    keys = re.findall(r'^\[([APN]\d+#\d+)\]', src, re.M)
    bad = [k for k in coded if k not in keys]
    with open(f'{HERE}/cls/batch-{n:02d}.txt', 'w', encoding='utf-8') as f:
        for k in keys: f.write(f"{k}|{coded.get(k, 'NR|')}\n")
    print(n, len(keys), 'coded', len(coded), 'not in batch', bad)
