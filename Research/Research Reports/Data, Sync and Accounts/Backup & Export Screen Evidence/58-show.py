import json, sys, re
c = json.load(open('/home/user/store-reviews/Research/Temp/58-candidates.json'))
mode = sys.argv[1]; extra = sys.argv[2] if len(sys.argv) > 2 else None; lim = int(sys.argv[3]) if len(sys.argv) > 3 else 400
rx = re.compile(extra, re.I) if extra else None
k = 0
for x in c:
    if mode in x['modes'] and (not rx or rx.search(x['text'])):
        k += 1
        print(f"{x['key']}|{x['review_id']}|{x['rating']}★|{x['app'][:28]}|{x['text'][:lim]}")
print('N=', k)
