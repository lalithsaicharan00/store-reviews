"""Decision 4: what reminders, Siri and the Live Activity should show while the app is locked.
A: a notification/Siri/Live Activity/lock-screen word near a privacy word (people around, hide, private, embarrass).
B: the other side: a reminder that doesn't say what it's for (generic text)."""
import json, re, glob, os, html
N = re.compile(r"notification|notif|reminder|push|alert|banner|lock ?screen|siri|spotlight|live activit|dynamic island|apple watch|watch face|alarm|"
 r"通知|提醒|推送|锁屏|通知センター|ロック画面|알림|잠금화면|уведомлен|напоминан|notificaci|recordatorio|notifica|lembrete|rappel|benachrichtig|erinnerung|bildirim", re.I)
P = re.compile(r"privacy|private|privately|discreet|discrete|embarrass\w*|ashamed|shame|someone (could|can|might|will) see|others? (can|could|might) see|people (can|could|might|will) see|"
 r"anyone (can|could) see|over my shoulder|in front of|my (mom|mum|dad|parents?|wife|husband|partner|boyfriend|girlfriend|family|kids?|boss|coworkers?|friends?|roommate)|"
 r"sensitive|personal|secret|hide (the )?(name|title|text|content|habit)|hidden|without (showing|revealing|saying)|generic|vague|neutral|"
 r"隐私|私密|别人看到|被看到|プライバシー|他人に|見られ|사생활|프라이버시|남이 보|приватн|личн|чужи|privacidad|privado|privacidade|confidentialit|privé|privatsphäre|gizlilik", re.I)
G = re.compile(r"(just|only) says? (\"|“|')?(reminder|notification|time to|habit|it'?s time|don'?t forget)|doesn'?t (say|tell|show) (me )?(which|what)|no idea (which|what) (habit|reminder|task)|"
 r"(which|what) (habit|task|reminder) (it'?s|it is) for|generic (reminder|notification|message)|custom (reminder |notification )?(message|text)|"
 r"(write|set|change|customi[sz]e|edit) (my own |the )?(reminder|notification) (text|message|wording)", re.I)
seen = {json.loads(l)["review_id"] for l in open("../read.jsonl")}
out = open("notif_candidates.jsonl", "w"); na = nb = 0
for store, base in (("A", "App Store Reviews"), ("P", "Play Store Reviews"), ("N", "Native Store Reviews")):
    for f in sorted(glob.glob(f"../../../{base}/*/reviews.jsonl")):
        app = os.path.basename(os.path.dirname(f))
        for line in open(f):
            r = json.loads(line)
            t = html.unescape((r.get("title") or "") + " — " + (r.get("body") or r.get("text") or ""))
            a = any(P.search(t[max(0, m.start()-140): m.end()+140]) for m in N.finditer(t))
            b = bool(G.search(t))
            if not (a or b): continue
            na += a; nb += b
            out.write(json.dumps({"store": store, "app": app, "review_id": r["review_id"], "rating": r.get("rating"),
                "date": (r.get("date") or "")[:10], "seen": r["review_id"] in seen, "a": a, "b": b, "text": t}, ensure_ascii=False) + "\n")
print("privacy-near-notification", na, "| generic-reminder", nb)
