"""
Play Store review locales.

Play partitions reviews by LANGUAGE, not country -- verified: holding hl=en and
varying gl across US/IN/JP/DE/BR/NG returned identical reviews, while varying hl
returned zero overlap. So a full sweep iterates these, not storefronts.
"""

LANGUAGES = """
en es pt fr de it nl pl ru uk tr ar fa he hi bn ta te ml kn mr gu pa ur ne si
id ms vi th my km lo tl zh-CN zh-TW ja ko
cs sk sl hr sr bs mk bg ro hu el sq
sv no da fi is et lv lt
af sw am zu yo ha ig
az kk ky uz mn ka hy be
ca eu gl
""".split()

# Highest-volume review languages first, so a partial run still covers the bulk.
PRIORITY = ["en", "es", "pt", "ru", "de", "fr", "it", "id", "tr", "ja", "ko",
            "zh-CN", "zh-TW", "pl", "nl", "vi", "th", "ar", "hi", "uk"]

ALL = PRIORITY + [l for l in LANGUAGES if l not in PRIORITY]

NAMES = {
    "en": "English", "es": "Spanish", "pt": "Portuguese", "fr": "French",
    "de": "German", "it": "Italian", "nl": "Dutch", "pl": "Polish",
    "ru": "Russian", "uk": "Ukrainian", "tr": "Turkish", "ar": "Arabic",
    "fa": "Persian", "he": "Hebrew", "hi": "Hindi", "bn": "Bengali",
    "ta": "Tamil", "te": "Telugu", "ml": "Malayalam", "kn": "Kannada",
    "mr": "Marathi", "gu": "Gujarati", "pa": "Punjabi", "ur": "Urdu",
    "id": "Indonesian", "ms": "Malay", "vi": "Vietnamese", "th": "Thai",
    "zh-CN": "Chinese (Simplified)", "zh-TW": "Chinese (Traditional)",
    "ja": "Japanese", "ko": "Korean", "cs": "Czech", "sk": "Slovak",
    "ro": "Romanian", "hu": "Hungarian", "el": "Greek", "sv": "Swedish",
    "no": "Norwegian", "da": "Danish", "fi": "Finnish", "sw": "Swahili",
}


def resolve(spec):
    """'all', 'priority', or a comma list like 'en,es,ja'."""
    spec = (spec or "all").strip().lower()
    if spec == "all":
        return list(dict.fromkeys(ALL))
    if spec == "priority":
        return list(PRIORITY)
    return [c.strip() for c in spec.split(",") if c.strip()]
