package com.oftenenough.app.app.account

import android.app.Activity
import androidx.credentials.CredentialManager
import androidx.credentials.CustomCredential
import androidx.credentials.GetCredentialRequest
import androidx.credentials.exceptions.GetCredentialCancellationException
import androidx.credentials.exceptions.GetCredentialException
import androidx.credentials.exceptions.NoCredentialException
import com.google.android.libraries.identity.googleid.GetSignInWithGoogleOption
import com.google.android.libraries.identity.googleid.GoogleIdTokenCredential

/** Who the person is, from Google's or Apple's own sign-in (never a password of ours). Null: they backed out. */
interface SignInProvider {
    suspend fun google(activity: Activity): SignIn?
    suspend fun apple(activity: Activity): SignIn?
    /** False where this build can't reach Google's sign-in yet (no OAuth client): the screens say so. */
    val canSignIn: Boolean
}

/**
 * Sign in with Google through Android's Credential Manager: Google's own account sheet (Figma 3.1, 2.3), "Add another
 * account" included. Its ID token goes to the Worker, which checks it with Google; the phone keeps only the email.
 * Apple's sign-in on Android is a web page the Worker hosts, so it waits for the Worker (Current Work 110).
 */
class GoogleSignInProvider(private val webClientId: String) : SignInProvider {
    override val canSignIn = true

    override suspend fun google(activity: Activity): SignIn? {
        val request = GetCredentialRequest.Builder().addCredentialOption(GetSignInWithGoogleOption.Builder(webClientId).build()).build()
        return try {
            val credential = CredentialManager.create(activity).getCredential(activity, request).credential
            if (credential is CustomCredential && credential.type == GoogleIdTokenCredential.TYPE_GOOGLE_ID_TOKEN_CREDENTIAL) {
                val google = GoogleIdTokenCredential.createFrom(credential.data)
                SignIn(SignInWith.GOOGLE, google.idToken, google.id, google.displayName ?: google.id.substringBefore('@'))
            } else null
        } catch (_: GetCredentialCancellationException) { null
        } catch (_: NoCredentialException) { null
        } catch (_: GetCredentialException) { null }
    }

    override suspend fun apple(activity: Activity): SignIn? = null
}

/**
 * Debug builds and tests before the OAuth client exists: no sheet, the next account is the one a test (or the debug
 * build's default) set. It never reaches Google and its token means nothing to a real server.
 */
class StandInSignIn : SignInProvider {
    override val canSignIn = true
    var nextGoogle: SignIn? = SignIn(SignInWith.GOOGLE, "stand-in", "sam@gmail.com", "Sam Kim")
    var nextApple: SignIn? = SignIn(SignInWith.APPLE, "stand-in", "sam@privaterelay.appleid.com", "Sam Kim")
    override suspend fun google(activity: Activity) = nextGoogle
    override suspend fun apple(activity: Activity) = nextApple
}

/** A release build without the OAuth client: no sign-in yet. */
object NoSignIn : SignInProvider {
    override val canSignIn = false
    override suspend fun google(activity: Activity): SignIn? = null
    override suspend fun apple(activity: Activity): SignIn? = null
}
