#!/bin/bash

source .env.sh

### COMMON ALIASES
alias ll='ls -la'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'


### DEVELOPER TOOLS
# MISC STUFF
alias show_opened_files="sudo dtrace -n 'syscall::open*:entry { printf(\"%s %s\",execname,copyinstr(arg0)); }' " # by http://www.brendangregg.com/dtrace.html
alias dd='dd bs=4M'

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

if [[ "$ENV_UNAMESTR" == 'Darwin' ]]; then
	alias get_gateway='netstat -rn | awk '"'"'{if($1=="default") print $2}'"'"
else
	alias get_gateway='netstat -rn | awk '"'"'{if($1=="0.0.0.0") print $2}'"'"
fi

# DAEMON/AGENT STUFF
alias ls_daemons="launchctl list"


### LOCATION-DEPENDENT
# WORK
if [ -f ~/.dotfiles/.bash_aliases_work ]; then
    . ~/.dotfiles/.bash_aliases_work
fi

# HOME
if [ -f ~/.dotfiles/.bash_aliases_home ]; then
    . ~/.dotfiles/.bash_aliases_home
fi


