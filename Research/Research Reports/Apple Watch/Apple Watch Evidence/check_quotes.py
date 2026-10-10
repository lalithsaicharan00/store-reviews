"""Checks every English quote in the report is in the review with that ID (translated quotes are checked by ID only)."""
import json, sys, html
d = {r['id']: r for r in json.load(open(sys.argv[1]))}
Q = [("11458708619","Sometimes I keep my phone out of reach to avoid distractions"),
("6733678418","it just says ”internet is required on your iphone” and does nothing"),
("12520956951","Please add a habit in iPhone app first."),
("10461378148","You have to close the app on the apple watch and open again"),
("6224557402","Complications constantly show “All completed” even when nothing is."),
("1506836526","That first glance reminder throughout the day is really helpful!!"),
("11069921765","a constant reminder – every time I look at my watch"),
("7067662905","you tap in watchOs and longhold in iOS to complete the circle"),
("9318566072","Too easy to accidentally completing on Apple Watch."),
("4717399926","very painful to add a count by typing the number in the tiny number pad"),
("10096953628","a tiny button while the big green check button is for completing all cups"),
("7641900979","my activity said an hour of exercise done"),
("8156774812","the habits there still reset at 12 am"),
("13660577110","also because it offers integration with Apple Watch"),
("12014746702","I bought a Apple Watch for this app."),
("12134334067","in order to access it on my apple watch I’d have to pay"),
("6213582796","It's not until I open the app on my iphone that the watch resets."),
("10832845541","including habits that aren’t scheduled for tod"),
("12717025537","the Apple Watch app doesn’t work without the phone around"),
("11368755180",None),("14269287686",None),("8509098000",None),("1480955144",None),("9886812490",None),("8343208608",None)]
bad = 0
for i, q in Q:
    t = html.unescape(d[i]['text'])
    if q and q not in t: print("MISSING", i, q); bad += 1
print("checked", len(Q), "bad", bad)
