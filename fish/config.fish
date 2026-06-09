
# sourcing for cachyOS
set cachyos_config "/usr/share/cachyos-fish-config/cachyos-config.fish"
if test -e $cachyos_config
    source cachyos_config
end

set -x SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"
source ~/.config/aliases


/usr/local/bin/starship init fish | source
# starship init fish | source

/opt/homebrew/bin/brew shellenv | source

