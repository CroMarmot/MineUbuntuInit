# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTCONTROL=erasedups
HISTFILESIZE=100000
HISTIGNORE="exit:pwd:ls:ll:htop:fg:bg:y *:"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

parse_git() {
	local unknown untracked stash clean ahead behind staged dirty diverged
	unknown='0;34'      # blue
	untracked='0;32'    # green
	stash='0;32'        # green
	clean='0;32'        # green
	ahead='0;33'        # yellow
	behind='0;33'       # yellow
	staged='0;96'       # cyan
	dirty='0;31'        # red
	diverged='0;31'     # red

	if [[ $TERM = *256color ]]; then
		unknown='38;5;20'     # dark blue
		untracked='38;5;76'   # mid lime-green
		stash='38;5;76'       # mid lime-green
		clean='38;5;82'       # brighter green
		ahead='38;5;226'      # bright yellow
		behind='38;5;142'     # darker yellow-orange
		staged='38;5;214'     # orangey yellow
		dirty='38;5;202'      # orange
		diverged='38;5;196'   # red
	fi

	git_branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
	git_status=$(git status 2> /dev/null)
	if [[ $git_branch == "" ]];then
		return 0
	fi
  printf "$git_branch/"
	if [[ $git_status =~ 'ahead' ]]; then
		color=$ahead
		st="ahead"
		printf "\033[%sm%s " "$color" "$st"
	fi
	if [[ $git_status =~ 'clean' ]]; then
		color=$clean
		st="clean"
		printf "\033[%sm%s " "$color" "$st"
	fi
	if [[ $git_status =~ 'dirty' ]]; then
		color=$dirty
		st="dirty"
		printf "\033[%sm%s " "$color" "$st"
	fi
	if [[ $git_status =~ 'staged' ]]; then
		color=$staged
		st="staged"
		printf "\033[%sm%s " "$color" "$st"
	fi
	if [[ $git_status =~ 'cherry-pick' ]]; then
		color=$unknown
		st="cherry-picking"
		printf "\033[%sm%s " "$color" "$st"
	fi
	if [[ $git_status =~ 'behind' ]]; then
		color=$behind
		st="behind"
		printf "\033[%sm%s " "$color" "$st"
	fi
	if [[ $git_status =~ 'Untracked' ]]; then
		color=$untracked
		st="untracked"
		printf "\033[%sm%s " "$color" "$st"
	fi
	return 0
}

get_date_and_ips(){
    printf "\033[00;96m$(date) \033[38;5;20m"
    printf "$(ip addr show | grep inet | grep -v 127.0.0.1 | awk '/inet /{print $2}' ORS='   ')"
    return 0
}


if [ "$color_prompt" = yes ]; then
    if [[ ${EUID} == 0 ]] ; then
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
    else
        # PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
        #PS1='\n\[\033[01;34m\]\w \[\033[01;32m\]\u \[\033[00m\]\n'
        PS1='\n $(get_date_and_ips)\n \[\033[01;31m\]< LOCAL > \[\033[01;34m\]\w \[\033[01;32m\]\u \[\033[00m\]$(parse_git)\[\033[00m\]\n'
    fi
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h \w \$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto --time-style="+%Y-%m-%d $newline%m-%d %H:%M"'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -l'
alias l='ls -la'
alias la='ls -Al'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# source ~/Tools/bash-wakatime/bash-wakatime.sh
export PATH=$PATH:~/.npm_global/bin
alias y='python ~/Tools/DICT.py'
set -o vi
shopt -s autocd

export ANDROID_HOME=/data/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/bin

# angular test
export CHROME_BIN=/usr/bin/chromium-browser

export PATH=$PATH:~/.local/bin

screenfetch
#curl wttr.in

alias npm='~/.npm_global/bin/npm'
