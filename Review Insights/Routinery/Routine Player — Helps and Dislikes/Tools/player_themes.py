"""Routinery routine player: what helps and what users dislike.

Every theme behind "Routinery — Routine Player — What Helps and What Users Dislike.md".
Run from anywhere:  python3 -I player_themes.py            (counts per theme)
                    python3 -I player_themes.py appendix   (every review ID per theme, as a Markdown table)
Writes player_themes.json (theme -> full review IDs) next to this file.

Problem themes ("P") are hand-curated lists of review-ID prefixes, made by reading every candidate label.
Help themes ("H") are patterns over the `liked` and `chose_for` labels, with false matches found by reading
excluded by ID or by pattern. The watch themes are patterns over `problems`, read in samples.
Written by Claude (Claude Code), 28 November 2026.
"""
import json,glob,re,collections,statistics,sys,os
HERE=os.path.dirname(os.path.abspath(__file__))
ROOT=os.path.abspath(os.path.join(HERE,"../../../.."))
LABELS=os.path.join(ROOT,"Review Labels","Routinery")
L={}
for f in sorted(glob.glob(os.path.join(LABELS,"*","labels.jsonl"))):
    for line in open(f):
        l=json.loads(line); L[l["review_id"]]=l
R={}
for f in sorted(glob.glob(os.path.join(LABELS,"*","reviews.jsonl"))):
    for line in open(f):
        r=json.loads(line); R[r["review_id"]]=r
def S(s): return s.split()
P={}  # problems
P["undo"]=S("fcaa917c 9691e9eb 00810516 4ea799a3 b1934dbe 2e9605d1 7079196017 ffffce59 94ba5eb7 7843095633 8094545941 8261526871 a1bb520b fc00b12e 302deabe 9980992196 1025016560 11ec4320 c0852f07 05f4e616 74440504 1121708861 1158084278 1206918238 1311985859 5e719aa3 bd1cc505 1003378164 7ac5d2ea adc0878b 5432864399 f6d545a7")
P["button_placement"]=S("5432864399 f6d545a7 5e719aa3 07a3077f 514b6c5f 74440504 adc0878b 1206918238 e33ffa7a")
P["skipped_gone_order"]=S("ba5e72ed a07c27ce d2f22a01 3570c16c fda805eb 79e68fb2 273e3c74 32b498e8 30fb4bae 561d8e2e 6938277128 823c7e8d 3cb035d9 2dd9c0ed 7c8daf10 155d2496 7a611c18 8745613875 1019177904 1273110183 1244206771 1077508068 81540359 7625583895 044a642b 1436190321 65692248 1246364261 1179908805 7734088825 1234907617 7625074704 5e719aa3")
P["no_skip_button"]=S("fe87180c 23cf7bd6 1407308062")
P["parallel"]=S("7806175559 fe93abb1 fc85df9f bc79b387 1071041711 82cd0403 4a947197 0148580a 7959641419")
P["edit_mid_run"]=S("9691e9eb c36b3b8c 1b1b57bc 1bd93dae 02da79c3 76b63f72 5bf51d5f 6955478723 7926ae3e 9d57f40d 98ba99fa 7671208684 fdad6e0d 5ee16525 a06c3af0 1211c43a 4d1e42de cdce22d6 8447625826 8c1d4e83 9316059449 9537508046 9818758756 8a721672 1212083900 1359599931 6190659183 85a1ae2e")
P["notes_mid_run"]=S("032a0615 1ae62139 7eb05b53 f0beeb7c 1360486704 1370244171")
P["timer_forced"]=S("cceb664f 6474496213 6661289869 81540359 b3d27f6b 8605ed47 7246817204 cc7ef4fb b05b9824 7510768204 7538016690 7625583895 8c142ba8 59fc3254 dd340cb5 a934f25c 8791467148 e00924fe 9010899661 71402363 1000406167 f4320cd9 3e02fac5 a7e26036 4d0a50a3 1050713501 1074601196 1101564215 e9c2e95f 17297b1b 1197291737 1216053156 1270046027 1307327855 1308317285 1344214122")
P["timer_stress"]=S("e824fae3 7510768204 12945c3c 8839466844 8848686558 1101564215 e0bc2095 194d970f 1197291737 1298460017 1312783001 1337380943 0e50a358 1402540953 81ca585c b3c1a9c5 1371415949")
P["hide_numbers"]=S("a5aca58b 9677875961 4f21117d")
P["no_time_up_alert"]=S("4e2e7cb4 1571e873 13dbb806 f1c9e692 c8c13021 3fcbde19 13ee861c 13063734 37137185 1c4c6100 7538016690 6967fdc9 9cf9111e c325d70f 510f685a 922d2b2d 7885385809 0ce079d3 8285258859 8355872368 e7f07cf2 2856f8c0 8791656213 6a5b871e a9f639ff 9219301950 47b8e170 ba3cf9e6 68371e26 60cafafd 33e72579 11d706e4 f68d6379 c1b4d6cf ad47e481 c449c0d9 11711220581 11862838916 753ee870 9bf9a480 d8d7fbbe 163b85bc 64950f79 810b5737 13982523131 aea0fc3d f2ea0c4c c923f3db 6c2f04ba 9f2d3783 29492692 8590021218 1d5fc5af bb2689ff 1f43da7e 7351344794")
P["nagging_alerts"]=S("0f9b544c 1354905192 be853b23 6727944992 e5935276 1371415949 1123377276 9709323898 7625583895 8d4fa3e2 1019147317 1402554307 9c7bb448 befcafe9 6052508429")
P["alert_sound_control"]=S("effc50a0 498be657 fda8ae2f 29cf670f c48a446a d469ad41 1019177904 1191760616 21d53eb0 5fbe93a1 b96b7728 9554803d")
P["wants_autonext"]=S("50424e8e 5900262906 76c3ff8d daf863d0 14300d14 5898b151 7119123744 d436eb5c ead62ba5 c325d70f 7665780253 50495293 9759182851 4f21117d 12900411902 11866462906 13526313778 14073080620 bf8493a8")
P["autonext_broken"]=S("7872735468 66b64fe0 6a5b871e 12f92e06 09eb441a 07a387bf dafcf1f2 d7ac46d9 24b5d083 9861014690 3d2935cb 10584591004 963e9573 12825861477 13727332123 13259002296 12397332591 14191150102 8765909690 3c165726")
P["autonext_dislike"]=S("7079196017 11233772767")
P["run_lost"]=S("6326429154 37357318 7e645850 7858806506 1e74cb7a 4878bcb8 9183771774 10999826761 11400702751 11626919730 13323018578 291c6a4a d9755b1e b805da86 12973553692 c545cb35 2a443a10 e5be6e7a 9267380614 8ca0edf5 181d08f8 26d4b900 5a338414 53f5bd6f ad8e1b17")
P["taps_freeze"]=S("6322696880 9607295246 3f33b873 f3939cbb cbb9e1be 518fa263 1138191698 1133893164 74381b21 84c55b5c 1e964c93 3da85b05 1bdf5bb1 8447625826 64db607d ac08896e 1338898919 10432199920 90e44f4f 52d2d9ce")
P["skip_bugs"]=S("1401657387 1403758294 1343340013 f326c5d8 b4616803 8b2b63db 1003378164 a77a46f1 9057847346 faff8d9c")
P["starts_last_step"]=S("7358636824 8948023303 9310254092 9512372663 9736016486 9765704843 9780720694")
P["outside_app_missing"]=S("99617b3b 605796a8 1ae62139 c923f3db 2388ba1a 945b911e 9c07f645 9239813390 9270622470 9502486128 9560577009 9810651911 9818758756 9914110069 9923645583 05f4e616 ebeb285f 1437269552 6808956777 bbf087f3 4a597709 794a53fa 03e5fd4e 12492516128 d469ad41 b04e1051 e39643c2 1375682976 1336c86b 7596402847 ba0238dd 447111a1 a198b84f 58677bfd 126d9e26 269f000d bf8493a8")
P["outside_app_broken"]=S("ee6c19d7 1030699616 ce1ac27a 1049600448 1069642941 6a2985ba 1101071815 92107e27 1160643914 1239733259 1282586147 1292208944 1332301857 1371847349 1372733212 1419115010 a2b750b5 0970d292 90160406 8949797596 ede1d792 9554803d c545cb35 e3a3e3e0")
P["timer_state_wrong"]=S("cf9b88b2 f815b43f e2aa7070 b603151e 5191cc78 fb57d428 faff8d9c 10520152450 223a0f24 15e15852 7cfb6a13 9711535882 9502486128 c6d7d584 8851792332 6e1f227e 90160406 f1c9e2fb 1390152911")
P["eta_wrong"]=S("6174662207 8ca0edf5 1032281449 1040464684 0d184902 1290046647 1292405232 1292669875 d889bda4 1292208944 1292686587 4bbcfad2 1293098598 dd4d3dbc ab9c6988 6e51d06f 1332301857 940604db 9110824182 1291112762")
P["eta_wants_more"]=S("8254740918 8ac54673 9964657099 e94fc7f4 7294333740 5e118c4d 9392564396 1268281073 5e2d5c82")
P["voice_dislike"]=S("5fbe93a1 9554803d 9332392150 9350028810 cfd2ba54 9447779146 9514086047 9517038038 b91dacbf 9614812362 be4c5439 9827006215 9773230745 3d4b18ef 1027481724 b1899f6e 1031878234 1038764387 1049600448 1053504109 1054211901 1118830093 1133956587 1146403545 1147097966 1191760616 1226851039 1274899174 1308369297 1312783001 1338027270 23a4750f 64950f79 1356897460 1362627206 1373032897 1379208067 ce3bde19 1430575920 07d7e19f 1213445455 12748991748 9888292979")
P["voice_cant_off"]=S("9554803d 9332392150 9514086047 9517038038 9614812362 be4c5439 3d4b18ef 1038764387 1274899174 1312783001 64950f79 1031878234 b96b7728 11233772767 9350028810 1027481724")
P["voice_broken"]=S("8406803990 8493158476 3d4b18ef 1043219992 1576d7bb 1343796733 1273322198 0c6f89f4 90b5d219 dafcf1f2 90160406")
P["voice_wants"]=S("e46de97c d8fd3973 9773230745 b1899f6e 1047231964 1077508068 1133956587 1255140674 1b280be1 1273322198 1292989041 1341163856 9447779146 1373032897 1146403545")
P["stops_music"]=S("5715799082 79742061 ebd77d40 8452720381 8456239482 8466255751 8483895502 016b7d12 1176059848 1379208067 1361986559")
P["wants_music"]=S("7b891566 7152899221 98ba99fa 54f7a1b9 92840693 1363456694 dbd3fe27 3215930a 6de0e983 185da7de 99af5017")
P["battery"]=S("9691e9eb cea2de07 7538451918 98bc807b 2a89a44e 8447625826 8547905253 8676407171 8687747703 9064153061 104c9e5d 92f3fa19 4c4beb1e 9472051623 9502486128 9529433434 9665650591 9693496853 2582006a 9759386345 9764474844 9842275773 9940458838 9984000312 9958518584 10062211570 10098317714 10135282986 10239716747 10256362801 10317575337 d086aaef 10312334582 fad193e1 31497d1c 10542119017 f69e8cfd 9d905c9b 10666322625 11125731785 11182114701 11188300937 11229354705 3067dffe 11515721909 c0678f27 11522558139 11695995725 194d970f e9a29ee1 15e15852 12275536848 12737168935 12845278815 13101387144 13091482216 13195777384 13219319750 13202769449 13249089782 13323018578 13376641175 13362713060 13520796132 f6a0141a 14073080620 14305701584 14305759207 14493761177 14491246957")
P["battery_while_running"]=S("7538451918 9064153061 9502486128 2582006a 9759386345 9958518584 10317575337 11125731785 11188300937 11229354705 3067dffe 11515721909 12737168935 13323018578 13376641175 4c4beb1e")
P["no_breathing_room"]=S("7174563257 7294333740 d9537896 971415d6 1371415949 76273996")
P["overtime_missing"]=S("5555227865 5558415928 53180359")
P["end_screen"]=S("8d4fa3e2 1212083900 01d2c8ea ef7158c0 5555227865 514b6c5f 9110824182")

# ---- helps: refined patterns over liked/chose_for labels, minus false matches found by reading
def liked_hits(rx, excl=(), exrx=None):
    out=set()
    for rid,l in L.items():
        for k in ("liked","chose_for"):
            for e in l.get(k) or []:
                t=(e.get("feature") or "").lower()
                if re.search(rx,t) and not (exrx and re.search(exrx,t)) and not any(rid.startswith(x) for x in excl):
                    out.add(rid)
    return out
H={}
H["timer"]=liked_hits(r"timer|countdown|count ?down|time limit|timed (task|step|routine)s?|time (for|per) (each|every) (task|step|activity|habit)",
    exrx=r"syncs|watch|widget|pomodoro|choice of timer type")
H["eta"]=liked_hits(r"(end|finish|finishing|completion|ending) time|ends? (by|at)|\beta\b|estimated (end|finish)|predict(s|ed)? (when|ending)|when (the routine|you|i|it)('ll| will)? (finish|end|be done)|time (left|remaining)|when you'll be done|when the routine will",
    excl=S("61bab33b eaaad9f4 0525a239 85a1ae2e 1085380809 1211748676 cedceb29 00df08d1 9839987217 02f9a984 c1aa0e5e f1ceba9f 1092518882"))
H["guided"]=liked_hits(r"one (task|step|thing|item|action|part)s? (at a time|on screen)|step[- ]by[- ]step|guides? (you|me|them)|walks? (you|me|them) through|guided|(what|the) (to do )?next (task|step|action)|tells? (you|me|them) what to do|focus on (one|the current|the one)|without thinking|no need to (think|remember)|don't have to think|choice paralysis|deciding the next",
    excl=S("1016974254 1089611802 1435295040 d0cf58c7 1131415356 9147886228 1341354440 5366f884"))
H["voice"]=liked_hits(r"voice|read(s)? (out|aloud)|announce|announcement|narrat|speaks?|talks to|spoken|audio reminder",
    excl=S("a891d31a 17397b04 1115373587"))
H["skip"]=liked_hits(r"\bskip", exrx=r"routine(s)? (when|less)|skips? (task initiation|routines less|or forgets)|without skipping|not skip|prevents skipped|can't skip|skip a routine|skips routines")
H["pause"]=liked_hits(r"\bpause", exrx=r"pause and breathe")
H["pause_reminder"]=liked_hits(r"(remind|alert|notif)\w*.{0,25}paus|paus\w*.{0,25}(remind|alert)|back on track after a pause")
H["add_time"]=liked_hits(r"add(ing)? (more |extra )?time|extra time|extend|snooze for|adding more minutes|\+ ?\d+ ?min|cut a step short", excl=S("1115373587"))
H["reorder_mid"]=liked_hits(r"(reorder|rearrange|swap|move).{0,30}(on the fly|during|mid|skipped|to (the )?end|steps)|adjust order on the fly|change order", excl=S("1435295040"))
H["records"]=liked_hits(r"how long (\w+ ){0,3}(really|actually) take|how long (each|every|routines?|tasks?|things?|everything|the routine|task series|getting ready)\w* (\w+ )?(take|took|takes|lasted)|time (spent|taken)|real time tasks|actual(ly)? took|time report|recap of time|tracks how long|records time|times how long|where and how long|underestimates how long",
    exrx=r"^set |setting how long|choosing how long|can change how long|will take|will end|how long to spend")
H["overtime"]=liked_hits(r"overtime|go(es)? over|let it go over|over the (timer|estimated)|over time warning|over time or paused|when going over time|runs over its time|runs late", excl=S("cd65717b 53de7b42 9467460594 e161ee7e 1267027169 1332208712"))
H["visual_timer"]=liked_hits(r"visual (timer|countdown)|time timer|look of the timer|pomodoro-style ring|smooth animation")
H["auto_next"]=liked_hits(r"auto[- ]?(advance|next|complete|matically moves|-start of next)|moves? (on )?to the next (task|step) automatically|automatically moves|netflix|moves straight to the next|tasks end by themselves|jump or go over", excl=S("1160296452 1440884775"))
H["manual_next_choice"]=liked_hits(r"option to not auto-advance|don't auto-complete unless|doesn't move to the next task by itself|fine settings for each routine, like auto-next|per-step customization such as auto-next")
H["time_up_cue"]=liked_hits(r"(alert|chime|alarm|sound|cue)s? (when|on|between|for) (time|the next|moving|morning tasks|a task|activities|the study)|timed alerts|chime on the next|quiet visual cue|alarm when time is up|tells them when to move|when to switch|when to move on|gentle reminder pushes", excl=S("da4a465f 1190820623"))
H["white_noise"]=liked_hits(r"white noise|background (sounds|noise)|ambient sounds")
H["kind_tone"]=liked_hits(r"no (penalty|punish|scolding)|without (feeling like failing|guilt|pressure|stress)|kind overtime|overtime notification says|no need to rush|not judgy|gentle transitions|streaks don.t break when tasks are skipped|doesn't penalize|no pressure|still marks it completed", exrx=r"self-care|enjoyable things")
H["hands_free"]=liked_hits(r"without (looking|touching|holding)|no need to (look|touch|hold)")
H["end_praise"]=liked_hits(r"well done|praise on finishing|'well done'|congratulates after|recap of time|per-habit time report|comment space after finishing|feels very organized after completing")
H["lock_island"]=liked_hits(r"dynamic island|live activit|lock ?screen|status bar")


# ---- watch: patterns over `problems` (28 Nov 2026), read in samples
WATCH=re.compile(r"(apple ?watch|galaxy ?watch|smart ?watch|wear ?os|watch ?app|watchos|\bthe watch\b|\bmy watch\b|watch (face|complication|version)|워치|ウォッチ)",re.I)
RUNNING=re.compile(r"timer|countdown|sync|freez|stuck|stops?|pause|step|task|screen (turns|goes|off)|wrist|start|progress|next|out of sync|time",re.I)
WISH=re.compile(r"no |missing|wish|want|support|app for",re.I)
watch_run,watch_wish=set(),set()
for rid,l in L.items():
    for e in l.get("problems") or []:
        t=e.get("problem","")+" "+(e.get("quote") or "")
        if not WATCH.search(t): continue
        if e.get("kind")=="missing" and WISH.search(e.get("problem","")): watch_wish.add(rid)
        elif RUNNING.search(e.get("problem","")): watch_run.add(rid)
watch_wish-=watch_run

def resolve(prefixes):
    out=set()
    for p in prefixes:
        m=[k for k in L if k.startswith(p)]
        if len(m)!=1: raise SystemExit(f"prefix {p} matches {len(m)}")
        out.add(m[0])
    return out
PR={k:resolve(v) for k,v in P.items()}
PR["watch_running"]=watch_run; PR["watch_wanted"]=watch_wish
def stats(ids):
    rs=[L[i]["rating"] for i in ids]; st=collections.Counter(L[i]["store"] for i in ids)
    return dict(n=len(ids), mean=round(statistics.mean(rs),2) if rs else None, low=sum(1 for x in rs if x<=2), app=st["appstore"], play=st["play"])
out={"problems":{k:stats(v) for k,v in PR.items()},"helps":{k:stats(v) for k,v in H.items()}}
json.dump({"P":{k:sorted(v) for k,v in PR.items()},"H":{k:sorted(v) for k,v in H.items()}},open(os.path.join(HERE,"player_themes.json"),"w"),indent=1)
if sys.argv[1:]==["appendix"]:
    print("| Side | Theme | Reviews | Review IDs (first 8 characters) |\n|---|---|---|---|")
    for side,d in (("Dislike",PR),("Helps",H)):
        for k,v in sorted(d.items()):
            print(f"| {side} | `{k}` | {len(v)} | "+" ".join(sorted(i[:8] if '-' in i else i for i in v))+" |")
    raise SystemExit
for side in out:
    print("==",side)
    for k,v in sorted(out[side].items(),key=lambda x:-x[1]["n"]): print(f"  {k:22} {v}")
allh=set().union(*H.values())
phone=set().union(*(v for k,v in PR.items() if not k.startswith("watch_")))
print("any phone-player problem:",stats(phone))
print("plus watch running problems:",stats(phone|PR["watch_running"])); print("any player help:",stats(allh)); print("total reviews",len(L))
