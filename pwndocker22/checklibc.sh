#!/bin/bash
if [ -z "$*" ];
then
    strings /lib/x86_64-linux-gnu/libc.so.6 | grep "GNU C Library"
else
    strings $@ | grep "GNU C Library"
fi