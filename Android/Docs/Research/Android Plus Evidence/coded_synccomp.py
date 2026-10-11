"""Hand coding of read/synccomp-<cat>.txt (sync complaints, both stores, seeded random 40 per category).

DUP_ENTRY      logs/entries recorded twice after sync (incl. Health double counts)
DUP_HABIT      whole habits duplicated across devices
DUP_PERSON     the person logs/does it twice because sync was late or missing
STALE_OVERWRITE an older device's copy replaced newer work (or deleted items came back)
LOST           data lost (reinstall, new phone, sync/backup failure)
MISSING_OTHER  a change made on one device not showing on the other
SLOW           sync delayed by minutes/hours
WATCH          watch and phone out of step
WIDGET_STALE   widget not updated after data synced / widget logs not syncing
CANT_TELL      can't tell whether / where it synced, or it says synced when it isn't
WANT_SYNCNOW   asks for a Sync Now / force-sync button
SYNCNOW_HELPED force sync fixed it
MANUAL_ONLY    has to press sync by hand every time
FORCE_FAILS    pressed sync, nothing happened
WANT_SYNC      sync between devices wanted (feature missing)
DELETE_SPREAD  surprised that a delete on one device removed it on the other
NOISE          not a sync complaint (calendar/Health sync, ads, prices, other meanings)
Note: A23#4576 and A23#4193 are the same text posted twice (one reviewer): count once.
"""

SYNCCOMP = {
    "duplicate": {
        "A2#486": "NOISE", "A53#1502": "NOISE", "A13#5792": "NOISE", "A31#375": "DUP_ENTRY",
        "A23#5370": "NOISE", "A24#16662": "NOISE", "A76#2365": "WANT_SYNC DUP_PERSON", "A76#5679": "NOISE",
        "A23#3297": "DUP_ENTRY STALE_OVERWRITE", "P24#3742": "LOST", "A1#353": "NOISE", "A76#7198": "WANT_SYNC",
        "A1#45633": "NOISE", "A13#13893": "DUP_HABIT", "A28#321": "NOISE", "A24#20278": "NOISE",
        "P122#13005": "NOISE", "A55#1596": "NOISE", "P84#13776": "DUP_PERSON SLOW", "A13#1393": "DUP_HABIT",
        "P126#36266": "FORCE_FAILS", "A24#5461": "NOISE", "P126#26798": "NOISE", "A53#1105": "DUP_ENTRY WATCH",
        "A10#32292": "NOISE", "P24#6759": "NOISE", "A46#2101": "STALE_OVERWRITE", "A48#4040": "DUP_HABIT",
        "A31#3651": "NOISE", "P122#11928": "NOISE", "A33#3780": "NOISE", "P98#692": "NOISE",
        "A23#506": "DUP_ENTRY STALE_OVERWRITE", "A1#52538": "NOISE", "P24#7244": "FORCE_FAILS", "P126#64449": "DUP_ENTRY",
        "P8#10155": "NOISE", "P49#3104": "NOISE", "A53#640": "WATCH", "P12#17466": "NOISE",
    },
    "status": {
        "A55#1575": "CANT_TELL", "P84#14698": "WANT_SYNCNOW", "A55#1596": "FORCE_FAILS", "P98#271": "WANT_SYNCNOW",
        "P97#2829": "CANT_TELL", "P24#11808": "MANUAL_ONLY", "A65#385": "WANT_SYNC", "P111#8250": "FORCE_FAILS",
        "P111#12238": "FORCE_FAILS", "P24#24034": "MANUAL_ONLY", "P24#9239": "LOST", "A5#452": "WANT_SYNCNOW WATCH",
        "A13#15861": "WANT_SYNCNOW", "A13#13120": "WATCH", "A55#1793": "WANT_SYNCNOW", "A1#51261": "WANT_SYNCNOW",
        "P111#10315": "SYNCNOW_HELPED", "P84#22712": "WANT_SYNC WANT_SYNCNOW", "P111#8340": "FORCE_FAILS", "A13#13187": "CANT_TELL WANT_SYNCNOW",
        "A23#4460": "STALE_OVERWRITE", "A23#2061": "SLOW WANT_SYNCNOW", "P111#8230": "MANUAL_ONLY", "A10#11550": "NOISE",
        "A1#54782": "WIDGET_STALE", "P24#15629": "MANUAL_ONLY", "A1#55593": "NOISE", "A31#4772": "MANUAL_ONLY",
        "P84#30060": "WANT_SYNC", "A1#46092": "NOISE", "P122#3194": "NOISE", "P122#7640": "NOISE",
        "P111#10691": "FORCE_FAILS", "P24#4158": "STALE_OVERWRITE", "P24#2069": "MANUAL_ONLY", "A33#3307": "NOISE",
        "P105#1103": "CANT_TELL", "A5#1828": "WATCH MISSING_OTHER", "P111#10565": "FORCE_FAILS", "A1#55434": "WANT_SYNCNOW",
    },
    "missing": {
        "P84#41087": "NOISE", "P2#1396": "NOISE", "P122#1334": "NOISE", "A23#3203": "WIDGET_STALE",
        "P1#111": "WANT_SYNC", "A13#2803": "WANT_SYNC", "P9#403": "WANT_SYNC MANUAL_ONLY", "A86#1496": "NOISE",
        "P49#3888": "WANT_SYNC", "A23#435": "NOISE", "P126#74961": "LOST", "A23#4814": "STALE_OVERWRITE",
        "P8#8426": "SLOW", "P2#9823": "NOISE", "P2#4799": "WANT_SYNC", "P84#17452": "NOISE",
        "P84#12886": "MISSING_OTHER", "P19#667": "WANT_SYNC", "A1#46113": "NOISE", "A33#3626": "NOISE",
        "P2#4635": "WANT_SYNC", "A1#52536": "LOST MISSING_OTHER", "A43#193": "NOISE", "A31#2324": "WATCH MISSING_OTHER",
        "A24#30485": "NOISE", "A33#3319": "NOISE", "A41#441": "NOISE", "P111#10631": "NOISE",
        "P126#75373": "WANT_SYNC", "A36#479": "NOISE", "P126#45498": "WANT_SYNC", "A7#447": "WANT_SYNC",
        "A20#3607": "WANT_SYNC", "P5#336": "NOISE", "P3#5260": "WANT_SYNC", "A31#386": "WATCH",
        "P120#8": "NOISE", "P3#7246": "WANT_SYNC", "A13#12669": "MISSING_OTHER", "A33#1359": "DELETE_SPREAD",
    },
    "slow": {
        "A33#898": "WATCH SLOW", "P10#6931": "NOISE", "A86#52": "NOISE", "A13#11615": "WANT_SYNC",
        "P84#16838": "SLOW", "A23#2061": "SLOW", "A46#1764": "SLOW WATCH", "P8#9886": "SLOW",
        "A46#1477": "NOISE", "P111#11591": "SLOW", "A23#5237": "SLOW", "A1#55502": "SLOW",
        "P111#8385": "NOISE", "A2#60": "SLOW", "P120#9": "NOISE", "P12#63040": "NOISE",
        "A85#3162": "NOISE", "A23#651": "WATCH CANT_TELL", "A13#7031": "NOISE", "P12#18417": "MANUAL_ONLY SLOW",
        "A13#6421": "SLOW MISSING_OTHER", "P126#59616": "NOISE", "P122#17230": "NOISE", "A1#56020": "SLOW",
        "P8#6108": "NOISE", "A86#1313": "WATCH", "A1#50885": "NOISE", "A23#2751": "WIDGET_STALE",
        "A31#1788": "NOISE", "A33#797": "SLOW", "A13#11941": "SLOW", "P5#198": "NOISE",
        "A23#3951": "NOISE", "P122#9409": "NOISE", "P12#64856": "NOISE", "A86#1238": "WATCH SLOW MISSING_OTHER",
        "A23#1426": "WATCH", "A13#15338": "SLOW", "A23#4812": "WIDGET_STALE", "P12#31144": "NOISE",
    },
    "overwrite": {
        "A31#4887": "LOST", "A55#1250": "LOST", "A13#15625": "NOISE", "A13#413": "LOST",
        "A86#23": "LOST", "P3#6704": "WANT_SYNC", "A2#192": "STALE_OVERWRITE WATCH", "A10#28056": "LOST",
        "P8#7318": "STALE_OVERWRITE", "P3#17766": "LOST", "A1#43608": "LOST", "A43#282": "LOST",
        "P111#9684": "LOST", "P24#3938": "LOST", "A1#55219": "LOST", "A13#17113": "LOST",
        "A23#4576": "STALE_OVERWRITE", "P3#9724": "LOST WANT_SYNC", "P3#1529": "LOST", "P111#16206": "LOST",
        "A3#8262": "NOISE", "A10#11565": "LOST", "A48#3016": "STALE_OVERWRITE", "A10#12241": "LOST",
        "A23#4193": "STALE_OVERWRITE", "A20#1256": "LOST", "P24#2374": "LOST", "A5#1889": "WATCH LOST",
        "A23#4633": "STALE_OVERWRITE", "A20#3400": "LOST", "A76#5695": "LOST", "A31#3701": "LOST",
        "P84#17063": "LOST", "P15#595": "NOISE", "P126#46321": "LOST", "A1#45751": "LOST",
        "A10#27156": "LOST", "A23#2046": "STALE_OVERWRITE", "P3#6031": "LOST", "A20#156": "LOST",
    },
}
