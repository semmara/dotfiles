#!/bin/bash
# Copyright: 2014 Thorsten Reinecke

function linkto()
{
	if [[ -d $1 ]]; then
  		echo "Activate package $1 temporary."
		if [[ -d $1/bin ]]; then export PATH="$1/bin:$PATH"; fi
		if [[ -d $1/lib ]]; then export LD_LIBRARY_PATH="$1/lib:$LD_LIBRARY_PATH"; fi
		if [[ -d $1/lib64 ]]; then export LD_LIBRARY_PATH="$1/lib64:$LD_LIBRARY_PATH"; fi
		if [[ -d $1/man ]]; then export MANPATH="$1/man:$(manpath)"; fi;
		if [[ -d $1/share/man ]]; then export MANPATH="$1/share/man:$(manpath)"; fi;
		if [[ -d $1/info ]]; then export INFOPATH="$1/info:$INFOPATH"; fi;
		if [[ -d $1/share/info ]]; then export INFOPATH="$1/share/info:$INFOPATH"; fi;
		return 0;
	else
		echo "Package $1 does not exist."
		return 1;
	fi
}
