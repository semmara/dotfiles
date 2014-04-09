#!/bin/bash

DFD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DFD/.env.sh

### COMMON ALIASES
if [[ "$ENV_UNAMESTR" == 'Linux' ]]; then
	alias ls='ls --color=auto'
	alias grep='grep --color=auto'
	alias egrep='egrep --color=auto'
	function versions() {
		if [ $# -lt 1 ]; then
			dpkg -l
		else
			dpkg -l | grep '^ii' | grep $1 | awk '{print $2 "\t" $3}'
		fi
	}
elif [[ "$ENV_UNAMESTR" == 'Darwin' ]]; then
	alias do_not_sleep='caffeinate'
fi
#alias l='ls -CF'
alias la='ls -A'
alias ll='ls -lahF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias fsize='du -hs'
alias fgrep='fgrep --color=auto'


### DEVELOPER TOOLS
# MISC STUFF
alias openfiles="sudo dtrace -n 'syscall::open*:entry { printf(\"%s %s\",execname,copyinstr(arg0)); }' " # by http://www.brendangregg.com/dtrace.html
alias dd='dd bs=4M'
alias dd_progress='sudo pkill -USR1 -n -x dd'
alias psg='ps ax | grep'
function tailgrep() {
        if [ $# -lt 2 ]; then
		scriptname="tailgrep"
                echo "Usage: $scriptname <file> <search string>"
                exit
        fi
	tail -f $1 | grep --line-buffered $2
}
alias grep_syslog='tailgrep /var/log/system.log'
if [[ "$ENV_UNAMESTR" == 'Darwin' ]]; then
	alias hardware='system_profiler SPHardwareDataType'
	alias software='system_profiler SPSoftwareDataType'
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
function enc.aes256 () {
	if [ $# -lt 1 ]; then
		echo "Usage: $0 filename"
		exit 1
	fi
	tar -cvf "$1".tar "$1"
	openssl enc -e -aes256 -in "$1".tar -out "$1".tar.enc
	rm "$1".tar
}
function dec.aes256 () {
	if [ $# -lt 1 ]; then
		echo "Usage: $0 encrypted_file"
		exit 1
	fi
	tmp_fn="$RANDOM".tar
	openssl enc -d -aes256 -in "$1" -out $tmp_fn
	tar -xvf $tmp_fn
	rm $tmp_fn
}

if [[ "$ENV_UNAMESTR" == 'Darwin' ]]; then
	alias get_gateway='netstat -rn | awk '"'"'{if($1=="default") print $2}'"'"
	function scan_ports() {
		ports="1-1023"
		if [ "$2" ]; then
			ports="$2"
		fi
		nc -vz $1 $ports | grep succeeded
	}
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


### FUNCTIONS AND ALIASES IN SEPARATE FILES
#for f in $DFD/aliases/*
#do
#	source $f
#done
