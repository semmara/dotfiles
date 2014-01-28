alias ll='ls -la'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'


# DEVELOPER TOOLS
alias show_opened_files="sudo dtrace -n 'syscall::open*:entry { printf(\"%s %s\",execname,copyinstr(arg0)); }' " # by http://www.brendangregg.com/dtrace.html
