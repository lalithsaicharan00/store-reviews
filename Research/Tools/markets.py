"""
App Store storefronts, grouped by why you'd care about them.

Tiers reflect iOS consumer spend and download volume, not population.
They are a starting shortlist -- for any specific app, use `--probe` to rank
storefronts by that app's actual review counts, which is what really matters.
"""

# Tier 1: highest iOS consumer spend / ARPU. Where subscription revenue comes from.
TIER1_REVENUE = [
    "us",  # ~40% of global iOS consumer spend on its own
    "jp",  # #2 for iOS spend; exceptional ARPU
    "cn",  # largest or 2nd largest by revenue; see notes in README
    "gb", "de", "fr", "ca", "au", "kr",
    "tw", "hk", "sg",              # small but very high ARPU in APAC
    "ch", "nl", "se", "no", "dk", "fi",  # highest per-capita spend in Europe
    "it", "es", "at", "be", "ie", "nz",
    "ae", "sa", "il",              # top ARPU in MENA
]

# Tier 2: high download volume, lower ARPU. Where your user base lives.
TIER2_VOLUME = [
    "in", "br", "mx", "id", "vn", "ph", "th", "tr",
    "ru",  # large, but App Store payments have been restricted since 2022
    "eg", "ng", "pk", "bd", "za",
    "ar", "co", "cl", "pe",
    "pl", "ua", "my", "ro", "cz", "pt", "gr", "hu",
]

# Everything else Apple operates.
TIER3_LONGTAIL = [
    "ag", "ai", "al", "am", "ao", "az", "ba", "bb", "bf", "bg", "bh", "bi", "bj",
    "bm", "bn", "bo", "bs", "bt", "bw", "by", "bz", "cd", "cg", "ci", "cm", "cr",
    "cv", "cy", "dm", "do", "dz", "ec", "ee", "er", "fj", "fm", "ga", "gd", "ge",
    "gh", "gm", "gt", "gw", "gy", "hn", "hr", "is", "jm", "jo", "ke", "kg", "kh",
    "kn", "kw", "ky", "kz", "la", "lb", "lc", "lk", "lr", "lt", "lu", "lv", "ly",
    "ma", "md", "me", "mg", "mk", "ml", "mm", "mn", "mo", "mr", "ms", "mt", "mu",
    "mv", "mw", "mz", "na", "ne", "ni", "np", "om", "pa", "pg", "pw", "py", "qa",
    "rs", "rw", "sb", "sc", "si", "sk", "sl", "sn", "sr", "st", "sv", "sz", "tc",
    "td", "tj", "tm", "tn", "to", "tt", "tz", "ug", "uy", "uz", "vc", "ve", "vg",
    "vu", "ws", "xk", "ye", "zm", "zw",
]

ALL = TIER1_REVENUE + TIER2_VOLUME + TIER3_LONGTAIL

PRESETS = {
    "t1": TIER1_REVENUE,
    "t2": TIER2_VOLUME,
    "t1+t2": TIER1_REVENUE + TIER2_VOLUME,
    "all": ALL,
}

NAMES = {
    "us": "United States", "jp": "Japan", "cn": "China mainland", "gb": "United Kingdom",
    "de": "Germany", "fr": "France", "ca": "Canada", "au": "Australia", "kr": "South Korea",
    "tw": "Taiwan", "hk": "Hong Kong", "sg": "Singapore", "ch": "Switzerland",
    "nl": "Netherlands", "se": "Sweden", "no": "Norway", "dk": "Denmark", "fi": "Finland",
    "it": "Italy", "es": "Spain", "at": "Austria", "be": "Belgium", "ie": "Ireland",
    "nz": "New Zealand", "ae": "UAE", "sa": "Saudi Arabia", "il": "Israel",
    "in": "India", "br": "Brazil", "mx": "Mexico", "id": "Indonesia", "vn": "Vietnam",
    "ph": "Philippines", "th": "Thailand", "tr": "Turkey", "ru": "Russia", "eg": "Egypt",
    "ng": "Nigeria", "pk": "Pakistan", "bd": "Bangladesh", "za": "South Africa",
    "ar": "Argentina", "co": "Colombia", "cl": "Chile", "pe": "Peru", "pl": "Poland",
    "ua": "Ukraine", "my": "Malaysia", "ro": "Romania", "cz": "Czechia", "pt": "Portugal",
    "gr": "Greece", "hu": "Hungary",
}


def resolve(spec):
    """'t1', 'all', or a comma list like 'us,gb,jp' -> list of storefront codes."""
    spec = (spec or "t1+t2").strip().lower()
    if spec in PRESETS:
        return list(dict.fromkeys(PRESETS[spec]))
    codes = [c.strip() for c in spec.split(",") if c.strip()]
    bad = [c for c in codes if len(c) != 2]
    if bad:
        raise SystemExit(f"Not valid 2-letter storefront codes: {bad}")
    return list(dict.fromkeys(codes))
