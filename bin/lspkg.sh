#!/bin/sh

# This script lists the "bill of materials"
# for the pkg file specified as a command-line argument.

if [ $# -lt 1 ]; then
	scriptname=`basename $0`
	echo "Usage: $scriptname pkg_file"
	exit
fi

lsbom `pkgutil --bom $1`
