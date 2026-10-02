import json,sys
a,b=int(sys.argv[1]),int(sys.argv[2])
for l in open("read.jsonl"):
    o=json.loads(l)
    if a<=o["n"]<b:
        t=o["text"]; t=t if len(t)<=380 else t[:380]+"…"
        print("[%d] %s %s★ %s | %s" % (o["n"], o["g"][:6], o["stars"], o["app"].split(". ",1)[-1][:16], t))
