"""Upload public static assets with a short-lived Pages JWT supplied only on stdin."""
import sys, json, hashlib, base64, mimetypes, getpass
from pathlib import Path
from urllib.request import Request, urlopen
from urllib.error import HTTPError
root=Path(__file__).resolve().parent/'public'
print('Ready for short-lived Pages upload authorization on stdin.',flush=True)
if not sys.stdin.isatty():
    raise RuntimeError('An interactive terminal is required for hidden credential input')
auth=json.loads(getpass.getpass('Upload authorization (hidden): '))
def call(path,body):
    req=Request('https://api.cloudflare.com/client/v4'+path,data=json.dumps(body).encode(),headers={'Authorization':'Bearer '+auth['jwt'],'Content-Type':'application/json'},method='POST')
    try:
        with urlopen(req,timeout=60) as r: value=json.load(r)
    except HTTPError as e:
        # API errors only; never print headers, credentials or the request object.
        raise RuntimeError(f'Pages asset request failed: HTTP {e.code}') from None
    if not value.get('success'): raise RuntimeError('Pages asset upload returned an unsuccessful response')
    return value.get('result')
files=[]; manifest={}
for file in sorted(root.iterdir()):
    if not file.is_file() or file.name.startswith('_'): continue
    data=file.read_bytes(); digest=hashlib.md5(data).hexdigest()
    manifest['/'+file.name]=digest
    mime=mimetypes.guess_type(file.name)[0] or 'application/octet-stream'
    files.append({'key':digest,'value':base64.b64encode(data).decode(),'base64':True,'metadata':{'contentType':mime}})
missing=set(call('/pages/assets/check-missing',{'hashes':list(manifest.values())}))
pending=[file for file in files if file['key'] in missing]
if pending: call('/pages/assets/upload',pending)
call('/pages/assets/upsert-hashes',{'hashes':list(manifest.values())})
print(json.dumps({'uploaded':len(pending),'manifest':manifest,'headers':(root/'_headers').read_text(),'redirects':(root/'_redirects').read_text()}),flush=True)
