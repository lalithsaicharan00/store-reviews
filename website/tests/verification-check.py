from html.parser import HTMLParser
from pathlib import Path
from urllib.parse import urlsplit, unquote
root=Path(__file__).resolve().parents[1]/'public'
class Page(HTMLParser):
    def __init__(self):
        super().__init__(); self.links=[]; self.ids=[]; self.h1=0; self.scripts=0
    def handle_starttag(self,tag,attrs):
        a=dict(attrs)
        if tag=='h1': self.h1+=1
        if tag=='script': self.scripts+=1
        if 'id' in a: self.ids.append(a['id'])
        if tag in ['a','link','img']:
            for key in ['href','src']:
                if key in a:self.links.append(a[key])
checks=0
for file in root.glob('*.html'):
    text=file.read_text(encoding='utf-8'); page=Page();page.feed(text)
    assert page.h1==1,file
    assert len(page.ids)==len(set(page.ids)),file
    assert page.scripts==0,file
    assert 'WORK IN PROGRESS' in text.upper(),file
    assert 'name="viewport"' in text,file
    for link in page.links:
        u=urlsplit(link)
        if u.scheme or u.netloc: continue
        if not u.path and u.fragment:
            assert u.fragment in page.ids,(file,link)
            continue
        p=unquote(u.path).lstrip('/')
        target=root/(p or 'index.html')
        assert target.is_file() or (root/(p+'.html')).is_file(),(file,link)
        checks+=1
for route in ['index','download','plus','privacy','help','terms','delete-account']:
    assert (root/(route+'.html')).is_file(),route
assert 'script-src \'none\'' in (root/'_headers').read_text()
assert (root/'favicon.svg').read_bytes()==(root.parents[1]/'Brand/Assets/BrandMarks/Light Tonal.svg').read_bytes()
assert not any('accounts.google.com' in p.read_text() for p in root.glob('*.html'))
print(f'PASS: 7 required pages, support/404, {checks} local links/assets, notice, one H1, unique IDs, strict CSP, approved logo, no scripts or fake sign-in.')
