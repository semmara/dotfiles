# dotfiles
if [ -f ~/.dotfiles/.bash_aliases ]; then
	. ~/.dotfiles/.bash_aliases
fi
if [ -d ~/.dotfiles/bin ]; then
	export PATH=~/.dotfiles/bin:$PATH
fi

# user bin
if [ -d ~/bin ]; then
	export PATH=~/bin:$PATH
fi
if [ -d ~/.bin ]; then
	export PATH=~/.bin:$PATH
fi

# for MacPorts
export PATH=/opt/local/bin:/opt/local/sbin:$PATH

