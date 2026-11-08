# ~/.config/fish/config.fish

# --- PATH ---
fish_add_path $HOME/.cargo/bin $HOME/.local/bin

# --- Environment ---
set fish_greeting # disable the welcome message

set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx RIPGREP_CONFIG_PATH "$HOME/.ripgreprc"

# --- Colors ---
# kanagawa-dragon palette
set -gx LS_COLORS "di=38;2;127;180;202:fi=38;2;197;201;197:ln=38;2;147;138;169:ex=38;2;135;169;135:*.md=38;2;230;195;132:*.json=38;2;230;195;132:*.py=38;2;135;169;135:*.rs=38;2;196;116;110:*.toml=38;2;230;195;132"
set -gx EZA_COLORS $LS_COLORS

set -g fish_color_autosuggestion '#6c6c6c'
set -g fish_color_search_match --background=brblack
set -g fish_color_valid_path normal

set -g fish_pager_color_selected_background normal
set -g fish_pager_color_selected_foreground '#7fb4ca'
set -g fish_pager_color_selected_underline normal
set -g fish_pager_color_prefix cyan
set -g fish_pager_color_completion normal
set -g fish_pager_color_description brblack

# --- Vi mode & cursor ---
set -g fish_escape_delay_ms 10 # snappy Esc when switching vi modes
set -g fish_cursor_default block
set -g fish_cursor_insert line
set -g fish_cursor_visual block
set -g fish_cursor_replace_one underscore

# --- Abbreviations ---
# expand into the full command when you press Space/Enter

# fish
abbr -a fishrc "nvim ~/.config/fish/config.fish"
abbr -a fishrr "source ~/.config/fish/config.fish"

# python / uv
abbr -a sv "source .venv/bin/activate.fish"
abbr -a py python3
abbr -a rc "uv run ruff check"

# rust
abbr -a cr "cargo run"
abbr -a ct "cargo test"

# git
abbr -a gl "git log --oneline --graph --decorate"
abbr -a gds "git diff --stat"
abbr -a gs "git status -sb"

# misc
abbr -a zz "zellij --layout ~/.config/zellij/layouts/layout.kdl"

# --- Aliases ---
# drop-in replacements for existing commands
alias ls eza
alias cat bat
alias top btop
alias sshw "ssh Marci@windows.tail0212d0.ts.net"

# --- Functions ---
# open the journal TUI
function jj
    cd /Users/marci/Projects/journal && ./journal tui
end

# Tab: accept the whole suggestion, or complete if there is none
function fish_tab_handler
    if commandline --showing-suggestion
        commandline -f accept-autosuggestion
    else
        commandline -f complete
    end
end

# Shift-Tab: take just the next path component of the suggestion
function fish_shift_tab_handler
    if commandline --showing-suggestion
        commandline -f forward-path-component
    else
        commandline -f complete-and-search
    end
end

# --- Key bindings ---
function fish_user_key_bindings
    fish_vi_key_bindings

    # history navigation
    bind -M insert \cp up-or-search
    bind -M insert \cn down-or-search

    # backspace behaves the same in every mode
    bind -M insert \x7f backward-delete-char
    bind -M default \x7f backward-delete-char

    # Tab = accept suggestion / complete
    bind -M insert \t fish_tab_handler
    bind -M default \t fish_tab_handler

    # Ctrl-F = accept the whole suggestion (second way)
    bind -M insert \cf accept-autosuggestion

    # Shift-Tab = next path component of the suggestion
    bind -M insert shift-tab fish_shift_tab_handler
    bind -M default shift-tab fish_shift_tab_handler
end

# --- Interactive tools ---
if status is-interactive
    fzf --fish | source
    starship init fish | source
    zoxide init fish | source # defines z and zi
    alias cd z

    # must come after fzf, which binds shift-tab to fzf_complete
    bind -M insert shift-tab fish_shift_tab_handler
    bind -M default shift-tab fish_shift_tab_handler
end
