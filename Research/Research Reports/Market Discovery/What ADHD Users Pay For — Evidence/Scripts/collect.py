import json,subprocess,sys,time,os
store=sys.argv[1]
base="/Users/lalith/Desktop/store reviews/Research/ADHD App Reviews"
A=json.load(open('apps.json'))
os.chdir("/Users/lalith/Desktop/store reviews/Research/Tools")
M="us,gb,ca,au,nz,ie,in,za,sg,ph,de,at,ch,nl,se,no,dk,fi,fr,be,es,it,br,mx,pt"
for i,a in enumerate(A[store],1):
    if store=='ios':
        cmd=["python3","extract_reviews.py",str(a),"--markets",M,"--no-probe","--workers","4","--number",str(i),"--out",base+"/App Store"]
    else:
        pages="2500" if a=="droom.sleepIfUCan" else "1000"
        cmd=["python3","play_extract.py",a,"--languages","en,de,es,fr,pt,nl","--number",str(i),"--out",base+"/Play Store","--max-pages",pages]
    t=time.time();print(f"=== [{i}/{len(A[store])}] {a}",flush=True)
    try:
        p=subprocess.run(cmd,timeout=3600,stdout=subprocess.DEVNULL,stderr=subprocess.PIPE,text=True)
        print(p.returncode,round(time.time()-t),(p.stderr or '')[-160:].replace('\n',' '),flush=True)
    except subprocess.TimeoutExpired: print('TIMEOUT',a,flush=True)
print('ALL DONE',flush=True)
