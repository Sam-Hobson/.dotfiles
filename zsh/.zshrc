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
function tmuxSessionizer { tmux-sessionizer }

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

# Git
alias g="git"
alias gst="git status"
alias ga="git add"
alias gaa="git add --all"
alias gb="git branch"
alias gba="git branch --all"
alias gbd="git branch --delete"
alias gbD="git branch --delete --force"
alias gco="git checkout"
alias gcor="git checkout --recurse-submodules"
alias gcob="git checkout -b"
alias gcl="git clone --recurse-submodules"
alias gc="git commit --verbose"
alias gca="git commit --verbose --amend"
alias gd="git diff"
alias gf="git fetch"
alias gfa="git fetch --all"
alias glg="git log --stat"
alias gl="git pull"
alias gp="git push"
alias gpf="git push --force"
alias grb="git rebase"
alias grbc="git rebase --continue"
alias grba="git rebase --abort"
alias grf="git reflog"
alias grh="git reset"
alias grhh="git reset --hard"
alias grhs="git reset --soft"
alias grs="git restore"
alias grst="git restore --staged"
alias gsta="git stash"
alias gstall="git stash --all"
alias gstl="git stash list"
alias gstp="git stash pop"
alias gsi="git submodule init"
alias gsu="git submodule update"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
