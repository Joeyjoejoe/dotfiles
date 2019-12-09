#!/bin/sh
printf '\033%s\007' $1|sed 's/\//∕/g'
