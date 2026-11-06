import pickle,re,collections,json,sys
rows=pickle.load(open('rows.pkl','rb'))
F=re.I
SEG={
 'adhd':r"\badhd\b|\badd brain\b|\bautis(m|tic)\b|neurodivergent|neurodiverse|executive (dys)?function|\baudhd\b",
 'mental':r"\bdepress(ion|ed|ive)\b|\banxiety\b|\banxious\b|mental health|\btherap(ist|y)\b|\bbpd\b|\bbipolar\b|\bptsd\b|burn ?out|\bsuicid",
 'quit':r"\bsober\b|sobriety|quit(ting)? (smoking|vaping|drinking|alcohol|porn|weed|sugar|caffeine|social media)|\bvap(e|ing)\b|\bcigarett|\bnofap\b|\bporn\b|addiction|\baddict\b|days clean|\bclean for\b|\brelapse",
 'fitness':r"\bgym\b|work ?outs?\b|\bexercis|weight loss|lose weight|losing weight|\bdiet(ing)?\b|calorie|\brunning\b|\bsteps\b|push ?ups?",
 'student':r"\bstudent\b|\bstudying\b|\bexams?\b|\bcollege\b|\buniversity\b|\bhomework\b|\bhigh school\b|\bclasses\b",
 'game':r"\brpg\b|gamif|\bgame\b|\blevel(ing)? up\b|\bxp\b|\bquests?\b|\bmy (pet|bird|birb|bunny|cat|teddy|creature)\b|\bpet\b|\bbirb\b",
 'faith':r"\bpray(er|ers|ing)?\b|\bquran\b|\bsalah\b|\bnamaz\b|\bbible\b|\bchurch\b|\bscripture\b|\bdhikr\b|\bdevotional",
 'parent':r"\bmy (kids|son|daughter|child|children|toddler|boys|girls)\b|\bchores\b|\bas a (mom|mum|dad|parent|mother|father)\b|\bmy (husband|wife|partner|boyfriend|girlfriend)\b|\bfamily\b",
 'data':r"\bstatistic|\bstats\b|\bcharts?\b|\bgraphs?\b|\banalytics\b|\bexport\b|\bcsv\b|\bheat ?map\b|\bdata\b",
 'planner':r"to-?do|\btasks?\b|\bplanner\b|\bschedul|\bcalendar\b|time ?block|productiv|\bmy work\b|\bat work\b",
 'routine':r"morning routine|night routine|evening routine|bedtime|\bwake up\b|\bsleep\b",
 'aesthetic':r"\baesthetic\b|\bcute\b|\badorable\b|\bpretty\b|\bkawaii\b|\bthat girl\b|\bglow ?up\b|\bpastel\b",
 'minimal':r"\bsimple\b|\bminimal(ist|istic)?\b|\bclean (design|ui|interface|look)\b|\bno (ads|bloat|fluff)\b|straightforward|\bno account\b|\bprivacy\b|\boffline\b",
 'meds':r"\bmedication\b|\bmeds\b|\bpills?\b|\bvitamins?\b|\bsupplements?\b|\bdiabet|\bchronic\b|\bdisabilit",
 'skincare':r"skin ?care|\bperiod\b(?! of)|\bcycle\b|\bpregnan",
 'apple_eco':r"apple watch|\bipad\b|\bmac(book|os)?\b|\bwatch app\b|\bwear ?os\b|\bwidgets?\b|\bshortcuts?\b|health ?kit|apple health",
 'social':r"\bfriends?\b.*\b(together|compete|challenge|share|accountab)|accountability partner|\bwith (my )?friends\b|\bleaderboard\b|\bcompete\b",
 'language':r"\bduolingo\b|learn(ing)? (a )?(language|spanish|french|japanese|german)|\bread(ing)? (books|more|daily)\b|\bjournal(ing)?\b",
}
SEG={k:re.compile(v,F) for k,v in SEG.items()}
PAID=re.compile(r"\b(i|i've|i have|i'?d|we|i just|i finally)\s+(just\s+|already\s+|happily\s+|gladly\s+|even\s+|finally\s+|actually\s+|also\s+|recently\s+|immediately\s+|ended up\s+)?(paid|bought|purchased|subscribed|upgraded|got the (premium|pro|lifetime|plus|full|annual|yearly))\b|\bpaid for (the )?(premium|pro|plus|lifetime|subscription|app|full|it)\b|worth (every (penny|cent|dollar)|the (money|price|subscription|purchase|upgrade))|\b(premium|pro|plus|lifetime|paying) (user|member|subscriber|customer)\b|\bi pay for\b|\bmy subscription\b|\bbought (the )?(premium|pro|lifetime|plus|full version|app)\b|\b(lifetime|premium|pro) (purchase|license)\b",F)
RESIST=re.compile(r"paywall|too expensive|overpriced|\bpricey\b|money ?grab|cash ?grab|greedy|not worth (paying|the price|the money)|\bhave to pay\b|wants? (your )?money|\bscam\b|charged me|ripoff|rip-off|\bsubscription\b.{0,40}\b(ridiculous|expensive|insane|crazy|no|hate|why)|\b(hate|no|not another|another) subscriptions?\b|everything (is )?(behind|locked)",F)
LIFE=re.compile(r"\b(lifetime|one[- ]time (purchase|payment|fee|price)|pay once|buy once)\b",F)
out={}
allen=[r for r in rows if r[4]]
base_p=sum(1 for r in allen if PAID.search(r[5]))/len(allen)
base_r=sum(1 for r in allen if RESIST.search(r[5]))/len(allen)
print('EN',len(allen),'paid %.3f%%'%(100*base_p),'resist %.3f%%'%(100*base_r))
hits=collections.defaultdict(list)
for r in allen:
    t=r[5]
    p=bool(PAID.search(t)); s=bool(RESIST.search(t)); lf=bool(LIFE.search(t))
    for k,rx in SEG.items():
        if rx.search(t): hits[k].append((r,p,s,lf))
res=[]
for k,L in hits.items():
    n=len(L); p=sum(x[1] for x in L); s=sum(x[2] for x in L); lf=sum(x[3] for x in L)
    ios=sum(1 for x in L if x[0][0]=='ios'); rt=sum(x[0][3] for x in L)/n
    apps=collections.Counter(x[0][1] for x in L)
    # share of segment mentions per app relative: top apps by count
    res.append((k,n,100*n/len(allen),100*p/n,(p/n)/base_p,100*s/n,(s/n)/base_r,100*lf/n,100*ios/n,rt,apps.most_common(6)))
res.sort(key=lambda x:-x[4])
for x in res:
    print(f"{x[0]:10} n={x[1]:6} {x[2]:5.2f}% paid={x[3]:4.2f}% ({x[4]:.2f}x) resist={x[5]:4.2f}% ({x[6]:.2f}x) life={x[7]:.2f}% ios={x[8]:.0f}% ★{x[9]:.2f}")
    print('    ',[(a[:30],c) for a,c in x[10]])
pickle.dump(hits,open('hits.pkl','wb'))
