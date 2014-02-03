#!/bin/bash

DFD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DFD/.env.sh

### COMMON ALIASES
if [[ "$ENV_UNAMESTR" == 'Linux' ]]; then
	alias ls='ls --color=auto'
	alias grep='grep --color=auto'
	alias egrep='egrep --color=auto'
	alias fgrep='fgrep --color=auto'
elif [[ "$ENV_UNAMESTR" == 'Darwin' ]]; then
	# replacing rm (by http://hints.macworld.com/article.php?story=20080224175659423)
	function rm () {
		local path
		for path in "$@"; do
			# ignore any arguments
			if [[ "$path" = -* ]]; then :
			else
				local dst=${path##*/}
				# append the time if necessary
				while [ -e ~/.Trash/"$dst" ]; do
					dst="`expr "$dst" : '\(.*\)\.[^.]*'` `date +%y%m%d-%H%M%S`.`expr "$dst" : '.*\.\([^.]*\)'`"
				done
				mv "$path" ~/.Trash/"$dst"
			fi
		done
	}
fi
#alias l='ls -CF'
alias la='ls -A'
alias ll='ls -laF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias fsize='du -hs'


### DEVELOPER TOOLS
# MISC STUFF
alias openfiles="sudo dtrace -n 'syscall::open*:entry { printf(\"%s %s\",execname,copyinstr(arg0)); }' " # by http://www.brendangregg.com/dtrace.html
alias dd='dd bs=4M'
alias psg='ps ax | grep'
if [[ "$ENV_UNAMESTR" == 'Darwin' ]]; then
	alias hardware='system_profiler SPHardwareDataType'
fi

function command_exists() {
	if [ $# -lt 1 ]; then
		scriptname=`basename $0`
		echo "Usage: $scriptname <binary name>"
		exit
	fi
	type "$1" &> /dev/null ;
}

function lowercase(){
    echo "$1" | sed "y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/"
}

# NETWORK STUFF
alias get_isp_ip="curl -s http://checkip.dyndns.org | sed 's/[a-zA-Z/<> :]//g'"
alias fb_reconnect="fritzbox-reconnect.py"

if [[ "$ENV_UNAMESTR" == 'Darwin' ]]; then
	alias get_gateway='netstat -rn | awk '"'"'{if($1=="default") print $2}'"'"
else
	alias get_gateway='netstat -rn | awk '"'"'{if($1=="0.0.0.0") print $2}'"'"
fi

# DAEMON/AGENT STUFF
alias ls_daemons="launchctl list"

# PATH STUFF
function realpath() {
	path="."
	if [ "$1" ]; then
		path="$1"
	fi
	python -c "import os; print os.path.realpath('$path')"
}

### LOCATION-DEPENDENT
# WORK
if [ -f ~/.dotfiles/.bash_aliases_work ]; then
    . ~/.dotfiles/.bash_aliases_work
fi

# HOME
if [ -f ~/.dotfiles/.bash_aliases_home ]; then
    . ~/.dotfiles/.bash_aliases_home
fi


