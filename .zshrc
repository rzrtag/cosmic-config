# --- Global POSIX Editor Variables ---
export EDITOR="nvim"
export VISUAL="nvim"
export SUDO_EDITOR="nvim"

# --- Add Local Bin to Path ---
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

# --- ZSH Core Plugins (Assumes manual apt install later) ---
[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# --- High-Performance Aliases ---
alias ls="eza --icons --group-directories-first"
alias ll="eza -la --icons --group-directories-first"
alias cat="bat --style=plain --paging=never"
alias lg="lazygit"

# --- Zoxide (Telemetric Path Jump) ---
eval "$(zoxide init zsh)"

# --- Starship Prompt ---
eval "$(starship init zsh)"

# --- Yazi Shell Wrapper Bridge ---
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# --- CTRL-Y: Yazi File Picker Widget Integration ---
yazi-file-widget() {
    local select_file="${HOME}/.cache/yazi-select-tmp"
    mkdir -p "$(dirname "$select_file")"
    yazi --chooser-file="${select_file}"
    if [[ -f "$select_file" ]]; then
        local selected
        selected=$(cat "${select_file}" | awk '{printf "\"%s\" ", $0}')
        rm "${select_file}"
        LBUFFER="${LBUFFER}${selected}"
    fi
    zle redisplay
}
zle -N yazi-file-widget
bindkey '^Y' yazi-file-widget

# --- Sovereign Sync (ssync) ---
function ssync() {
    local config_repo="$HOME/cosmic-config"
    if [ ! -d "$config_repo" ]; then
        echo "Error: Config repository not found at $config_repo"
        return 1
    fi
    
    cd "$config_repo"
    
    # Mirror files
    cp ~/.zshrc .
    [ -f ~/.config/starship.toml ] && cp ~/.config/starship.toml .
    mkdir -p .config
    cp -r ~/.config/yazi .config/
    cp -r ~/.config/nvim .config/
    [ -d ~/.config/cosmic ] && cp -r ~/.config/cosmic .config/
    
    # Sync
    git add .
    git commit -m "Sovereign Sync: $(date)"
    git push origin master
    
    echo "Sovereign Synchronization Complete."
}

# --- FZF Integration ---
export FZF_DEFAULT_COMMAND="fdfind --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fdfind --type d --hidden --strip-cwd-prefix --exclude .git"
[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
