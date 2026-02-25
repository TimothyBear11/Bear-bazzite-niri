### ENVIRONMENT VARIABLES ###
# Pointing to the path you specified
set -gx STARSHIP_CONFIG "$HOME/.configs/starship.toml"

# Ensure ~/.local/bin is in path (common on Arch)
fish_add_path "$HOME/.local/bin"

### INTERACTIVE SETTINGS ###
if status is-interactive
    # Disable default greeting
    set -g fish_greeting ""

    # --- Tool Initializations ---
    # These replace the 'enableFishIntegration = true' lines from Nix

    # Initialize Starship prompt
    starship init fish | source

    # Initialize Zoxide (smarter cd)
    zoxide init fish | source

    # Initialize Direnv (automatic env loading)
    direnv hook fish | source

    # --- Fastfetch (System Info) ---
    if type -q fastfetch
        fastfetch \
            --logo "$HOME/Pictures/tbearlogo.png" \
            --logo-type auto \
            --logo-width 45 \
            --logo-height 30
    end

    # --- Load Custom Functions ---
    # Sourcing modular function files
    if test -d "$HOME/.config/fish/functions_extra"
        for f in $HOME/.config/fish/functions_extra/*.fish
            source $f
        end
    end

    # Git Abbreviations
    abbr -a gs 'git status'
    abbr -a ga 'git add .'
    abbr -a gc 'git commit -m'
    abbr -a gp 'git push'
    abbr -a gd 'git diff'
    abbr -a gds 'git diff --staged'
    abbr -a gl 'git pull --rebase'
    abbr -a gco 'git checkout'
    abbr -a gb 'git branch -vv'
    abbr -a gcm 'git checkout main && git pull'
    abbr -a gundo 'git reset --soft HEAD~1'

    # --- Aliases ---
    alias vim='nvim'

    # Modern ls replacement (eza)
    alias ls='eza --icons --group-directories-first'
    alias ll='eza -l --icons --group-directories-first'

    # Quick navigation
    alias d='cd ~'
    alias dl='cd ~/Downloads'
    alias dt='cd ~/Documents'
    alias proj='cd ~/projects'
    alias zd='z down'
    alias zp='z projects'

end

# Generated for envman. Do not edit.
test -s ~/.config/envman/load.fish; and source ~/.config/envman/load.fish
