# Neovim Cheatsheet

Tailored to your LazyVim config. `<leader>` = `Space`.

---

## 1. Macros

Record, replay, repeat.

| Keys | Action |
|------|--------|
| `qa` | Start recording into register `a` |
| `q` | Stop recording |
| `@a` | Play macro `a` |
| `@@` | Replay last macro |
| `10@a` | Play macro 10 times |
| `:%normal @a` | Run macro on every line |
| `:'<,'>normal @a` | Run macro on visual selection |
| `"ap` | Paste macro as text (edit it, then `"ayy` back, `0"ay$`) |

### Example: add trailing comma to each line

Before:

```
apple
banana
cherry
```

Steps:

1. Cursor on `apple`.
2. `qa` start recording.
3. `A,` `Esc` append comma.
4. `j` move down.
5. `q` stop.
6. `2@a` replay for remaining lines.

Result:

```
apple,
banana,
cherry,
```

Tip: end macro with `j` so it chains down the file. Use `100@a`, stops at last line on error.

---

## 2. Search and Replace

### Basics

| Command | Action |
|---------|--------|
| `:%s/old/new/g` | Replace all in file |
| `:%s/old/new/gc` | Replace all, confirm each (`y`/`n`/`a`/`q`) |
| `:'<,'>s/old/new/g` | Replace in visual selection |
| `:s/old/new/` | Current line, first match |
| `:%s/old/new/gn` | Count matches only, no change |
| `:%s//new/g` | Reuse last search pattern |
| `&` | Repeat last `:s` on current line |

`incsearch` is on: preview updates as you type.

### Grouping

`\(...\)` captures. `\1`, `\2` recall. `\0` or `&` = whole match.
Prefix `\v` (very magic) to skip backslash noise.

Swap `key=value` to `value=key`:

```vim
:%s/\v(\w+)\=(\w+)/\2=\1/g
```

Swap Python call args:

```vim
:%s/\vfoo\((\w+), (\w+)\)/foo(\2, \1)/g
```

Rename `snake_case` to `camelCase`:

```vim
:%s/\v_(\w)/\u\1/g
```

Wrap word in quotes:

```vim
:%s/\v<(\w+)>/"\1"/g
```

### Case escapes in replacement

| Escape | Effect |
|--------|--------|
| `\u\1` | Uppercase first char |
| `\U\1\E` | Uppercase group until `\E` |
| `\L\1\E` | Lowercase group |

### Useful regex bits

| Pattern | Meaning |
|---------|---------|
| `\v<word>` | Whole word match |
| `\s\+$` | Trailing whitespace |
| `^\s*$` | Blank line |
| `.\{-}` | Non-greedy `.*` |

Strip trailing whitespace:

```vim
:%s/\s\+$//e
```

### No-regex alternative: `cgn` loop

1. `*` on word (or `/pattern` `Enter`).
2. `cgn` type replacement `Esc`.
3. `.` to apply to next match. Repeat. Skip with `n`.

### Project-wide

- `<leader>sr`: grug-far (search and replace across files).

---

## 3. Marks: Place and Jump

| Keys | Action |
|------|--------|
| `ma` | Set mark `a` (file-local) |
| `mA` | Set global mark `A` (works across files) |
| `'a` | Jump to line of mark `a` |
| `` `a `` | Jump to exact line and column |
| `<leader>j` + `a` | Your remap of `` ` ``: exact jump |
| `` `` `` | Jump back to previous position |
| `` `. `` | Last change |
| `` `^ `` | Last insert exit |
| `` `[ `` / `` `] `` | Start / end of last yank or change |
| `:marks` | List marks |
| `:delmarks a` | Delete mark `a` |
| `:delmarks!` | Delete all lowercase marks |

Combine with operators: `d'a` delete to mark line, `y` + `<leader>j` + `a` yank to exact mark.

Jumplist (separate from marks):

| Keys | Action |
|------|--------|
| `Ctrl + o` | Back in jumplist |
| `Ctrl + i` | Forward in jumplist |
| `g;` | Previous change position |
| `g,` | Next change position |

Workflow: `mA` in file one, edit elsewhere, `'A` to return from any buffer.

---

## 4. Small Keymaps Worth Knowing

### Edit

| Keys | Action |
|------|--------|
| `.` | Repeat last change |
| `ciw` | Change word |
| `ci"` | Change inside quotes |
| `ci(` | Change inside parens |
| `dap` | Delete paragraph |
| `gi` | Go to last insert spot and enter insert |
| `gv` | Reselect last visual selection |
| `J` | Join line below |
| `gJ` | Join without space |
| `~` | Toggle case of char |
| `gUiw` / `guiw` | Upper / lower word |
| `Ctrl + a` / `Ctrl + x` | Increment / decrement number |
| `g Ctrl + a` (visual) | Sequential increment (1,2,3...) |
| `Ctrl + v` + `I` + text + `Esc` | Insert on many lines (block insert) |

### Surround (nvim-surround)

| Keys | Action |
|------|--------|
| `ysiw"` | Surround word with `"` |
| `cs"'` | Change `"` to `'` |
| `ds"` | Delete surrounding `"` |
| `S"` (visual) | Surround selection |

### Move and find

| Keys | Action |
|------|--------|
| `s` | Flash jump (type 2 chars, pick label) |
| `4` | End of line (your remap of `$`) |
| `%` | Jump to matching bracket |
| `*` / `#` | Search word under cursor fwd / back |
| `Ctrl + d` / `Ctrl + u` | Half page, centered |
| `n` / `N` | Next / prev match, centered |

### Registers

| Keys | Action |
|------|--------|
| `"ayy` | Yank line into register `a` |
| `"Ayy` | Append line to register `a` |
| `"ap` | Paste register `a` |
| `"_d` | Delete without clobbering clipboard |
| `"0p` | Paste last yank (not last delete) |
| `:reg` | List registers |
| `Ctrl + r` `Ctrl + w` (cmdline) | Insert word under cursor |

### Global command

| Command | Action |
|---------|--------|
| `:g/pattern/d` | Delete all lines matching |
| `:v/pattern/d` | Delete all lines NOT matching |
| `:g/pattern/normal A;` | Run normal keys on matching lines |
| `:g/^$/d` | Delete blank lines |

### Your custom maps

| Keys | Action |
|------|--------|
| `Ctrl + n` / `Ctrl + b` | Next / prev buffer |
| `<leader>bd` | Delete buffer, keep split |
| `Option + j` / `Option + k` | Move line / selection down / up |
| `Option + l` / `Option + h` | Indent / unindent |
| `<leader>cs` | Insert section divider |
| `<leader>cp` | Python one-line docstring |
| `<leader>vd` | Diagnostic float |
| `Ctrl + .` (insert) | Insert `;` |
| `gcc` / `gc` (visual) | Comment line / selection |

### Command line

| Keys | Action |
|------|--------|
| `q:` | Command history window (editable) |
| `@:` | Repeat last command |
| `Ctrl + f` (in cmdline) | Open cmdline in editable window |

---
