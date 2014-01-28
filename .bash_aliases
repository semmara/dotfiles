#!/bin/bash

alias ll='ls -la'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias dd='dd bs=4M'

# DEVELOPER TOOLS
alias show_opened_files="sudo dtrace -n 'syscall::open*:entry { printf(\"%s %s\",execname,copyinstr(arg0)); }' " # by http://www.brendangregg.com/dtrace.html

function command_exists() {
	if [ $# -lt 1 ]; then
		scriptname=`basename $0`
		echo "Usage: $scriptname <binary name>"
		exit
	fi
	type "$1" &> /dev/null ;
}

alias get_isp_ip="curl -s http://checkip.dyndns.org | sed 's/[a-zA-Z/<> :]//g'"
alias get_gateway_mac='netstat -rn | awk '"'"'{if($1=="default") print $2}'"'"
alias get_gateway_linux='netstat -rn | awk '"'"'{if($1=="0.0.0.0") print $2}'"'"

# WORK
if [ -f ~/.dotfiles/.bash_aliases_work ]; then
    . ~/.dotfiles/.bash_aliases_work
fi

# HOME
if [ -f ~/.dotfiles/.bash_aliases_home ]; then
    . ~/.dotfiles/.bash_aliases_home
fi


