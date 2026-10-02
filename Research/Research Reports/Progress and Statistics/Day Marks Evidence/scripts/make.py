# Heat-map palette (2 Oct 2026): per habit colour, grey + 5 steps (⅓, ⅔, almost, goal met, more than the goal),
# light and dark mode, in OKLCH, checked by measurement: OKLab ΔE between neighbours (normal vision and the three
# colour-vision deficiencies), and the contrast of the day's number on each step.
import math, json
MARK = dict(red=0xFA352B, orange=0xC97505, yellow=0xAA8809, green=0x07A941, mint=0x09A19A, teal=0x079DB4,
            cyan=0x0698D0, blue=0x3289FF, indigo=0x7679FC, purple=0xB75AE7, pink=0xFB2852, brown=0xA48660, gray=0x8B8B90)
def s2l(c): return c/12.92 if c <= 0.04045 else ((c+0.055)/1.055)**2.4
def l2s(c): return 12.92*c if c <= 0.0031308 else 1.055*c**(1/2.4)-0.055
def lin_to_oklab(r,g,b):
    l=0.4122214708*r+0.5363325363*g+0.0514459929*b; m=0.2119034982*r+0.6806995451*g+0.1073969566*b; s=0.0883024619*r+0.2817188376*g+0.6299787005*b
    l,m,s=[math.copysign(abs(x)**(1/3),x) for x in (l,m,s)]
    return (0.2104542553*l+0.7936177850*m-0.0040720468*s, 1.9779984951*l-2.4285922050*m+0.4505937099*s, 0.0259040371*l+0.7827717662*m-0.8086757660*s)
def oklab_to_lin(L,a,b):
    l=L+0.3963377774*a+0.2158037573*b; m=L-0.1055613458*a-0.0638541728*b; s=L-0.0894841775*a-1.2914855480*b
    l,m,s=l**3,m**3,s**3
    return (4.0767416621*l-3.3077115913*m+0.2309699292*s, -1.2684380046*l+2.6097574011*m-0.3413193965*s, -0.0041960863*l-0.7034186147*m+1.7076147010*s)
def hex2lin(h): return tuple(s2l(int(h[i:i+2],16)/255) for i in (1,3,5))
def lin2hex(rgb): return '#'+''.join('%02X'%round(max(0,min(1,l2s(x)))*255) for x in rgb)
def lch(L,C,h):
    # largest chroma ≤ C that fits sRGB
    while True:
        rgb=oklab_to_lin(L,C*math.cos(h),C*math.sin(h))
        if all(-1e-5<=x<=1+1e-5 for x in rgb) or C<1e-4: return lin2hex(rgb)
        C*=0.985
def base_lch(v):
    L,a,b=lin_to_oklab(*[s2l((v>>s&255)/255) for s in (16,8,0)]); return L, math.hypot(a,b), math.atan2(b,a)
# Colour-vision deficiency (Machado 2009, severity 1.0), applied in linear RGB
CVD={'protan':((0.152286,1.052583,-0.204868),(0.114503,0.786281,0.099216),(-0.003882,-0.048116,1.051998)),
     'deutan':((0.367322,0.860646,-0.227968),(0.280085,0.672501,0.047413),(-0.011820,0.042940,0.968881)),
     'tritan':((1.255528,-0.076749,-0.178779),(-0.078411,0.930809,0.147602),(0.004733,0.691367,0.303900))}
def sim(rgb,m): return tuple(max(0,min(1,sum(m[i][j]*rgb[j] for j in range(3)))) for i in range(3))
def dE(h1,h2,m=None):
    a,b=hex2lin(h1),hex2lin(h2)
    if m: a,b=sim(a,m),sim(b,m)
    p,q=lin_to_oklab(*a),lin_to_oklab(*b); return math.dist(p,q)
def lum(h): r,g,b=hex2lin(h); return 0.2126*r+0.7152*g+0.0722*b
def contrast(h1,h2): a,b=sorted((lum(h1),lum(h2)),reverse=True); return (a+0.05)/(b+0.05)
# Lightness per step: evenly spaced, the goal-met step at the habit's own lightness (0.64), "more" one step beyond.
LIGHT=dict(grey='#EBEBF0', card='#FFFFFF', L=[0.855,0.78,0.71,0.64,0.52], C=[0.50,0.70,0.88,1.0,0.90])
DARK =dict(grey='#2C2C2E', card='#1C1C1E', L=[0.415,0.49,0.565,0.64,0.76], C=[0.55,0.72,0.88,1.0,0.85])
GRAY_HUE=(0.03,4.6)   # "gray" habits get a cool slate tint, so their steps never read as the not-done grey
out={}
for mode,P in (('light',LIGHT),('dark',DARK)):
    out[mode]={}
    for name,v in MARK.items():
        L0,C0,h=base_lch(v)
        if name=='gray': C0,h=GRAY_HUE
        C0=max(C0,0.05)
        steps=[lch(L,C0*c,h) for L,c in zip(P['L'],P['C'])]
        out[mode][name]=[P['grey']]+steps
json.dump(out,open('palette.json','w'),indent=1)
# ---- measurements ----
rep=[]
for mode,P in (('light',LIGHT),('dark',DARK)):
    worst={'normal':(9,''),'protan':(9,''),'deutan':(9,''),'tritan':(9,'')}; textmin=(99,'')
    for name,row in out[mode].items():
        for k in range(len(row)-1):
            for key,m in (('normal',None),('protan',CVD['protan']),('deutan',CVD['deutan']),('tritan',CVD['tritan'])):
                d=dE(row[k],row[k+1],m)
                if d<worst[key][0]: worst[key]=(d,f'{name} {k}->{k+1}')
        # number on the square: dark text on steps 1-3 (light) / white on 4-5; dark mode: white text on all
        for k,c in enumerate(row[1:],1):
            fg = max(('#1C1C1E','#FFFFFF'), key=lambda f: contrast(f,c))
            cr=contrast(fg,c)
            if cr<textmin[0]: textmin=(cr,f'{name} step{k} {fg}')
    rep.append((mode,worst,textmin))
print('grey vs card', {m: round(dE(P['grey'],P['card']),3) for m,P in (('light',LIGHT),('dark',DARK))})
for mode,worst,textmin in rep:
    print(mode, {k:(round(v[0],3),v[1]) for k,v in worst.items()}, 'min text contrast', round(textmin[0],2), textmin[1])
