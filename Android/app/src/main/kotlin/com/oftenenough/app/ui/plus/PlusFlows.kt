package com.oftenenough.app.ui.plus

import androidx.activity.compose.LocalActivity
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.selection.selectable
import androidx.compose.foundation.selection.selectableGroup
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.RadioButton
import androidx.compose.material3.RadioButtonDefaults
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.foundation.clickable
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.rounded.Cancel
import androidx.compose.material.icons.rounded.LinkOff
import androidx.compose.material.icons.rounded.TimerOff
import androidx.compose.material.icons.rounded.Group
import androidx.compose.material.icons.rounded.GroupAdd
import androidx.compose.material.icons.rounded.Groups
import androidx.compose.material.icons.automirrored.rounded.Login
import androidx.compose.material.icons.rounded.QrCodeScanner
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.drawBehind
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.geometry.Size
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import com.oftenenough.app.ui.components.segmentShape
import androidx.compose.ui.graphics.ColorFilter
import androidx.compose.ui.layout.onSizeChanged
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.semantics.heading
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.unit.dp
import com.oftenenough.app.R
import com.oftenenough.app.app.BuyResult
import com.oftenenough.app.app.PlusOwned
import com.oftenenough.app.app.PlusProduct
import com.oftenenough.app.app.PlusStore
import com.oftenenough.app.app.RestoreResult
import app.habits.account.AccountCenter
import app.habits.account.AccountPlus
import app.habits.account.Answer
import app.habits.account.InviteLink
import app.habits.account.InviteLook
import app.habits.account.SignIn
import com.oftenenough.app.app.account.SignInProvider
import app.habits.account.SignInReply
import app.habits.account.SignInWith
import com.oftenenough.app.ui.components.Segment
import com.oftenenough.app.ui.components.SegmentedList
import com.oftenenough.app.ui.newhabit.FormPage
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors
import kotlinx.coroutines.Job
import kotlinx.coroutines.launch

/** Where a Plus & Account flow goes when it's finished. */
interface PlusFlowNav {
    /** Back to Plus & Account (closing the flow), with words for a snackbar there. */
    fun toPage(message: String? = null)
    /** Back to Plus & Account, showing "No Plus found" over it (Figma 4.2). */
    fun toPageNoPlusFound()
    fun getPlus()
    fun signIn()
}

private val offlineWords = "Couldn’t connect. Check your internet connection, then try again."

// ==================================================================== 2 · Get Plus, 2.4, 8 · Plus Family, and buying

/**
 * Get Plus (Figma 2, 2.4) or the Plus Family upgrade (8): the plan first, then what you get and where it works; the
 * button pinned at the bottom names the plan and its price. Buying opens Google Play's own sheet (2.1, 2.5, 8.1); then
 * thanks and the account offer (2.2, 2.6, 8.2), Play's wait for a payment (2.1.1) or "Payment not completed" (2.1.2).
 */
@Composable
fun GetPlusScreen(plus: PlusStore, accounts: AccountCenter, signIn: SignInProvider, upgrade: Boolean, nav: PlusFlowNav, onBack: () -> Unit) {
    val c = appColors
    val activity = LocalActivity.current
    val scope = rememberCoroutineScope()
    var family by rememberSaveable { mutableStateOf(upgrade) }
    var step by rememberSaveable { mutableStateOf("choose") }
    var notCompleted by rememberSaveable { mutableStateOf(false) }
    var buying by rememberSaveable { mutableStateOf(false) }
    var bottomHeight by androidx.compose.runtime.remember { mutableIntStateOf(0) }
    val product = if (upgrade) PlusProduct.FAMILY_UPGRADE else if (family) PlusProduct.FAMILY else PlusProduct.PLUS

    fun buy() {
        val a = activity ?: return
        if (buying) return
        scope.launch {
            buying = true
            val result = plus.buy(a, product)
            buying = false
            when (result) {
                BuyResult.BOUGHT -> {
                    accounts.syncPurchases(plus.purchases())
                    val account = accounts.account
                    step = when {
                        product == PlusProduct.PLUS && account == null -> "thanks-plus"
                        product == PlusProduct.PLUS -> { nav.toPage("Plus is yours. Thank you."); "done" }
                        else -> "thanks-family"
                    }
                }
                BuyResult.PENDING -> step = "pending"
                BuyResult.NOT_COMPLETED -> notCompleted = true
                BuyResult.CANCELLED -> {}
                BuyResult.UNAVAILABLE -> nav.toPage("Buying isn’t available on this version yet. Everything you have stays yours.")
            }
        }
    }

    // A pending payment Play confirms while this screen is open turns into the thanks by itself (2.1.1: "Plus turns on by itself").
    LaunchedEffect(step, plus.owned) {
        if (step == "pending" && plus.owned != PlusOwned.NONE) {
            accounts.syncPurchases(plus.purchases())
            step = if (plus.owned == PlusOwned.PLUS) (if (accounts.account == null) "thanks-plus" else "done.page") else "thanks-family"
            if (step == "done.page") nav.toPage("Plus is yours. Thank you.")
        }
    }

    when (step) {
        "pending" -> CenterScreen("Waiting for your payment", "Plus turns on as soon as Google Play confirms it.", "Close", "plus-pending", { nav.toPage() })
        "thanks-plus" -> ThanksPlus(accounts, signIn, plus, nav)
        "thanks-family" -> ThanksFamily(accounts, signIn, plus, nav)
        "choose" -> Box(Modifier.fillMaxSize().background(c.screen)) {
            FormPage(if (upgrade) "Plus Family" else "Get Plus", chip = null, onBack = onBack) {
                Spacer(Modifier.height(12.dp))
                Column(verticalArrangement = Arrangement.spacedBy(20.dp)) {
                    Row(Modifier.padding(start = 4.dp), verticalAlignment = Alignment.CenterVertically) {
                        AppIconTile(48.dp)
                        Spacer(Modifier.width(16.dp))
                        Column(Modifier.semantics(mergeDescendants = true) { heading() }, verticalArrangement = Arrangement.spacedBy(2.dp)) {
                            Text(if (upgrade) "Plus Family" else "Plus", style = AppType.titleLargeEmphasized, color = c.ink)
                            Text(if (upgrade) "You have Plus. Pay only the difference." else "One payment, yours forever.", style = AppType.bodyMedium, color = c.secondary)
                        }
                    }
                    if (!upgrade) PlanChoice(plus, family) { family = it }
                    WhiteCard {
                        if (upgrade) {
                            CheckLine("Plus for up to 5 more people")
                            CheckLine("Everyone’s habits stay their own", "Nobody sees anyone else’s.")
                            CheckLine("Invite with a link or a QR code")
                        } else {
                            CheckLine("Unlimited habits")
                            CheckLine("Sync across all your devices", "Through your own Google Drive.")
                            CheckLine("More widgets")
                        }
                        HorizontalDivider(color = c.tonal)
                        WorksOn()
                    }
                }
                Spacer(Modifier.height(with(LocalDensity.current) { bottomHeight.toDp() }))
            }
            Column(Modifier.align(Alignment.BottomCenter).fillMaxWidth()
                // Figma 2: a soft shadow cast upward over the content scrolling under it (0, -4, blur 12, black 6 %).
                .let { if (upgrade) it else it.drawBehind {
                    val h = 16.dp.toPx()
                    drawRect(Brush.verticalGradient(listOf(Color.Transparent, Color.Black.copy(alpha = 0.06f)), startY = -h, endY = 0f),
                        topLeft = Offset(0f, -h), size = Size(size.width, h))
                } }
                .background(c.screen).navigationBarsPadding()
                .padding(start = 16.dp, end = 16.dp, top = if (upgrade) 16.dp else 12.dp, bottom = 8.dp).onSizeChanged { bottomHeight = it.height },
                verticalArrangement = Arrangement.spacedBy(4.dp)) {
                val price = plus.price(product)
                MainButton((if (product == PlusProduct.PLUS) "Get Plus" else "Get Plus Family") + (price?.let { " · $it" } ?: ""), "plus-buy",
                    enabled = plus.canBuy && !buying) { buy() }
                if (!upgrade) QuietButton("I already have Plus", "plus-already", height = 40.dp) { nav.signIn() }
            }
        }
    }
    if (notCompleted) PlusDialog(Symbols.Error, "Payment not completed",
        "Nothing was charged. Check your payment method in Google Play, then try again.", "Try again",
        { notCompleted = false; buy() }, { notCompleted = false }, tag = "dialog-payment")
}

/** Just you or Family: radio rows in one white card, the price on the right (Figma 2's "Choice"). */
@Composable
private fun PlanChoice(plus: PlusStore, family: Boolean, onFamily: (Boolean) -> Unit) {
    val c = appColors
    Column(Modifier.fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(c.surface).padding(vertical = 4.dp).selectableGroup()) {
        for ((i, plan) in listOf(PlusProduct.PLUS, PlusProduct.FAMILY).withIndex()) {
            if (i == 1) HorizontalDivider(color = c.tonal2)
            val selected = family == (plan == PlusProduct.FAMILY)
            Row(Modifier.fillMaxWidth().selectable(selected, role = Role.RadioButton) { onFamily(plan == PlusProduct.FAMILY) }
                .padding(start = 16.dp, end = 20.dp, top = 12.dp, bottom = 12.dp).semantics { testTag = "plan-" + plan.name.lowercase() },
                verticalAlignment = Alignment.CenterVertically) {
                RadioButton(selected, null, colors = RadioButtonDefaults.colors(selectedColor = c.ink, unselectedColor = c.secondary))
                Spacer(Modifier.width(16.dp))
                Column(Modifier.weight(1f)) {
                    Text(if (plan == PlusProduct.PLUS) "Just you" else "Family", style = AppType.titleMedium, color = c.ink)
                    Text(if (plan == PlusProduct.PLUS) "On all your devices" else "You + 5 people", style = AppType.bodyMedium, color = c.secondary)
                }
                Text(plus.price(plan) ?: "—", style = AppType.titleMedium, color = c.ink)
            }
        }
    }
}

private val accountPoints = listOf(
    Point(Symbols.Devices, "Plus on all your devices", "Sign in on your other devices."),
    Point(Symbols.AddToDrive, "Your habits sync through your Google Drive", "They stay in your own Drive. We never see them."),
    Point(Symbols.VerifiedUser, "Your purchase stays safe", "Even if you lose this phone."),
)

/**
 * Signing in to keep a purchase (2.2, 2.6, 6, 8.2): Google's sheet, then the account is found (and the purchase added)
 * or made with it. Returns false when they backed out; "Couldn't connect" is shown by the caller.
 */
private suspend fun signInAndKeep(proof: SignIn, accounts: AccountCenter, plus: PlusStore): Answer<Unit> {
    return when (val reply = accounts.signIn(proof)) {
        Answer.Offline -> Answer.Offline
        is Answer.Ok -> when (reply.value) {
            is SignInReply.Found -> { accounts.syncPurchases(plus.purchases()); Answer.Ok(Unit) }
            SignInReply.NoAccount -> if (accounts.create(proof, plus.purchases()) is Answer.Ok) Answer.Ok(Unit) else Answer.Offline
        }
    }
}

/** 2.2 · Plus is yours: keep it on all your devices? (an account, optional; Not now: 1.2). */
@Composable
private fun ThanksPlus(accounts: AccountCenter, signIn: SignInProvider, plus: PlusStore, nav: PlusFlowNav) {
    val activity = LocalActivity.current
    val scope = rememberCoroutineScope()
    var offline by rememberSaveable { mutableStateOf(false) }
    FlowScreen(onBack = { nav.toPage() }, tag = "plus-thanks", showBack = false, bottom = {
        BottomNote("Without an account, Plus stays with your Google Play account, on Android only. You can create one later.")
        ContinueWith(google = true, tag = "thanks-google") {
            scope.launch {
                val proof = activity?.let { signIn.google(it) } ?: return@launch
                if (signInAndKeep(proof, accounts, plus) is Answer.Ok) nav.toPage() else offline = true
            }
        }
        QuietButton("Not now", "thanks-not-now") { nav.toPage() }
    }) {
        Hero(HeroArt.AppIcon, "Plus is yours.", "Thank you. Keep it on all your devices with an account.")
        Spacer(Modifier.height(28.dp))
        PointsCard(accountPoints)
    }
    if (offline) PlusDialog(Symbols.WifiOff, "Couldn’t connect", "We couldn’t reach Google. Check your internet connection, then try again.",
        "OK", { offline = false }, { offline = false }, dismiss = "", tag = "dialog-offline")
}

/**
 * 2.6 / 8.2 · Plus Family is yours: inviting needs an account, so sign in (no Not now); with an account already, Done.
 */
@Composable
private fun ThanksFamily(accounts: AccountCenter, signIn: SignInProvider, plus: PlusStore, nav: PlusFlowNav) {
    val activity = LocalActivity.current
    val scope = rememberCoroutineScope()
    var offline by rememberSaveable { mutableStateOf(false) }
    val signedIn = accounts.account != null
    FlowScreen(onBack = { nav.toPage() }, tag = "plus-family-thanks", showBack = false, bottom = {
        if (signedIn) MainButton("Done", "family-thanks-done") { nav.toPage() }
        else {
            BottomNote("Your account holds your purchase and your family, never your habits.")
            ContinueWith(google = true, tag = "family-thanks-google") {
                scope.launch {
                    val proof = activity?.let { signIn.google(it) } ?: return@launch
                    if (signInAndKeep(proof, accounts, plus) is Answer.Ok) nav.toPage() else offline = true
                }
            }
        }
    }) {
        Hero(HeroArt.AppIcon, "Plus Family is yours.", if (signedIn) "Thank you. Invite people from Your family." else "Thank you. Sign in to invite people to your family.")
        Spacer(Modifier.height(28.dp))
        PointsCard(listOf(
            Point(Symbols.GroupAdd, "Invite up to 5 people", "With a link or a QR code."),
            Point(Symbols.VisibilityOff, "Everyone’s habits stay their own", "Nobody sees anyone else’s."),
            Point(Symbols.AddToDrive, "Your habits sync through your Google Drive", "We never see them."),
        ))
    }
    if (offline) PlusDialog(Symbols.WifiOff, "Couldn’t connect", "We couldn’t reach Google. Check your internet connection, then try again.",
        "OK", { offline = false }, { offline = false }, dismiss = "", tag = "dialog-offline")
}

// ==================================================================== 6 · Create an account

/** 6 · Create an account (from Plus, no account yet): Google's sheet, then Plus & Account with the account (1.3). */
@Composable
fun CreateAccountScreen(accounts: AccountCenter, signIn: SignInProvider, plus: PlusStore, nav: PlusFlowNav, onBack: () -> Unit) {
    val activity = LocalActivity.current
    val scope = rememberCoroutineScope()
    var offline by rememberSaveable { mutableStateOf(false) }
    FlowScreen(onBack = onBack, tag = "account-create", bottom = {
        ContinueWith(google = true, tag = "create-google") {
            scope.launch {
                val proof = activity?.let { signIn.google(it) } ?: return@launch
                if (signInAndKeep(proof, accounts, plus) is Answer.Ok) nav.toPage() else offline = true
            }
        }
    }) {
        Hero(HeroArt.AppIcon, "Create an account.", "It takes Plus to all your devices.")
        Spacer(Modifier.height(28.dp))
        PointsCard(accountPoints)
    }
    if (offline) PlusDialog(Symbols.WifiOff, "Couldn’t connect", "We couldn’t reach Google. Check your internet connection, then try again.",
        "OK", { offline = false }, { offline = false }, dismiss = "", tag = "dialog-offline")
}

// ==================================================================== 3 · Sign in (to bring Plus back)

/**
 * 3 · Sign in, then 3.2 Looking for your Plus, 3.3 Plus is back, 3.4 No account found or 3.5 Couldn't connect. With
 * [onSignedIn], the flow hands the account on instead of finishing (joining a family, 5.1).
 */
@Composable
fun SignInFlow(
    accounts: AccountCenter, signIn: SignInProvider, plus: PlusStore, nav: PlusFlowNav, onBack: () -> Unit,
    join: String? = null, onSignedIn: (() -> Unit)? = null,
) {
    val activity = LocalActivity.current
    val scope = rememberCoroutineScope()
    var step by rememberSaveable { mutableStateOf("start") }
    var email by rememberSaveable { mutableStateOf("") }
    var with by rememberSaveable { mutableStateOf(SignInWith.GOOGLE) }
    var job by androidx.compose.runtime.remember { mutableStateOf<Job?>(null) }
    var lastProof by androidx.compose.runtime.remember { mutableStateOf<SignIn?>(null) }

    fun look(proof: SignIn) {
        lastProof = proof; email = proof.email; with = proof.with; step = "looking"
        job = scope.launch {
            when (val reply = accounts.signIn(proof)) {
                Answer.Offline -> step = "offline"
                is Answer.Ok -> when (reply.value) {
                    is SignInReply.Found -> { accounts.syncPurchases(plus.purchases()); if (onSignedIn != null) onSignedIn() else step = "found" }
                    // Joining a family needs only an account: a free one is made for them (5.1 → 5.2).
                    SignInReply.NoAccount -> if (onSignedIn != null) {
                        if (accounts.create(proof, plus.purchases()) is Answer.Ok) onSignedIn() else step = "offline"
                    } else step = "none"
                }
            }
        }
    }
    fun choose(google: Boolean) {
        val a = activity ?: return
        scope.launch { (if (google) signIn.google(a) else signIn.apple(a))?.let(::look) }
    }

    when (step) {
        "looking" -> CenterScreen("Looking for your Plus", "Signed in with " + (if (with == SignInWith.GOOGLE) "Google" else "Apple"), "Cancel", "signin-looking",
            { job?.cancel(); step = "start" })
        "offline" -> CenterScreen("Couldn’t connect", "We couldn’t reach " + (if (with == SignInWith.GOOGLE) "Google" else "Apple") + ". Check your internet connection, then try again.",
            "Cancel", "signin-offline", { step = "start" }, icon = Symbols.WifiOff, main = "Try again", onMain = { lastProof?.let(::look) ?: run { step = "start" } })
        "found" -> {
            val account = accounts.account
            FlowScreen(onBack = { nav.toPage() }, tag = "signin-found", showBack = false, bottom = { MainButton("Done", "signin-done") { nav.toPage() } }) {
                Hero(HeroArt.AppIcon, if (account?.givesPlus == true) "Plus is back." else "You’re signed in.", "Signed in as $email.")
                Spacer(Modifier.height(28.dp))
                PointsCard(listOf(
                    Point(Symbols.Devices, "Plus on all your devices", "Sign in on each one the same way."),
                    Point(Symbols.AddToDrive, "Your habits sync through Drive", "We never see them."),
                ))
            }
        }
        "none" -> NoAccountFound(email, onBack = { step = "start" }, onGoogle = { choose(true) }, onApple = { choose(false) }, onGetPlus = nav::getPlus)
        else -> FlowScreen(onBack = onBack, tag = if (join != null) "join-sign-in" else "signin-start", bottom = {
            BottomNote("Made your account on an iPhone? Sign in the same way you did there.")
            ContinueWith(google = true, tag = "signin-google") { choose(true) }
            ContinueWith(google = false, tag = "signin-apple") { choose(false) }
        }) {
            if (join != null) {
                Hero(HeroArt.Cookie(Icons.Rounded.GroupAdd), "Sign in to join.", "$join’s family shares Plus with you.")
                Spacer(Modifier.height(28.dp))
                PointsCard(listOf(
                    Point(null, "Plus on all your devices", "At no cost to you."),
                    Point(Symbols.AccountCircle, "Your account keeps your place", "Sign in anywhere and Plus is there."),
                    Point(Symbols.VisibilityOff, "Your habits stay your own", "$join never sees them."),
                ))
            } else {
                Hero(HeroArt.Cookie(Icons.AutoMirrored.Rounded.Login), "Sign in.", "Bring Plus back from your account.")
                Spacer(Modifier.height(28.dp))
                PointsCard(listOf(
                    Point(null, "Plus comes back", "On this phone and your others."),
                    Point(Symbols.Group, "Your family too", "If you’re in a Plus Family."),
                    Point(Symbols.AddToDrive, "Your habits stay in your Drive", "Your account never holds them."),
                ))
            }
        }
    }
}

/** 3.4 · No account found: try another Google account, Apple, or get Plus. */
@Composable
private fun NoAccountFound(email: String, onBack: () -> Unit, onGoogle: () -> Unit, onApple: () -> Unit, onGetPlus: () -> Unit) {
    val c = appColors
    FlowScreen(onBack = onBack, tag = "signin-none", top = true) {
        Column(Modifier.fillMaxWidth().padding(horizontal = 8.dp), verticalArrangement = Arrangement.spacedBy(8.dp)) {
            Text("No account found.", Modifier.semantics { heading() }, style = AppType.headlineMediumEmphasized, color = c.ink)
            Text("No Plus account uses $email.", style = AppType.bodyLarge, color = c.secondary)
        }
        Spacer(Modifier.height(24.dp))
        Column(Modifier.fillMaxWidth(), verticalArrangement = Arrangement.spacedBy(12.dp)) {
            Text("Try another account", Modifier.padding(start = 16.dp), style = AppType.labelLarge, color = c.secondary)
            SegmentedList {
                LogoRow(0, 2, "Another Google account", "Choose a different one", "none-google", onGoogle) { Image(painterResource(R.drawable.ic_google_logo), null, Modifier.size(20.dp)) }
                LogoRow(1, 2, "Continue with Apple", "If you made it with Apple", "none-apple", onApple) {
                    Image(painterResource(R.drawable.ic_apple_logo), null, Modifier.size(width = 17.dp, height = 21.dp), colorFilter = ColorFilter.tint(c.ink))
                }
            }
            Text("Don’t have Plus?", Modifier.padding(start = 16.dp), style = AppType.labelLarge, color = c.secondary)
            SegmentedList { LogoRow(0, 1, "Get Plus", "One payment, yours forever", "none-get-plus", onGetPlus, disc = false) { MarkIcon(40.dp) } }
        }
    }
}

@Composable
private fun LogoRow(index: Int, count: Int, title: String, line: String, tag: String, onClick: () -> Unit, disc: Boolean = true, logo: @Composable () -> Unit) {
    val c = appColors
    // Figma 3.4's "Choice · …": 16 around, 12 at the chevron's side, as Plus & Account's rows.
    Row(Modifier.fillMaxWidth().clip(segmentShape(index, count)).background(c.surface).clickable(onClick = onClick)
        .padding(start = 16.dp, end = 12.dp, top = 16.dp, bottom = 16.dp).semantics(mergeDescendants = true) { testTag = tag },
        verticalAlignment = Alignment.CenterVertically, horizontalArrangement = Arrangement.spacedBy(16.dp)) {
        Box(Modifier.size(40.dp).clip(CircleShape).background(if (disc) c.tonal else androidx.compose.ui.graphics.Color.Transparent), contentAlignment = Alignment.Center) { logo() }
        Column(Modifier.weight(1f), verticalArrangement = Arrangement.spacedBy(2.dp)) {
            Text(title, style = AppType.titleMedium, color = c.ink)
            Text(line, style = AppType.bodyMedium, color = c.secondary)
        }
        Icon(Symbols.ChevronRight, null, Modifier.size(24.dp), tint = c.secondary)
    }
}

// ==================================================================== 4 · Restore from Google Play

/** 4 · Looking for your purchase, then 4.1 Plus is back, 4.2 No Plus found (over the page) or 4.3 Couldn't connect. */
@Composable
fun RestoreFlow(plus: PlusStore, accounts: AccountCenter, nav: PlusFlowNav) {
    var step by rememberSaveable { mutableStateOf("looking") }
    var attempt by rememberSaveable { mutableIntStateOf(0) }
    LaunchedEffect(attempt) {
        if (step != "looking") return@LaunchedEffect
        when (plus.restore()) {
            RestoreResult.FOUND -> { accounts.syncPurchases(plus.purchases()); step = "found" }
            RestoreResult.NONE -> nav.toPageNoPlusFound()
            RestoreResult.COULD_NOT_CONNECT -> step = "offline"
        }
    }
    when (step) {
        "found" -> FlowScreen(onBack = { nav.toPage() }, tag = "restore-found", showBack = false, bottom = { MainButton("Done", "restore-done") { nav.toPage() } }) {
            Hero(HeroArt.AppIcon, "Plus is back.", "Bought with this Google account.")
            Spacer(Modifier.height(28.dp))
            PointsCard(listOf(
                Point(Symbols.Devices, "Plus on your Android devices", "With this Google account."),
                Point(Symbols.PersonAdd, "Want it on an iPhone or iPad too?", "Create one in Plus & Account."),
            ))
        }
        "offline" -> CenterScreen("Couldn’t connect", "We couldn’t reach Google Play. Check your internet connection, then try again.", "Cancel", "restore-offline",
            { nav.toPage() }, icon = Symbols.WifiOff, main = "Try again", onMain = { step = "looking"; attempt++ })
        else -> CenterScreen("Looking for your purchase", "On this Google account", "Cancel", "restore-looking", { nav.toPage() })
    }
}

// ==================================================================== 5 · Join a family, and opening an invite

/** 5 · Join a family (from the menu): the link opens here by itself; with them, scan their code (Google's scanner). */
@Composable
fun JoinFamilyScreen(onScanned: (String) -> Unit, onBack: () -> Unit) {
    val context = LocalContext.current
    var notOurs by rememberSaveable { mutableStateOf(false) }
    FlowScreen(onBack = onBack, tag = "join-family", bottom = {
        MainButton("Scan QR code", "join-scan", Symbols.QrCodeScanner, iconSize = 20.dp) {
            // Google's code scanner: its own camera screen, no camera permission for the app.
            com.google.mlkit.vision.codescanner.GmsBarcodeScanning.getClient(context,
                com.google.mlkit.vision.codescanner.GmsBarcodeScannerOptions.Builder()
                    .setBarcodeFormats(com.google.mlkit.vision.barcode.common.Barcode.FORMAT_QR_CODE).build())
                .startScan()
                .addOnSuccessListener { code -> InviteLink.token(code.rawValue)?.let(onScanned) ?: run { notOurs = true } }
        }
    }) {
        Hero(HeroArt.Cookie(Icons.Rounded.QrCodeScanner), "Join a family.", "Use the invite you were sent.")
        Spacer(Modifier.height(28.dp))
        PointsCard(listOf(
            Point(Symbols.Link, "Got a link?", "Tap it on this phone. It opens here."),
            Point(Symbols.QrCodeScanner, "With them?", "Scan the code on their phone."),
        ))
    }
    if (notOurs) PlusDialog(Symbols.LinkOff, "Not an invite", "That code isn’t an Often Enough invite. Ask for the code in their Plus & Account.",
        "OK", { notOurs = false }, { notOurs = false }, dismiss = "", tag = "dialog-not-invite")
}

/**
 * An invite opened (a link, or a scanned code): 5.1 sign in to join, 5.2 Join Lee's family?, or why it can't be used
 * (5.3 ended, 5.4 used, 5.5 cancelled, 5.6 full, 5.7 you have Plus, 5.8 already in a family).
 */
@Composable
fun InviteFlow(token: String, plus: PlusStore, accounts: AccountCenter, signIn: SignInProvider, nav: PlusFlowNav) {
    val scope = rememberCoroutineScope()
    var look by androidx.compose.runtime.remember { mutableStateOf<InviteLook?>(null) }
    var state by rememberSaveable { mutableStateOf("looking") }
    var attempt by rememberSaveable { mutableIntStateOf(0) }
    var joining by rememberSaveable { mutableStateOf(false) }
    var joinAnyway by rememberSaveable { mutableStateOf(false) }
    LaunchedEffect(attempt) {
        state = "looking"
        when (val r = accounts.lookInvite(token)) {
            Answer.Offline -> state = "offline"
            is Answer.Ok -> { look = r.value; state = if (r.value == null) "unknown" else "ready" }
        }
    }
    fun join() {
        if (joining) return
        scope.launch {
            joining = true
            val r = accounts.join(token)
            joining = false
            when {
                r == Answer.Offline -> state = "offline"
                accounts.account?.plus == AccountPlus.FAMILY_MEMBER -> nav.toPage("You joined ${look?.ownerName ?: ""}’s family.")
                else -> attempt++
            }
        }
    }
    val owner = look?.ownerName ?: ""
    val account = accounts.account
    when {
        state == "looking" -> CenterScreen("Opening the invite", "Checking it with your family’s account", "Cancel", "invite-looking", { nav.toPage() })
        state == "offline" -> CenterScreen("Couldn’t connect", "We couldn’t open the invite. Check your internet connection, then try again.", "Cancel", "invite-offline",
            { nav.toPage() }, icon = Symbols.WifiOff, main = "Try again", onMain = { attempt++ })
        state == "unknown" -> Ended(Icons.Rounded.LinkOff, "This invite doesn’t work.", "Check the link, or ask for a new one.", "invite-unknown", nav)
        look is InviteLook.Ended -> Ended(Icons.Rounded.TimerOff, "This invite has ended.", "Invites work for 7 days. Ask $owner for a new one.", "invite-ended", nav)
        look is InviteLook.Used -> Ended(Icons.Rounded.LinkOff, "This invite was already used.", "Each invite works once. Ask $owner for a new one.", "invite-used", nav)
        look is InviteLook.Cancelled -> Ended(Icons.Rounded.Cancel, "Invite cancelled.", "$owner cancelled it. To join, ask $owner for a new one.", "invite-cancelled", nav)
        look is InviteLook.Full -> Ended(Icons.Rounded.Group, "$owner’s family is full.", "It already has 6 people. $owner can make room in Plus & Account.", "invite-full", nav)
        account == null -> SignInFlow(accounts, signIn, plus, nav, onBack = { nav.toPage() }, join = owner, onSignedIn = { attempt++ })
        account.plus == AccountPlus.FAMILY_MEMBER && account.family?.ownerName != owner -> FlowScreen(onBack = { nav.toPage() }, tag = "invite-in-family", bottom = {
            MainButton("Leave and join $owner’s", "invite-leave-join", enabled = !joining) { join() }
            QuietButton("Not now", "invite-not-now") { nav.toPage() }
        }) {
            Hero(HeroArt.Cookie(Icons.Rounded.Groups), "Already in a family.", "You’re in ${account.family?.ownerName}’s family. Leave it to join $owner’s. Your habits stay with you.")
        }
        (account.plus == AccountPlus.PLUS || account.plus == AccountPlus.FAMILY_OWNER || plus.owned != PlusOwned.NONE) && !joinAnyway
            && account.plus != AccountPlus.FAMILY_MEMBER -> FlowScreen(onBack = { nav.toPage() }, tag = "invite-have-plus", bottom = {
            MainButton("Done", "invite-done") { nav.toPage() }
            if (account.plus != AccountPlus.FAMILY_OWNER) QuietButton("Join anyway", "invite-join-anyway") { joinAnyway = true }
        }) {
            Hero(HeroArt.AppIcon, "You have Plus.", "You don’t need $owner’s family for it. Keep the place for someone else?")
        }
        else -> FlowScreen(onBack = { nav.toPage() }, tag = "invite-join", bottom = {
            MainButton("Join family", "invite-join-family", enabled = !joining) { join() }
            QuietButton("Not now", "invite-not-now") { nav.toPage() }
        }) {
            Hero(HeroArt.Cookie(Icons.Rounded.Group), "Join $owner’s family?", "$owner invited you to share Plus.")
            Spacer(Modifier.height(28.dp))
            PointsCard(listOf(
                Point(null, "Plus on all your devices", "Unlimited habits, at no cost to you."),
                Point(Symbols.VisibilityOff, "Your habits stay private", "Neither of you sees the other’s."),
                Point(Symbols.Logout, "Leave whenever you like", "Your habits stay with you."),
            ))
        }
    }
}

/** An invite that can't be used: why, and Done (Figma 5.3–5.6). */
@Composable
private fun Ended(icon: androidx.compose.ui.graphics.vector.ImageVector, title: String, line: String, tag: String, nav: PlusFlowNav) {
    FlowScreen(onBack = { nav.toPage() }, tag = tag, bottom = { MainButton("Done", "$tag-done") { nav.toPage() } }) {
        Hero(HeroArt.Cookie(icon), title, line)
    }
}
