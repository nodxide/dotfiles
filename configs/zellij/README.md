# Zellij Configuration & Keybindings — Elaris

A reference for the single-file Elaris Zellij configuration in `~/.config/zellij/config.kdl`. It documents the custom settings, the embedded Elaris theme, the custom keybindings, and the default bindings that remain enabled.

> **Configuration model:** this is a custom keymap layered over Zellij's defaults. The configuration does not set `clear-defaults=true`, so default bindings remain available unless a key is explicitly overridden or unbound.

## Contents

- [Configuration overview](#configuration-overview)
- [Key notation](#key-notation)
- [Global shortcuts](#global-shortcuts)
- [Mode reference](#mode-reference)
- [Normal mode](#normal-mode)
- [Locked mode](#locked-mode)
- [Resize mode](#resize-mode)
- [Pane mode](#pane-mode)
- [Move mode](#move-mode)
- [Tab mode](#tab-mode)
- [Scroll mode](#scroll-mode)
- [Search mode](#search-mode)
- [EnterSearch mode](#entersearch-mode)
- [RenameTab mode](#renametab-mode)
- [RenamePane mode](#renamepane-mode)
- [Session mode](#session-mode)
- [Settings reference](#settings-reference)
- [Elaris theme palette](#elaris-theme-palette)
- [Common workflows](#common-workflows)
- [Notes and validation](#notes-and-validation)

## Configuration overview

| Setting | Current value | Purpose |
|---|---|---|
| Config file | `~/.config/zellij/config.kdl` | One file contains settings, keybindings, and the `elaris` theme. |
| Default shell | `fish` | Shell used when Zellij opens a new shell pane. |
| Default layout | `compact` | Layout selected for a new session unless overridden. |
| Scrollback buffer | `50000` rows per pane | Keeps a large history for long-running commands and logs. |
| Scrollback editor | `nvim` | Editor opened by the scrollback-editor action. |
| Simplified UI | Enabled | Requests simplified plugin UI elements. |
| Startup tips / release notes | Disabled | Suppresses startup tips and first-run release notes. |
| OSC 8 hyperlinks | Enabled | Allows terminal hyperlinks where the terminal emulator supports them. |
| Mouse hover effects | Enabled | Shows Zellij's hover-related visual feedback. |
| Visual bell | Disabled | Prevents bell events from producing visual alerts. |
| Pane frame style | `full` | Uses full pane borders rather than title-only frames. |
| Pane frame corners | Rounded | Requests rounded pane-frame corners. |
| Session name in pane frames | Hidden | Keeps session names out of pane frames. |
| Theme | `elaris` | Uses the custom Elaris palette embedded in the same file. |

## Key notation

- `Ctrl + P` means hold **Ctrl** and press **P**.
- `Alt + H` means hold **Alt** and press **H**.
- `Shift + H` means hold **Shift** and press **H** (uppercase `H` in KDL keybinds).
- `h / Left` means either the `h` key or the left-arrow key is accepted.
- A mode-entry chord such as `Ctrl + P` enters a mode; the next key performs an action in that mode.
- `Normal` is the usual mode. `Locked` temporarily disables Zellij's usual key handling so keys can reach the application running in a pane.

## Global shortcuts

These are defined in `shared_except` blocks. The exclusions matter: global shortcuts are intentionally disabled while entering a search query or editing a tab/pane name, so typing is not intercepted by Zellij's mode bindings.

| Shortcut | Action | Availability / notes |
|---|---|---|
| `Ctrl + P` | Enter Pane mode | Except when already in Pane or Locked mode, and during search/name text entry. |
| `Ctrl + N` | Enter Resize mode | Same text-entry exclusions. |
| `Ctrl + H` | Enter Move mode | Same text-entry exclusions. |
| `Ctrl + T` | Enter Tab mode | Same text-entry exclusions. |
| `Ctrl + S` | Enter Scroll mode | Not bound this way in Scroll, Search, Locked, or text-entry modes. |
| `Ctrl + O` | Enter Session mode | Not bound this way in Session, Locked, or text-entry modes. |
| `Ctrl + G` | Enter Locked mode | Not available in Locked, RenameTab, RenamePane, or EnterSearch. Press again in Locked mode to unlock. |
| `Ctrl + Q` | Quit Zellij | Not available in Locked, RenameTab, RenamePane, or EnterSearch. Use carefully. |
| `Enter` / `Esc` | Return to Normal mode | Applies to operational modes except Normal, Locked, EnterSearch, RenameTab, and RenamePane. Those modes define their own behavior. |
| `Alt + H` / `Alt + Left` | Focus left pane or previous tab | Uses `MoveFocusOrTab`. |
| `Alt + J` / `Alt + Down` | Focus pane below | Uses `MoveFocus`. |
| `Alt + K` / `Alt + Up` | Focus pane above | Uses `MoveFocus`. |
| `Alt + L` / `Alt + Right` | Focus right pane or next tab | Uses `MoveFocusOrTab`. |
| `Alt + =` / `Alt + +` | Increase pane size | Global resize action. |
| `Alt + -` | Decrease pane size | Global resize action. |

## Mode reference

| Mode | How to enter | Primary use |
|---|---|---|
| Normal | Default mode | Normal terminal work; Zellij's default Normal-mode bindings remain available. |
| Locked | `Ctrl + G` | Temporarily pass most keypresses through to the application. Press `Ctrl + G` again to unlock. |
| Resize | `Ctrl + N` | Resize the focused pane with directional keys. |
| Pane | `Ctrl + P` | Focus, create, display, pin, float, close, or rename panes. |
| Move | `Ctrl + H` | Move the focused pane within the layout. |
| Tab | `Ctrl + T` | Switch, reorder, create, close, rename, or synchronize tabs. |
| Scroll | `Ctrl + S` | Inspect pane history, use the scrollback editor, or begin a search. |
| EnterSearch | Scroll mode → `s` | Enter a search query. |
| Search | EnterSearch → type query → `Enter` | Navigate matches and adjust search options. |
| RenameTab | Tab mode → `r` | Rename the active tab. |
| RenamePane | Pane mode → `c` | Rename the focused pane. |
| Session | `Ctrl + O` | Open the Session Manager or detach from the session. |

## Normal mode

The custom `normal {}` block is intentionally empty. This leaves Zellij's default Normal-mode bindings in place while the shared blocks define the custom global shortcuts above. As a result, this document lists the **custom** bindings, not every binding active in Normal mode.

## Locked mode

Enter with `Ctrl + G` from modes where the global lock binding is available.

| Shortcut | Action |
|---|---|
| `Ctrl + G` | Return to Normal mode (unlock Zellij). |

While Locked mode is active, Zellij's normal keybinding handling is suspended so application shortcuts can be used more directly. This is useful for terminal editors such as Neovim, but it is not a separate Zellij pane-management mode.

## Resize mode

Enter with `Ctrl + N`. Lowercase directional keys increase size; uppercase directional keys decrease size.

| Shortcut | Action |
|---|---|
| `h` / `Left` | Increase size toward the left. |
| `j` / `Down` | Increase size downward. |
| `k` / `Up` | Increase size upward. |
| `l` / `Right` | Increase size toward the right. |
| `H` | Decrease size toward the left. |
| `J` | Decrease size downward. |
| `K` | Decrease size upward. |
| `L` | Decrease size toward the right. |
| `=` / `+` | Increase size. |
| `-` | Decrease size. |
| `Ctrl + N` | Return to Normal mode. |
| `Enter` / `Esc` | Return to Normal mode through the shared operational-mode binding. |

## Pane mode

Enter with `Ctrl + P`.

| Shortcut | Action |
|---|---|
| `h` / `Left` | Focus the pane to the left. |
| `j` / `Down` | Focus the pane below. |
| `k` / `Up` | Focus the pane above. |
| `l` / `Right` | Focus the pane to the right. |
| `p` | Switch focus between panes. |
| `n` | Create a pane using the default direction. |
| `d` | Create a pane below. |
| `r` | Create a pane to the right. |
| `s` | Create a stacked pane. |
| `f` | Toggle fullscreen for the focused pane. |
| `z` | Toggle pane frames. |
| `w` | Toggle floating panes. |
| `e` | Toggle the focused pane between embedded and floating. |
| `i` | Toggle the focused pane's pinned state. |
| `x` | Close the focused pane. |
| `c` | Enter RenamePane mode. |
| `Ctrl + P` | Return to Normal mode. |
| `Enter` / `Esc` | Return to Normal mode through the shared operational-mode binding. |

## Move mode

Enter with `Ctrl + H`. Directional movement returns to Normal mode immediately after the move.

| Shortcut | Action |
|---|---|
| `h` / `Left` | Move the focused pane left. |
| `j` / `Down` | Move the focused pane down. |
| `k` / `Up` | Move the focused pane up. |
| `l` / `Right` | Move the focused pane right. |
| `n` / `Tab` | Move the pane through the layout order. |
| `Ctrl + H` | Return to Normal mode. |
| `Enter` / `Esc` | Return to Normal mode through the shared operational-mode binding. |

## Tab mode

Enter with `Ctrl + T`. The default `Up`, `k`, `Down`, and `j` bindings are explicitly unbound in this mode so vertical movement keys are not used for tab navigation.

| Shortcut | Action |
|---|---|
| `h` / `Left` | Switch to the previous tab. |
| `l` / `Right` | Switch to the next tab. |
| `Shift + H` | Move the active tab left. |
| `Shift + L` | Move the active tab right. |
| `n` | Create a new tab. |
| `x` | Close the active tab. |
| `r` | Enter RenameTab mode. |
| `s` | Toggle synchronized input across panes in the active tab. |
| `1`–`9` | Switch directly to the tab with that index. |
| `Tab` | Toggle between tabs. |
| `Ctrl + T` | Return to Normal mode. |
| `Enter` / `Esc` | Return to Normal mode through the shared operational-mode binding. |

## Scroll mode

Enter with `Ctrl + S`. Use this mode to review long command output without losing the live terminal session.

| Shortcut | Action |
|---|---|
| `j` / `Down` | Scroll down one line. |
| `k` / `Up` | Scroll up one line. |
| `Ctrl + F` / `PageDown` / `Right` / `l` | Scroll down one page. |
| `Ctrl + B` / `PageUp` / `Left` / `h` | Scroll up one page. |
| `d` | Scroll down half a page. |
| `u` | Scroll up half a page. |
| `s` | Enter EnterSearch mode and begin a search. |
| `e` | Open the scrollback buffer in `nvim`. After the editor action is invoked, return to Normal mode. |
| `Ctrl + C` | Jump to the bottom of the output and return to Normal mode. |
| `Ctrl + S` | Return to Normal mode without forcing the scroll position to the bottom. |
| `Enter` / `Esc` | Return to Normal mode through the shared operational-mode binding; unlike `Ctrl + C`, this does not explicitly jump to the bottom. |

## Search mode

Start from Scroll mode with `s`, type the search query in EnterSearch mode, and press `Enter` to enter Search mode.

| Shortcut | Action |
|---|---|
| `n` | Move to the next match (`Search "down"`). |
| `p` | Move to the previous match (`Search "up"`). |
| `c` | Toggle case sensitivity. |
| `w` | Toggle wrapping. |
| `o` | Toggle whole-word matching. |
| `j` / `Down` | Scroll down one line. |
| `k` / `Up` | Scroll up one line. |
| `Ctrl + F` / `PageDown` / `Right` / `l` | Scroll down one page. |
| `Ctrl + B` / `PageUp` / `Left` / `h` | Scroll up one page. |
| `d` / `u` | Scroll down / up half a page. |
| `Ctrl + C` | Jump to the bottom and return to Normal mode. |
| `Ctrl + S` | Return to Normal mode. |
| `Enter` / `Esc` | Return to Normal mode via the shared operational-mode binding. |

## EnterSearch mode

This is the text-entry phase of scrollback search. Global mode-entry shortcuts are excluded here to avoid intercepting the search query.

| Shortcut | Action |
|---|---|
| Type text | Enter the search query. |
| `Enter` | Confirm the query and enter Search mode. |
| `Esc` / `Ctrl + C` | Cancel the query and return to Scroll mode. |

## RenameTab mode

Enter from Tab mode with `r`. Global mode-entry and global navigation shortcuts are excluded while the tab name is being edited.

| Input | Action |
|---|---|
| Type text | Edit the tab name. |
| `Esc` | Undo the rename and return to Tab mode. |
| `Ctrl + C` | Return to Normal mode. |

## RenamePane mode

Enter from Pane mode with `c`. Global mode-entry and global navigation shortcuts are excluded while the pane name is being edited.

| Input | Action |
|---|---|
| Type text | Edit the pane name. |
| `Esc` | Undo the rename and return to Pane mode. |
| `Ctrl + C` | Return to Normal mode. |

## Session mode

Enter with `Ctrl + O`.

| Shortcut | Action |
|---|---|
| `w` | Launch or focus the `session-manager` plugin, then switch to Normal mode. |
| `d` | Detach from the current session. |
| `Ctrl + O` | Return to Normal mode. |
| `Enter` / `Esc` | Return to Normal mode through the shared operational-mode binding. |

To create or reconnect to a named session from a shell, use `zellij attach --create <session-name>`; to list sessions, use `zellij list-sessions`. These are CLI commands, not keybindings from this file.

## Settings reference

| Setting | Value | Practical effect |
|---|---|---|
| `simplified_ui` | `true` | Asks plugins to use a simplified UI presentation. |
| `default_shell` | `"fish"` | Starts Fish in new shell panes by default. |
| `default_layout` | `"compact"` | Uses the `compact` layout for new sessions unless another layout is specified. |
| `scroll_buffer_size` | `50000` | Retains up to 50,000 display rows per pane; larger buffers use more memory, especially with many panes. |
| `scrollback_editor` | `"nvim"` | Uses Neovim for editing scrollback. |
| `show_startup_tips` | `false` | Hides startup tips. |
| `show_release_notes` | `false` | Hides release notes. |
| `osc8_hyperlinks` | `true` | Enables OSC 8 hyperlink support, subject to terminal-emulator support. |
| `mouse_hover_effects` | `true` | Enables hover-related UI feedback. |
| `visual_bell` | `false` | Disables visual bell notifications. |
| `pane_frame_style` | `"full"` | Uses full pane borders. |
| `ui.pane_frames.rounded_corners` | `true` | Requests rounded frame corners. |
| `ui.pane_frames.hide_session_name` | `true` | Hides the session name in pane frames. |
| `theme` | `"elaris"` | Selects the custom theme defined in the `themes` block in the same file. |

## Elaris theme palette

The `elaris` theme is embedded in `config.kdl`, so no separate theme file is required. It uses charcoal surfaces and muted lavender-gray text, with lime for focus, teal for secondary emphasis, and copper for transient highlights.

| Role | Hex | Use in the theme |
|---|---|---|
| Main background | `#17171D` | Terminal/UI background. |
| Raised black | `#252530` | ANSI black / raised surface. |
| Main foreground | `#EBE7E1` | Primary text. |
| Secondary text | `#B8AFBE` | Unselected UI labels and less prominent text. |
| Inactive border | `#41414D` | Unfocused pane frames. |
| Focus lime | `#DBE4A8` | Selected tab ribbon, focused pane frame, primary emphasis. |
| Teal | `#9FD4C5` | Secondary emphasis and selected UI hints. |
| Soft blue | `#B8CEF0` | Additional UI emphasis. |
| Lilac | `#D2B7EE` | Additional UI emphasis. |
| Amber | `#E5C98F` | Warnings / additional emphasis. |
| Sage | `#BEDAA4` | Success / green ANSI color. |
| Copper | `#F0B394` | Highlighted pane frame and warm accent. |
| Error coral | `#EF9BA4` | Error exit status / red ANSI color. |
| Selected surface | `#343440` | Selected list/text/table background. |

### Theme component mapping

| Component | Visual role |
|---|---|
| `text_unselected` / `text_selected` | General interface text and selected text. |
| `ribbon_unselected` / `ribbon_selected` | Inactive and active tabs or mode ribbons. |
| `table_title`, `table_cell_unselected`, `table_cell_selected` | Table headers, normal cells, and selected cells. |
| `list_unselected`, `list_selected` | Normal and selected list rows. |
| `frame_unselected`, `frame_selected`, `frame_highlight` | Inactive pane border, focused pane border, and transient mode/hover highlight. |
| `exit_code_success`, `exit_code_error` | Successful and failed command exit status indicators. |
| `multiplayer_user_colors` | Distinct colors for up to ten users in shared sessions. |

## Common workflows

### Create a pane to the right

1. Press `Ctrl + P` to enter Pane mode.
2. Press `r` to create a right-hand pane.
3. Zellij returns to Normal mode after the pane is created.

### Resize a pane

1. Press `Ctrl + N` to enter Resize mode.
2. Press `h`, `j`, `k`, or `l` to expand in a direction; use `H`, `J`, `K`, or `L` to shrink in a direction.
3. Press `Enter`, `Esc`, or `Ctrl + N` to return to Normal mode.

### Reorder tabs

1. Press `Ctrl + T` to enter Tab mode.
2. Press `Shift + H` to move the tab left or `Shift + L` to move it right.
3. Use `h` / `l` to navigate between tabs, or `1`–`9` to go directly to a tab.

### Search scrollback

1. Press `Ctrl + S` to enter Scroll mode.
2. Press `s`, enter a query, then press `Enter`.
3. Use `n` and `p` for next and previous matches; `c`, `w`, and `o` change search options.
4. Press `Ctrl + C` to jump to the bottom and return to Normal mode, or `Esc` / `Enter` to leave Search mode without explicitly scrolling to the bottom.

### Open the Session Manager

1. Press `Ctrl + O` to enter Session mode.
2. Press `w` to launch or focus the Session Manager plugin.
3. Press `d` to detach from the current session instead.

### Pass a shortcut to Neovim or another terminal app

Press `Ctrl + G` to enter Locked mode, use the application shortcut, then press `Ctrl + G` again to return to Normal mode. This is useful when an application uses the same key chord as Zellij.

## Notes and validation

- **This file documents custom bindings, not every active shortcut.** Since `clear-defaults=true` is not set, Zellij's default bindings remain available wherever they are not overridden or explicitly unbound. The custom `tab` block specifically unbinds `Up`, `k`, `Down`, and `j` for that mode.
- **Key conflicts are expected in a mode-based terminal multiplexer.** `Ctrl + P`, `Ctrl + N`, `Ctrl + H`, `Ctrl + T`, `Ctrl + S`, and `Ctrl + O` are also used by some applications. Locked mode provides a way to use those application shortcuts.
- **Scrollback memory:** `scroll_buffer_size 50000` is per pane. It is appropriate for long logs but increases memory use when many panes are active.
- **One-file setup:** all settings, `keybinds`, and the `themes` definition live in `~/.config/zellij/config.kdl`; no concatenation or include step is required.

Back up the file before editing, then validate it with Zellij:

```bash
cp ~/.config/zellij/config.kdl ~/.config/zellij/config.kdl.bak
zellij setup --check
```

Start a new session after validation and test mode transitions, search, session-manager access, and pane operations. `zellij setup --check` checks the active configuration; it does not prove that every action will behave as intended on every installed Zellij version.

## Official references

- [Zellij keybindings](https://zellij.dev/documentation/keybindings)
- [Keybinding modes](https://zellij.dev/documentation/keybindings-modes)
- [Shared bindings](https://zellij.dev/documentation/keybindings-shared)
- [Binding and overriding keys](https://zellij.dev/documentation/keybindings-binding)
- [Configuration options](https://zellij.dev/documentation/options)
- [Themes](https://zellij.dev/documentation/themes)
