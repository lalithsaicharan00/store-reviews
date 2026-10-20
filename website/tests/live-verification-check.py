"""Read-only checks of the deployed verification site; no accounts or writes."""
import json, sys
from urllib.request import urlopen, Request
from urllib.error import HTTPError
from concurrent.futures import ThreadPoolExecutor
base=sys.argv[1].rstrip('/') if len(sys.argv)>1 else 'https://oftenenough.com'
routes=['/','/download','/plus','/privacy','/help','/terms','/delete-account','/favicon.svg','/style.css','/support','/privacy-policy','/terms-and-conditions','/not-a-real-page-verification-check']
def check(route):
    expected=404 if route.startswith('/not-a-real') else 200
    try:
        response=urlopen(Request(base+route,headers={'User-Agent':'OftenEnough-Verification/1.0'}),timeout=25)
    except HTTPError as e:
        response=e
    with response:
        data=response.read(); status=response.status; url=response.url
        content=data.decode('utf-8',errors='replace')
        assert status==expected,(route,status)
        assert "script-src 'none'" in response.headers.get('Content-Security-Policy',''),route
        if route in routes[:7]:
            assert 'Work in progress' in content and 'under development' in content.lower(),route
            assert '<script' not in content.lower(),route
        return {'route':route,'status':status,'bytes':len(data),'url':url}
with ThreadPoolExecutor(max_workers=5) as pool:
    results=list(pool.map(check,routes))
print(json.dumps({'base':base,'checks':results,'success':True},indent=2))
