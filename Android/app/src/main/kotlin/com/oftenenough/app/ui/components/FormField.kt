package com.oftenenough.app.ui.components

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.RowScope
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.text.BasicTextField
import androidx.compose.foundation.text.KeyboardActions
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.SolidColor
import androidx.compose.ui.graphics.takeOrElse
import androidx.compose.ui.unit.dp
import com.oftenenough.app.ui.theme.AppType
import com.oftenenough.app.ui.theme.Symbols

/**
 * Atom 3.1, **Form field** (Figma 1065:2120; Components — Atoms Build Plan): our own field, for the habit and task
 * forms only, where the design types straight into the form's grouped list instead of a Material text field: a
 * habit's name and description, a custom unit, a checklist's steps. Everywhere else a field is Material's own
 * (`OutlinedTextField`: New time of day, a group's name; [DropdownField]).
 *
 * It's one piece of the form's segmented list, so it looks like the [AppListItem]s beside it: their Surface (Figma's
 * Surface bright, the same F9F9F9) and their corners by place, 24 outside and 4 between ([segmentShape], Position:
 * First, Middle, Last, Single), 56 dp tall with 16 all round, and taller only as the text grows (a description's four
 * lines, 200 % text). The text is Body Large in On surface, the [placeholder] in On surface variant, the cursor Primary
 * (State: Empty, Filled, Typing). It has no error state: a missing name never turns it red (Android A65).
 *
 * - **[handle]** (Show handle): a step's drag_indicator at the start, 16 before the text; the modifier carries the drag.
 * - **[trailing]** (Show remove): a step's ✕ ([FormFieldRemove]), or the custom unit's Done; the field then ends 4 from
 *   its edge, so a 48 dp icon button's glyph sits 16 in, where Figma draws it.
 *
 * [modifier] is the whole piece (a dragged step's lift, its accessibility actions); [fieldModifier] is the text field
 * itself (its focus, test tag and spoken name).
 */
@Composable
fun FormField(
    value: String,
    onValueChange: (String) -> Unit,
    placeholder: String,
    index: Int,
    count: Int,
    modifier: Modifier = Modifier,
    fieldModifier: Modifier = Modifier,
    maxLines: Int = 1,
    keyboardOptions: KeyboardOptions = KeyboardOptions.Default,
    keyboardActions: KeyboardActions = KeyboardActions.Default,
    handle: Modifier? = null,
    /** Its fill: Surface, or the page's own (the habit form's Surface bright). */
    containerColor: Color = Color.Unspecified,
    trailing: (@Composable RowScope.() -> Unit)? = null,
) {
    val s = MaterialTheme.colorScheme
    Row(
        modifier.fillMaxWidth().clip(segmentShape(index, count)).background(containerColor.takeOrElse { s.surface }).heightIn(min = 56.dp)
            .padding(start = 16.dp, end = if (trailing != null) 4.dp else 16.dp),
        verticalAlignment = Alignment.CenterVertically,
    ) {
        if (handle != null) {
            Icon(Symbols.DragIndicator, "Reorder", handle.size(24.dp), tint = s.onSurfaceVariant)
            Spacer(Modifier.width(16.dp))
        }
        BasicTextField(
            value, onValueChange, fieldModifier.weight(1f).padding(vertical = 16.dp),
            textStyle = AppType.bodyLarge.copy(color = s.onSurface), singleLine = maxLines == 1, maxLines = maxLines,
            keyboardOptions = keyboardOptions, keyboardActions = keyboardActions, cursorBrush = SolidColor(s.primary),
            decorationBox = { inner ->
                Box { if (value.isEmpty()) Text(placeholder, style = AppType.bodyLarge, color = s.onSurfaceVariant); inner() }
            },
        )
        trailing?.invoke(this)
    }
}

/** A step's ✕ at the end of its [FormField] (Figma Show remove): Material's icon button, the glyph On surface variant. */
@Composable
fun FormFieldRemove(label: String, onClick: () -> Unit) = StandardIconButton(Symbols.Close, label, onClick)
