#!/usr/sbin/dtrace -s

/* measure runtime of processes */

#pragma D option quiet
#pragma D option destructive

proc:::exec
{
	self->path = args[0]
}

proc:::exec-success
{
	self->start = timestamp;
	self->targetPID = pid;
}

syscall::*exit:entry
/ pid == self->targetPID /
{
	this->end = timestamp;
	this->duration = (this->end - self->start)/1000000;
	printf("%s, %s, %d[ms]\n", execname, self->path, this->duration);
}

