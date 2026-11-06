import pickle,re,collections
src=open('seg.py').read(); exec(src.split("out={}")[0])
SEG['skincare']=re.compile(r"skin ?care|\bmy (period|cycle)\b|\bpregnan|\bmenstrua",re.I)
SEG['data']=re.compile(r"\bstatistic|\bstats\b|\bcharts?\b|\bgraphs?\b|\banalytics\b|\bexport\b|\bcsv\b|\bheat ?map\b|\bmy data\b.{0,30}(see|view|analy|track)",re.I)
SEG['older']=re.compile(r"\bi'?m (in my )?(50|60|70|80)s?\b|\bat my age\b|\bsenior\b|\bretired\b|\bgrand(kids|children|son|daughter)\b|\bi am (6|7|8)\d\b|\bi'?m (6|7|8)\d\b",re.I)
SEG['nurse_shift']=re.compile(r"\bshift work|\bnight shifts?\b|\bnurse\b|\bdoctor\b|\bteacher\b",re.I)
allen=[r for r in rows if r[4]]
def pos_paid(r): return r[3]>=4 and bool(PAID.search(r[5]))
def neg_paid(r): return r[3]<=2 and bool(PAID.search(r[5]))
app=collections.defaultdict(lambda:[0,0,0,0])
flags=[]
for r in allen:
    pp=pos_paid(r); np_=neg_paid(r); rs=bool(RESIST.search(r[5]))
    a=app[(r[0],r[1])]; a[0]+=1; a[1]+=pp; a[2]+=np_; a[3]+=rs
    flags.append((pp,np_,rs))
rate={k:(v[1]/v[0],v[2]/v[0],v[3]/v[0]) for k,v in app.items()}
print('baseline happy-buyer %.2f%% unhappy-buyer %.2f%% resist %.2f%%'%(100*sum(f[0] for f in flags)/len(allen),100*sum(f[1] for f in flags)/len(allen),100*sum(f[2] for f in flags)/len(allen)))
out=[]
for k,rx in SEG.items():
    n=o1=o2=o3=e1=e2=e3=0; apps=collections.Counter(); ios=0
    for r,f in zip(allen,flags):
        if rx.search(r[5]):
            n+=1; o1+=f[0]; o2+=f[1]; o3+=f[2]; rr=rate[(r[0],r[1])]; e1+=rr[0]; e2+=rr[1]; e3+=rr[2]; apps[r[1][:28]]+=1; ios+=r[0]=='ios'
    top=apps.most_common(1)[0]
    out.append((k,n,o1,o1/e1 if e1 else 0,o2/e2 if e2 else 0,o3/e3 if e3 else 0,100*ios/n,top[0],100*top[1]/n,len(apps)))
out.sort(key=lambda x:-x[3])
print(f"{'seg':11} {'n':>6} {'happyBuy':>8} {'liftHappy':>9} {'liftUnhappy':>11} {'liftResist':>10} ios% topApp share apps")
for x in out: print(f"{x[0]:11} {x[1]:6} {x[2]:8} {x[3]:9.2f} {x[4]:11.2f} {x[5]:10.2f} {x[6]:4.0f} {x[7]:28} {x[8]:4.0f}% {x[9]}")
pickle.dump((SEG,),open('seg2.pkl','wb')) if False else None
