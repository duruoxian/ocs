# ocs Tutorial / 使用教程

English | [简体中文](TUTORIAL.zh-CN.md)

> **Open Coding Sessions** — a session picker for opencode / claude code / codex.
> Open it by typing `ocs` in your terminal. Press `esc` anywhere to quit.

---

## 1. Browsing

| Key | Effect |
|---|---|
| `ocs` | Open the session list (the facade shows the current tool's logo and its sessions, grouped by directory, newest first) |
| Click/Enter a **tool row** on top | Switch between opencode / claude code / codex (last choice remembered; uninstalled tools just say "no sessions yet") |
| Type | Filter — searches **titles and conversation content** |
| `↑` `↓` | Move; live preview on the right |
| `Enter` / double-click | Resume the session; when the CLI exits you're back in the list |
| Scroll wheel | Scroll the list |
| `ctrl-y` | Copy the current session ID to the clipboard |

## 2. Conversation view (reading a chat)

| Key | Effect |
|---|---|
| `→` | Open the conversation view for the selected session |
| — | By default only **your questions** are listed, one per line |
| **Click a question** (or `→` on it) | Expand that question's **AI answer** (long answers wrap) |
| Click again | Collapse it |
| `←` or click "← back" | Return to the session list |
| Right pane | Shows the full Q&A of whatever the cursor is on |

## 3. Copying text

| Key | Effect |
|---|---|
| **Right-click once** (or `F8`) | Hand the mouse to the terminal: **drag = select**, **right-click = copy menu** (no Shift needed) |
| `F8` again | Back to click mode (arrow cursor, clickable list) |

> The mouse can only belong to one "owner" at a time. Normally it belongs to the program
> (so the list is clickable); one right-click hands it to the terminal for normal
> text selection. **Windows doesn't need this** — just drag and right-click → Copy.

## 4. Housekeeping

| Key | Effect |
|---|---|
| `ctrl-r` | Rename a session (opencode) |
| `ctrl-d` | Delete: on a session = that one; on a group header = the whole group; after `tab` multi-select (or `ctrl-a`) = bulk delete |
| `ctrl-e` | Fork & resume a copy of the session (opencode) |
| `tab` | Multi-select / deselect |
| `esc` | Quit |

## 5. Command line (optional)

```bash
ocs                     # the everyday command
ocs -p /path/dir       # only sessions under this directory
ocs --last [N]         # resume the Nth most recent session directly
ocs --show ID          # inspect a session (m:<tool>:<session>:<n> shows one message)
ocs --delete ID...     # delete sessions (with confirmation)
ocs -l                 # plain-text list (for pipes/scripts)
ocs -h                 # full help
```

---

### Tips

- **Finding old sessions**: just type what you remember — e.g. "install" finds every
  session that ever discussed installing, even if the title is English.
- **Across all three tools**: `ocs -l` mixes all installed tools in one listing — handy for scripts.
- **Resizing**: column widths follow your terminal window.
- **Install**: Linux/macOS `./install.sh` (macOS needs `brew install fzf`); Windows `./install.ps1`.
