#!/bin/sh
if [ -n "$1" ]; then
  ab -n 50 -c 5 -H 'Accept-Encoding: gzip' $1
fi
