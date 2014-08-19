# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source global definitions
[ -f /etc/bashrc ] && . /etc/bashrc

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

export PANEL_FIFO=/tmp/panel-fifo
export BSPWM_SOCKET=/tmp/bspwm-socket
export BSPWM_TREE=/tmp/bspwm.tree
export BSPWM_HISTORY=/tmp/bspwm.history
export BSPWM_STACK=/tmp/bspwm.stack

export PATH=$PATH:$HOME/.config/bspwm/panel
