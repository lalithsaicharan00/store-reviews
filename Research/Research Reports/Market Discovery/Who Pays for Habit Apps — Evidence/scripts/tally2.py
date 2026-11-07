import json,glob,collections,importlib.util,re,math,sys
sys.path.insert(0,'codes')
from lift_core import bucket
import samples as SM, precision as PR
AB={'adhd':'AD','add_caps':'AD','autism':'AU','depression_anxiety':'DA','serious_mh':'MH','therapy_client':'TC','professional_helper':'PR','chronic_illness':'CI','recovery_quit':'RQ','student':'ST','teen_minor':'TN','parent':'PA','for_child':'CH','couple_friends':'CF','shift_work_jobs':'JB','tech_founder':'TF','faith':'FA','older_adult':'OA'}
NAME={'AD':'ADHD / neurodivergent','AU':'Autistic','DA':'Depression / anxiety','MH':'PTSD, bipolar, OCD, severe','TC':'In therapy','PR':'Helpers (therapist, coach, teacher)','CI':'Chronic illness, disability, brain injury','RQ':'Quitting / recovery','ST':'Student','TN':'Teenager','PA':'Parent','CH':'Buys for a child','CF':'With partner or friends','JB':'Shift or demanding job','TF':'Developer, designer, founder','FA':'Faith','OA':'Older or retired'}
R=json.load(open('readA.json'))
N=set();S=set();X={};ADD={};WHY=collections.defaultdict(set)
for f in sorted(glob.glob('codes/a[0-9].py')):
    sp=importlib.util.spec_from_file_location('c',f);m=importlib.util.module_from_spec(sp);sp.loader.exec_module(m)
    N|=set(m.N);S|=set(m.S);X.update(m.X);ADD.update(m.ADD)
    for k,v in m.WHY.items(): WHY[k]|=set(v)
hand={}
for o in R:
    i=o['i']; st='N' if i in N else 'S' if i in S else 'P'
    true=({AB[x] for x in o['g']}-set(X.get(i,'').split()))|set(ADD.get(i,'').split())
    hand[o['k']]=dict(i=i,status=st,true=true,app=o['app'],stars=o['st'],why=[k for k,v in WHY.items() if i in v])
rows=[json.loads(l) for l in open('flags.jsonl')]
fl={r['k']:r for r in rows}
paid=[r for r in rows if r['tier']]
print('reviews',len(rows),'machine payers',len(paid),'trap',sum(r['trap'] for r in paid))
c=collections.Counter(h['status'] for h in hand.values()); print('A read',len(hand),c)
P=[k for k,h in hand.items() if h['status']=='P']
named=[k for k in P if hand[k]['true']]
print('A chose',len(P),'with real group',len(named))
print('A by store',collections.Counter(fl[k]['s'] for k in named))
# sample rates
restB=set(json.load(open('restB.json')))
Bk=json.load(open('readB.json')); Ck=json.load(open('readC1.json'))+json.load(open('readC2.json'))
bn=len(Bk);bN=len(SM.B_N);bS=len(SM.B_S);bC=bn-bN-bS
cn=len(Ck);cN=len(SM.C_N);cS=len(SM.C_S);cC=cn-cN-cS
print('B',bn,'chose',bC,'S',bS,'N',bN,'| C',cn,'chose',cC,'S',cS,'N',cN)
Bnotrap=[k for k in restB if not fl[k]['trap']]; Btrap=len(restB)-len(Bnotrap)
nog=[r for r in paid if not r['g']]; nog_nt=[r for r in nog if not r['trap']]; nog_t=len(nog)-len(nog_nt)
# trap-flagged payers with no group: take the rate seen among trap-flagged reads in set A
tr=[h for k,h in hand.items() if fl[k]['trap']]; trc=collections.Counter(h['status'] for h in tr); print('trap read',len(tr),trc)
tp=trc['P']/len(tr)
est_B=len(Bnotrap)*bC/bn+Btrap*tp
est_C=len(nog_nt)*cC/cn+nog_t*tp
tot=len(P)+est_B+est_C
print('est chose: A',len(P),'B',round(est_B),'none',round(est_C),'total',round(tot))
print('nog',len(nog),'nog no trap',len(nog_nt),'B notrap',len(Bnotrap),'Btrap',Btrap)
g_paid=collections.Counter();g_sur=collections.Counter();g_why=collections.defaultdict(collections.Counter);g_store=collections.defaultdict(collections.Counter);g_app=collections.defaultdict(collections.Counter)
for k,h in hand.items():
    for g in h['true']:
        if h['status']=='P':
            g_paid[g]+=1;g_store[g][fl[k]['s']]+=1;g_app[g][h['app']]+=1
            for w in h['why']: g_why[g][w]+=1
        if h['status']=='S': g_sur[g]+=1
print('\nGroup paid surprise sur% share_of_named share_of_est ios play')
for g,n in g_paid.most_common():
    print(f"{NAME[g]:42}{n:5d}{g_sur[g]:5d}{100*g_sur[g]/(n+g_sur[g]):5.0f}%{100*n/len(named):6.1f}%{100*n/tot:6.2f}% {g_store[g]['ios']:4d}{g_store[g]['play']:4d}  {g_app[g].most_common(4)}")
print('\nWHY by group (of chose, percent)')
order=['need','worked','love','thanks','invest','cheaper','family','last','limit','once']
for g,n in g_paid.most_common(10):
    print(f"{NAME[g]:42}{n:4d} "+' '.join(f"{w[:5]}:{100*g_why[g][w]/n:3.0f}" for w in order))
allw=collections.Counter(w for k in P for w in hand[k]['why']); print('all A',len(P),allw)
none=sum(1 for k in named if not hand[k]['why']); print('named, no why coded',none)
# no-group reasons
cR={k:len(v) for k,v in SM.C_R.items()}; said=sum(cR.values()); print('\nC chose',cC,'said',said,'no reason',cC-said,cR)
bR={k:len(v) for k,v in SM.B_R.items()}; saidb=sum(bR.values()); print('B chose',bC,'said',saidb,'no reason',bC-saidb,bR)
print('B true groups',{k:len(v) for k,v in SM.B_G.items()})
tb=collections.Counter(g for r in paid if not set(r['g'])&set(AB) for g in r['g']); print('machine tier B payers',tb)
# Who pays more: hand-corrected, 4-5 stars, English, app x length strata
EN={'en','us','gb','ca','au','nz','ie','in','za','sg','ph'}
pos=[r for r in rows if r['st']>=4 and r['loc'] in EN]
# chose-rate for unread payers in positive English reviews
posC=[o['k'] for o in Ck if fl[o['k']]['st']>=4]; Cset=set(SM.C_N)|set(SM.C_S); idx={o['k']:o['i'] for o in Ck}
w=sum(1 for k in posC if idx[k] not in Cset)/len(posC)
print('\nunread payers in 4-5 stars, share who chose',round(w,3),len(posC))
res={}
strata=collections.defaultdict(list)
for r in pos: strata[(r['app'],bucket(r['w']))].append(r)
for g in NAME:
    p=PR.TRUE[g]/24; SR=SD=V1=V2=V3=0; A=Bt=0
    num=den=0;va=vb=vc=0
    for s,rs in strata.items():
        a=b=cc=d=0
        for r in rs:
            h=hand.get(r['k'])
            isg=(g in h['true']) if h else any(AB.get(x)==g for x in r['g'])
            if h: y=1.0 if h['status']=='P' else 0.0
            elif r['tier']: y=w
            else: y=0.0
            if isg:
                if h or not r['tier']:
                    a+=y; b+=(1-y)*(1 if h else p)
                else: a+=y*p; b+=(1-y)*p
            else: cc+=y; d+=1-y
        n=a+b+cc+d
        if n==0 or (a+b)==0: continue
        R_=a*d/n;S_=b*cc/n;num+=R_;den+=S_;A+=a;Bt+=b
        Pn=(a+d)/n;Qn=(b+cc)/n
        V1+=Pn*R_;V2+=Pn*S_+Qn*R_;V3+=Qn*S_
    if num and den:
        OR=num/den;se=math.sqrt(V1/(2*num**2)+V2/(2*num*den)+V3/(2*den**2))
        res[g]=(OR,OR*math.exp(-1.96*se),OR*math.exp(1.96*se),A,A+Bt)
base_a=sum((1.0 if hand[r['k']]['status']=='P' else 0) if r['k'] in hand else (w if r['tier'] else 0) for r in pos)
print('base positive rate',round(100*base_a/len(pos),2),'of',len(pos))
print(f"{'group':42}{'OR':>5}{'lo':>6}{'hi':>6}{'payers':>7}{'real members':>13}{'rate':>7}")
for g,v in sorted(res.items(),key=lambda x:-x[1][0]):
    print(f"{NAME[g]:42}{v[0]:5.2f}{v[1]:6.2f}{v[2]:6.2f}{v[3]:7.0f}{v[4]:13.0f}{100*v[3]/v[4]:6.1f}%")
# lifetime vs subscription among hand payers
txt={}
want=set(P)
for l in open('corpus.jsonl'):
    r=json.loads(l);k=f"{r['s']}|{r['app'].split('.')[0]}|{r['id']}"
    if k in want: txt[k]=r['t'].lower()
ONCE=re.compile(r'lifetime|life time|one[- ]time|forever|lifelong|навсегда|vitalici|終身|永久')
SUB=re.compile(r'subscri|annual|yearly|monthly|a year|per year|per month|подписк|assin|suscrip')
print('\nonce vs sub')
for g,n in g_paid.most_common(10):
    ks=[k for k in P if g in hand[k]['true']]
    o=sum(1 for k in ks if ONCE.search(txt[k]));s=sum(1 for k in ks if SUB.search(txt[k]))
    print(f"{NAME[g]:42}{n:4d} once {100*o/n:3.0f}% sub {100*s/n:3.0f}%")
json.dump({k:{'status':h['status'],'true':sorted(h['true']),'why':h['why']} for k,h in hand.items()},open('hand_codes.json','w'))
