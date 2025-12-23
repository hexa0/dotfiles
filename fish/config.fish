if status is-interactive
    # Commands to run in interactive sessions can go here
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

function fish_greeting
    # empty greeting
end

set -g fish_greeting

# pnpm
set -gx PNPM_HOME "/home/hexa/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# zoxide

zoxide init --cmd cd fish | source

# yabridge

export PATH="$PATH:$HOME/.local/share/yabridge"

# why
source ~/miniconda3/etc/fish/conf.d/conda.fish

# stupid
alias ffmpeg="ffmpeg -hide_banner"
alias ffprobe="ffprobe -hide_banner"
alias ffplay="ffplay -hide_banner"

fish_add_path /home/hexa/.spicetify
