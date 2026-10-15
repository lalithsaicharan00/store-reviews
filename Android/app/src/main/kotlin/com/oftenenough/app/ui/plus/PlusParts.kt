package com.oftenenough.app.ui.plus

import android.graphics.Bitmap
import androidx.activity.compose.BackHandler
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.BoxWithConstraints
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

/**
 * The app icon on its tile (the light tile in light mode, as approved; Brand/Logo Guide.md). Lifted by a soft shadow
 * on a flow's hero and Get Plus (Figma 2, 2.2); [flat] in Plus & Account's white card, where it sits on white (Figma 1).
 */
@Composable
fun AppIconTile(size: Dp, flat: Boolean = false) {
    val c = appColors
    val shape = RoundedCornerShape(size * (if (flat) 0.27f else 0.3f))
    Box(Modifier.size(size).let { if (flat) it else it.shadow(size * 0.05f, shape) }.clip(shape).background(c.surface)) {
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
            Column(Modifier.weight(1f), verticalArrangement = Arrangement.spacedBy(2.dp)) {
                Text(p.title, style = AppType.labelLarge, color = c.ink)
                Text(p.line, style = AppType.bodyMedium, color = c.secondary)
            }
        }
    }
}

/**
 * A step of a flow: an optional back arrow, the content (scrolls when the font is large), and its buttons pinned at the
 * bottom. The content sits in the middle of the space between the top and the buttons, as every flow frame draws it;
 * [top] keeps it under the bar instead (Figma 3.4, a list). Back (the system's too) does what the arrow does.
 */
@Composable
fun FlowScreen(
    onBack: (() -> Unit)?, tag: String, showBack: Boolean = true, top: Boolean = false,
    bottom: @Composable ColumnScope.() -> Unit = {}, content: @Composable ColumnScope.() -> Unit,
) {
    val c = appColors
    if (onBack != null) BackHandler(onBack = onBack)
    Column(Modifier.fillMaxSize().background(c.screen).statusBarsPadding().navigationBarsPadding().semantics { testTag = tag }) {
        if (onBack != null && showBack) Box(Modifier.heightIn(min = 64.dp).padding(start = 4.dp), contentAlignment = Alignment.CenterStart) {
            IconButton(onBack, Modifier.semantics { testTag = "flow-back" }) { Icon(Symbols.ArrowBack, "Back", tint = c.ink) }
        }
        BoxWithConstraints(Modifier.weight(1f).fillMaxWidth()) {
            val room = maxHeight
            Column(Modifier.fillMaxSize().verticalScroll(rememberScrollState()).padding(horizontal = 16.dp)) {
                Column(Modifier.fillMaxWidth().heightIn(min = room), horizontalAlignment = Alignment.CenterHorizontally,
                    verticalArrangement = if (top) Arrangement.Top else Arrangement.Center) {
                    Spacer(Modifier.height(if (top) 8.dp else 24.dp))
                    content()
                    Spacer(Modifier.height(24.dp))
                }
            }
        }
        Column(Modifier.fillMaxWidth().padding(horizontal = 16.dp, vertical = 12.dp), verticalArrangement = Arrangement.spacedBy(8.dp),
            horizontalAlignment = Alignment.CenterHorizontally, content = bottom)
    }
}

/** The small note above a flow's buttons ("Made your account on an iPhone? …"). */
@Composable
fun BottomNote(text: String) =
    Text(text, Modifier.fillMaxWidth(), style = AppType.bodySmall, color = appColors.secondary, textAlign = TextAlign.Center)

/** A flow's main button: ink, full width, 56 high at least; its icon 18 (20 for Scan QR code, Figma 5). */
@Composable
fun MainButton(text: String, tag: String, icon: ImageVector? = null, enabled: Boolean = true, iconSize: Dp = 18.dp, onClick: () -> Unit) {
    val c = appColors
    Button(onClick, Modifier.fillMaxWidth().heightIn(min = 56.dp).semantics { testTag = tag }, enabled = enabled,
        colors = ButtonDefaults.buttonColors(containerColor = c.ink, contentColor = c.onInk, disabledContainerColor = c.tonal, disabledContentColor = c.secondary),
        contentPadding = PaddingValues(horizontal = 24.dp, vertical = 12.dp)) {
        if (icon != null) { Icon(icon, null, Modifier.size(iconSize)); Spacer(Modifier.width(8.dp)) }
        Text(text, style = AppType.titleMedium, textAlign = TextAlign.Center)
    }
}

/**
 * A flow's quiet button ("Not now", "Cancel", "Close"): text only, 56 high at least. "I already have Plus" is 40 high
 * under Get Plus (Figma 2: [height]); "Cancel invite" in the invite sheet is Label Large (Figma 7.5: [small]).
 */
@Composable
fun QuietButton(text: String, tag: String, height: Dp = 56.dp, small: Boolean = false, onClick: () -> Unit) {
    TextButton(onClick, Modifier.fillMaxWidth().heightIn(min = height).semantics { testTag = tag },
        shape = if (small) RoundedCornerShape(20.dp) else ButtonDefaults.textShape) {
        Text(text, style = if (small) AppType.labelLarge else AppType.titleMedium, color = appColors.ink, textAlign = TextAlign.Center)
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
                Icon(icon, null, Modifier.size(32.dp), tint = c.ink)
            }
            Spacer(Modifier.height(24.dp))
            Text(title, style = AppType.titleLargeEmphasized, color = c.ink, textAlign = TextAlign.Center, modifier = Modifier.semantics { heading() })
            Spacer(Modifier.height(8.dp))
            Text(line, style = AppType.bodyMedium, color = c.secondary, textAlign = TextAlign.Center)
            Spacer(Modifier.height(24.dp))
        }
        Column(Modifier.padding(horizontal = 16.dp, vertical = 12.dp), verticalArrangement = Arrangement.spacedBy(8.dp)) {
            if (main != null) MainButton(main, "$tag-main", onClick = onMain)
            QuietButton(quiet, "$tag-quiet", onClick = onQuiet)
        }
    }
}

/**
 * A dialog (Figma 7.x): an icon, a headline, the words, and two actions, all in ink; [destructive] draws the icon and the
 * confirm in red, which only deleting the account does (7.2, 7.9, 7.10: removing, leaving and cancelling stay ink).
 */
@Composable
fun PlusDialog(
    icon: ImageVector, title: String, text: String, confirm: String, onConfirm: () -> Unit, onDismiss: () -> Unit,
    dismiss: String = "Cancel", destructive: Boolean = false, tag: String,
) {
    val c = appColors
    PlusDialogFrame(icon, title, tag, onDismiss, iconTint = if (destructive) c.error else c.ink, actions = {
        if (dismiss.isNotEmpty()) DialogButton(dismiss, "$tag-dismiss", onClick = onDismiss)
        DialogButton(confirm, "$tag-confirm", color = if (destructive) c.error else c.ink, onClick = onConfirm)
    }) {
        Text(text, style = AppType.bodyMedium, color = c.secondary)
    }
}

/**
 * Figma 7.x's dialog: 312 wide, 24 in (20 under the actions), its icon at the start above the headline, everything 16
 * apart and the actions at the end, 8 under the words' gap. Material's AlertDialog centres the icon, so it's drawn here.
 */
@OptIn(androidx.compose.material3.ExperimentalMaterial3Api::class)
@Composable
fun PlusDialogFrame(
    icon: ImageVector, title: String, tag: String, onDismiss: () -> Unit, iconTint: Color = appColors.ink,
    actions: @Composable androidx.compose.foundation.layout.RowScope.() -> Unit, content: @Composable ColumnScope.() -> Unit,
) {
    val c = appColors
    androidx.compose.material3.BasicAlertDialog(onDismiss, Modifier.widthIn(max = 312.dp).semantics { testTag = tag }) {
        // Scrolls when larger text makes it taller than the screen; the actions wrap to a second line rather than break a
        // button's words ("Cancel invite" at 200 %).
        Column(Modifier.fillMaxWidth().clip(RoundedCornerShape(28.dp)).background(if (c.dark) c.surface else Color(0xFFF4F4F6))
            .verticalScroll(rememberScrollState())
            .padding(start = 24.dp, end = 24.dp, top = 24.dp, bottom = 20.dp), verticalArrangement = Arrangement.spacedBy(16.dp)) {
            Icon(icon, null, Modifier.size(24.dp), tint = iconTint)
            Text(title, Modifier.semantics { heading() }, style = AppType.headlineSmall, color = c.ink)
            content()
            androidx.compose.foundation.layout.FlowRow(Modifier.fillMaxWidth().padding(top = 8.dp),
                horizontalArrangement = Arrangement.spacedBy(8.dp, Alignment.End), verticalArrangement = Arrangement.spacedBy(8.dp),
                itemVerticalAlignment = Alignment.CenterVertically, content = actions)
        }
    }
}

/** A dialog's text button: Label Large, 40 high at least, 12 at its sides. */
@Composable
fun DialogButton(text: String, tag: String, color: Color = appColors.ink, enabled: Boolean = true, onClick: () -> Unit) {
    TextButton(onClick, Modifier.heightIn(min = 40.dp).semantics { testTag = tag }, enabled = enabled,
        contentPadding = PaddingValues(horizontal = 12.dp, vertical = 10.dp)) {
        Text(text, style = AppType.labelLarge, color = if (enabled) color else color.copy(alpha = 0.38f))
    }
}

/** A feature with a check (Get Plus, Plus Family): the name and, under it, an optional line. */
@Composable
fun CheckLine(title: String, line: String? = null) {
    val c = appColors
    Row(Modifier.fillMaxWidth().semantics(mergeDescendants = true) {}) {
        Icon(Symbols.Check, null, Modifier.padding(top = 2.dp).size(20.dp), tint = c.ink)
        Spacer(Modifier.width(12.dp))
        Column(Modifier.weight(1f), verticalArrangement = Arrangement.spacedBy(2.dp)) {
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
            for (name in listOf(a, b)) Box(Modifier.weight(1f).clip(RoundedCornerShape(12.dp)).border(1.dp, if (c.dark) c.outline.copy(alpha = 0.45f) else Color(0xFFC9C9CE), RoundedCornerShape(12.dp))
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

/**
 * A row of Plus & Account (Figma 1–1.5's "Row · …"): a 24 icon in a 40 tonal disc, a name and an optional line, and a
 * chevron when it opens something. At least 72 high, 16 around (12 at the chevron's side), so larger text grows it.
 */
@Composable
fun PlusRow(
    title: String, index: Int, count: Int, line: String? = null, icon: ImageVector, onClick: (() -> Unit)? = null,
    modifier: Modifier = Modifier, red: Boolean = false, chevron: Boolean = onClick != null,
) {
    val c = appColors
    val tint = if (red) c.error else c.ink
    Row(modifier.fillMaxWidth().clip(com.oftenenough.app.ui.components.segmentShape(index, count)).background(c.surface)
        .let { if (onClick != null) it.clickable(onClick = onClick) else it }
        .heightIn(min = 72.dp).padding(start = 16.dp, end = if (chevron) 12.dp else 16.dp, top = 16.dp, bottom = 16.dp),
        verticalAlignment = Alignment.CenterVertically, horizontalArrangement = Arrangement.spacedBy(16.dp)) {
        IconDisc(icon, tint)
        Column(Modifier.weight(1f), verticalArrangement = Arrangement.spacedBy(2.dp)) {
            Text(title, style = AppType.titleMedium, color = tint)
            if (line != null) Text(line, style = AppType.bodyMedium, color = c.secondary)
        }
        if (chevron) Icon(Symbols.ChevronRight, null, Modifier.size(24.dp), tint = c.secondary)
    }
}

/** A row's icon: 24, in a 40 tonal disc. */
@Composable
fun IconDisc(icon: ImageVector, tint: Color = appColors.ink) =
    Box(Modifier.size(40.dp).clip(androidx.compose.foundation.shape.CircleShape).background(appColors.tonal), contentAlignment = Alignment.Center) {
        Icon(icon, null, Modifier.size(24.dp), tint = tint)
    }

/** Plus & Account's tonal button (Sign out, Create an account, Back up to Google Drive): 40 high, as wide as its words. */
@Composable
fun PlusTonalButton(text: String, icon: ImageVector, tag: String, onClick: () -> Unit) {
    val c = appColors
    Button(onClick, Modifier.heightIn(min = 40.dp).semantics { testTag = tag },
        colors = ButtonDefaults.buttonColors(containerColor = c.tonal, contentColor = c.ink),
        contentPadding = PaddingValues(start = 16.dp, end = 24.dp, top = 10.dp, bottom = 10.dp)) {
        Icon(icon, null, Modifier.size(18.dp))
        Spacer(Modifier.width(8.dp))
        Text(text, style = AppType.labelLarge)
    }
}

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
