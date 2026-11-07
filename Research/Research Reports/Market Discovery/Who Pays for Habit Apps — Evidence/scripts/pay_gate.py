import re
EN=r"""\b(i|we|i've|ive|i'd|id)\s+(have\s+|had\s+|just\s+|already\s+|actually\s+|finally\s+|even\s+|also\s+|recently\s+|gladly\s+|happily\s+|willingly\s+|originally\s+|initially\s+|did\s+|once\s+|literally\s+|really\s+)*(paid|pay|purchased|bought|buy|subscribed|subscribe|upgraded|renewed|invested|spent|signed up for|got the|got premium|got pro|got plus|have premium|have the premium|have pro|have the pro|have plus|tried the premium|use the premium|use the paid|use premium|use the pro)\b
|\bpaid\s+(for|version|user|member|subscri|customer|plan|app|premium|the|it|\$|£|€)|\bpaying\s+(for|customer|user|member|subscri|the|\$|£|€|premium|a\s)|\b(am|been|was|as a|i'm|im)\s+(a\s+)?(paying|paid|premium|pro|plus|lifetime|subscribed|subscriber|longtime subscriber|long-time subscriber)\b
|\bpurchas(ed|e|ing)\b|\bbought\b|\bsubscri(ption|ber|bed)\b|\bmy (membership|plan|premium|plus|renewal)\b|\blifetime\b|\bworth\s+(every|each|the|it|paying|a|my|its)\s*(penny|cent|dollar|money|price|cost|subscription|fee|premium|pro|upgrade|investment|paying)?\b|\bworth\s+paying\b
|\bupgrad(e|ed|ing)\b|\bpremium\b|\bpro version\b|\bfull version\b|\bpaid version\b|\bpaywall\b|\bcharged\b|\brefund|\brenew|\bannual\b|\byearly\b|\bone[- ]time\b|\bmoney well spent\b|\bbest\s+\$|\$\s?\d|£\s?\d|€\s?\d|\bdollars?\b|\bbucks\b|\bmoney\b"""
OTHER=r"""pagu[eé]|pagado|pago|pagar|compr[eéoó]|comprado|comprei|suscri|suscripci|assin(ei|atura|ar|ante)|premium|mensalidade|vital[ií]ci|de por vida|anual|reembols|cobr(ar|aram|aron|o)|
gekauft|bezahlt|zahle|abo\b|abonnement|lebenslang|jahresabo|kostenpflichtig|vollversion|geld\s+wert|
pay[ée]|achet[ée]|abonn[ée]|à vie|rembours|
pagato|acquistat|comprato|abbonament|a vita|
kupi[łl]|zap[łl]aci|subskrypcj|abonament|premium|
betaald|gekocht|abonnement|
satın al|ödedim|ödeme|abonelik|premium|
beli|langganan|bayar|berlangganan|
mua\b|trả phí|đăng ký|
купил|купила|покупк|оплатил|оплат|подписк|премиум|платн|заплат|пожизнен|
买了|购买|付费|订阅|会员|永久|终身|续费|充值|花钱|退款|買了|購買|付費|訂閱|會員|買斷|
課金|購入|買い切り|サブスク|有料|プレミアム|買った|
결제|구매|구독|유료|프리미엄|평생|환불|샀|
اشتراك|دفعت|اشتريت|مدفوع|بريميوم|شراء|
خریدم|اشتراک|پرداخت|پولی|
ซื้อ|จ่าย|พรีเมียม|สมัครสมาชิก|
खरीद|सब्सक्रिप्शन|पेड"""
en=re.compile(EN.replace('\n',''),re.I); ot=re.compile(OTHER.replace('\n',''),re.I)
def gate(t): return bool(en.search(t) or ot.search(t))
