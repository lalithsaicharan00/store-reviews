// TO BE DELETED (the user, 21 Oct 2026): no accounts; Plus moves between iPhone and Android by hand. The server side was deleted the same day (account-server/README.md, "The accounts, deleted 21 Oct 2026").
package app.habits.account

/*
 * The Plus account, shared by the Android app, the iPhone and the Watch (Rulebook D16; Current Work 110; moved from
 * Android's `app/account/` on 16 Oct 2026 so every platform runs one copy). Only Plus has an account (the user, 16 Oct
 * 2026): it holds the purchase, the family and which cloud holds the habits, never a habit. It is made only with Google
 * or Apple (no email, no password). The server is one Cloudflare Worker (`account-server/`): [HttpAccountServer].
 *
 * What stays with each platform: Google's or Apple's sign-in sheet (it hands over a [SignIn]), the store's purchase
 * sheet (it hands over a [StorePurchase]), sending an HTTP request ([AccountHttp]), where the account is saved
 * ([AccountStorage]) and how a screen redraws when it changes ([AccountHolder]).
 */

enum class SignInWith { GOOGLE, APPLE }

/** What the account gives: nothing (yet), its own Plus, a family it owns, or a place in one. */
enum class AccountPlus { NONE, PLUS, FAMILY_OWNER, FAMILY_MEMBER }

/** Plus Family is the buyer and 5 more, six in all (the user, 14 Oct 2026). */
const val FAMILY_SIZE = 6

/** How long an invite works (Figma 7: "Works once, for 7 days"). */
const val INVITE_DAYS = 7

data class FamilyPerson(val id: String, val name: String, val owner: Boolean, val you: Boolean, val joinedDay: Long?)

/** One single-use invite: a link, shown as a QR code too, that ends after [INVITE_DAYS]. */
data class FamilyInvite(val token: String, val link: String, val endsDay: Long)

data class Family(val ownerName: String, val people: List<FamilyPerson>, val invite: FamilyInvite?) {
    /** Places left to invite into: six, less the people in it and an invite waiting. */
    val placesFree: Int get() = (FAMILY_SIZE - people.size - (if (invite != null) 1 else 0)).coerceAtLeast(0)
}

/** Which cloud holds the habits (D16): a Google Drive, or an iCloud (which only an iPhone, iPad or Mac can open). */
enum class CloudKind { GOOGLE_DRIVE, ICLOUD }

/** The kind of device that last synced there ("from an iPhone"). */
enum class CloudDevice { ANDROID, IPHONE, IPAD }

/**
 * Where a device keeps the habits: the cloud and its account's private ID, exactly as the device's sync binds to it
 * ([key]: "gdrive:" and [CloudKeys.googleDrive], or "icloud:" and CloudKit's user record name). Never an email.
 */
data class CloudPlace(val kind: CloudKind, val key: String, val device: CloudDevice)

/**
 * Where the account says the habits live (D16, Current Work 138), as the last device to sync there said: the place,
 * when ([syncedAt], epoch ms), and whether it's a Google Drive of the very Google account the account signs in with
 * ([signInAccount]: a new phone signed in with that account goes straight there, with no chooser).
 */
data class CloudRecord(val place: CloudPlace, val syncedAt: Long, val signInAccount: Boolean)

/**
 * The private ID a device's sync gives a cloud account. Google Drive: "gdrive:" and the SHA-256 (hex) of "google:" and
 * Google's fixed account ID (`sub`), the same on every device and on the Worker (`googleDriveKey`), so the account can
 * tell its own Google account's Drive without keeping anything more. An email is never a key.
 */
object CloudKeys {
    fun googleDrive(googleId: String): String = "gdrive:" + app.habits.core.Sha256.digest(("google:$googleId").encodeToByteArray())
        .joinToString("") { (it.toInt() and 0xff).toString(16).padStart(2, '0') }
}

/**
 * The signed-in account, as this device keeps it. [email] is shown on this device only ("Signed in as …"); the server
 * keeps Google's or Apple's fixed account ID and a masked hint, never the full email (D16). [session] is this device's
 * sign-in with the Worker, sent with every call (empty with the stand-in). [cloud]: where the habits live, null before
 * any device has said.
 */
data class Account(
    val id: String, val with: SignInWith, val email: String, val plus: AccountPlus, val family: Family?, val session: String = "",
    val cloud: CloudRecord? = null,
) {
    val givesPlus: Boolean get() = plus != AccountPlus.NONE
}

/**
 * What Google or Apple handed back after the person chose an account: proof for the server, and who it is. [nonce] is
 * the random value whose SHA-256 the token carries, so a copied token can't be used again elsewhere.
 */
data class SignIn(val with: SignInWith, val idToken: String, val email: String, val name: String, val nonce: String = "")

/** A purchase made on this device through its store, sent to the account so the server can check it with the store. */
data class StorePurchase(val product: String, val token: String)

/** Every server call either answers or couldn't connect (Figma 3.5, 4.3: "Couldn't connect"). */
sealed interface Answer<out T> {
    data class Ok<T>(val value: T) : Answer<T>
    data object Offline : Answer<Nothing>
}

/** Signing in (Figma 3.2): an account was found, or none uses that Google or Apple account (3.4). */
sealed interface SignInReply {
    data class Found(val account: Account) : SignInReply
    data object NoAccount : SignInReply
}

/** What an invite link says when it's opened (Figma 5.2–5.6). */
sealed interface InviteLook {
    val ownerName: String
    data class Open(override val ownerName: String) : InviteLook
    data class Ended(override val ownerName: String) : InviteLook
    data class Used(override val ownerName: String) : InviteLook
    data class Cancelled(override val ownerName: String) : InviteLook
    data class Full(override val ownerName: String) : InviteLook
}

/**
 * Plus's one-time products, the same IDs on Google Play and the App Store, and what each gives. The upgrade is Plus →
 * Plus Family for the difference, so it makes a family only beside Plus (the Worker's `paidFor`).
 */
object PlusProducts {
    const val PLUS = "com.oftenenough.app.plus"
    const val FAMILY = "com.oftenenough.app.plusfamily"
    const val FAMILY_UPGRADE = "com.oftenenough.app.plusfamily.upgrade"
    val all = listOf(PLUS, FAMILY, FAMILY_UPGRADE)

    /** A family product: Plus Family itself or the upgrade to it. */
    fun isFamily(product: String) = product == FAMILY || product == FAMILY_UPGRADE

    /**
     * Whether the account doesn't show yet what [product] gives, so this device should send it: a family product
     * until the account owns a family, Plus until the account has any Plus.
     */
    fun missingFrom(account: Account, product: String): Boolean =
        if (isFamily(product)) account.plus != AccountPlus.FAMILY_OWNER else account.plus == AccountPlus.NONE
}

/** The invite link's form: `https://oftenenough.com/join/<token>` (the app opens it; the website explains it otherwise). */
object InviteLink {
    private const val PREFIX = "https://oftenenough.com/join/"
    private const val BARE = "oftenenough.com/join/"
    private val TOKEN = Regex("[A-Za-z0-9_-]{8,64}")

    fun of(token: String) = PREFIX + token

    /** The token in a link, a scanned QR code or a typed code; null when it isn't one of ours. */
    fun token(text: String?): String? {
        val t = text?.trim() ?: return null
        val raw = when {
            t.startsWith(PREFIX) -> t.removePrefix(PREFIX)
            t.startsWith(BARE) -> t.removePrefix(BARE)
            else -> return null
        }
        return raw.substringBefore('?').substringBefore('#').takeIf { it.matches(TOKEN) }
    }
}

/** "alexandra.montgomery@gmail.com" → "alexa…@gmail.com" where room is short (Figma 1.4's header), whole elsewhere. */
object EmailWords {
    fun short(email: String, keep: Int = 5): String {
        val at = email.indexOf('@')
        if (at <= keep + 1) return email
        return email.take(keep) + "…" + email.substring(at)
    }
}
