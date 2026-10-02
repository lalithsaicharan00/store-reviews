"""Tally the hand codes: validate against the codebook, then count reviews, apps and mean stars per code and sentiment."""
import json,glob,re,collections
rows={json.loads(l)["n"]:json.loads(l) for l in open("read_set.jsonl")}
coded={}
for f in sorted(glob.glob("codes_*.txt")):
    for line in open(f):
        n,c=line.strip().split(":",1); n=int(n)
        assert n not in coded, n; coded[n]=c.split(",")
assert set(coded)==set(rows), (len(coded),len(rows))
book=set(re.findall(r"^([A-Z]+)\s",open("codebook.md").read(),re.M))
for n,cs in coded.items():
    for c in cs:
        base=c.lstrip("+?-")
        assert base in book, (n,c)
def app(o): return o["app"].split(". ",1)[1][:28] if ". " in o["app"] else o["app"]
on=[n for n,cs in coded.items() if cs!=["NA"]]
print("read",len(coded),"on topic",len(on),"apps",len({rows[n]["app"] for n in on}))
agg=collections.defaultdict(list)
for n,cs in coded.items():
    for c in cs:
        if c=="NA": continue
        base=c.lstrip("+?-"); s=c[0] if c[0] in "+?-" else "·"
        agg[base].append((s,n))
out=[]
for base,lst in sorted(agg.items(),key=lambda x:-len({n for _,n in x[1]})):
    ns={n for _,n in lst}
    by={k:{n for s,n in lst if s==k} for k in "+?-·"}
    apps={rows[n]["app"] for n in ns}
    stars=[rows[n]["stars"] for n in ns if rows[n]["stars"]]
    out.append((base,len(ns),len(apps),round(sum(stars)/len(stars),2),len(by["+"]),len(by["?"]),len(by["-"]),len(by["·"])))
print("code reviews apps mean★ praise ask complain neutral")
for r in out: print(*r)
json.dump({"coded":{str(k):v for k,v in coded.items()}},open("coded.json","w"))
