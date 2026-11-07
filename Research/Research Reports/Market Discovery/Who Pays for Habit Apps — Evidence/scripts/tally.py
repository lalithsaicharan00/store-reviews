import json,glob,collections,importlib.util,sys
AB={'adhd':'AD','add_caps':'AD','autism':'AU','depression_anxiety':'DA','serious_mh':'MH','therapy_client':'TC','professional_helper':'PR','chronic_illness':'CI','recovery_quit':'RQ','student':'ST','teen_minor':'TN','parent':'PA','for_child':'CH','couple_friends':'CF','shift_work_jobs':'JB','tech_founder':'TF','faith':'FA','older_adult':'OA'}
R=json.load(open('readA.json'))
N=set();S=set();X={};ADD={};WHY=collections.defaultdict(set);hi=-1
for f in sorted(glob.glob('codes/a*.py')):
    sp=importlib.util.spec_from_file_location('c',f);m=importlib.util.module_from_spec(sp);sp.loader.exec_module(m)
    N|=set(m.N);S|=set(m.S);X.update(m.X);ADD.update(m.ADD)
    for k,v in m.WHY.items(): WHY[k]|=set(v)
    hi=min(1297,186*(int(f.split("/a")[-1].split(".")[0])+1)-1)
print('read through',hi)
c=collections.Counter(); g_read=collections.Counter(); g_true=collections.Counter(); g_paid=collections.Counter(); g_sur=collections.Counter(); g_why=collections.defaultdict(collections.Counter); g_stars=collections.defaultdict(list)
n=0
for o in R:
    i=o['i']
    if i>hi: continue
    n+=1
    st='N' if i in N else 'S' if i in S else 'P'; c[st]+=1
    mg={AB[x] for x in o['g']}
    for g in mg: g_read[g]+=1
    true=(mg-set(X.get(i,'').split()))|set(ADD.get(i,'').split())
    for g in true:
        g_true[g]+=1
        if st=='P':
            g_paid[g]+=1; g_stars[g].append(o['st'])
            for k,v in WHY.items():
                if i in v: g_why[g][k]+=1
        if st=='S': g_sur[g]+=1
print(n,c)
print(f"{'g':4}{'read':>5}{'true':>5}{'prec':>6}{'paid':>5}{'surp':>5}{'sur%':>6}{'avg★':>5}  why")
for g,_ in g_read.most_common():
    p=g_paid[g];s=g_sur[g]
    print(f"{g:4}{g_read[g]:5d}{g_true[g]:5d}{100*g_true[g]/g_read[g]:6.0f}{p:5d}{s:5d}{100*s/max(1,p+s):6.0f}{sum(g_stars[g])/max(1,len(g_stars[g])):5.1f}  {dict(g_why[g].most_common())}")
