package com.oftenenough.app.ui.plus

import android.graphics.Bitmap
import androidx.activity.compose.BackHandler
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ColumnScope
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.statusBarsPadding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.layout.widthIn
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.rounded.ArrowBack
import androidx.compose.material.icons.rounded.Check
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.shadow
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.ColorFilter
import androidx.compose.ui.graphics.FilterQuality
import androidx.compose.ui.graphics.asImageBitmap
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.semantics.heading
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import com.google.zxing.BarcodeFormat
import com.google.zxing.EncodeHintType
import com.google.zxing.qrcode.QRCodeWriter
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel
import com.oftenenough.app.R
import com.oftenenough.app.ui.components.CookieIcon
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.appColors

/*
 * The pieces every Plus & Account screen shares (Figma "Settings: Plus & Account", 1476:2). Text is only the shared
 * styles (AppType); rows and buttons have minimum heights, never fixed ones, so a larger font grows them.
 */

/** The app icon on its tile (the light tile in light mode, as approved; Brand/Logo Guide.md). */
@Composable
fun AppIconTile(size: Dp) {
    val c = appColors
    Box(Modifier.size(size).shadow(size * 0.05f, RoundedCornerShape(size * 0.3f)).clip(RoundedCornerShape(size * 0.3f)).background(c.surface)) {
        Image(painterResource(if (c.dark) R.drawable.mark_dark else R.drawable.mark_light), null, Modifier.size(size))
    }
}

/** The app's mark alone, small, as a point's icon ("Plus comes back"). */
@Composable
fun MarkIcon(size: Dp = 24.dp) =
    Image(painterResource(if (appColors.dark) R.drawable.mark_dark else R.drawable.mark_light), null, Modifier.size(size))

/** What leads a hero: an icon in the Expressive cookie (ink), or the app icon. */
sealed interface HeroArt {
    data class Cookie(val icon: ImageVector) : HeroArt
    data object AppIcon : HeroArt
}

/** A flow screen's top: its picture, a headline and one line under it, centred (Figma 3, 5, 2.2). */
@Composable
fun Hero(art: HeroArt, title: String, line: String) {
    val c = appColors
    Column(Modifier.fillMaxWidth().padding(horizontal = 24.dp), horizontalAlignment = Alignment.CenterHorizontally) {
        when (art) {
            is HeroArt.Cookie -> CookieIcon(art.icon, 88.dp, container = c.ink, tint = c.onInk)
            HeroArt.AppIcon -> AppIconTile(80.dp)
        }
        Spacer(Modifier.height(16.dp))
        Text(title, Modifier.widthIn(max = 312.dp).semantics { heading() }, style = AppType.headlineMediumEmphasized, color = c.ink, textAlign = TextAlign.Center)
        Spacer(Modifier.height(8.dp))
        Text(line, Modifier.widthIn(max = 280.dp), style = AppType.bodyLarge, color = c.secondary, textAlign = TextAlign.Center)
    }
}

/** One point in a points card: an icon, a name and a line. [mark] shows the app's mark instead of an icon. */
data class Point(val icon: ImageVector?, val title: String, val line: String)

/** What a step gives you, a white card of points (Figma 3's "Card · points"). */
@Composable
fun PointsCard(points: List<Point>) {
    val c = appColors
    Column(Modifier.fillMaxWidth().clip(RoundedCornerShape(28.dp)).background(c.surface).padding(vertical = 20.dp), verticalArrangement = Arrangement.spacedBy(20.dp)) {
        for (p in points) Row(Modifier.fillMaxWidth().padding(start = 24.dp, end = 16.dp).semantics(mergeDescendants = true) {}) {
            if (p.icon != null) Icon(p.icon, null, Modifier.size(24.dp), tint = c.secondary) else MarkIcon()
            Spacer(Modifier.width(24.dp))
            Column(Modifier.weight(1f)) {
                Text(p.title, style = AppType.labelLarge, color = c.ink)
                Text(p.line, style = AppType.bodyMedium, color = c.secondary)
            }
        }
    }
}

/**
 * A step of a flow: an optional back arrow, the content (scrolls when the font is large), and its buttons pinned at the
 * bottom. Back (the system's too) does what the arrow does.
 */
@Composable
fun FlowScreen(
    onBack: (() -> Unit)?, tag: String, showBack: Boolean = true, bottom: @Composable ColumnScope.() -> Unit = {}, content: @Composable ColumnScope.() -> Unit,
) {
    val c = appColors
    if (onBack != null) BackHandler(onBack = onBack)
    Column(Modifier.fillMaxSize().background(c.screen).statusBarsPadding().navigationBarsPadding().semantics { testTag = tag }) {
        if (onBack != null && showBack) Box(Modifier.heightIn(min = 64.dp).padding(start = 4.dp), contentAlignment = Alignment.CenterStart) {
            IconButton(onBack, Modifier.semantics { testTag = "flow-back" }) { Icon(Icons.AutoMirrored.Rounded.ArrowBack, "Back", tint = c.ink) }
        }
        Column(Modifier.weight(1f).fillMaxWidth().verticalScroll(rememberScrollState()).padding(horizontal = 16.dp),
            horizontalAlignment = Alignment.CenterHorizontally) {
            Spacer(Modifier.height(if (onBack != null && showBack) 40.dp else 48.dp))
            content()
            Spacer(Modifier.height(24.dp))
        }
        Column(Modifier.fillMaxWidth().padding(horizontal = 16.dp, vertical = 12.dp), verticalArrangement = Arrangement.spacedBy(8.dp),
            horizontalAlignment = Alignment.CenterHorizontally, content = bottom)
    }
}

/** The small note above a flow's buttons ("Made your account on an iPhone? …"). */
@Composable
fun BottomNote(text: String) =
    Text(text, Modifier.fillMaxWidth().padding(horizontal = 8.dp), style = AppType.bodySmall, color = appColors.secondary, textAlign = TextAlign.Center)

/** A flow's main button: ink, full width, 56 high at least. */
@Composable
fun MainButton(text: String, tag: String, icon: ImageVector? = null, enabled: Boolean = true, onClick: () -> Unit) {
    val c = appColors
    Button(onClick, Modifier.fillMaxWidth().heightIn(min = 56.dp).semantics { testTag = tag }, enabled = enabled,
        colors = ButtonDefaults.buttonColors(containerColor = c.ink, contentColor = c.onInk, disabledContainerColor = c.tonal, disabledContentColor = c.secondary),
        contentPadding = PaddingValues(horizontal = 24.dp, vertical = 12.dp)) {
        if (icon != null) { Icon(icon, null, Modifier.size(18.dp)); Spacer(Modifier.width(8.dp)) }
        Text(text, style = AppType.titleMedium, textAlign = TextAlign.Center)
    }
}

/** A flow's quiet button ("Not now", "Cancel", "Close", "I already have Plus"): text only, 56 high at least. */
@Composable
fun QuietButton(text: String, tag: String, onClick: () -> Unit) {
    TextButton(onClick, Modifier.fillMaxWidth().heightIn(min = 56.dp).semantics { testTag = tag }) {
        Text(text, style = AppType.titleMedium, color = appColors.ink, textAlign = TextAlign.Center)
    }
}

/** Continue with Google or Apple: a white button with the company's own logo (their sign-in branding). */
@Composable
fun ContinueWith(google: Boolean, tag: String, onClick: () -> Unit) {
    val c = appColors
    Button(onClick, Modifier.fillMaxWidth().heightIn(min = 56.dp).semantics { testTag = tag },
        colors = ButtonDefaults.buttonColors(containerColor = c.surface, contentColor = c.ink),
        contentPadding = PaddingValues(horizontal = 24.dp, vertical = 12.dp)) {
        if (google) Image(painterResource(R.drawable.ic_google_logo), null, Modifier.size(20.dp))
        else Image(painterResource(R.drawable.ic_apple_logo), null, Modifier.size(width = 17.dp, height = 21.dp), colorFilter = ColorFilter.tint(c.ink))
        Spacer(Modifier.width(12.dp))
        Text(if (google) "Continue with Google" else "Continue with Apple", style = AppType.titleMedium)
    }
}

/**
 * A centred moment (Figma 3.2, 4, 2.1.1, 3.5, 4.3): waiting on Google, Google Play or the server, with Material 3
 * Expressive's contained loading indicator (its seven shapes morphing as it turns; it only draws while on screen), or
 * a still [icon] in the same tonal circle when it's a message ("Couldn't connect"). Then the words, and the way on.
 */
@Composable
fun CenterScreen(
    title: String, line: String, quiet: String, tag: String, onQuiet: () -> Unit,
    icon: ImageVector? = null, main: String? = null, onMain: () -> Unit = {},
) {
    val c = appColors
    BackHandler(onBack = onQuiet)
    Column(Modifier.fillMaxSize().background(c.screen).statusBarsPadding().navigationBarsPadding().semantics { testTag = tag }) {
        Column(Modifier.weight(1f).fillMaxWidth().verticalScroll(rememberScrollState()).padding(horizontal = 40.dp),
            horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.Center) {
            Spacer(Modifier.height(24.dp))
            if (icon == null) com.oftenenough.app.ui.components.ExpressiveLoadingIndicator(c.tonal, c.ink, Modifier.semantics { testTag = "$tag-loading" })
            else Box(Modifier.size(64.dp).clip(androidx.compose.foundation.shape.CircleShape).background(c.tonal), contentAlignment = Alignment.Center) {
                Icon(icon, null, Modifier.size(28.dp), tint = c.ink)
            }
            Spacer(Modifier.height(24.dp))
            Text(title, style = AppType.titleLargeEmphasized, color = c.ink, textAlign = TextAlign.Center, modifier = Modifier.semantics { heading() })
            Spacer(Modifier.height(8.dp))
            Text(line, style = AppType.bodyMedium, color = c.secondary, textAlign = TextAlign.Center)
            Spacer(Modifier.height(24.dp))
        }
        Column(Modifier.padding(horizontal = 16.dp, vertical = 12.dp), verticalArrangement = Arrangement.spacedBy(8.dp)) {
            if (main != null) MainButton(main, "$tag-main", onClick = onMain)
            QuietButton(quiet, "$tag-quiet", onQuiet)
        }
    }
}

/** A dialog (Figma 7.x): an icon, a headline, the words, and two actions; [destructive] draws the confirm in red. */
@Composable
fun PlusDialog(
    icon: ImageVector, title: String, text: String, confirm: String, onConfirm: () -> Unit, onDismiss: () -> Unit,
    dismiss: String = "Cancel", destructive: Boolean = false, tag: String,
) {
    val c = appColors
    AlertDialog(onDismiss,
        modifier = Modifier.semantics { testTag = tag },
        icon = { Icon(icon, null, tint = if (destructive) c.error else c.secondary) },
        title = { Text(title, style = AppType.headlineSmall, color = c.ink, textAlign = TextAlign.Start, modifier = Modifier.fillMaxWidth()) },
        text = { Text(text, style = AppType.bodyMedium, color = c.secondary) },
        confirmButton = {
            TextButton(onConfirm, Modifier.semantics { testTag = "$tag-confirm" }) { Text(confirm, style = AppType.labelLarge, color = if (destructive) c.error else c.ink) }
        },
        dismissButton = if (dismiss.isEmpty()) null else ({ TextButton(onDismiss, Modifier.semantics { testTag = "$tag-dismiss" }) { Text(dismiss, style = AppType.labelLarge, color = c.ink) } }),
        containerColor = if (c.dark) c.surface else Color(0xFFF4F4F6),
    )
}

/** A feature with a check (Get Plus, Plus Family): the name and, under it, an optional line. */
@Composable
fun CheckLine(title: String, line: String? = null) {
    val c = appColors
    Row(Modifier.fillMaxWidth().semantics(mergeDescendants = true) {}) {
        Icon(Icons.Rounded.Check, null, Modifier.padding(top = 2.dp).size(20.dp), tint = c.ink)
        Spacer(Modifier.width(12.dp))
        Column(Modifier.weight(1f)) {
            Text(title, style = AppType.titleMedium, color = c.ink)
            if (line != null) Text(line, style = AppType.bodyMedium, color = c.secondary)
        }
    }
}

/** "Works on": Plus on every kind of device, ours and Apple's side by side (A13–A14: some built later). */
@Composable
fun WorksOn() {
    val c = appColors
    Text("Works on", Modifier.fillMaxWidth(), style = AppType.labelLarge, color = c.secondary)
    val pairs = listOf("Android phone" to "iPhone", "Tablet" to "iPad", "Wear OS watch" to "Apple Watch", "Windows" to "Mac")
    Column(Modifier.fillMaxWidth().semantics(mergeDescendants = true) {}, verticalArrangement = Arrangement.spacedBy(10.dp)) {
        for ((a, b) in pairs) Row(Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.spacedBy(10.dp)) {
            for (name in listOf(a, b)) Box(Modifier.weight(1f).clip(RoundedCornerShape(12.dp)).border(1.dp, c.outline.copy(alpha = 0.45f), RoundedCornerShape(12.dp))
                .heightIn(min = 40.dp).padding(horizontal = 14.dp, vertical = 10.dp), contentAlignment = Alignment.CenterStart) {
                Text(name, style = AppType.labelLarge, color = c.ink)
            }
        }
    }
}

/** A grey box inside a card, or a card of its own. */
@Composable
fun WhiteCard(modifier: Modifier = Modifier, padding: Dp = 20.dp, gap: Dp = 16.dp, content: @Composable ColumnScope.() -> Unit) =
    Column(modifier.fillMaxWidth().clip(RoundedCornerShape(28.dp)).background(appColors.surface).padding(padding), verticalArrangement = Arrangement.spacedBy(gap), content = content)

/** The invite's QR code: drawn on the phone from the link, black on white in both themes (cameras read that best). */
@Composable
fun InviteQr(link: String, size: Dp = 160.dp) {
    val bitmap = remember(link) { qrBitmap(link, 512) }
    Box(Modifier.size(size).clip(RoundedCornerShape(8.dp)).background(Color.White).padding(6.dp)) {
        Image(bitmap.asImageBitmap(), "Invite QR code", Modifier.fillMaxSize(), filterQuality = FilterQuality.None)
    }
}

private fun qrBitmap(text: String, px: Int): Bitmap {
    val m = QRCodeWriter().encode(text, BarcodeFormat.QR_CODE, px, px, mapOf(EncodeHintType.MARGIN to 0, EncodeHintType.ERROR_CORRECTION to ErrorCorrectionLevel.M))
    val pixels = IntArray(m.width * m.height) { i -> if (m.get(i % m.width, i / m.width)) android.graphics.Color.BLACK else android.graphics.Color.WHITE }
    return Bitmap.createBitmap(pixels, m.width, m.height, Bitmap.Config.RGB_565)
}

/** A plain clickable modifier for whole rows, with the row's own name for TalkBack. */
fun Modifier.rowClick(label: String, onClick: () -> Unit) = clickable(onClickLabel = label, onClick = onClick)
