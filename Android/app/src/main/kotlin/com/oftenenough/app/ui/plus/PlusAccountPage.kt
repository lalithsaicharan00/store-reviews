package com.oftenenough.app.ui.plus

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.rounded.ArrowForward
import androidx.compose.material.icons.automirrored.outlined.Login
import androidx.compose.material.icons.automirrored.outlined.Logout
import androidx.compose.material.icons.outlined.AddToDrive
import androidx.compose.material.icons.outlined.CloudOff
import androidx.compose.material.icons.outlined.DeleteForever
import androidx.compose.material.icons.outlined.Group
import androidx.compose.material.icons.outlined.GroupAdd
import androidx.compose.material.icons.outlined.GroupRemove
import androidx.compose.material.icons.outlined.LinkOff
import androidx.compose.material.icons.outlined.Person
import androidx.compose.material.icons.outlined.PersonAdd
import androidx.compose.material.icons.outlined.PersonRemove
import androidx.compose.material.icons.outlined.ScheduleSend
import androidx.compose.material.icons.outlined.Share
import androidx.compose.material.icons.outlined.Redeem
import androidx.compose.material.icons.outlined.Shop
import androidx.compose.material.icons.outlined.SearchOff
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.LinearProgressIndicator
import androidx.compose.material3.ModalBottomSheet
import androidx.compose.material3.SnackbarHostState
import androidx.compose.material3.Text
import androidx.compose.material3.rememberModalBottomSheetState
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.semantics.heading
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import com.oftenenough.app.app.PlusOwned
import com.oftenenough.app.app.PlusProduct
import com.oftenenough.app.app.PlusStore
import com.oftenenough.app.app.account.Account
import com.oftenenough.app.app.account.AccountCenter
import com.oftenenough.app.app.account.AccountPlus
import com.oftenenough.app.app.account.Answer
import com.oftenenough.app.app.account.Family
import com.oftenenough.app.app.account.FamilyPerson
import com.oftenenough.app.app.account.SignInProvider
import com.oftenenough.app.app.backup.BackupCenter
import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.ui.components.ListRow
import com.oftenenough.app.ui.components.SegmentedList
import com.oftenenough.app.ui.components.TonalButton
import com.oftenenough.app.ui.newhabit.FormPage
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors
import kotlinx.coroutines.launch

/** Where Plus & Account's rows go. */
interface PlusNav {
    fun seePlus()
    fun upgradeToFamily()
    fun signIn()
    fun restore()
    fun joinFamily()
    fun createAccount()
    fun backup()
    fun back()
}

/** Which of the page's states it's in (Figma 1, 1.1–1.5), from Play and the account. */
enum class PlusState { FREE, PLUS_NO_ACCOUNT, PLUS, FAMILY_OWNER, FAMILY_MEMBER, FREE_SIGNED_IN }

fun plusState(plus: PlusStore, account: Account?, fromCode: Boolean = false): PlusState = when {
    account?.plus == AccountPlus.FAMILY_OWNER -> PlusState.FAMILY_OWNER
    account?.plus == AccountPlus.FAMILY_MEMBER -> PlusState.FAMILY_MEMBER
    account?.plus == AccountPlus.PLUS -> PlusState.PLUS
    account != null && (plus.owned != PlusOwned.NONE || fromCode) -> PlusState.PLUS
    account != null -> PlusState.FREE_SIGNED_IN
    plus.owned != PlusOwned.NONE || fromCode -> PlusState.PLUS_NO_ACCOUNT
    else -> PlusState.FREE
}

/**
 * ≡ › Plus & Account (Figma 1476:2; W6: what people want to see here is what they have, then what they can do). The
 * state card first (Free, or Plus is yours and who's signed in), then Backup, Your family, and the ways back to a Plus
 * bought elsewhere. Every place the account appears says it holds only the purchase and the family, never habits (D16).
 * [restoreFoundNothing] is set by Restore from Google Play when Play found nothing (Figma 4.2, shown over this page).
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun PlusAccountPage(
    store: HabitStore, plus: PlusStore, accounts: AccountCenter, signIn: SignInProvider, backup: BackupCenter,
    snackbar: SnackbarHostState, nav: PlusNav, restoreFoundNothing: Boolean = false, onRestoreDialogSeen: () -> Unit = {},
    codes: com.oftenenough.app.app.PlusCodes? = null,
) {
    val c = appColors
    val scope = rememberCoroutineScope()
    val activity = androidx.activity.compose.LocalActivity.current
    val account = accounts.account
    val state = plusState(plus, account, codes?.redeemed == true)
    var dialog by rememberSaveable { mutableStateOf<String?>(null) }
    var sheet by rememberSaveable { mutableStateOf<String?>(null) }
    var removing by rememberSaveable { mutableStateOf<String?>(null) }
    var working by rememberSaveable { mutableStateOf(false) }
    val say: (String) -> Unit = { m -> scope.launch { snackbar.showSnackbar(m) } }
    val offline = "Couldn't connect. Check your internet connection, then try again."
    LaunchedEffect(restoreFoundNothing) { if (restoreFoundNothing) { dialog = "no-plus"; onRestoreDialogSeen() } }
    LaunchedEffect(Unit) { accounts.refresh() }

    FormPage("Plus & Account", chip = null, onBack = nav::back) {
        Spacer(Modifier.height(8.dp))
        StateCard(state, account, store, onSeePlus = nav::seePlus, onCreate = nav::createAccount, onSignOut = { dialog = "sign-out" })
        Spacer(Modifier.height(24.dp))
        Section("Backup", footer = "We never see your habits.") { BackupRow(backup, nav::backup) }
        Spacer(Modifier.height(24.dp))
        when (state) {
            PlusState.FREE, PlusState.FREE_SIGNED_IN -> Section("Your family") {
                SegmentedList { ListRow("Join a family", 0, 1, "Have an invite? Open it or scan it", Icons.Outlined.GroupAdd, iconDisc = true,
                    onClick = nav::joinFamily, modifier = Modifier.semantics { testTag = "plus-join-family" }) }
            }
            PlusState.PLUS_NO_ACCOUNT, PlusState.PLUS -> Section("Your family") {
                if (plus.owned == PlusOwned.FAMILY && account == null) SegmentedList {
                    ListRow("Invite your family", 0, 1, "Create an account first, then invite up to 5 people", Icons.Outlined.GroupAdd, iconDisc = true,
                        onClick = nav::createAccount, modifier = Modifier.semantics { testTag = "plus-invite-needs-account" })
                } else SegmentedList {
                    ListRow("Upgrade to Plus Family", 0, 1, "Add up to 5 people for ${plus.price(PlusProduct.FAMILY_UPGRADE) ?: "the difference"}, the difference",
                        Icons.Outlined.Group, iconDisc = true, onClick = nav::upgradeToFamily, modifier = Modifier.semantics { testTag = "plus-upgrade-family" })
                }
            }
            PlusState.FAMILY_OWNER -> account?.family?.let { family ->
                Section("Your family", footer = "Plus Family · up to 6 people. Each person has their own habits. Nobody sees anyone else’s.") {
                    OwnerRows(family, onPerson = { removing = it.id; dialog = "remove" }, onInviteSent = { sheet = "invite-sent" }, onAdd = {
                        if (!working) scope.launch {
                            working = true
                            when (accounts.invite()) { is Answer.Ok -> sheet = "invite"; Answer.Offline -> say(offline) }
                            working = false
                        }
                    })
                }
            }
            PlusState.FAMILY_MEMBER -> account?.family?.let { family ->
                Section("Your family", footer = "Each person has their own habits. Nobody sees anyone else’s.") {
                    MemberRows(family) { dialog = "leave" }
                }
            }
        }
        if (state == PlusState.FREE) {
            Spacer(Modifier.height(24.dp))
            Section("Already have Plus?", footer = "Plus bought on this Google account also comes back by itself when you open the app.") {
                SegmentedList {
                    ListRow("Sign in", 0, 3, "Bought on an iPhone, or have an account", Icons.AutoMirrored.Outlined.Login, iconDisc = true,
                        onClick = nav::signIn, modifier = Modifier.semantics { testTag = "plus-sign-in" })
                    ListRow("Restore from Google Play", 1, 3, "From this Google account", Icons.Outlined.Shop, iconDisc = true,
                        onClick = nav::restore, modifier = Modifier.semantics { testTag = "plus-restore" })
                    ListRow("Redeem a code", 2, 3, "If you were given one", Icons.Outlined.Redeem, iconDisc = true,
                        onClick = { dialog = "code" }, modifier = Modifier.semantics { testTag = "plus-redeem" })
                }
            }
        }
        if (state == PlusState.FREE_SIGNED_IN) {
            Spacer(Modifier.height(24.dp))
            Section("Already have Plus?", footer = "Plus bought on this Google account also comes back by itself when you open the app.") {
                SegmentedList {
                    ListRow("Restore from Google Play", 0, 2, "From this Google account", Icons.Outlined.Shop, iconDisc = true,
                        onClick = nav::restore, modifier = Modifier.semantics { testTag = "plus-restore" })
                    ListRow("Redeem a code", 1, 2, "If you were given one", Icons.Outlined.Redeem, iconDisc = true,
                        onClick = { dialog = "code" }, modifier = Modifier.semantics { testTag = "plus-redeem" })
                }
            }
        }
        if (account != null) {
            Spacer(Modifier.height(24.dp))
            SegmentedList {
                ListRow("Delete my account…", 0, 1, null, Icons.Outlined.DeleteForever, iconDisc = true, titleColor = c.error, iconTint = c.error, strong = true,
                    onClick = { dialog = "delete" }, chevron = false, modifier = Modifier.semantics { testTag = "plus-delete-account" })
            }
        }
        Spacer(Modifier.height(8.dp))
    }

    // ---------------------------------------------------------------- Dialogs (Figma 7.1–7.10, 4.2)
    val owner = account?.family?.ownerName ?: ""
    when (dialog) {
        "sign-out" -> PlusDialog(Icons.AutoMirrored.Outlined.Logout, "Sign out?", when (state) {
            PlusState.FAMILY_OWNER -> "Plus stays on this phone through Google Play, and your family keeps Plus. Your habits stay here and in your Google Drive."
            PlusState.FAMILY_MEMBER -> "Plus from $owner’s family stops on this phone until you sign in again. Your habits stay on this phone and in your Google Drive."
            PlusState.FREE_SIGNED_IN -> "Your habits stay on this phone and in your Google Drive."
            else -> "Plus stays on this phone through Google Play. Your habits stay here and in your Google Drive."
        }, "Sign out", { dialog = null; accounts.signOut(); say("Signed out") }, { dialog = null }, tag = "dialog-sign-out")
        "delete" -> PlusDialog(Icons.Outlined.DeleteForever, "Delete your account?", when (state) {
            PlusState.FAMILY_OWNER -> "Your account and your family are deleted, so " + familyNames(account?.family) + " Your purchase stays with Google Play, and your habits stay here and in your Google Drive."
            PlusState.FAMILY_MEMBER -> "Your account is deleted and you leave $owner’s family, so Plus stops on this phone. Your habits stay here and in your Google Drive."
            else -> "Your account is deleted. Your purchase stays with Google Play. Your habits stay on this phone and in your Google Drive."
        }, "Delete", {
            dialog = null
            // Google's (or Apple's) own sign-in confirms it's them first (Figma 7.2.1); then the account goes (7.2.2).
            scope.launch {
                val a = accounts.account ?: return@launch
                val proof = activity?.let { if (a.with == com.oftenenough.app.app.account.SignInWith.GOOGLE) signIn.google(it) else signIn.apple(it) } ?: return@launch
                if (!proof.email.equals(a.email, ignoreCase = true)) { say("That’s a different account. Choose ${a.email} to delete it."); return@launch }
                when (val r = accounts.delete(proof)) {
                    is Answer.Ok -> if (r.value) say("Your account was deleted") else say("Your account couldn’t be deleted. Try again.")
                    Answer.Offline -> say(offline)
                }
            }
        }, { dialog = null }, destructive = true, tag = "dialog-delete-account")
        "remove" -> account?.family?.people?.firstOrNull { it.id == removing }?.let { p ->
            PlusDialog(Icons.Outlined.PersonRemove, "Remove ${p.name}?",
                "${p.name} keeps their habits. Plus stops on their devices, and their place opens for someone else.", "Remove", {
                    dialog = null
                    scope.launch { if (accounts.remove(p.id) == Answer.Offline) say(offline) }
                }, { dialog = null }, destructive = true, tag = "dialog-remove")
        }
        "leave" -> PlusDialog(Icons.Outlined.GroupRemove, "Leave $owner’s family?",
            "Your habits stay on this phone and in your Google Drive. Plus stops until you get it again.", "Leave", {
                dialog = null
                scope.launch { if (accounts.leave() == Answer.Offline) say(offline) }
            }, { dialog = null }, destructive = true, tag = "dialog-leave")
        "cancel-invite" -> PlusDialog(Icons.Outlined.LinkOff, "Cancel this invite?",
            "The link and the QR code stop working, and the place is free again.", "Cancel invite", {
                dialog = null; sheet = null
                scope.launch { if (accounts.cancelInvite() == Answer.Offline) say(offline) }
            }, { dialog = null }, dismiss = "Keep it", destructive = true, tag = "dialog-cancel-invite")
        "code" -> RedeemCodeDialog({ code -> codes?.redeem(code) == true }, onDone = { dialog = null; say("Plus is on. Thank you.") }) { dialog = null }
        "no-plus" -> PlusDialog(Icons.Outlined.SearchOff, "No Plus found", "If you bought it on an iPhone, or have an account, sign in instead.",
            "Sign in", { dialog = null; nav.signIn() }, { dialog = null }, tag = "dialog-no-plus")
    }

    // ---------------------------------------------------------------- Sheets (Figma 7, 7.5)
    val invite = account?.family?.invite
    if (sheet != null && invite != null) {
        val context = LocalContext.current
        val sheetState = rememberModalBottomSheetState(skipPartiallyExpanded = true)
        ModalBottomSheet({ sheet = null }, sheetState = sheetState, containerColor = if (c.dark) c.surface else androidx.compose.ui.graphics.Color(0xFFFCFCFD),
            modifier = Modifier.semantics { testTag = "sheet-" + sheet }) {
            val sent = sheet == "invite-sent"
            Column(Modifier.fillMaxWidth().padding(start = 24.dp, end = 24.dp, bottom = 24.dp), verticalArrangement = Arrangement.spacedBy(16.dp),
                horizontalAlignment = Alignment.CenterHorizontally) {
                Column(Modifier.fillMaxWidth(), verticalArrangement = Arrangement.spacedBy(8.dp)) {
                    Text(if (sent) "Invite sent" else "Invite someone", Modifier.semantics { heading() }, style = AppType.headlineSmallEmphasized, color = c.ink)
                    Text(if (sent) "Ends ${DayWords.dayMonth(invite.endsDay.toInt())}. Nobody has used it yet." else "They join with their own account. Their habits stay their own.",
                        style = AppType.bodyMedium, color = c.secondary)
                }
                Column(Modifier.fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(c.screen).padding(start = 16.dp, end = 16.dp, top = 20.dp, bottom = 16.dp),
                    horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.spacedBy(12.dp)) {
                    InviteQr(invite.link)
                    Text("With them? They scan it with their camera.", style = AppType.bodySmall, color = c.secondary, textAlign = TextAlign.Center)
                }
                MainButton(if (sent) "Share again" else "Share invite link", "invite-share", Icons.Outlined.Share) { shareInvite(context, invite.link) }
                if (sent) QuietButton("Cancel invite", "invite-cancel") { dialog = "cancel-invite" }
                Text(if (sent) "It works once. They join with their own account." else "Works once, for 7 days. Cancel it in Your family.",
                    style = AppType.bodySmall, color = c.secondary, textAlign = TextAlign.Center)
            }
        }
    }
}

/** The owner's family loses Plus when the account goes: "Lee loses Plus." / "Lee and Priya lose Plus." */
private fun familyNames(family: Family?): String {
    val others = family?.people?.filter { !it.you }?.map { it.name }.orEmpty()
    return when (others.size) {
        0 -> "nobody else is affected."
        1 -> "${others[0]} loses Plus."
        else -> others.dropLast(1).joinToString(", ") + " and " + others.last() + " lose Plus."
    }
}

private fun shareInvite(context: android.content.Context, link: String) {
    val send = android.content.Intent(android.content.Intent.ACTION_SEND).setType("text/plain")
        .putExtra(android.content.Intent.EXTRA_TEXT, "Join my Plus Family on Often Enough: $link")
    context.startActivity(android.content.Intent.createChooser(send, "Share invite link"))
}

/** The state card: what you have, who's signed in, what the account holds, and the one thing to do next. */
@Composable
private fun StateCard(state: PlusState, account: Account?, store: HabitStore, onSeePlus: () -> Unit, onCreate: () -> Unit, onSignOut: () -> Unit) {
    val c = appColors
    val owner = account?.family?.ownerName ?: ""
    WhiteCard(Modifier.semantics { testTag = "plus-state-" + state.name.lowercase() }) {
        Row(verticalAlignment = Alignment.CenterVertically) {
            AppIconTile(56.dp)
            Spacer(Modifier.width(16.dp))
            Column(Modifier.weight(1f).semantics(mergeDescendants = true) { heading() }) {
                Text(if (state == PlusState.FREE || state == PlusState.FREE_SIGNED_IN) "Free" else "Plus is yours", style = AppType.title20Emphasized, color = c.ink)
                Text(when {
                    account != null -> "Signed in as " + account.email
                    state == PlusState.FREE -> "No sign-in needed"
                    else -> "No account yet"
                }, style = AppType.bodyMedium, color = c.secondary, maxLines = 1, overflow = TextOverflow.MiddleEllipsis)
            }
        }
        Text(when (state) {
            PlusState.FREE -> "An account only keeps a Plus purchase and signs you in on your other devices. Free has nothing to keep, so you don’t need one."
            PlusState.FREE_SIGNED_IN -> "Your account holds no purchase yet; it signs you in on your other devices. Your habits stay in your own Google Drive."
            PlusState.PLUS_NO_ACCOUNT -> "An account keeps Plus on all your devices. It holds only your purchase: your habits stay in your own Google Drive."
            PlusState.PLUS -> "Your account holds only your Plus purchase, so you can sign in on your other devices. Your habits sync through your own Google Drive."
            PlusState.FAMILY_OWNER -> "Your account holds only your Plus purchase and your family, so you can sign in on your other devices. Your habits sync through your own Google Drive."
            PlusState.FAMILY_MEMBER -> "Your account holds only your place in $owner’s family, so you can sign in on your other devices. Your habits sync through your own Google Drive."
        }, style = AppType.bodyMedium, color = c.secondary)
        when (state) {
            PlusState.FREE, PlusState.FREE_SIGNED_IN -> {
                FreeBox(store, onSeePlus)
                if (state == PlusState.FREE_SIGNED_IN) TonalButton("Sign out", onSignOut, Modifier.semantics { testTag = "plus-sign-out" }, icon = Icons.AutoMirrored.Outlined.Logout, height = 40.dp)
            }
            PlusState.PLUS_NO_ACCOUNT -> TonalButton("Create an account", onCreate, Modifier.semantics { testTag = "plus-create-account" }, icon = Icons.Outlined.PersonAdd, height = 40.dp)
            else -> TonalButton("Sign out", onSignOut, Modifier.semantics { testTag = "plus-sign-out" }, icon = Icons.AutoMirrored.Outlined.Logout, height = 40.dp)
        }
    }
}

/** Free: how many of the free habits are used, what Plus adds, and the way to it. */
@Composable
private fun FreeBox(store: HabitStore, onSeePlus: () -> Unit) {
    val c = appColors
    val used = store.activeHabitCount
    val limit = HabitStore.FREE_HABIT_LIMIT
    Column(Modifier.fillMaxWidth().clip(RoundedCornerShape(20.dp)).background(c.screen).padding(16.dp), verticalArrangement = Arrangement.spacedBy(12.dp)) {
        Column(Modifier.semantics(mergeDescendants = true) { testTag = "plus-used" }, verticalArrangement = Arrangement.spacedBy(10.dp)) {
            Row {
                Text("$used of $limit free habits used", Modifier.weight(1f), style = AppType.labelLarge, color = c.ink)
                Text(maxOf(0, limit - used).let { if (it == 0) "None left" else "$it left" }, style = AppType.bodyMedium, color = c.secondary)
            }
            LinearProgressIndicator({ minOf(1f, used / limit.toFloat()) }, Modifier.fillMaxWidth().height(6.dp),
                color = c.ink, trackColor = c.tonal.let { if (c.dark) it else androidx.compose.ui.graphics.Color(0xFFD9D9DE) },
                strokeCap = StrokeCap.Round, gapSize = 0.dp, drawStopIndicator = {})
        }
        Text("Plus gives you unlimited habits, sync across all your devices and more widgets. One payment, yours forever.", style = AppType.bodyMedium, color = c.secondary)
        Button(onSeePlus, Modifier.heightIn(min = 40.dp).semantics { testTag = "plus-see" },
            colors = ButtonDefaults.buttonColors(containerColor = c.ink, contentColor = c.onInk),
            contentPadding = androidx.compose.foundation.layout.PaddingValues(start = 24.dp, end = 16.dp, top = 10.dp, bottom = 10.dp)) {
            Text("See what’s in Plus", style = AppType.labelLarge)
            Spacer(Modifier.width(8.dp))
            Icon(Icons.AutoMirrored.Rounded.ArrowForward, null, Modifier.size(18.dp))
        }
    }
}

/** The Backup row: where the habits are kept, or that they aren't yet (the button opens Backup & Sync's own flow). */
@Composable
private fun BackupRow(backup: BackupCenter, onOpen: () -> Unit) {
    val c = appColors
    val email = backup.link.accountName?.let { n -> Regex("\\((.+)\\)").find(n)?.groupValues?.get(1) ?: n }
    if (email != null) SegmentedList {
        ListRow("Backed up to Google Drive", 0, 1, email, Icons.Outlined.AddToDrive, iconDisc = true, onClick = onOpen,
            modifier = Modifier.semantics { testTag = "plus-backup" })
    } else WhiteCard(Modifier.semantics { testTag = "plus-not-backed-up" }, padding = 16.dp, gap = 12.dp) {
        Row(verticalAlignment = Alignment.CenterVertically) {
            Box(Modifier.size(40.dp).clip(CircleShape).background(c.tonal), contentAlignment = Alignment.Center) {
                Icon(Icons.Outlined.CloudOff, null, Modifier.size(22.dp), tint = c.ink)
            }
            Spacer(Modifier.width(16.dp))
            Column(Modifier.weight(1f)) {
                Text("Not backed up", style = AppType.titleMedium, color = c.ink)
                Text("Only on this phone for now", style = AppType.bodyMedium, color = c.secondary)
            }
        }
        TonalButton("Back up to Google Drive", onOpen, Modifier.fillMaxWidth().padding(start = 56.dp), icon = Icons.Outlined.AddToDrive, height = 40.dp)
    }
}

/** A labelled group: "Backup", "Your family"; an optional footer under it. */
@Composable
private fun Section(label: String, footer: String? = null, content: @Composable () -> Unit) {
    val c = appColors
    Column(Modifier.fillMaxWidth(), verticalArrangement = Arrangement.spacedBy(8.dp)) {
        Text(label, Modifier.padding(start = 16.dp).semantics { heading() }, style = AppType.labelLarge, color = c.secondary)
        content()
        if (footer != null) Text(footer, Modifier.padding(horizontal = 16.dp), style = AppType.bodySmall, color = c.secondary)
    }
}

/** The owner's family: You, each person (tap to remove), the waiting invite, and Add a person while there's room. */
@Composable
private fun OwnerRows(family: Family, onPerson: (FamilyPerson) -> Unit, onInviteSent: () -> Unit, onAdd: () -> Unit) {
    val rows = family.people.size + (if (family.invite != null) 1 else 0) + (if (family.placesFree > 0) 1 else 0)
    var i = 0
    SegmentedList(Modifier.semantics { testTag = "plus-family" }) {
        for (p in family.people) {
            val index = i++
            if (p.you) ListRow("You", index, rows, "Owner", Icons.Outlined.Person, iconDisc = true)
            else ListRow(p.name, index, rows, joined(p), Icons.Outlined.Person, iconDisc = true, onClick = { onPerson(p) },
                modifier = Modifier.semantics { testTag = "family-person-" + p.name })
        }
        family.invite?.let { inv ->
            ListRow("Invite sent", i++, rows, "Ends " + DayWords.dayMonth(inv.endsDay.toInt()), Icons.Outlined.ScheduleSend, iconDisc = true,
                onClick = onInviteSent, modifier = Modifier.semantics { testTag = "family-invite-sent" })
        }
        if (family.placesFree > 0) ListRow("Add a person", i, rows, "${family.placesFree} " + (if (family.placesFree == 1) "place" else "places") + " free",
            Icons.Outlined.PersonAdd, iconDisc = true, onClick = onAdd, modifier = Modifier.semantics { testTag = "family-add" })
    }
}

/** A member's view: the owner, everyone in it, and Leave. */
@Composable
private fun MemberRows(family: Family, onLeave: () -> Unit) {
    val rows = family.people.size + 1
    SegmentedList(Modifier.semantics { testTag = "plus-family" }) {
        family.people.forEachIndexed { i, p ->
            ListRow(if (p.you) "You" else p.name, i, rows, if (p.owner) "Owner" else joined(p), Icons.Outlined.Person, iconDisc = true)
        }
        ListRow("Leave ${family.ownerName}’s family", family.people.size, rows, "Your habits stay; only Plus stops", Icons.Outlined.GroupRemove, iconDisc = true,
            onClick = onLeave, chevron = false, modifier = Modifier.semantics { testTag = "family-leave" })
    }
}

private fun joined(p: FamilyPerson) = p.joinedDay?.let { "Joined " + DayWords.dayMonth(it.toInt()) } ?: ""

/** Redeem a code: type it, and Plus turns on when it's one of ours; a wrong code says so and keeps what was typed. */
@Composable
private fun RedeemCodeDialog(redeem: (String) -> Boolean, onDone: () -> Unit, onDismiss: () -> Unit) {
    val c = appColors
    var code by rememberSaveable { mutableStateOf("") }
    var wrong by rememberSaveable { mutableStateOf(false) }
    val submit = { if (redeem(code)) onDone() else wrong = true }
    androidx.compose.material3.AlertDialog(onDismiss,
        modifier = Modifier.semantics { testTag = "dialog-code" },
        icon = { Icon(Icons.Outlined.Redeem, null, tint = c.secondary) },
        title = { Text("Redeem a code", style = AppType.headlineSmall, color = c.ink, modifier = Modifier.fillMaxWidth()) },
        text = {
            Column(verticalArrangement = Arrangement.spacedBy(12.dp)) {
                Text("A code turns on Plus on this phone.", style = AppType.bodyMedium, color = c.secondary)
                androidx.compose.material3.OutlinedTextField(code, { code = it.take(40); wrong = false }, Modifier.fillMaxWidth().semantics { testTag = "code-field" },
                    textStyle = AppType.bodyLarge, singleLine = true, label = { Text("Code", style = AppType.bodySmall) },
                    isError = wrong, supportingText = if (wrong) ({ Text("That code doesn’t work. Check it and try again.", style = AppType.bodySmall) }) else null,
                    keyboardOptions = androidx.compose.foundation.text.KeyboardOptions(capitalization = androidx.compose.ui.text.input.KeyboardCapitalization.Characters,
                        autoCorrectEnabled = false, imeAction = androidx.compose.ui.text.input.ImeAction.Done),
                    keyboardActions = androidx.compose.foundation.text.KeyboardActions(onDone = { if (code.isNotBlank()) submit() }))
            }
        },
        confirmButton = {
            androidx.compose.material3.TextButton(submit, Modifier.semantics { testTag = "dialog-code-confirm" }, enabled = code.isNotBlank()) {
                Text("Redeem", style = AppType.labelLarge, color = c.ink)
            }
        },
        dismissButton = { androidx.compose.material3.TextButton(onDismiss) { Text("Cancel", style = AppType.labelLarge, color = c.ink) } },
        containerColor = if (c.dark) c.surface else androidx.compose.ui.graphics.Color(0xFFF4F4F6),
    )
}
