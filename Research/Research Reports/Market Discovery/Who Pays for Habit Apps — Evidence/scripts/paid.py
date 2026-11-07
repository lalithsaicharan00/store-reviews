# Decides, from one review's words, whether its writer says they paid. Machine first pass; precision is measured by hand.
import re
HYP=re.compile(r"\b(would|wouldn'?t|will|won'?t|i'?ll|i'?d|if|unless|might|may|could|couldn'?t|can'?t|cannot|should|shouldn'?t|not|never|no|don'?t|didn'?t|doesn'?t|isn'?t|wasn'?t|without|before|until|want(ed)? to|going to|gonna|have to|had to|need to|needs? to|must|forced|force|asked|asks|asking|make(s)? you|you have|you need|you must|you can|you'd|nobody|no one|refuse|unwilling|willing to|happy to|gladly pay|tempted|thinking|considering|plan to|hope|wish|try to|ready to|love to|like to|able to|option to|just to|only to|chance to|in order to|but to)\b",re.I)
# first-person, past or ongoing payment
ACT=re.compile(r"\b(i|we|i've|ive|we've|i\s+have|i\s+had)\s+(?:\w+\s+){0,3}?(paid|purchased|bought|subscribed|renewed|upgraded|invested|spent)\b(?!\s+(?:a lot of|so much|hours|time|years? (?:using|on))\b)|\b(i|we)\s+(?:\w+\s+){0,1}?pay\s+(?:for|the|\$|£|€|a|an|\d|yearly|monthly|annually|every|each|premium)|\bi'?m\s+paying\b|\bi\s+am\s+paying\b|\bi\s+was\s+paying\b|\bi'?ve been paying\b|\bbeen paying\b",re.I)
STATUS=re.compile(r"\b(paying|paid|premium|lifetime|pro|plus|annual|yearly)\s+(member|customer|user|subscriber|account holder|supporter)\b|\bmy\s+(subscription|membership|premium|plus subscription|annual|yearly|renewal|lifetime|purchase|paid)\b|\b(have|got|using|use|bought|on)\s+(the\s+)?(lifetime|premium|paid|pro|plus)\s*(version|plan|subscription|membership|account|tier|license|licence|purchase|access|upgrade)?\b|\bsubscriber\b|\bas a (premium|paid|paying|pro|lifetime|plus)\b|\bbeen\s+(subscribed|a subscriber|a member)\b|\bam\s+subscribed\b|\bi'?m\s+subscribed\b",re.I)
VALUE=re.compile(r"\bworth\s+(every|each)\s+(single\s+)?(penny|cent|dollar|rupee|pound)|\bworth\s+the\s+(money|price|cost|subscription|fee|investment|upgrade|premium|purchase|\$)|\bworth\s+(paying|buying|purchasing|subscribing|upgrading)\b|\bmoney well spent\b|\bbest\s+(purchase|money|\$|investment|few dollars)\b|\bworth\s+my\s+money\b",re.I)
FUT_VALUE=re.compile(r"\b(not|isn'?t|wasn'?t|hardly|never|n'?t)\b.{0,25}\bworth\b",re.I)
TRAP=re.compile(r"\b(charged|billed|took my money|stole|scam|without (my )?(consent|permission|asking|knowing)|auto[- ]?renew|automatically (charged|renewed|billed)|refund|trial)\b",re.I)
O=[
 r"\b(pagu[eé]|he pagado|compr[eé]|he comprado|me suscrib[ií]|estoy suscrit|soy premium|mi suscripci[oó]n|vale la pena pagar|vale cada (centavo|euro|peso)|paguei|comprei|assinei|sou assinante|minha assinatura|vale cada centavo|vale a pena pagar)\b",
 r"\b(gekauft|gezahlt|ich zahle|bezahlt|mein abo|abonniert|jeden cent wert|sein geld wert|j'ai pay[eé]|j'ai achet[eé]|je paye|je paie|mon abonnement|je suis abonn|abonn[eé]e?\b|ho pagato|ho acquistato|ho comprato|il mio abbonamento|kupi[łl](em|am)|zap[łl]aci[łl](em|am)|ik heb betaald|gekocht|heb gekocht|satın aldım|ödedim|saya beli|sudah beli|sudah bayar|saya bayar|tôi đã mua|đã mua)\b",
 r"(купил|купила|оплатил|оплатила|заплатил|заплатила|приобрел|приобрёл|приобрела|оформил[а]? подписку|моя подписка|я плачу|пользуюсь (платной|премиум))",
 r"(我买了|买了会员|买了永久|买了终身|我购买|已购买|购买了|我付费|付费了|已付费|开了会员|我订阅|订阅了|花钱买|充了|买断了|永久会员|终身会员|我買了|已購買|購買了|買斷了|付費了|訂閱了|課金した|課金しました|課金して|購入した|購入しました|買い切り(を|で)購入|買いました|買った|サブスクに入|결제했|결제 했|결제함|구매했|구매 했|구매함|구독했|구독 중|구독중|샀어요|샀는데|샀습니다|유료 결제|유료결제|دفعت|اشتريت|اشتركت|قمت بالشراء|خریدم|ซื้อแล้ว|จ่ายแล้ว)",
]
OTH=[re.compile(p,re.I) for p in O]
NEG_O=re.compile(r"\b(no|nunca|nie|nicht|ne\s|non\s|não|nao|не\s|никогда)\b",re.I)
def sentences(t): return re.split(r"(?<=[.!?\n;])\s+|\s+but\s+|\s+however\s+",t)
NOTAPP=re.compile(r"^\W*(?:a |an |the |my |some |this |these |those |new |another |all |more )*(?:new |used |second |pixel|iphone|ipad|samsung|galaxy|phone|tablet|watch|apple watch|house|car|clothes|clothing|outfits?|hats?|shirts?|furniture|gems|coins|rainbow stones|stones|tickets|gift|item|items|a book|book|books|paper|journal|notebook|planner|time|hours|days|weeks|months|years|so much time|lot of time)",re.I)
FEATMENTION=re.compile(r"^\s*(?:version )?(?:features?|content|options?|functions?|stuff|items?|tiers?|plans? (?:is|are|cost)|version (?:is|has|costs?|would))\b",re.I)
def classify(t):
    """returns (tier, hit). tier: act | status | value | other | '' """
    t=t.replace('\u2019',"'").replace('&#39;',"'").replace('\u2018',"'")
    for s in sentences(t):
        m=ACT.search(s)
        if m:
            pre=s[max(0,m.start()-45):m.start()]
            if not HYP.search(pre+' '+m.group(0)) and not NOTAPP.search(s[m.end():m.end()+30]):
                return 'act',m.group(0)
        m=STATUS.search(s)
        if m:
            pre=s[max(0,m.start()-30):m.start()]
            if not HYP.search(pre) and not FEATMENTION.search(s[m.end():m.end()+24]) and not re.search(r"\b(on|have|got|has)\s+premium\s*$",m.group(0),re.I): return 'status',m.group(0)
        m=VALUE.search(s)
        if m and not FUT_VALUE.search(s[:m.end()]) and not re.search(r"\b(would|if|might|may|could|will|not|isn'?t)\b",s[max(0,m.start()-30):m.start()],re.I):
            return 'value',m.group(0)
    for p in OTH:
        m=p.search(t)
        if m:
            pre=t[max(0,m.start()-14):m.start()]
            post=t[m.end():m.end()+6]
            if not NEG_O.search(pre) and not re.match(r"\s*(бы|할텐데|したい)",post): return 'other',m.group(0)
    return '',''
