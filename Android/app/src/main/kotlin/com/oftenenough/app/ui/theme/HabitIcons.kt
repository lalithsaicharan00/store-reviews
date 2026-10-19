package com.oftenenough.app.ui.theme

import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.outlined.*
import androidx.compose.material.icons.rounded.*
import androidx.compose.ui.graphics.vector.ImageVector

/**
 * Habit icons are saved by the iPhone's symbol names (SF Symbols: "drop.fill"), so a habit keeps its icon on every
 * device; Android draws each with the nearest Material icon. The groups are the iPhone's icon picker's
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
        "heart.fill" to Icons.Rounded.Favorite, "pills.fill" to Icons.Rounded.Medication, "cross.case.fill" to Icons.Rounded.MedicalServices,
        "drop.fill" to Icons.Rounded.WaterDrop, "lungs.fill" to Icons.Rounded.Air, "brain.head.profile" to Icons.Rounded.Psychology,
        "bandage.fill" to Icons.Rounded.Healing, "mouth.fill" to Icons.Rounded.Mood, "eye.fill" to Icons.Rounded.Visibility,
        "bed.double.fill" to Icons.Rounded.Bed, "allergens" to Icons.Rounded.Grass, "stethoscope" to Icons.Rounded.LocalHospital,
        "figure.walk" to Icons.Rounded.DirectionsWalk, "figure.run" to Icons.Rounded.DirectionsRun,
        "figure.flexibility" to Icons.Rounded.SportsGymnastics, "figure.strengthtraining.traditional" to Icons.Rounded.FitnessCenter,
        "figure.yoga" to Icons.Rounded.SelfImprovement, "figure.pool.swim" to Icons.Rounded.Pool, "bicycle" to Icons.Rounded.DirectionsBike,
        "dumbbell.fill" to Icons.Rounded.FitnessCenter, "figure.hiking" to Icons.Rounded.Hiking, "sportscourt.fill" to Icons.Rounded.SportsTennis,
        "stopwatch.fill" to Icons.Rounded.Timer, "shoeprints.fill" to Icons.Rounded.NordicWalking,
        "figure.mind.and.body" to Icons.Rounded.SelfImprovement, "book.fill" to Icons.Rounded.MenuBook, "brain" to Icons.Rounded.Psychology,
        "pencil" to Icons.Rounded.Edit, "text.book.closed.fill" to Icons.Rounded.Book, "lightbulb.fill" to Icons.Rounded.Lightbulb,
        "music.note" to Icons.Rounded.MusicNote, "paintpalette.fill" to Icons.Rounded.Palette, "guitars.fill" to Icons.Rounded.Piano,
        "headphones" to Icons.Rounded.Headphones, "character.book.closed.fill" to Icons.Rounded.Translate, "sparkles" to Icons.Rounded.AutoAwesome,
        "house.fill" to Icons.Rounded.Home, "washer.fill" to Icons.Rounded.LocalLaundryService, "dishwasher.fill" to Icons.Rounded.Countertops,
        "sink.fill" to Icons.Rounded.Wash, "refrigerator.fill" to Icons.Rounded.Kitchen, "trash.fill" to Icons.Rounded.Delete,
        "leaf.fill" to Icons.Rounded.Eco, "pawprint.fill" to Icons.Rounded.Pets, "cart.fill" to Icons.Rounded.ShoppingCart,
        "tshirt.fill" to Icons.Rounded.Checkroom, "shower.fill" to Icons.Rounded.Shower,
        "laptopcomputer" to Icons.Rounded.Laptop, "briefcase.fill" to Icons.Rounded.Work, "envelope.fill" to Icons.Rounded.Email,
        "phone.fill" to Icons.Rounded.Phone, "calendar" to Icons.Rounded.CalendarMonth, "checklist" to Icons.Rounded.Checklist,
        "clock.fill" to Icons.Rounded.Schedule, "chart.bar.fill" to Icons.Rounded.BarChart, "graduationcap.fill" to Icons.Rounded.School,
        "dollarsign.circle.fill" to Icons.Rounded.MonetizationOn, "person.2.fill" to Icons.Rounded.People, "bubble.left.fill" to Icons.Rounded.ChatBubble,
        "hands.and.sparkles.fill" to Icons.Rounded.VolunteerActivism, "book.closed.fill" to Icons.Rounded.AutoStories,
        "moon.stars.fill" to Icons.Rounded.Bedtime, "sun.max.fill" to Icons.Rounded.WbSunny, "sunrise.fill" to Icons.Rounded.WbTwilight,
        "building.columns.fill" to Icons.Rounded.AccountBalance, "heart.text.square.fill" to Icons.Rounded.Loyalty, "star.fill" to Icons.Rounded.Star,
        "fork.knife" to Icons.Rounded.Restaurant, "cup.and.saucer.fill" to Icons.Rounded.Coffee, "carrot.fill" to Icons.Rounded.Agriculture,
        "fish.fill" to Icons.Rounded.SetMeal, "takeoutbag.and.cup.and.straw.fill" to Icons.Rounded.Fastfood, "birthday.cake.fill" to Icons.Rounded.Cake,
        "mug.fill" to Icons.Rounded.EmojiFoodBeverage, "wineglass" to Icons.Rounded.WineBar,
        "nosign" to Icons.Rounded.Block, "smoke.fill" to Icons.Rounded.SmokeFree, "iphone.slash" to Icons.Rounded.Smartphone,
        "gamecontroller.fill" to Icons.Rounded.SportsEsports, "tv.fill" to Icons.Rounded.Tv, "cart.badge.minus" to Icons.Rounded.RemoveShoppingCart,
        "hand.raised.fill" to Icons.Rounded.PanTool, "bolt.slash.fill" to Icons.Rounded.FlashOff,
        "flame.fill" to Icons.Rounded.LocalFireDepartment, "bolt.fill" to Icons.Rounded.Bolt, "target" to Icons.Rounded.TrackChanges,
        "flag.fill" to Icons.Rounded.Flag, "gift.fill" to Icons.Rounded.CardGiftcard, "camera.fill" to Icons.Rounded.PhotoCamera,
        "globe" to Icons.Rounded.Public, "airplane" to Icons.Rounded.Flight, "car.fill" to Icons.Rounded.DirectionsCar, "tree.fill" to Icons.Rounded.Park,
        "plus.forwardslash.minus" to Icons.Rounded.Calculate, "timer" to Icons.Rounded.Timer, "trophy.fill" to Icons.Rounded.EmojiEvents,
        // Symbols the iPhone's ideas and tasks use outside the picker.
        "shippingbox.fill" to Icons.Rounded.Inventory2, "creditcard.fill" to Icons.Rounded.CreditCard, "banknote.fill" to Icons.Rounded.Payments,
        "checkmark.circle.fill" to Icons.Rounded.CheckCircle, "list.bullet" to Icons.Rounded.Checklist, "figure.cooldown" to Icons.Rounded.SportsGymnastics,
        "sun.horizon.fill" to Icons.Rounded.WbTwilight, "moon.fill" to Icons.Rounded.Bedtime, "drop" to Icons.Rounded.WaterDrop,
        "phone.down.fill" to Icons.Rounded.PhoneDisabled, "wind" to Icons.Rounded.Air, "flower" to Icons.Rounded.LocalFlorist,
        "camera.macro" to Icons.Rounded.LocalFlorist, "repeat" to Icons.Rounded.Repeat, "square.and.pencil" to Icons.Rounded.EditNote,
    )

    /** The same icons outlined, as the picker draws them (Figma 2.1.1: Material Symbols, fill 0); a habit's own circle stays filled. */
    private val outlinedMap: Map<String, ImageVector> = mapOf(
        "heart.fill" to Icons.Outlined.FavoriteBorder, "pills.fill" to Icons.Outlined.Medication, "cross.case.fill" to Icons.Outlined.MedicalServices,
        "drop.fill" to Icons.Outlined.WaterDrop, "lungs.fill" to Icons.Outlined.Air, "brain.head.profile" to Icons.Outlined.Psychology,
        "bandage.fill" to Icons.Outlined.Healing, "mouth.fill" to Icons.Outlined.Mood, "eye.fill" to Icons.Outlined.Visibility,
        "bed.double.fill" to Icons.Outlined.Bed, "allergens" to Icons.Outlined.Grass, "stethoscope" to Icons.Outlined.LocalHospital,
        "figure.walk" to Icons.Outlined.DirectionsWalk, "figure.run" to Icons.Outlined.DirectionsRun,
        "figure.flexibility" to Icons.Outlined.SportsGymnastics, "figure.strengthtraining.traditional" to Icons.Outlined.FitnessCenter,
        "figure.yoga" to Icons.Outlined.SelfImprovement, "figure.pool.swim" to Icons.Outlined.Pool, "bicycle" to Icons.Outlined.DirectionsBike,
        "dumbbell.fill" to Icons.Outlined.FitnessCenter, "figure.hiking" to Icons.Outlined.Hiking, "sportscourt.fill" to Icons.Outlined.SportsTennis,
        "stopwatch.fill" to Icons.Outlined.Timer, "shoeprints.fill" to Icons.Outlined.NordicWalking,
        "figure.mind.and.body" to Icons.Outlined.SelfImprovement, "book.fill" to Icons.Outlined.MenuBook, "brain" to Icons.Outlined.Psychology,
        "pencil" to Icons.Outlined.Edit, "text.book.closed.fill" to Icons.Outlined.Book, "lightbulb.fill" to Icons.Outlined.Lightbulb,
        "music.note" to Icons.Outlined.MusicNote, "paintpalette.fill" to Icons.Outlined.Palette, "guitars.fill" to Icons.Outlined.Piano,
        "headphones" to Icons.Outlined.Headphones, "character.book.closed.fill" to Icons.Outlined.Translate, "sparkles" to Icons.Outlined.AutoAwesome,
        "house.fill" to Icons.Outlined.Home, "washer.fill" to Icons.Outlined.LocalLaundryService, "dishwasher.fill" to Icons.Outlined.Countertops,
        "sink.fill" to Icons.Outlined.Wash, "refrigerator.fill" to Icons.Outlined.Kitchen, "trash.fill" to Icons.Outlined.Delete,
        "leaf.fill" to Icons.Outlined.Eco, "pawprint.fill" to Icons.Outlined.Pets, "cart.fill" to Icons.Outlined.ShoppingCart,
        "tshirt.fill" to Icons.Outlined.Checkroom, "shower.fill" to Icons.Outlined.Shower,
        "laptopcomputer" to Icons.Outlined.Laptop, "briefcase.fill" to Icons.Outlined.Work, "envelope.fill" to Icons.Outlined.Email,
        "phone.fill" to Icons.Outlined.Phone, "calendar" to Icons.Outlined.CalendarMonth, "checklist" to Icons.Outlined.Checklist,
        "clock.fill" to Icons.Outlined.Schedule, "chart.bar.fill" to Icons.Outlined.BarChart, "graduationcap.fill" to Icons.Outlined.School,
        "dollarsign.circle.fill" to Icons.Outlined.MonetizationOn, "person.2.fill" to Icons.Outlined.People, "bubble.left.fill" to Icons.Outlined.ChatBubble,
        "hands.and.sparkles.fill" to Icons.Outlined.VolunteerActivism, "book.closed.fill" to Icons.Outlined.AutoStories,
        "moon.stars.fill" to Icons.Outlined.Bedtime, "sun.max.fill" to Icons.Outlined.WbSunny, "sunrise.fill" to Icons.Outlined.WbTwilight,
        "building.columns.fill" to Icons.Outlined.AccountBalance, "heart.text.square.fill" to Icons.Outlined.Loyalty, "star.fill" to Icons.Outlined.StarOutline,
        "fork.knife" to Icons.Outlined.Restaurant, "cup.and.saucer.fill" to Icons.Outlined.Coffee, "carrot.fill" to Icons.Outlined.Agriculture,
        "fish.fill" to Icons.Outlined.SetMeal, "takeoutbag.and.cup.and.straw.fill" to Icons.Outlined.Fastfood, "birthday.cake.fill" to Icons.Outlined.Cake,
        "mug.fill" to Icons.Outlined.EmojiFoodBeverage, "wineglass" to Icons.Outlined.WineBar,
        "nosign" to Icons.Outlined.Block, "smoke.fill" to Icons.Outlined.SmokeFree, "iphone.slash" to Icons.Outlined.Smartphone,
        "gamecontroller.fill" to Icons.Outlined.SportsEsports, "tv.fill" to Icons.Outlined.Tv, "cart.badge.minus" to Icons.Outlined.RemoveShoppingCart,
        "hand.raised.fill" to Icons.Outlined.PanTool, "bolt.slash.fill" to Icons.Outlined.FlashOff,
        "flame.fill" to Icons.Outlined.LocalFireDepartment, "bolt.fill" to Icons.Outlined.Bolt, "target" to Icons.Outlined.TrackChanges,
        "flag.fill" to Icons.Outlined.Flag, "gift.fill" to Icons.Outlined.CardGiftcard, "camera.fill" to Icons.Outlined.PhotoCamera,
        "globe" to Icons.Outlined.Public, "airplane" to Icons.Outlined.Flight, "car.fill" to Icons.Outlined.DirectionsCar, "tree.fill" to Icons.Outlined.Park,
        "plus.forwardslash.minus" to Icons.Outlined.Calculate, "timer" to Icons.Outlined.Timer, "trophy.fill" to Icons.Outlined.EmojiEvents,
        // Symbols the iPhone's ideas and tasks use outside the picker.
        "shippingbox.fill" to Icons.Outlined.Inventory2, "creditcard.fill" to Icons.Outlined.CreditCard, "banknote.fill" to Icons.Outlined.Payments,
        "checkmark.circle.fill" to Icons.Outlined.CheckCircle, "list.bullet" to Icons.Outlined.Checklist, "figure.cooldown" to Icons.Outlined.SportsGymnastics,
        "sun.horizon.fill" to Icons.Outlined.WbTwilight, "moon.fill" to Icons.Outlined.Bedtime, "drop" to Icons.Outlined.WaterDrop,
        "phone.down.fill" to Icons.Outlined.PhoneDisabled, "wind" to Icons.Outlined.Air, "flower" to Icons.Outlined.LocalFlorist,
        "camera.macro" to Icons.Outlined.LocalFlorist, "repeat" to Icons.Outlined.Repeat, "square.and.pencil" to Icons.Outlined.EditNote,
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

    fun icon(symbol: String): ImageVector = map[symbol] ?: Icons.Rounded.Star

    fun outlined(symbol: String): ImageVector = outlinedMap[symbol] ?: Icons.Outlined.StarOutline

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
