package com.oftenenough.app.ui.components

import com.oftenenough.app.ui.theme.Symbols
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.WindowInsets
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.statusBars
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.layout.windowInsetsPadding
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.SearchBarDefaults
import androidx.compose.material3.SearchBarValue
import androidx.compose.material3.rememberSearchBarState
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberUpdatedState
import androidx.compose.runtime.snapshotFlow
import androidx.compose.foundation.text.input.TextFieldState
import androidx.compose.foundation.text.input.rememberTextFieldState
import androidx.compose.foundation.text.input.setTextAndPlaceCursorAtEnd
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.focus.FocusRequester
import androidx.compose.ui.focus.focusRequester
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.role
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.semantics.testTag
import androidx.compose.ui.unit.dp
import com.oftenenough.app.ui.theme.AppType

/**
 * Atom 1.9, **Search view header** (Figma 1052:1960; Components — Atoms Build Plan): the header of Material's full-screen
 * search, built from Material's own search field (`SearchBarDefaults.InputField`: Body Large, On surface text, On surface
 * variant placeholder, a Primary cursor, the keyboard's Search key). 72 dp high, ← at the start, ✕ once something is
 * typed, both On surface variant (1.1); then Material's divider (Outline variant). It has no colour of its own: it sits
 * on the page (Surface container, Figma's Search page). The field takes focus when it opens empty.
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun SearchHeader(
    query: String,
    onQueryChange: (String) -> Unit,
    onBack: () -> Unit,
    placeholder: String,
    modifier: Modifier = Modifier,
    fieldTag: String? = null,
    backTag: String? = null,
    clearTag: String? = null,
    clearLabel: String = "Clear",
) {
    val focus = remember { FocusRequester() }
    LaunchedEffect(Unit) { if (query.isEmpty()) runCatching { focus.requestFocus() } }
    Column(modifier.fillMaxWidth().windowInsetsPadding(WindowInsets.statusBars)) {
        SearchBarDefaults.InputField(
            textFieldState = searchText(query, onQueryChange),
            searchBarState = rememberSearchBarState(SearchBarValue.Expanded),
            onSearch = {},
            modifier = Modifier.fillMaxWidth().heightIn(min = 72.dp).focusRequester(focus)
                .semantics { fieldTag?.let { testTag = it }; contentDescription = placeholder },
            placeholder = { Text(placeholder) },
            leadingIcon = { StandardIconButton(Symbols.ArrowBack, "Back", onBack, backTag.tagged()) },
            trailingIcon = if (query.isEmpty()) null else {
                { StandardIconButton(Symbols.Close, clearLabel, { onQueryChange("") }, clearTag.tagged()) }
            },
        )
        HorizontalDivider()
    }
}

/**
 * Atom 1.9, **Search bar** (Figma 1114:1963): Material's collapsed search bar, a 56 dp pill with Material's own search
 * field in it. One setting of the design's: the pill is **Surface container highest** (Material's is Surface container
 * high). The search icon is On surface, the placeholder On surface variant; ✕ clears once something is typed.
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun SearchBarField(
    query: String,
    onQueryChange: (String) -> Unit,
    placeholder: String,
    modifier: Modifier = Modifier,
    fieldTag: String? = null,
    clearLabel: String = "Clear search",
) {
    Surface(modifier.fillMaxWidth(), shape = SearchBarDefaults.inputFieldShape, color = MaterialTheme.colorScheme.surfaceContainerHighest) {
        SearchBarDefaults.InputField(
            textFieldState = searchText(query, onQueryChange),
            searchBarState = rememberSearchBarState(SearchBarValue.Collapsed),
            onSearch = {},
            modifier = Modifier.fillMaxWidth().semantics { fieldTag?.let { testTag = it }; contentDescription = placeholder },
            placeholder = { Text(placeholder) },
            leadingIcon = { Icon(Symbols.Search, null) },
            trailingIcon = if (query.isEmpty()) null else {
                { StandardIconButton(Symbols.Close, clearLabel, { onQueryChange("") }) }
            },
        )
    }
}

/**
 * The Search bar as a button (Figma 1114:1963, State=Empty): the same pill, whose tap opens a full-screen search
 * ([SearchHeader]) instead of typing in place (the habit's notes).
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun SearchBarButton(placeholder: String, onClick: () -> Unit, modifier: Modifier = Modifier) {
    Surface(onClick, modifier.fillMaxWidth().semantics { role = Role.Button }, shape = SearchBarDefaults.inputFieldShape,
        color = MaterialTheme.colorScheme.surfaceContainerHighest) {
        Row(Modifier.heightIn(min = SearchBarDefaults.InputFieldHeight).padding(horizontal = 16.dp), verticalAlignment = Alignment.CenterVertically) {
            Icon(Symbols.Search, null, tint = MaterialTheme.colorScheme.onSurface)
            Spacer(Modifier.width(16.dp))
            Text(placeholder, style = AppType.bodyLarge, color = MaterialTheme.colorScheme.onSurfaceVariant)
        }
    }
}

/**
 * Material 1.5's search field keeps its text in a `TextFieldState`; the screens keep theirs as a String. This keeps the
 * two the same: what's typed goes to [onChange], and the screen's own value (cut to its length, cleared by ✕ or Back)
 * comes back into the field.
 */
@Composable
private fun searchText(query: String, onChange: (String) -> Unit): TextFieldState {
    val state = rememberTextFieldState(query)
    val latest by rememberUpdatedState(onChange)
    val current by rememberUpdatedState(query)
    LaunchedEffect(state) { snapshotFlow { state.text.toString() }.collect { if (it != current) latest(it) } }
    LaunchedEffect(query) { if (state.text.toString() != query) state.setTextAndPlaceCursorAtEnd(query) }
    return state
}

private fun String?.tagged(): Modifier = this?.let { t -> Modifier.semantics { testTag = t } } ?: Modifier
