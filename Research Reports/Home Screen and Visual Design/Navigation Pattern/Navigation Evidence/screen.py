"""Full-corpus screen for app-navigation remarks (hamburger/drawer vs bottom tab bar, menus, tabs,
findability). Writes every matched review to candidates.jsonl with the families it matched.
line = 1-based line number in the source reviews.jsonl."""
import json, glob, re, collections, os
ROOT = "/Users/lalith/Desktop/store reviews"
F = {}
# SPEC-DRAWER: hamburger / side drawer / side menu
F["DRW"] = re.compile(r"""
 hamburger|burger\s*menu|\bdrawer\b|side[\s-]?(menu|bar|panel|navigation|nav)s?\b|sidebar|slide[\s-]?(out|in)\s+(menu|panel|drawer)|slide\s+menu|swipe\s+(from\s+the\s+)?(left|right)\s+(for|to\s+(open|get|see))\s+(the\s+)?menu
 | three\s+(horizontal\s+)?(lines|bars|stripes)\b | 3\s+(horizontal\s+)?(lines|bars)\b.{0,20}(menu|icon|button|top)
 | 侧边栏|侧栏|側邊欄|侧滑|抽屉|抽屜|汉堡|漢堡|サイドメニュー|サイドバー|ハンバーガー|ドロワー|사이드\s*(메뉴|바)|햄버거|서랍
 | men[úu]\s+lateral|barra\s+lateral|men[úu]\s+(hamburguesa|desplegable\s+lateral)|menu\s+lat[ée]ral|barre\s+lat[ée]rale|seitenmen[üu]|seitenleiste|men[úu]\s+a\s+scomparsa|бургер|боков(ое|ая|ой)\s+(меню|панел)|шторк|yan\s+men[üu]|القائمة\s+الجانبية|menu\s+samping|boczne\s+menu|zijmenu
""", re.I|re.X)
# SPEC-TAB: bottom tab bar / bottom navigation / tabs
F["TAB"] = re.compile(r"""
 bottom\s+(tab|nav|navigation|menu|bar|toolbar|buttons?|icons?)s?\b|tab[\s-]?bars?\b|nav(igation)?[\s-]?bars?\b|tabs?\s+(at|on|along)\s+(the\s+)?(bottom|top)|(bottom|top)\s+of\s+the\s+screen.{0,25}(tab|button|icon|menu|bar)
 | (menu|toolbar|buttons?|icons?)\s+(at|on)\s+the\s+bottom|(too\s+many|so\s+many|several|different|multiple|separate|extra)\s+tabs|\btabs?\b.{0,25}\b(navigat|switch|swipe|tap\s+between|go\s+between|jump)
 | 底部(导航|導航|栏|欄|菜单|菜單|按钮|标签)|标签栏|標籤欄|导航栏|導航欄|タブバー|下部の?(タブ|メニュー|ボタン)|ボトム(ナビ|バー|メニュー)|하단\s*(탭|메뉴|바|내비|네비|버튼)|탭\s*바
 | barra\s+(inferior|de\s+navegaci[óo]n|de\s+(pestañas|abas))|men[úu]\s+inferior|pestañas|\babas\b|onglets?|barre\s+(du\s+bas|inf[ée]rieure|de\s+navigation|d.onglets)|registerkarten|men[üu]leiste|untere\s+(leiste|men[üu])|navigationsleiste|barra\s+in\s+basso|нижн(ее|яя|ей|юю)\s+(меню|панел|вкладк)|вкладк|alt\s+(men[üu]|çubu)|sekme
""", re.I|re.X)
# FIND: findability / buried / hidden in menus / too many menus / navigation difficulty
F["FND"] = re.compile(r"""
 (buried|hidden|tucked|lost)\s+(away\s+)?(in|under|behind|inside)\s+(a\s+|the\s+|some\s+|several\s+|multiple\s+)?(menu|settings|submenu|sub-menu|layers?|tabs?|screens?|pages?)
 | (too\s+many|so\s+many|endless|lots\s+of|layers\s+of|multiple)\s+(menus|sub-?menus|clicks|taps|screens|pages|layers|buttons)
 | (hard|difficult|confusing|impossible|annoying|tricky|not\s+easy|unintuitive|counter-?intuitive)\s+to\s+(navigate|find)|navigation\s+(is|was)\s+(confusing|clunky|hard|difficult|awful|terrible|bad|poor|weird|counter)|(confusing|clunky|poor|bad|awkward|unintuitive|cumbersome|weird)\s+navigation
 | (can.?t|cannot|couldn.?t|could\s+not|unable\s+to)\s+find\s+(the\s+|where|how|a\s+way|any\s+way)|where\s+(is|are)\s+the\s+(settings?|menu|button|option|stats?|statistics)
 | menu\s+(button|icon)|(open|tap|click|press)\s+(the\s+)?menu|in\s+the\s+menu|from\s+the\s+menu|main\s+menu|the\s+menu\b
""", re.I|re.X)
# GEN: generic "easy to navigate / navigation"
F["GEN"] = re.compile(r"navigat|ナビ|导航|導航|내비|네비|navega|navig|навиг|gezin", re.I)

def recs():
    for store, pat in [("app","App Store Reviews/*/reviews.jsonl"),("play","Play Store Reviews/*/reviews.jsonl"),("native","Native Store Reviews/*/reviews.jsonl")]:
        for f in sorted(glob.glob(os.path.join(ROOT, pat))):
            folder = f.split("/")[-2]
            for i,l in enumerate(open(f)):
                r = json.loads(l)
                text = ((r.get("title") or "") + " — " + (r.get("body") or r.get("text") or r.get("content") or "")).strip()
                yield store, folder, i+1, r, text

tot = collections.Counter(); hit = collections.Counter()
with open("candidates.jsonl","w") as out:
    for store, folder, line, r, text in recs():
        tot[store]+=1
        fams = [k for k,rx in F.items() if rx.search(text)]
        if not fams: continue
        for k in fams: hit[(store,k)]+=1
        out.write(json.dumps({"store":store,"folder":folder,"line":line,"review_id":r.get("review_id") or r.get("reviewId") or r.get("id"),
            "rating":r.get("rating") or r.get("score"),"date":(r.get("date") or r.get("at") or "")[:10],"fams":fams,"text":text},ensure_ascii=False)+"\n")
print("screened", dict(tot), sum(tot.values()))
for k in F:
    print(k, {s:hit[(s,k)] for s in ("app","play","native")})
