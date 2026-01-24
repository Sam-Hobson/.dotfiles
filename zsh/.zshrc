paths_to_add=(
	/usr/local/bin
	$HOME/.local/bin
)

for dir in "${paths_to_add[@]}"; do
	dir_expanded=$(eval echo "$dir")
	# Check if that path exists and isn't already in $PATH
	if [ -d "$dir_expanded" ] && [[ ":$PATH:" != *":$dir_expanded:"* ]]; then
		export PATH="$PATH:$dir_expanded"
	fi
done


export EDITOR='nvim'

# Init zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"


# Add PL10K command prompt
# zinit ice depth=1; zinit light romkatv/powerlevel10k
# [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]] && source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"

# Zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
# zinit light zsh-users/zsh-autosuggestions


# Zsh snippets
zinit snippet OMZP::command-not-found


# Load zsh-completions
autoload -Uz compinit && compinit


# Open CMD buffer in editor
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^x^g' edit-command-line


# Set options
setopt extendedglob

HISTSIZE=50000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
WORDCHARS=""

# Display information such as current path in TMUX status bar, so refresh it frequently
if [ -n "$TMUX" ]; then
    precmd() {
        tmux refresh-client -S
    }
fi

PROMPT='%?%(1j. %j.) $ '

# Key bindings
function tmuxSessionizer {
    exec </dev/tty  # This is to fix an issue with zle binds nulling stdin/out.
    exec <&1
    tmux-sessionizer
}

function gotoDir {
	. gotodir
}

zle -N tmuxSessionizer
zle -N gotoDir

bindkey '^x^f' tmuxSessionizer
bindkey '^x^a' gotoDir
bindkey '^x^u' undo
bindkey '^x^r' redo
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[[Z' reverse-menu-complete
bindkey '^[^?' backward-kill-word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word


# Set up fzf key bindings and fuzzy completion
if command -v fzf >/dev/null 2>&1; then
	source <(fzf --zsh)
fi

# Aliases
alias l="ls -lh --color=auto"
alias ll="ls -lAh --color=auto"

# Add some shortcuts
hash -d df=~/.dotfiles/


files_to_source=(
	# ${0:a:h}/.p10k.zsh
	${0:a:h}/private_zsh_config/*(N)
)

for file in "${files_to_source[@]}"; do
	file_expanded=$(eval echo "$file")
	if [ -f "$file_expanded" ]; then
		source "$file_expanded"
	fi
done
