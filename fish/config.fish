if status is-interactive
    # Commands to run in interactive sessions can go here
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# greeting for furries lmfao

function fish_greeting
	#echo Welcome to fish, the friendly interactive shell
	#echo Type (set_color green)help(set_color normal) for instructions on how to use fish
	#echo Also you\'re a furry lol
    #    echo (set_color blue)owo(set_color normal)
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

# dotslashless shell scripts

function dotslashless_enabled
   return 1
end

if dotslashless_enabled
    function fish_command_not_found
        set -l script_path (pwd)/$argv[1]

        # Check if a file with the command's name exists in the current directory
        if test -f "$script_path"
            # Check if it's executable
            if test -x "$script_path"
                # If so, execute it with all provided arguments
                eval "$script_path" $argv[2..-1]
                return 0
            else
                # If it's a file but not executable, give a friendly reminder
                echo "fish: The command '$argv[1]' is in the current directory but is not executable. You may need to run 'chmod +x $argv[1]'." >&2
                return 126
            end
         end

        # If no script is found, use the default handler to display the error
        command -q $argv[1]; or return 127
        return 1
    end
end

# why
source ~/miniconda3/etc/fish/conf.d/conda.fish

# stupid
alias ffmpeg="ffmpeg -hide_banner"
alias ffprobe="ffprobe -hide_banner"
alias ffplay="ffplay -hide_banner"

fish_add_path /home/hexa/.spicetify
