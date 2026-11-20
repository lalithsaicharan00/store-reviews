# Candidate scan for "doing habits together" in app 1. Narrow patterns; the excluded remainder of the broad scan is sampled by hand (see notes).
import json,re,random
R=[json.loads(l) for l in open('../../../../App Store Reviews/1. Habit Tracker - Goal Tracker & ADHD Planner/reviews.jsonl')]
EN=r"shared? (a |my |the |our |your )?habits?|habit[- ]shar|sharing (feature|option|function|habits?)|share (it |them )?(with|progress)|together|accountability (partner|buddy|buddies|with|feature)|hold (each other|one another)|with (my |a |our )?(friends?|partner|husband|wife|boyfriend|girlfriend|bf|gf|spouse|kids?|children|son|daughter|family|mom|mum|dad|sister|brother|roommate|team|coworkers?)\b|\bgroups?\b|compet|challenge (with|friends|my|each)|buddy|buddies|leaderboard|qr code|\bsocial\b|invit|friends? (can|could|to|will) see|see (each other|my friends|their|how my)|each other|one another|android (users?|friends?|family)"
CN=r"一起打卡|一起养成|一起養成|好友|共享|组队|組隊|搭子|情侣|情侶|伙伴|夥伴|互相(监督|督促|監督|打卡|鼓励|鼓勵)|[和跟与與](朋友|家人|对象|對象|男朋友|女朋友|男友|女友|老公|老婆|同学|同學|室友|闺蜜|閨蜜)|邀请|邀請|分享(习惯|習慣|打卡)|朋友.{0,8}(一起|监督|監督|互相|打卡|看到)|一起.{0,6}(习惯|習慣|坚持|堅持|监督|監督)|[监監督][督促].{0,3}(男朋友|女朋友|老公|老婆|孩子|小朋友|家人|对象|對象)|孩子|小朋友|安卓用户|安卓用戶"
OT=r"partag|ensemble|zusammen|gemeinsam|juntos|compartir|compartilh|вместе|一緒|함께|共有|teilen|condivid|insieme|samen|razem|делит|друз|семь"
def hit(r):
    t=(r.get('title') or '')+' | '+(r.get('body') or '')
    return re.search(EN,t,re.I) or re.search(CN,t) or re.search(OT,t,re.I)
if __name__=='__main__':
    H=sorted([r for r in R if hit(r)],key=lambda r:r['date'])
    print(len(H))
    with open('1-together-read.txt','w') as f:
        for i,r in enumerate(H):
            f.write(f"{i}|{r['review_id']}|{r['country']}|{r['rating']}|{r['date'][:7]}| {r.get('title')} | {r.get('body')}".replace('\n',' ')+'\n')
    json.dump([r['review_id'] for r in H],open('1-together-ids.json','w'))
    broad=set(json.load(open('1-together-candidates.json')))
    rest=[r for r in R if r['review_id'] in broad and not hit(r)]
    random.seed(7); s=random.sample(rest,min(120,len(rest)))
    with open('1-together-excluded-sample2.txt','w') as f:
        for r in s: f.write(f"{r['review_id']}|{r['country']}|{r['rating']}| {r.get('title')} | {r.get('body')}".replace('\n',' ')[:500]+'\n')
    print('excluded from broad',len(rest))
