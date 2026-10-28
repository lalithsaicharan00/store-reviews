package com.oftenenough.app.ui.theme

import androidx.compose.ui.graphics.vector.ImageVector

/**
 * Habit icons are saved by the iPhone's symbol names (SF Symbols: "drop.fill"), so a habit keeps its icon on every
 * device; Android draws each with the nearest Material Symbol, filled (`Symbols.Filled`). The groups are the iPhone's icon picker's
 * (iOS/Habits/AddHabit/Appearance.swift), in the same order.
 */
object HabitIcons {
    data class Group(val name: String, val symbols: List<String>)

    val groups = listOf(
        Group("Health", listOf("heart.fill", "pills.fill", "cross.case.fill", "drop.fill", "lungs.fill", "brain.head.profile", "bandage.fill", "mouth.fill", "eye.fill", "bed.double.fill", "allergens", "stethoscope")),
        Group("Fitness", listOf("figure.walk", "figure.run", "figure.flexibility", "figure.strengthtraining.traditional", "figure.yoga", "figure.pool.swim", "bicycle", "dumbbell.fill", "figure.hiking", "sportscourt.fill", "stopwatch.fill", "shoeprints.fill")),
        Group("Mind", listOf("figure.mind.and.body", "book.fill", "brain", "pencil", "text.book.closed.fill", "lightbulb.fill", "music.note", "paintpalette.fill", "guitars.fill", "headphones", "character.book.closed.fill", "sparkles")),
        Group("Home and chores", listOf("house.fill", "washer.fill", "dishwasher.fill", "sink.fill", "refrigerator.fill", "trash.fill", "leaf.fill", "pawprint.fill", "cart.fill", "tshirt.fill", "shower.fill")),
        Group("Work and study", listOf("laptopcomputer", "briefcase.fill", "envelope.fill", "phone.fill", "calendar", "checklist", "clock.fill", "chart.bar.fill", "graduationcap.fill", "dollarsign.circle.fill", "person.2.fill", "bubble.left.fill")),
        Group("Faith and reflection", listOf("hands.and.sparkles.fill", "book.closed.fill", "moon.stars.fill", "sun.max.fill", "sunrise.fill", "building.columns.fill", "heart.text.square.fill", "star.fill")),
        Group("Food", listOf("fork.knife", "cup.and.saucer.fill", "carrot.fill", "fish.fill", "takeoutbag.and.cup.and.straw.fill", "birthday.cake.fill", "mug.fill", "wineglass")),
        Group("Break a habit", listOf("nosign", "smoke.fill", "iphone.slash", "gamecontroller.fill", "tv.fill", "cart.badge.minus", "hand.raised.fill", "bolt.slash.fill")),
        Group("Other", listOf("flame.fill", "bolt.fill", "target", "flag.fill", "gift.fill", "camera.fill", "globe", "airplane", "car.fill", "tree.fill", "plus.forwardslash.minus", "timer")),
    )

    private val map: Map<String, ImageVector> = mapOf(
        "heart.fill" to Symbols.Filled.Favorite, "pills.fill" to Symbols.Filled.Medication, "cross.case.fill" to Symbols.Filled.MedicalServices,
        "drop.fill" to Symbols.Filled.WaterDrop, "lungs.fill" to Symbols.Filled.Air, "brain.head.profile" to Symbols.Filled.Psychology,
        "bandage.fill" to Symbols.Filled.Healing, "mouth.fill" to Symbols.Filled.Mood, "eye.fill" to Symbols.Filled.Visibility,
        "bed.double.fill" to Symbols.Filled.Bed, "allergens" to Symbols.Filled.Grass, "stethoscope" to Symbols.Filled.LocalHospital,
        "figure.walk" to Symbols.Filled.DirectionsWalk, "figure.run" to Symbols.Filled.DirectionsRun,
        "figure.flexibility" to Symbols.Filled.SportsGymnastics, "figure.strengthtraining.traditional" to Symbols.Filled.FitnessCenter,
        "figure.yoga" to Symbols.Filled.SelfImprovement, "figure.pool.swim" to Symbols.Filled.Pool, "bicycle" to Symbols.Filled.DirectionsBike,
        "dumbbell.fill" to Symbols.Filled.FitnessCenter, "figure.hiking" to Symbols.Filled.Hiking, "sportscourt.fill" to Symbols.Filled.SportsTennis,
        "stopwatch.fill" to Symbols.Filled.Timer, "shoeprints.fill" to Symbols.Filled.NordicWalking,
        "figure.mind.and.body" to Symbols.Filled.SelfImprovement, "book.fill" to Symbols.Filled.MenuBook, "brain" to Symbols.Filled.Psychology,
        "pencil" to Symbols.Filled.Edit, "text.book.closed.fill" to Symbols.Filled.Book, "lightbulb.fill" to Symbols.Filled.Lightbulb,
        "music.note" to Symbols.Filled.MusicNote, "paintpalette.fill" to Symbols.Filled.Palette, "guitars.fill" to Symbols.Filled.Piano,
        "headphones" to Symbols.Filled.Headphones, "character.book.closed.fill" to Symbols.Filled.Translate, "sparkles" to Symbols.Filled.AutoAwesome,
        "house.fill" to Symbols.Filled.Home, "washer.fill" to Symbols.Filled.LocalLaundryService, "dishwasher.fill" to Symbols.Filled.Countertops,
        "sink.fill" to Symbols.Filled.Wash, "refrigerator.fill" to Symbols.Filled.Kitchen, "trash.fill" to Symbols.Filled.Delete,
        "leaf.fill" to Symbols.Filled.Eco, "pawprint.fill" to Symbols.Filled.Pets, "cart.fill" to Symbols.Filled.ShoppingCart,
        "tshirt.fill" to Symbols.Filled.Checkroom, "shower.fill" to Symbols.Filled.Shower,
        "laptopcomputer" to Symbols.Filled.Laptop, "briefcase.fill" to Symbols.Filled.Work, "envelope.fill" to Symbols.Filled.Mail,
        "phone.fill" to Symbols.Filled.Phone, "calendar" to Symbols.Filled.CalendarMonth, "checklist" to Symbols.Filled.Checklist,
        "clock.fill" to Symbols.Filled.Schedule, "chart.bar.fill" to Symbols.Filled.BarChart, "graduationcap.fill" to Symbols.Filled.School,
        "dollarsign.circle.fill" to Symbols.Filled.MonetizationOn, "person.2.fill" to Symbols.Filled.People, "bubble.left.fill" to Symbols.Filled.ChatBubble,
        "hands.and.sparkles.fill" to Symbols.Filled.VolunteerActivism, "book.closed.fill" to Symbols.Filled.AutoStories,
        "moon.stars.fill" to Symbols.Filled.Bedtime, "sun.max.fill" to Symbols.Filled.WbSunny, "sunrise.fill" to Symbols.Filled.WbTwilight,
        "building.columns.fill" to Symbols.Filled.AccountBalance, "heart.text.square.fill" to Symbols.Filled.Loyalty, "star.fill" to Symbols.Filled.Star,
        "fork.knife" to Symbols.Filled.Restaurant, "cup.and.saucer.fill" to Symbols.Filled.Coffee, "carrot.fill" to Symbols.Filled.Agriculture,
        "fish.fill" to Symbols.Filled.SetMeal, "takeoutbag.and.cup.and.straw.fill" to Symbols.Filled.Fastfood, "birthday.cake.fill" to Symbols.Filled.Cake,
        "mug.fill" to Symbols.Filled.EmojiFoodBeverage, "wineglass" to Symbols.Filled.WineBar,
        "nosign" to Symbols.Filled.Block, "smoke.fill" to Symbols.Filled.SmokeFree, "iphone.slash" to Symbols.Filled.Smartphone,
        "gamecontroller.fill" to Symbols.Filled.SportsEsports, "tv.fill" to Symbols.Filled.Tv, "cart.badge.minus" to Symbols.Filled.RemoveShoppingCart,
        "hand.raised.fill" to Symbols.Filled.PanTool, "bolt.slash.fill" to Symbols.Filled.FlashOff,
        "flame.fill" to Symbols.Filled.LocalFireDepartment, "bolt.fill" to Symbols.Filled.Bolt, "target" to Symbols.Filled.TrackChanges,
        "flag.fill" to Symbols.Filled.Flag, "gift.fill" to Symbols.Filled.CardGiftcard, "camera.fill" to Symbols.Filled.PhotoCamera,
        "globe" to Symbols.Filled.Public, "airplane" to Symbols.Filled.Flight, "car.fill" to Symbols.Filled.DirectionsCar, "tree.fill" to Symbols.Filled.Park,
        "plus.forwardslash.minus" to Symbols.Filled.Calculate, "timer" to Symbols.Filled.Timer, "trophy.fill" to Symbols.Filled.EmojiEvents,
        // Symbols the iPhone's ideas and tasks use outside the picker.
        "shippingbox.fill" to Symbols.Filled.Inventory2, "creditcard.fill" to Symbols.Filled.CreditCard, "banknote.fill" to Symbols.Filled.Payments,
        "checkmark.circle.fill" to Symbols.Filled.CheckCircle, "list.bullet" to Symbols.Filled.Checklist, "figure.cooldown" to Symbols.Filled.SportsGymnastics,
        "sun.horizon.fill" to Symbols.Filled.WbTwilight, "moon.fill" to Symbols.Filled.Bedtime, "drop" to Symbols.Filled.WaterDrop,
        "phone.down.fill" to Symbols.Filled.PhoneDisabled, "wind" to Symbols.Filled.Air, "flower" to Symbols.Filled.LocalFlorist,
        "camera.macro" to Symbols.Filled.LocalFlorist, "repeat" to Symbols.Filled.Repeat, "square.and.pencil" to Symbols.Filled.EditNote,
    )

    /** The same icons outlined, as the picker draws them (Figma 2.1.1: Material Symbols, fill 0); a habit's own circle stays filled. */
    private val outlinedMap: Map<String, ImageVector> = mapOf(
        "heart.fill" to Symbols.Favorite, "pills.fill" to Symbols.Medication, "cross.case.fill" to Symbols.MedicalServices,
        "drop.fill" to Symbols.WaterDrop, "lungs.fill" to Symbols.Air, "brain.head.profile" to Symbols.Psychology,
        "bandage.fill" to Symbols.Healing, "mouth.fill" to Symbols.Mood, "eye.fill" to Symbols.Visibility,
        "bed.double.fill" to Symbols.Bed, "allergens" to Symbols.Grass, "stethoscope" to Symbols.LocalHospital,
        "figure.walk" to Symbols.DirectionsWalk, "figure.run" to Symbols.DirectionsRun,
        "figure.flexibility" to Symbols.SportsGymnastics, "figure.strengthtraining.traditional" to Symbols.FitnessCenter,
        "figure.yoga" to Symbols.SelfImprovement, "figure.pool.swim" to Symbols.Pool, "bicycle" to Symbols.DirectionsBike,
        "dumbbell.fill" to Symbols.FitnessCenter, "figure.hiking" to Symbols.Hiking, "sportscourt.fill" to Symbols.SportsTennis,
        "stopwatch.fill" to Symbols.Timer, "shoeprints.fill" to Symbols.NordicWalking,
        "figure.mind.and.body" to Symbols.SelfImprovement, "book.fill" to Symbols.MenuBook, "brain" to Symbols.Psychology,
        "pencil" to Symbols.Edit, "text.book.closed.fill" to Symbols.Book, "lightbulb.fill" to Symbols.Lightbulb,
        "music.note" to Symbols.MusicNote, "paintpalette.fill" to Symbols.Palette, "guitars.fill" to Symbols.Piano,
        "headphones" to Symbols.Headphones, "character.book.closed.fill" to Symbols.Translate, "sparkles" to Symbols.AutoAwesome,
        "house.fill" to Symbols.Home, "washer.fill" to Symbols.LocalLaundryService, "dishwasher.fill" to Symbols.Countertops,
        "sink.fill" to Symbols.Wash, "refrigerator.fill" to Symbols.Kitchen, "trash.fill" to Symbols.Delete,
        "leaf.fill" to Symbols.Eco, "pawprint.fill" to Symbols.Pets, "cart.fill" to Symbols.ShoppingCart,
        "tshirt.fill" to Symbols.Checkroom, "shower.fill" to Symbols.Shower,
        "laptopcomputer" to Symbols.Laptop, "briefcase.fill" to Symbols.Work, "envelope.fill" to Symbols.Mail,
        "phone.fill" to Symbols.Phone, "calendar" to Symbols.CalendarMonth, "checklist" to Symbols.Checklist,
        "clock.fill" to Symbols.Schedule, "chart.bar.fill" to Symbols.BarChart, "graduationcap.fill" to Symbols.School,
        "dollarsign.circle.fill" to Symbols.MonetizationOn, "person.2.fill" to Symbols.People, "bubble.left.fill" to Symbols.ChatBubble,
        "hands.and.sparkles.fill" to Symbols.VolunteerActivism, "book.closed.fill" to Symbols.AutoStories,
        "moon.stars.fill" to Symbols.Bedtime, "sun.max.fill" to Symbols.WbSunny, "sunrise.fill" to Symbols.WbTwilight,
        "building.columns.fill" to Symbols.AccountBalance, "heart.text.square.fill" to Symbols.Loyalty, "star.fill" to Symbols.Star,
        "fork.knife" to Symbols.Restaurant, "cup.and.saucer.fill" to Symbols.Coffee, "carrot.fill" to Symbols.Agriculture,
        "fish.fill" to Symbols.SetMeal, "takeoutbag.and.cup.and.straw.fill" to Symbols.Fastfood, "birthday.cake.fill" to Symbols.Cake,
        "mug.fill" to Symbols.EmojiFoodBeverage, "wineglass" to Symbols.WineBar,
        "nosign" to Symbols.Block, "smoke.fill" to Symbols.SmokeFree, "iphone.slash" to Symbols.Smartphone,
        "gamecontroller.fill" to Symbols.SportsEsports, "tv.fill" to Symbols.Tv, "cart.badge.minus" to Symbols.RemoveShoppingCart,
        "hand.raised.fill" to Symbols.PanTool, "bolt.slash.fill" to Symbols.FlashOff,
        "flame.fill" to Symbols.LocalFireDepartment, "bolt.fill" to Symbols.Bolt, "target" to Symbols.TrackChanges,
        "flag.fill" to Symbols.Flag, "gift.fill" to Symbols.CardGiftcard, "camera.fill" to Symbols.PhotoCamera,
        "globe" to Symbols.Public, "airplane" to Symbols.Flight, "car.fill" to Symbols.DirectionsCar, "tree.fill" to Symbols.Park,
        "plus.forwardslash.minus" to Symbols.Calculate, "timer" to Symbols.Timer, "trophy.fill" to Symbols.EmojiEvents,
        // Symbols the iPhone's ideas and tasks use outside the picker.
        "shippingbox.fill" to Symbols.Inventory2, "creditcard.fill" to Symbols.CreditCard, "banknote.fill" to Symbols.Payments,
        "checkmark.circle.fill" to Symbols.CheckCircle, "list.bullet" to Symbols.Checklist, "figure.cooldown" to Symbols.SportsGymnastics,
        "sun.horizon.fill" to Symbols.WbTwilight, "moon.fill" to Symbols.Bedtime, "drop" to Symbols.WaterDrop,
        "phone.down.fill" to Symbols.PhoneDisabled, "wind" to Symbols.Air, "flower" to Symbols.LocalFlorist,
        "camera.macro" to Symbols.LocalFlorist, "repeat" to Symbols.Repeat, "square.and.pencil" to Symbols.EditNote,
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

    fun icon(symbol: String): ImageVector = map[symbol] ?: Symbols.Filled.Star

    fun outlined(symbol: String): ImageVector = outlinedMap[symbol] ?: Symbols.Star

    /** TalkBack's name for an icon. */
    fun spokenName(symbol: String): String = keywords[symbol]?.firstOrNull() ?: symbol.replace(".fill", "").replace(".", " ")

    private val candidates = keywords.flatMap { (symbol, keys) -> keys.map { it to symbol } }.sortedByDescending { it.first.length }

    /** An icon from the habit's name, so choosing one is optional (the iPhone's `IconSuggester`). */
    fun suggest(name: String): String? {
        val text = name.lowercase()
        if (text.length < 3) return null
        val words = text.split(Regex("[^\\p{L}-]+")).filter { it.isNotEmpty() }.toSet()
        for ((key, symbol) in candidates) {
            if (if (" " in key) key in text else (key in words || "${key}s" in words)) return symbol
        }
        return null
    }
}
