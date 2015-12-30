# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' '' 'm:{[:lower:]}={[:upper:]}'
zstyle ':completion:*' max-errors 3
zstyle ':completion:*' menu select
zstyle ':completion:*' prompt 'Possible errors. '
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/home/dev/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory notify
bindkey -e
# End of lines configured by zsh-newuser-install


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# MobaXTerm colors fixing
[[ $TERM == 'xterm' ]] && export TERM=xterm-256color

#fix some key bindings  {{{

# bindkey "\e[C" forward-word
# bindkey "\e[D" backward-word
# bindkey "\e[5C" forward-word
# bindkey "\eOc" emacs-forward-word
# bindkey "\e[5D" backward-word
# bindkey "\eOd" emacs-backward-word

bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history
bindkey "\e[3~" delete-char
bindkey "\e[2~" quoted-insert
bindkey "^H" backward-delete-word

# }}}

# prompt stuff {{{
function prompt_git {
    echo `git branch 2>/dev/null | sed -n '/\* /s///p'`
}

setopt promptsubst
PROMPT='[%(?,%2F%?,%5F%?) %4F%n %3F%~%f]#'
RPROMPT='$(prompt_git)'

# }}}

# Aliases

alias ls='ls --color -a'
alias ll='ls --color -lah'
alias httpserve='python2 -m SimpleHTTPServer'

# ENVIRONMENT

LANG=en_US.UTF-8




# TODO: test it wont break anything if tmux is not installed
[[ -z $TMUX ]] && type tmux && exec tmux new-session -A -s MAIN


