import json,re
R={o['i']:o['k'] for o in json.load(open('readA.json')) for _ in [0]} if False else {}
for o in json.load(open('readA.json')): R[o['i']]=o['k']
for f in ('readB.json','readC1.json','readC2.json','readP.json'):
    for o in json.load(open(f)): R[o['i']]=o['k']
Q=[(1070,"It reminds me of everything my ADHD-brain forgets"),(803,"my ADHD is bad so I end up forgetting about monthly subscriptions"),(863,"It’s the only app I’ve ever purchased."),(1290,"The first app I bought in 8 years"),(999,"It’s the first time I ever pay a subscription for an app"),(636,"They know we have adhd, they know we’re going to forget"),(570,"The ADHD tax is high enough without another forgotten subscription."),(1192,"has become a tax I pay for having ADHD"),
(618,"We all know therapy can be expensive"),(1214,"I justified it saying it was for my mental health"),(1286,"I'm broke but I still bought the upgrade"),(1280,"I never purchase apps. Not even 99 cent apps."),(566,"It’s like having a therapist and a Buddhist monk for a small monthly fee."),(724,"a schedule is an absolute need in my life"),(1088,"I have a TBI and this is truly helping me to cope."),(932,"after a massive stroke"),
(963,"I bought the full version so I could have unlimited habits"),(1137,"Perfect for Mom Brain!"),(1197,"to see if it would be any good for my children"),(1163,"And I'm a broke college student so that's really saying something."),(572,"its a little much for a full time student"),(700,"I’m happy I spent my money on this and not on alcohol"),(632,"it’s been helpful to me and my clients (social worker)"),(1245,"I recommend it to all my clients as well"),
(1025,"thinking if I paid for it I’d be more motivated to use it"),(714,"Now I have buy in."),(3151,"Best $3 a month I have ever invested in myself"),(676,"I bought premium not because I needed to, but to support these guys"),(2037,"it would be rude not to pay"),(2057,"I’m a sucker for cute little decor things for my birb"),(2090,"i got the paid version after just one day"),(2033,"I had to pay 60$ at a phone repair shop"),(3184,"I used the free version of this app for about a year"),(3008,"I purchased the upgrade because I wanted to add more than 5 habits"),(3119,"I truly feel the app is worth every penny"),(1096,"I couldn’t af"),(765,"I accidentally paid for the yearly subscription when I couldn't afford it")]
txt={}; want={R[i] for i,_ in Q}
for l in open('corpus.jsonl'):
    r=json.loads(l);k=f"{r['s']}|{r['app'].split('.')[0]}|{r['id']}"
    if k in want: txt[k]=(r['t'].replace('&#39;',"'"),r['app'],r['s'],r['id'])
bad=0;out=[]
for i,q in Q:
    k=R[i]; t,a,s,idv=txt[k]; n=re.sub(r'\s+',' ',t)
    ok=q in n
    if not ok: bad+=1; print('MISS',i,q)
    out.append({'i':i,'id':str(idv),'store':s,'app':a,'quote':q})
json.dump(out,open('quotes.json','w'),ensure_ascii=False,indent=0)
print('quotes',len(Q),'bad',bad)
for o in out: print(o['i'],o['store'],o['id'],o['app'][:22])
