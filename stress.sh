#!/bin/sh
if [ -n "$1" ]; then
  for i in {1..100}; do
    curl -L -H "Accept-Encoding: gzip" $1 >/dev/null
  done
fi
#ab -n 50 -c 5 -H 'Accept-Encoding: gzip' $1
#curl -L -H "Accept-Encoding: gzip" $1 >/dev/null
