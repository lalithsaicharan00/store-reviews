import collections,math
def bucket(w): return 0 if w<10 else 1 if w<20 else 2 if w<40 else 3 if w<80 else 4 if w<160 else 5
def mh(rows,g,paidf,mode='both'):
    st=collections.defaultdict(lambda:[0,0,0,0])
    for r in rows:
        k={'both':(r['app'],bucket(r['w'])),'len':bucket(r['w']),'app':r['app']}[mode]
        ing=g in r['g'] if isinstance(g,str) else g(r)
        p=paidf(r)
        st[k][(0 if ing else 2)+(0 if p else 1)]+=1
    R=S=PR=PSQR=QS=0
    for a,b,c,d in st.values():
        n=a+b+c+d
        if a+b==0 or c+d==0: continue
        Ri=a*d/n;Si=b*c/n;Pi=(a+d)/n;Qi=(b+c)/n
        R+=Ri;S+=Si;PR+=Pi*Ri;PSQR+=Pi*Si+Qi*Ri;QS+=Qi*Si
    if not R or not S: return (float('nan'),0,0)
    o=R/S;se=math.sqrt(PR/(2*R*R)+PSQR/(2*R*S)+QS/(2*S*S))
    return (o,math.exp(math.log(o)-1.96*se),math.exp(math.log(o)+1.96*se))
