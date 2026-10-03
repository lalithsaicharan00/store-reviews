"""Verify corpus-findings.md: every `A|P|N<n>#<line>` cite resolves to a review in the corpus, and every double-quoted
string (>= 8 chars) on a line with cites appears verbatim (whitespace-normalised, HTML entities decoded, '…' splits
fragments) in one of that line's cited reviews. Lines marked '(paraphrase)' are skipped for quote matching."""
import re, json, glob, html, os, sys
os.chdir(os.path.dirname(os.path.abspath(__file__)))
ROOT = os.path.abspath("../..")
BASE = {"A": "App Store Reviews", "P": "Play Store Reviews", "N": "Native Store Reviews"}
_cache = {}
def load(c):
    s, rest = c[0], c[1:]; n, line = rest.split("#")
    f = glob.glob(f"{ROOT}/{BASE[s]}/{n}. */reviews.jsonl"); assert len(f) == 1, (c, f)
    if f[0] not in _cache: _cache[f[0]] = open(f[0]).read().split("\n")
    r = json.loads(_cache[f[0]][int(line)])
    return html.unescape((r.get("title") or "") + " — " + (r.get("body") or r.get("text") or ""))
norm = lambda s: re.sub(r"\s+", " ", s).strip()
doc = sys.argv[1] if len(sys.argv) > 1 else "corpus-findings.md"
bad = 0; cites = set(); nq = 0
for ln, line in enumerate(open(doc), 1):
    cs = re.findall(r"`([APN]\d+#\d+)`", line)
    if not cs: continue
    texts = []
    for c in cs:
        cites.add(c)
        try: texts.append(norm(load(c)))
        except Exception as e: print("BAD ID", ln, c, e); bad += 1
    if "(paraphrase)" in line: continue
    for q in re.findall(r"\"([^\"]{8,})\"", line):
        nq += 1
        frags = [norm(x).strip(" .,") for x in q.split("…") if x.strip(" .,")]
        if not any(all(f in t for f in frags) for t in texts):
            print("QUOTE MISMATCH line", ln, cs, "|", q); bad += 1
print("cites", len(cites), "quotes checked", nq, "problems", bad)
