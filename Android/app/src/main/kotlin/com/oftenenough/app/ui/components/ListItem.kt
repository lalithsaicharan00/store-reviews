package com.oftenenough.app.ui.components

import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.text.AnnotatedString
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ColumnScope
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.ExperimentalMaterial3ExpressiveApi
import androidx.compose.material3.Icon
import androidx.compose.material3.LocalContentColor
import androidx.compose.material3.ListItemDefaults
import androidx.compose.material3.ListItemShapes
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.SegmentedListItem
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.CompositionLocalProvider
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.unit.dp
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.Symbols

/**
 * Atom 2.4, **List item** (Figma 528:85; Components — Atoms Build Plan): Material 1.5's own `SegmentedListItem`, the
 * Expressive grouped list. Material's own: Surface on the Surface container page, 2 dp between rows, 16 at the sides and
 * 10 above and below, 12 either side of the text, 56 dp for one line and 72 for two (and taller as the text grows), On
 * surface variant icons and supporting text in Body Medium, and the shape that rounds up while pressed. The design's
 * small settings, nothing else:
 *
 * - **Corners:** 24 outside, 4 between ([listItemShapes]; Material's outside is 16): the radius every card and group in
 *   the designs has, so a list and the card beside it match.
 * - **Headline:** Title Medium, one line or two (Material's is Body Large; the user, 24 Oct 2026: a row needs the weight).
 * - **Avatar:** an icon in a 40 dp circle of Surface container highest ([ListAvatar]; Material's is Primary container,
 *   for a person's initials); Primary with On primary once its task is done (State=Done).
 * - **Beside the headline** ([beside], Figma's Headline row, 8 apart): the Plus label, or a day's "Today".
 * - **Under the text** ([below]): what the design adds under the supporting text: a day's note ([ListNote]), an example
 *   tag ([ListExample]), a tonal action ([ListAction], State=To do), a Plus label on its own line.
 *
 * The rows of one group are stacked by their column, [SegmentedListGap] apart; never a divider.
 */
@OptIn(ExperimentalMaterial3ExpressiveApi::class)
@Composable
fun AppListItem(
    headline: String,
    index: Int,
    count: Int,
    modifier: Modifier = Modifier,
    supporting: String? = null,
    /** How many lines the supporting text may take (a note shown in one line ends with …). */
    supportingLines: Int = Int.MAX_VALUE,
    leading: (@Composable () -> Unit)? = null,
    trailing: (@Composable () -> Unit)? = null,
    onClick: (() -> Unit)? = null,
    onLongClick: (() -> Unit)? = null,
    enabled: Boolean = true,
    containerColor: Color = Color.Unspecified,
    headlineColor: Color = Color.Unspecified,
    headlineLines: Int = Int.MAX_VALUE,
    /** Title Medium; a choice among options takes Body Large (Figma's Option, a radio's row). */
    headlineStyle: androidx.compose.ui.text.TextStyle = AppType.titleMedium,
    beside: (@Composable () -> Unit)? = null,
    below: (@Composable ColumnScope.() -> Unit)? = null,
    tag: String? = null,
) {
    val shapes = listItemShapes(index, count)
    val m = modifier.semantics { tag?.let { testTag = it } }
    val headlineText: @Composable () -> Unit = {
        val text = @Composable { m: Modifier -> Text(headline, m, style = headlineStyle, color = headlineColor, maxLines = headlineLines, overflow = TextOverflow.Ellipsis) }
        if (beside == null) text(Modifier)
        else Row(verticalAlignment = Alignment.CenterVertically, horizontalArrangement = Arrangement.spacedBy(8.dp)) { text(Modifier.weight(1f, fill = false)); beside() }
    }
    val support: (@Composable () -> Unit)? = if (supporting == null && below == null) null else {
        {
            Column(verticalArrangement = Arrangement.Top) {
                if (supporting != null) Text(supporting, style = AppType.bodyMedium, maxLines = supportingLines, overflow = TextOverflow.Ellipsis)
                below?.invoke(this)
            }
        }
    }
    val colors = ListItemDefaults.segmentedColors(containerColor = containerColor)
    // Figma's List item is 8 above and below (56 for one line with its 40 avatar); Material's 10 made it 60.
    val padding = if (below == null) PaddingValues(horizontal = 16.dp, vertical = 8.dp) else ListItemDefaults.ContentPadding
    if (onClick != null) SegmentedListItem(onClick, shapes, m, enabled, leading, trailing, supportingContent = support, onLongClick = onLongClick,
        colors = colors, contentPadding = padding, content = headlineText)
    else SegmentedListItem(shapes, m, enabled, leading, trailing, supportingContent = support, colors = colors, contentPadding = padding, content = headlineText)
}

/** Between the rows of one group (Material's `SegmentedGap`, 2 dp). */
val SegmentedListGap = ListItemDefaults.SegmentedGap

/**
 * A row's corners by its place in its group (Figma List item, Position: First, Middle, Last, Single): [segmentShape]'s
 * 24 outside and 4 between, rounding up to 24 all round while pressed, focused or hovered, as Material's do to theirs.
 */
@Composable
fun listItemShapes(index: Int, count: Int): ListItemShapes {
    val material = ListItemDefaults.shapes()
    return remember(index, count, material) {
        val base = segmentShape(index, count)
        val round = RoundedCornerShape(24.dp)
        material.copy(shape = base, selectedShape = base, pressedShape = round, focusedShape = round, hoveredShape = round)
    }
}

/** A row's leading icon in its circle (Figma List item, Leading avatar): 40 dp, the icon 24; [done] fills it Primary. */
@Composable
fun ListAvatar(icon: ImageVector, done: Boolean = false, tint: Color? = null) = ListAvatar(done) {
    Icon(icon, null, tint = tint ?: LocalContentColor.current)
}

/** The same circle around anything else (a brand mark: Google Drive's logo); its content colour follows [done]. */
@Composable
fun ListAvatar(done: Boolean = false, content: @Composable () -> Unit) {
    val s = MaterialTheme.colorScheme
    Box(Modifier.size(40.dp).clip(CircleShape).background(if (done) s.primary else s.surfaceContainerHighest), contentAlignment = Alignment.Center) {
        CompositionLocalProvider(LocalContentColor provides if (done) s.onPrimary else s.onSurfaceVariant, content = content)
    }
}

/** A row that opens a page ends in › (Figma List item, Trailing icon: chevron_right). */
@Composable
fun ListChevron() = Icon(Symbols.ChevronRight, null)

/**
 * A row's fix, under its words (Figma List item, State=To do: a Tonal Small button, 12 under the text; A40, A70): Android's
 * Safety Center puts a fix there, and Material's list items take no button at their end. Once it's done, the row's
 * avatar turns into the ✓ ([ListAvatar] with `done`) and the button goes.
 */
@Composable
fun ListAction(text: String, onClick: () -> Unit, tag: String? = null) =
    AppButton(text, onClick, Modifier.padding(top = 12.dp), style = ButtonStyle.Tonal, tag = tag)

/** An example under a choice (Figma List item, Show example): "e.g. Make your bed" in a tag, 8 under the line. */
@Composable
fun ListExample(text: String) =
    Box(Modifier.padding(top = 8.dp).clip(RoundedCornerShape(8.dp)).background(MaterialTheme.colorScheme.surfaceContainerHigh).padding(horizontal = 8.dp, vertical = 2.dp)) {
        Text(text, style = AppType.bodySmall, color = MaterialTheme.colorScheme.onSurfaceVariant)
    }

/** A day's note under its line (Figma List item, Show note): the note icon, 8, up to two lines in On surface. */
@Composable
fun ListNote(note: AnnotatedString) =
    Row(Modifier.padding(top = 4.dp).semantics { contentDescription = "Note: ${note.text}" }) {
        Icon(Symbols.StickyNote2, null, Modifier.padding(top = 2.dp).size(18.dp))
        Spacer(Modifier.width(8.dp))
        Text(note, style = AppType.bodyMedium, color = MaterialTheme.colorScheme.onSurface, maxLines = 2, overflow = TextOverflow.Ellipsis)
    }
