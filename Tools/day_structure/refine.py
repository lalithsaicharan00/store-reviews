"""Second pass: split habit/routine apps from adjacent (to-do, notes, calendar, gym) corpora and
drop generic matches (plain 'step by step', plain 'timer', social 'group') that are not about day structure."""
import json,re,collections
ADJ_PLAY={84,85,95,96,97,100,111,121,122,126,127,129,131}
HW=r"(habit|h[áa]bit|habitud|gewohnheit|abitudin|привыч|alışkanl|عاد|kebiasaan|nawyk|gewoonte|thói\s*quen|习惯|習慣|습관|task|tarea|tarefa|t[âa]che|aufgabe|задач|görev|مهام|tugas|zadan|taak|việc|任务|タスク|할\s*일|routine|rutin|rotin|рутин|ルーティン|루틴|goal|meta|objetiv|objecti|ziel|цел|hedef|目标|目標|목표|lista|list|список)"
GRP_GENERIC=re.compile(r"(\bgroups?\b|\bgrupos?\b|\bgroupes?\b|\bgruppen?\b|\bgruppi\b|групп|\bgrup\b|nhóm|مجموع|그룹|グループ|分组|分組)",re.I)
GRP_STRONG=re.compile(r"(categor|kategor|категор|folder|carpeta|pasta|dossier|ordner|cartell|папк|klasör|مجلد|mappe|thư\s*mục|文件夹|フォルダ|폴더|(?-i:\btags?\b)|tagging|etiquet|[ée]tiquette|etiket|etykiet|(?<![а-яё])метк|(?<![а-яё])тег(?!рац)|标签|標籤|タグ|태그|\blabels?\b|분류|分类|类别|類別|カテゴリ|카테고리|فئ|تصنيف|danh\s*mục|areas?\s+of\s+(my\s+)?life|life\s+areas?|filter|separate\s+(lists|tabs|pages)|multiple\s+(lists|tabs|pages)|lists?\s+of\s+habits|sort\s+(my\s+)?habits|organi[sz]e\s+(my\s+)?habits)",re.I)
RTN_STRONG=re.compile(r"((start|begin|run|play|launch)\s+(the\s+|my\s+|a\s+|your\s+)?(morning\s+|evening\s+|night\s+|bedtime\s+)?routines?|routines?\s+(mode|player|timer|runner|flow|builder|feature|function|option|section|tab)|guided\s+(routine|mode|session|flow)|habit\s+stack|stack(ing)?\s+(my\s+)?habits|chain\s+(of\s+)?habits|sequence|in\s+(a\s+)?order\b|next\s+(step|task|habit|activity)|ルーティン.{0,3}(開始|実行|再生)|루틴\s*(시작|실행|모드)|例程|流程|rutinas?\s+guiad|rotinas?\s+guiad|routine\s+starten|запустить)",re.I)
TIMERW=re.compile(r"(timer|countdown|temporizador|cron[óo]metro|minuteur|таймер|zamanlayıcı|مؤقت|计时|倒计时|タイマー|타이머)",re.I)
STEPW=re.compile(r"(step[\s-]by[\s-]step|paso\s+a\s+paso|passo\s+a\s+passo|[ée]tape\s+par|schritt\s+f[üu]r|passo\s+dopo|пошагов|adım\s+adım|خطوة\s+بخطوة|一步一步)",re.I)
ROUT_CTX=re.compile(r"(routine|rutina|rotina|рутин|ルーティン|루틴|例程|each|every|per\s|step|sequence|next|cada|chaque|jede|каждо|her\s|كل|每|各|각)",re.I)
out=collections.Counter(); keep=[]
for l in open("candidates.jsonl"):
    c=json.loads(l); t=c["text"]
    n=int(c["folder"].split(".")[0])
    c["tier"]="adjacent" if c["store"]=="native" or (c["store"]=="play" and n in ADJ_PLAY) else "habit"
    fam=set(c["fam"])
    german=re.search(r"\b(und|ich|nicht|die|das|ist)\b",t) and re.search(r"(?-i:\bTag)",t)
    if german and not re.search(r"(?-i:\btags\b)|categor|kategor|ordner|gruppe",t,re.I): t2=re.sub(r"\b[Tt]ag\b","",t)
    else: t2=t
    if "GRP" in fam and not GRP_STRONG.search(t2):
        # generic group word: keep only near a habit/task/routine word
        m=GRP_GENERIC.search(t)
        if not (m and re.search(HW+r".{0,40}"+GRP_GENERIC.pattern+"|"+GRP_GENERIC.pattern+r".{0,40}"+HW,t,re.I)): fam.discard("GRP")
    if "RTN" in fam and not RTN_STRONG.search(t):
        ok=False
        for m in TIMERW.finditer(t):
            if ROUT_CTX.search(t[max(0,m.start()-60):m.end()+60]): ok=True
        for m in STEPW.finditer(t):
            if re.search(r"(routine|rutina|rotina|рутин|timer|temporizador|guide|guía|guia)",t[max(0,m.start()-60):m.end()+60],re.I): ok=True
        if not ok: fam.discard("RTN")
    if fam:
        c["fam"]=sorted(fam); keep.append(c)
        for f in fam: out[(c["tier"],f)]+=1
        out[c["tier"]]+=1
print(sorted(out.items(),key=str))
json.dump(keep,open("candidates2.json","w"),ensure_ascii=False)
