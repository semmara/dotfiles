#!/bin/bash

DFD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
NOW=`date +"%Y_%m_%d_%H_%M_%S"`

# .bash_profile
if [ -f $HOME/.bash_profile ]; then
	mv $HOME/.bash_profile $HOME/.bash_profile_$NOW
fi
ln -s $DFD/.bash_profile $HOME/.bash_profile

