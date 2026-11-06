import re,collections
exec(open('apptypes.py').read().split("random.seed")[0].replace("print(f\"{t:28}","(f\"{t:28}"))
W={'support dev':r"support (the )?(dev|developer|creator|team|this|app|indie|small)|to support",
'no ads':r"\bads?\b|advert",
'more habits/limit':r"more (habits|tasks|goals|routines)|unlimited|limit",
'one-time/lifetime':r"lifetime|one[- ]time|pay once|no subscription|not a subscription|without (a )?subscription",
'sync/devices':r"\bsync|ipad|tablet|apple watch|wear ?os|another device|multiple devices",
'widgets':r"widget",
'content/coaching':r"coach|content|journeys?|meditation|courses?|challenges?|guided|program",
'cosmetic/pet/game':r"clothes|outfits?|cosmetic|pets?\b|gems|quests?|avatar|rainbow stones|furniture",
'stats/export':r"stats|statistic|charts?|graphs?|export|backup",
'mental health':r"anxiety|depress|mental health|adhd|ptsd",
'student/teen':r"\bteen|college|student|school",
'cheap/fair price':r"cheap|affordable|reasonable|fair price|inexpensive|only \$|sale\b",
}
W={k:re.compile(v,re.I) for k,v in W.items()}
print(f"{'type':28}"+''.join(f"{k[:11]:>12}" for k in W))
for t in sorted(hb):
    L=hb[t]; print(f"{t[:22]+' n='+str(len(L)):28}"+''.join(f"{100*sum(1 for r in L if rx.search(r[5]))/len(L):11.0f}%" for rx in W.values()))
