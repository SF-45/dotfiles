#1
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
export GPG_TTY=$(tty)
PS1='[\u@\h \W]\$ '
if [[ -z ${BASH_EXECUTION_STRING} ]]
then
	exec fish
fi
