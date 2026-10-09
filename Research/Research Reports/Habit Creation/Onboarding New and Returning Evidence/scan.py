"""Onboarding for new and returning people (Current Work 73 + 3, 9 Oct 2026). Every review in the three corpora;
writes candidates.jsonl with the patterns each review matched."""
import json, re, glob, os, collections
ROOT = "../.."
P = {
 # someone with an account or history, made to go through the first-run again, or unable to find how to sign in
 'RETURN_ONBOARD': r"(already ha(ve|d)|existing|old|previous|my) (an? )?account.{0,120}(onboard\w*|set ?up|quiz|questions?|survey|tutorial|intro\w*|walkthrough|welcome|sign ?up|log ?in|sign ?in|start(ed)? over)"
                   r"|(onboard\w*|set ?up|quiz|questionnaire|survey|tutorial|intro\w*|walkthrough|welcome screens?).{0,80}(again|every time|each time|all over|again and again)"
                   r"|(no|couldn'?t find|can'?t find|cannot find|could not find|where is|where'?s|no way to|no option to|not able to find|hard to find|impossible to find|hidden) (the |a |any )?(log ?in|sign ?in|login|signin)( button| option| link| page)?"
                   r"|(only|just) (a |the )?(sign ?up|create (an )?account|register)( button| option)?.{0,40}(no|not|without|instead).{0,20}(log ?in|sign ?in)"
                   r"|(made|created|opened|started|signed up for|ended up with|got) (me )?(a |an )?(new|second|another|different|duplicate|fresh|empty|blank) (empty |blank )?account"
                   r"|(i'?m|i am|as) an? (existing|returning|old|previous|long.?time) (user|customer|member|subscriber)",
 # reinstall / new phone, and what signing in or restoring did
 'REINSTALL_SIGNIN': r"(reinstall\w*|re-install\w*|redownload\w*|re-download\w*|deleted (and|then) (re)?(install|download)\w*|uninstall\w*|new (phone|iphone|ipad|device|handy|telefono|teléfono|téléphone|celular)|switch\w* (to a new )?(phones?|iphones?|devices?)|upgrad\w* (my |to a new )?(phone|iphone)|got a new (phone|iphone)|changed (my )?(phone|iphone)|factory reset|reset (my )?(phone|iphone))"
                     r".{0,160}(log\w* (back )?in|sign\w* (back )?in|account|restor\w*|backup|back up|icloud|came back|all there|still there|synced|sync\w* back|recover\w*|transfer\w*)"
                     r"|(log\w* (back )?in|sign\w* (back )?in|restor\w*).{0,100}(reinstall\w*|re-install\w*|new (phone|iphone|device)|switch\w* phones?|uninstall\w*)",
 # the app asked (or didn't) whether to restore; found the backup by itself
 'RESTORE_PROMPT': r"(ask(ed|s)?|prompt(ed|s)?|offer(ed|s)?|popup|pop-up|pop up) (me )?(if|whether|to) (i )?(want(ed)? to )?restore"
                   r"|restore (prompt|popup|pop-up|button|option)"
                   r"|(found|detected|recogni[sz]ed|remembered) (my )?(backup|account|data|habits|old data|previous data)"
                   r"|(automatically|auto|just|instantly|immediately|seamless\w*) (restor\w*|came back|synced|transferred|recovered|pulled)"
                   r"|(everything|all (my|of my|the) (data|habits|history|streaks|progress)) (was|is|came|were) (back|there|restored|still there|right there)"
                   r"|picked up (right )?where i left off",
 # signing in with the "wrong" provider or sign-up vs log-in confusion
 'WRONG_DOOR': r"(different|wrong|another|other) (email|apple id|google account|sign.?in method|login method|provider)"
               r".{0,120}(account|data|habits|empty|nothing|lost|gone|new)"
               r"|(hide my email|private relay|privaterelay).{0,120}(account|login|log in|sign in|lost|new)"
               r"|(sign\w* ?up|register\w*) (instead of|rather than) (log\w* ?in|sign\w* ?in)"
               r"|(log\w* ?in|sign\w* ?in) (instead of|rather than) (sign\w* ?up|register\w*)",
 # where the account lives; can't find sign-out / account settings
 'ACCOUNT_FIND': r"(can'?t|cannot|couldn'?t|could not|unable to|no way to|how (do|can) (i|you)|where (do|can) i|impossible to|hard to) (find |see |locate )?(how to |where to )?(log ?out|sign ?out|log ?off|sign ?off|my account|the account|account settings|account page|account info\w*|profile settings)"
                 r"|(which|what) account (am i|i'?m|was i|did i|is (it|this))"
                 r"|(no|not any|without) (log ?out|sign ?out|logout|signout) (button|option)"
                 r"|(logged|signed) in (as|with) (who|what|which)"
                 r"|(account|log ?in|sign ?in|log ?out|sign ?out) (is |was )?(hidden|buried|tucked away)",
}
RX = {k: re.compile(v, re.I) for k, v in P.items()}
out = open("candidates.jsonl", "w"); counts = collections.Counter(); total = 0; apps = collections.defaultdict(set)
for store, base in (("A", "App Store Reviews"), ("P", "Play Store Reviews"), ("N", "Native Store Reviews")):
    for f in sorted(glob.glob(f"{ROOT}/{base}/*/reviews.jsonl")):
        app = os.path.basename(os.path.dirname(f))
        for i, line in enumerate(open(f)):
            r = json.loads(line); total += 1
            text = ((r.get("title") or "") + " — " + (r.get("body") or r.get("text") or "")).strip(" —")
            hits = [k for k, rx in RX.items() if rx.search(text)]
            if not hits: continue
            for h in hits: counts[h] += 1; apps[h].add(app)
            out.write(json.dumps({"key": f"{store}{app.split('.')[0]}#{i}", "store": store, "app": app, "review_id": r["review_id"],
                                  "rating": r.get("rating"), "date": (r.get("date") or "")[:10],
                                  "loc": r.get("country") or r.get("language"), "hits": hits, "text": text}, ensure_ascii=False) + "\n")
print("reviews scanned", total)
for k in P: print(k, counts[k], "apps", len(apps[k]))
