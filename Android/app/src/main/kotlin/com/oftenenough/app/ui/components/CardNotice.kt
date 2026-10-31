package com.oftenenough.app.ui.components

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ExperimentalLayoutApi
import androidx.compose.foundation.layout.FlowRow
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.ExperimentalMaterial3ExpressiveApi
import androidx.compose.material3.Icon
import androidx.compose.material3.LinearWavyProgressIndicator
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.unit.dp
import com.oftenenough.app.ui.theme.AppType

/**
 * Molecule 4.7, **Card notice** (Figma 795:499; Components — Atoms Build Plan): a card that says how something stands
 * and what to do about it, by State: **Notice**, **Progress** and **Done**. On Today, above the first time of day
 * (backup paused, off or deleted; reminders that can't come or came late; a payment Google Play hasn't finished), and
 * at the top of Backup & Sync (backed up, not backed up, backing up, waiting for the internet).
 *
 * Material's filled `Card` in Surface bright with corners 24 (Material's are 12; every card in the designs is 24). In
 * it, the [icon] in a 40 dp disc of Secondary container (the glyph On secondary container, outlined), 16, then the
 * [title] in Title Medium (On surface) over the [body] in Body Medium (On surface variant), 4 apart. Both wrap;
 * nothing is cut.
 *
 * - **Notice** ([action] given): 16 at the start and top, 8 at the end and bottom (the words end 16 in); 4 under the
 *   words, the buttons at the end, Material's Text buttons ([dismiss] first, if there is one, then the [action]), 8
 *   apart, wrapping to a second line when long. With [actionUnder] (Backup & Sync), 16 all round and the one action a
 *   Tonal button under the words instead, lined up with them (56 in), 12 below them.
 * - **Progress** ([working]): the work happening here (A39). No buttons; 12 under the words, Material's wavy bar in
 *   Primary on Secondary container, filled to [progress] (0 to 1), or Material's moving wave while there's no count.
 *   16 all round.
 * - **Done** (no action, not working): the confirmation, or a state with nothing to do. 16 all round.
 *
 * The card keeps its place as it changes state: nothing else on the page moves (U4). How it folds away is the page's.
 */
@OptIn(ExperimentalLayoutApi::class, ExperimentalMaterial3ExpressiveApi::class)
@Composable
fun CardNotice(
    icon: ImageVector,
    title: String,
    body: String,
    modifier: Modifier = Modifier,
    dismiss: String? = null,
    onDismiss: () -> Unit = {},
    action: String? = null,
    onAction: () -> Unit = {},
    actionUnder: Boolean = false,
    actionEnabled: Boolean = true,
    actionTag: String = "notice-action",
    working: Boolean = false,
    progress: Float? = null,
    tag: String? = null,
) {
    val s = MaterialTheme.colorScheme
    val buttons = action != null && !working
    val atEnd = buttons && !actionUnder
    Card(
        modifier.fillMaxWidth().semantics { if (tag != null) testTag = tag },
        shape = RoundedCornerShape(24.dp),
        colors = CardDefaults.cardColors(containerColor = s.surface, contentColor = s.onSurface),
    ) {
        Column(
            // The Text buttons keep their 48 dp touch target, 4 past their 40 above and below: so the card is 4 less at
            // the bottom and the buttons 4 less from the words, and every edge lands where Figma draws it (Card notice
            // 795:466: 4 above the buttons, 8 under them; 160 tall for a three-line notice).
            if (atEnd) Modifier.padding(start = 16.dp, top = 16.dp, end = 8.dp, bottom = 4.dp) else Modifier.padding(16.dp),
            verticalArrangement = Arrangement.spacedBy(4.dp),
        ) {
            Row(Modifier.padding(end = if (atEnd) 8.dp else 0.dp), horizontalArrangement = Arrangement.spacedBy(16.dp)) {
                Box(Modifier.size(40.dp).clip(CircleShape).background(s.secondaryContainer), contentAlignment = Alignment.Center) {
                    Icon(icon, null, tint = s.onSecondaryContainer)
                }
                Column(Modifier.weight(1f)) {
                    Column(verticalArrangement = Arrangement.spacedBy(4.dp)) {
                        Text(title, style = AppType.titleMedium, color = s.onSurface)
                        Text(body, style = AppType.bodyMedium, color = s.onSurfaceVariant)
                    }
                    if (working) {
                        Spacer(Modifier.height(12.dp))
                        if (progress != null) WavyProgress(progress)
                        else LinearWavyProgressIndicator(Modifier.fillMaxWidth())
                    }
                }
            }
            if (atEnd) {
                FlowRow(Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.spacedBy(8.dp, Alignment.End)) {
                    if (dismiss != null) AppButton(dismiss, onDismiss, style = ButtonStyle.Text, tag = "notice-dismiss")
                    AppButton(action, onAction, style = ButtonStyle.Text, enabled = actionEnabled, tag = actionTag)
                }
            } else if (buttons) {
                AppButton(action, onAction, Modifier.padding(start = 56.dp, top = 8.dp), style = ButtonStyle.Tonal, enabled = actionEnabled, tag = actionTag)
            }
        }
    }
}
