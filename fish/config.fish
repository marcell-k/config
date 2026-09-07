fish_add_path $HOME/.cargo/bin $HOME/.local/bin
set fish_greeting

# custom ls
alias ls eza
set -gx EZA_COLORS "di=38;2;127;180;202:fi=38;2;197;201;197:ln=38;2;147;138;169:ex=38;2;135;169;135:*.md=38;2;230;195;132:*.json=38;2;230;195;132"

uv generate-shell-completion fish | source

set -gx EDITOR nvim

set -g fish_escape_delay_ms 10
set -g fish_cursor_default block
set -g fish_cursor_insert line
set -g fish_cursor_visual block
set -g fish_cursor_replace_one underscore

# Aliases
alias zshrc "nvim ~/.config/fish/config.fish"
alias zshrcrr "source ~/.config/fish/config.fish"

alias sv "source .venv/bin/activate.fish"
alias py python3
alias ub "uv run basedpyright"
alias rc "uv run ruff check"

alias cr "cargo run"
alias ct "cargo test"

alias gl "git log --oneline --graph --decorate"
alias gds "git diff --stat"

alias sshw "ssh Marci@windows.tail0212d0.ts.net"

function jj
    cd /Users/marci/Projects/journal && ./journal tui
end
alias zz "zellij --layout ~/.config/zellij/layouts/layout.kdl"

alias n nvim

fzf --fish | source

set -gx RIPGREP_CONFIG_PATH "$HOME/.ripgreprc"

starship init fish | source

source ~/.config/fish/zoxide-init.fish

set -g fish_color_autosuggestion '#6c6c6c'
set -g fish_pager_color_selected_background normal
set -g fish_pager_color_selected_foreground '#7fb4ca'
set -g fish_pager_color_selected_underline normal
set -g fish_pager_color_prefix cyan
set -g fish_pager_color_completion normal
set -g fish_pager_color_description brblack
set -g fish_color_search_match --background=brblack
set -g fish_color_valid_path normal

function fish_tab_handler
    commandline -f accept-autosuggestion
    or commandline -f complete
end

function fish_user_key_bindings
    fish_vi_key_bindings
    bind -M insert \cp up-or-search
    bind -M insert \cn down-or-search
    bind -M insert \x7f backward-delete-char
    bind -M default \x7f backward-delete-char
    bind -M insert \t fish_tab_handler
    bind -M default \t fish_tab_handler
    bind -M insert \cx\cl complete
    bind -M default \cx\cl complete
end

set -gx FZF_DEFAULT_COMMAND "fd --type f --hidden --exclude .git"
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -gx FZF_ALT_C_COMMAND "fd --type d --hidden --exclude .git"
