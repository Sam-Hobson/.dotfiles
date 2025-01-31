export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.local/share/npm/bin:$PATH

export EDITOR='nvim'

# Init zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"


# Add PL10K command prompt
zinit ice depth=1; zinit light romkatv/powerlevel10k
[[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]] && source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"


# Zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions


# Zsh snippets
zinit snippet OMZP::command-not-found


# Load zsh-completions
autoload -Uz compinit && compinit


# Set options
setopt extendedglob

HISTSIZE=5000
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


# Key bindings
function tmuxSessionizer {
    exec </dev/tty  # This is to fix an issue with zle binds nulling stdin/out.
    exec <&1
    tmux-sessionizer
}

function fdSearch {
    dir=$(fd . ./ -td --exclude ".git" --exclude "node_modules" | fzf)
    [ -n "$dir" ] && cd $dir
}

zle -N tmuxSessionizer
zle -N fdSearch

bindkey '^f' tmuxSessionizer
bindkey '^a' fdSearch
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[[Z' reverse-menu-complete
bindkey '^[^?' backward-kill-word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word


# Aliases
alias l="eza -l"
alias ll="eza -la"

alias icat="kitty +kitten icat --background=white"

alias cd.="cd .."
alias cd..="cd ../.."
alias cd...="cd ../../.."
alias cd....="cd ../../../.."
alias cd.....="cd ../../../../.."

# TMUX
alias tm="tmux"
alias ta="tmux attach -t"
alias tl="tmux ls"
alias tam="ta || tm"
alias tksv="tmux kill-server"
alias tkss="tmux kill-session -t"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
