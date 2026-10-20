# Neovim Cheatsheet

`<leader>` = `Space`

---

## 1. Macros

| Keys | Action |
|------|--------|
| `qa` ... `q` | Record into `a`, stop |
| `@a` / `@@` | Play / replay last |
| `5@a` | Play 5 times |
| `:%normal @a` | Run on every line |
| `:'<,'>normal @a` | Run on selection |

Start at a fixed spot (`0`), end with `j` so it chains.

**Example: trailing comma**

```
apple      apple,
banana  -> banana,
cherry     cherry,
```

`qa` `A,` `Esc` `j` `q`, then `2@a`

---

## 2. Search and Replace

| Command | Action |
|---------|--------|
| `:%s/old/new/g` | Replace all in file |
| `:%s/old/new/gc` | Confirm each |
| `:'<,'>s/old/new/g` | Selection only |
| `:%s/\s\+$//e` | Strip trailing whitespace |

**No-regex way:** `*` on word, `cgn` + new text + `Esc`, then `.` per match (`n` skips).

Captures: `\v(\w+)=(\w+)` then `\2=\1` swaps both sides.

---

## 3. Marks

| Keys | Action |
|------|--------|
| `ma` / `mA` | Set local / global mark |
| `'a` | Jump to line |
| `<leader>j` `a` | Jump to exact line + column |
| `Ctrl + o` / `Ctrl + i` | Jumplist back / forward |
| `g;` / `g,` | Prev / next change |

---

## 4. Edit

| Keys | Action |
|------|--------|
| `.` | Repeat last change |
| `ciw` / `ci"` / `ci(` | Change word / quotes / parens |
| `dap` | Delete paragraph |
| `gv` | Reselect visual |
| `gi` | Back to last insert spot |
| `Ctrl + a` / `Ctrl + x` | Increment / decrement number |
| `Ctrl + v` `I` text `Esc` | Insert on many lines |
| `gcc` / `gc` (visual) | Comment |
| `"_d` | Delete without clobbering clipboard |
| `"0p` | Paste last yank |

**Surround**

| Keys | Action |
|------|--------|
| `ysiw"` | Surround word |
| `cs"'` | Change `"` to `'` |
| `ds"` | Delete surround |
| `S"` (visual) | Surround selection |

**Global**

| Command | Action |
|---------|--------|
| `:g/pat/d` | Delete matching lines |
| `:v/pat/d` | Delete non-matching lines |
| `:g/pat/normal A;` | Run keys on matching lines |

---

## 5. Debug

| Keys | Action |
|------|--------|
| `<leader>db` | Breakpoint |
| `<leader>dc` | Continue / start |
| `<leader>do` / `di` / `dO` | Step over / into / out |
| `<leader>dt` | Terminate |
| `<leader>dv` | Toggle dap-view |
| `<leader>dm` | Debug pytest method |

dap-view tabs: `W` watches, `S` scopes, `B` breakpoints, `R` REPL. Empty view = wrong tab, press `S`.

- **Python:** breakpoint, `<leader>dc`, "Launch file".
- **Rust:** breakpoint, `:RustLsp debuggables`, pick debug target.

---

## 6. Command Line

| Keys | Action |
|------|--------|
| `q:` | Editable command history |
| `@:` | Repeat last command |
| `Ctrl + f` (in cmdline) | Open cmdline as editable window |
