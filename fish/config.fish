if status is-interactive
    # Commands to run in interactive sessions can go here
end

if test -d $HOME/.bun/
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

# python

if test -d ~/miniconda3/
    # why can't it do this by itself is beyond me
    source ~/miniconda3/etc/fish/conf.d/conda.fish
end

# literally nobody asked for these

alias ffmpeg="ffmpeg -hide_banner"
alias ffprobe="ffprobe -hide_banner"
alias ffplay="ffplay -hide_banner"

# termux stuff

if test -f "$HOME/omen_ssh_ip.txt"
    set omen_ssh_ip $(cat "$HOME/omen_ssh_ip.txt")

    alias omenl="ssh hexa@omen.desktop" # in a LAN context we'll be on my dns server which will resolve it correctly
    alias omen="ssh hexa@$omen_ssh_ip -p 23" # otherwise we'll have the public ip get used instead which will be stored privately
    alias cl=clear
end

# spicetify

if test -d ~/.spicetify/
	fish_add_path ~/.spicetify
end

# dotnet

if test -d ~/.dotnet/tools/
    fish_add_path ~/.dotnet/tools
end

# roblox wally

if test -d ~/wally/
    fish_add_path ~/wally
end

# roblox zap

if test -d ~/zap/
    fish_add_path ~/zap
end

if test -d ~/.path/
	fish_add_path ~/.path
end

# roblox rokit

if test -d ~/.rokit/bin/
	fish_add_path  ~/.rokit/bin
end

# wii homebrew

if test -d /opt/devkitpro
    set -gx DEVKITPRO /opt/devkitpro
    set -gx DEVKITPPC $DEVKITPRO/devkitPPC
    
    fish_add_path $DEVKITPRO/tools/bin
end

# ps2 homebrew

if test -d /usr/local/ps2dev/
	set -gx PS2DEV /usr/local/ps2dev
	set -gx PS2SDK $PS2DEV/ps2sdk
	set -gx GSKIT $PS2DEV/gsKit

	fish_add_path $PS2DEV/bin
	fish_add_path $PS2DEV/ee/bin
	fish_add_path $PS2DEV/iop/bin
	fish_add_path $PS2DEV/dvp/bin
end

# odin

#if test -d ~/odin/
#    fish_add_path ~/odin
#end

# why

if test -d /usr/share/antigravity/
	# not even sure if this will work but it's completely busted so whatever
	source /usr/share/antigravity/resources/app/out/vs/workbench/contrib/terminal/common/scripts/shellIntegration.fish

	function __force_ag_unstick --on-event fish_prompt
        if set -q _vsc_has_cmd
            printf "force exit code \e]633;D\a"
            set -e _vsc_has_cmd
        end
    end
end
