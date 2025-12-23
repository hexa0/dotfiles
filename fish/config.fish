if status is-interactive
    # Commands to run in interactive sessions can go here
end

if test -d ~/.local/share/.bun/
# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
end

function fish_greeting
    # empty greeting
end

set -g fish_greeting

if test -d ~/.local/share/pnpm/
# pnpm
set -gx PNPM_HOME "/home/hexa/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
end

# zoxide

if type -q zoxide
    zoxide init --cmd cd fish | source
end

# yabridge

if test -d ~/.local/share/yabridge/
    export PATH="$PATH:$HOME/.local/share/yabridge"
end

if test -d ~/miniconda3/
    # why can't it do this by itself is beyond me
    source ~/miniconda3/etc/fish/conf.d/conda.fish
end

# literally nobody asked for these
alias ffmpeg="ffmpeg -hide_banner"
alias ffprobe="ffprobe -hide_banner"
alias ffplay="ffplay -hide_banner"

# ssh stuff for termux
if test -f "$HOME/omen_ssh_ip.txt"
    set omen_ssh_ip = $(cat "~/omen_ssh_ip.txt")

    alias omenl="ssh hexa@omen.desktop" # in a LAN context we'll be on my dns server which will resolve it correctly
    alias omen="ssh hexa@$omen_ssh_ip" # otherwise we'll have the public ip get used instead which will be stored privately
end

fish_add_path /home/hexa/.spicetify
