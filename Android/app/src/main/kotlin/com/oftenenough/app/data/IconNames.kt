package com.oftenenough.app.data

/**
 * Every name an icon goes by, so a habit keeps its icon when a backup file moves between Android and the iPhone (the
 * user, 5 Nov 2026; Android A111; `Core/Backup File Format.md`, "Icon names"). A habit's `symbol` is the name of one
 * SF Symbol ("figure.run"), never a picture, and Android draws the nearest Material Symbol for it. Its `symbol_names`
 * keep all its names, the iPhone's, Android's and the plain words: the other phone, or a later version of this one,
 * takes the first it knows.
 */
object IconNames {
    /** The SF Symbols Android can draw (`HabitIcons`), with the Material Symbols they go by, the one drawn first. */
    private val material: Map<String, List<String>> = mapOf(
        "heart.fill" to listOf("favorite"), "pills.fill" to listOf("medication", "pill"),
        "cross.case.fill" to listOf("medical_services"), "drop.fill" to listOf("water_drop"), "lungs.fill" to listOf("air"),
        "brain.head.profile" to listOf("psychology"), "bandage.fill" to listOf("healing"), "mouth.fill" to listOf("mood"),
        "eye.fill" to listOf("visibility"), "bed.double.fill" to listOf("bed"), "allergens" to listOf("grass"),
        "stethoscope" to listOf("local_hospital"), "figure.walk" to listOf("directions_walk"),
        "figure.run" to listOf("directions_run", "run_circle", "sprint"), "figure.flexibility" to listOf("sports_gymnastics"),
        "figure.strengthtraining.traditional" to listOf("fitness_center"), "figure.yoga" to listOf("self_improvement"),
        "figure.pool.swim" to listOf("pool"), "bicycle" to listOf("directions_bike", "pedal_bike"),
        "dumbbell.fill" to listOf("fitness_center"), "figure.hiking" to listOf("hiking"),
        "sportscourt.fill" to listOf("sports_tennis"), "stopwatch.fill" to listOf("timer"),
        "shoeprints.fill" to listOf("nordic_walking"), "figure.mind.and.body" to listOf("self_improvement"),
        "book.fill" to listOf("menu_book"), "brain" to listOf("psychology"), "pencil" to listOf("edit"),
        "text.book.closed.fill" to listOf("book"), "lightbulb.fill" to listOf("lightbulb"),
        "music.note" to listOf("music_note"), "paintpalette.fill" to listOf("palette"), "guitars.fill" to listOf("piano"),
        "headphones" to listOf("headphones", "headset"), "character.book.closed.fill" to listOf("translate"),
        "sparkles" to listOf("auto_awesome"), "house.fill" to listOf("home"), "washer.fill" to listOf("local_laundry_service"),
        "dishwasher.fill" to listOf("countertops"), "sink.fill" to listOf("wash"), "refrigerator.fill" to listOf("kitchen"),
        "trash.fill" to listOf("delete"), "leaf.fill" to listOf("eco", "local_florist", "potted_plant", "spa"),
        "pawprint.fill" to listOf("pets"), "cart.fill" to listOf("shopping_cart"), "tshirt.fill" to listOf("checkroom"),
        "shower.fill" to listOf("shower"), "laptopcomputer" to listOf("laptop"), "briefcase.fill" to listOf("work"),
        "envelope.fill" to listOf("mail"), "phone.fill" to listOf("phone", "call"),
        "calendar" to listOf("calendar_month", "calendar_today", "calendar_view_week", "date_range", "event", "today"),
        "checklist" to listOf("checklist", "checklist_rtl"), "clock.fill" to listOf("schedule"), "chart.bar.fill" to listOf("bar_chart"),
        "graduationcap.fill" to listOf("school"), "dollarsign.circle.fill" to listOf("monetization_on", "savings"),
        "person.2.fill" to listOf("people"), "bubble.left.fill" to listOf("chat_bubble", "chat"),
        "hands.and.sparkles.fill" to listOf("volunteer_activism", "clean_hands"), "book.closed.fill" to listOf("auto_stories"),
        "moon.stars.fill" to listOf("bedtime"), "sun.max.fill" to listOf("wb_sunny"), "sunrise.fill" to listOf("wb_twilight"),
        "building.columns.fill" to listOf("account_balance"), "heart.text.square.fill" to listOf("loyalty"),
        "star.fill" to listOf("star"), "fork.knife" to listOf("restaurant", "set_meal"),
        "cup.and.saucer.fill" to listOf("coffee"), "carrot.fill" to listOf("agriculture"), "fish.fill" to listOf("set_meal"),
        "takeoutbag.and.cup.and.straw.fill" to listOf("fastfood"), "birthday.cake.fill" to listOf("cake"),
        "mug.fill" to listOf("emoji_food_beverage"), "wineglass" to listOf("wine_bar"), "nosign" to listOf("block"),
        "smoke.fill" to listOf("smoke_free"), "iphone.slash" to listOf("smartphone"),
        "gamecontroller.fill" to listOf("sports_esports"), "tv.fill" to listOf("tv"),
        "cart.badge.minus" to listOf("remove_shopping_cart"), "hand.raised.fill" to listOf("pan_tool"),
        "bolt.slash.fill" to listOf("flash_off"), "flame.fill" to listOf("local_fire_department"),
        "bolt.fill" to listOf("bolt"), "target" to listOf("track_changes"), "flag.fill" to listOf("flag"),
        "gift.fill" to listOf("card_giftcard"), "camera.fill" to listOf("photo_camera"), "globe" to listOf("public"),
        "airplane" to listOf("flight"), "car.fill" to listOf("directions_car"), "tree.fill" to listOf("park", "yard"),
        "plus.forwardslash.minus" to listOf("calculate"), "timer" to listOf("timer", "av_timer"), "trophy.fill" to listOf("emoji_events"),
        "shippingbox.fill" to listOf("inventory_2"), "creditcard.fill" to listOf("credit_card"),
        "banknote.fill" to listOf("payments"), "checkmark.circle.fill" to listOf("check_circle", "done_all"),
        "list.bullet" to listOf("checklist", "list"), "figure.cooldown" to listOf("sports_gymnastics"),
        "sun.horizon.fill" to listOf("wb_twilight"), "moon.fill" to listOf("bedtime"), "drop" to listOf("water_drop"),
        "phone.down.fill" to listOf("phone_disabled"), "wind" to listOf("air"), "flower" to listOf("local_florist"),
        "camera.macro" to listOf("local_florist"), "repeat" to listOf("repeat", "repeat_on"), "square.and.pencil" to listOf("edit_note"),
    )

    /** Extra words for search (the iPhone's `IconLibrary.keywords`). */
    val keywords: Map<String, List<String>> = mapOf(
        "drop.fill" to listOf("water", "hydrate", "drink"), "pills.fill" to listOf("meds", "medicine", "vitamin", "pill", "tablet"),
        "bed.double.fill" to listOf("sleep", "bed", "nap"), "mouth.fill" to listOf("teeth", "brush", "floss", "dentist"),
        "figure.walk" to listOf("walk", "steps"), "figure.run" to listOf("run", "jog"), "figure.yoga" to listOf("yoga"),
        "figure.flexibility" to listOf("stretch"), "figure.strengthtraining.traditional" to listOf("gym", "workout", "lift", "weights"),
        "figure.pool.swim" to listOf("swim"), "bicycle" to listOf("bike", "cycle", "cycling"), "dumbbell.fill" to listOf("exercise", "push-ups", "pushups"),
        "figure.mind.and.body" to listOf("meditate", "meditation", "breathe", "mindful"), "book.fill" to listOf("read", "reading", "book"),
        "pencil" to listOf("write", "journal", "diary"), "music.note" to listOf("music", "practice", "piano", "sing"),
        "graduationcap.fill" to listOf("study", "learn", "homework", "class"), "character.book.closed.fill" to listOf("language", "spanish", "french", "vocabulary"),
        "house.fill" to listOf("home", "tidy", "clean"), "washer.fill" to listOf("laundry", "wash"), "dishwasher.fill" to listOf("dishes"),
        "sink.fill" to listOf("sink", "kitchen"), "refrigerator.fill" to listOf("fridge", "groceries"), "trash.fill" to listOf("trash", "bins", "rubbish"),
        "leaf.fill" to listOf("plants", "water plants", "garden"), "pawprint.fill" to listOf("dog", "cat", "pet", "walk the dog"),
        "cart.fill" to listOf("shop", "shopping"), "tshirt.fill" to listOf("clothes", "iron"), "shower.fill" to listOf("shower", "bath"),
        "envelope.fill" to listOf("email", "inbox"), "phone.fill" to listOf("call", "phone", "family"), "calendar" to listOf("plan", "appointment", "dentist"),
        "dollarsign.circle.fill" to listOf("money", "budget", "save", "invest"), "hands.and.sparkles.fill" to listOf("pray", "prayer", "gratitude"),
        "book.closed.fill" to listOf("bible", "quran", "scripture", "torah"), "building.columns.fill" to listOf("church", "mosque", "temple"),
        "moon.stars.fill" to listOf("night", "evening"), "sunrise.fill" to listOf("morning", "wake"), "fork.knife" to listOf("eat", "meal", "lunch", "dinner", "breakfast", "cook"),
        "carrot.fill" to listOf("vegetables", "veggies", "healthy"), "fish.fill" to listOf("fish"), "mug.fill" to listOf("tea"), "cup.and.saucer.fill" to listOf("coffee", "caffeine"),
        "wineglass" to listOf("alcohol", "wine", "drinking", "beer"), "smoke.fill" to listOf("smoking", "cigarette", "vape", "nicotine"),
        "iphone.slash" to listOf("screen time", "social media", "scrolling", "doomscrolling"), "gamecontroller.fill" to listOf("games", "gaming"), "tv.fill" to listOf("tv", "netflix", "youtube"),
        "birthday.cake.fill" to listOf("sugar", "sweets", "dessert"), "takeoutbag.and.cup.and.straw.fill" to listOf("junk food", "fast food", "takeaway"),
        "heart.fill" to listOf("health", "heart", "self-care"), "brain.head.profile" to listOf("mental", "therapy", "mood"), "lungs.fill" to listOf("breathing"),
        "eye.fill" to listOf("eyes", "contacts"), "stethoscope" to listOf("doctor", "check-up"), "flame.fill" to listOf("streak", "challenge"),
        "laptopcomputer" to listOf("work", "code", "computer"), "clock.fill" to listOf("time", "early"), "person.2.fill" to listOf("friends", "social"),
    )

    private const val SEPARATOR = ","

    /** Any way of writing the same name: "heart", "Heart" and "heart.fill" are one icon. */
    private fun plain(name: String) = name.trim().lowercase().removeSuffix(".fill")

    /** Every name to look a stored name up by. An SF Symbol's own name beats a Material name, and both beat a plain word. */
    private val symbolByName: Map<String, String> by lazy {
        buildMap {
            for (symbol in material.keys) putIfAbsent(plain(symbol), symbol)
            for ((symbol, names) in material) for (name in names) putIfAbsent(plain(name), symbol)
            for ((symbol, words) in keywords) if (symbol in material) for (word in words) putIfAbsent(plain(word), symbol)
        }
    }

    private fun read(names: String?): List<String> = names?.split(SEPARATOR)?.map { it.trim() }?.filter { it.isNotEmpty() }.orEmpty()

    /** All of an icon's names, its own first. */
    fun of(symbol: String): List<String> = (listOf(symbol) + material[symbol].orEmpty() + keywords[symbol].orEmpty()).distinct()

    /** What a habit stores for an icon. */
    fun stored(symbol: String): String = of(symbol).joinToString(SEPARATOR)

    /**
     * The icon this phone draws for a habit: the first of its names it knows, then its symbol. Null when it knows none
     * of them, so the habit keeps what it had and goes back to the other phone unchanged.
     */
    fun closest(symbol: String, names: String?): String? {
        for (name in read(names) + symbol) {
            if (name in material) return name
            symbolByName[plain(name)]?.let { return it }
        }
        return null
    }

    /**
     * The names to save with a habit. While the icon is still the one its names lead to, they're kept, so an icon only
     * the iPhone has comes back to the iPhone. An icon chosen since starts again from its own names.
     */
    fun toSave(symbol: String, kept: String?): String {
        val names = read(kept)
        if (names.isEmpty()) return stored(symbol)
        val found = closest(symbol, kept)
        val same = found == symbol || (found == null && symbol !in material)
        return if (same) (names + of(symbol)).distinct().joinToString(SEPARATOR) else stored(symbol)
    }
}
