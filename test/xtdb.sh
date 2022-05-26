#!/bin/sh

cd "$(dirname "$0")"

clojure -M xtdb.clj &

cd ..

smalltalkci -s $1
