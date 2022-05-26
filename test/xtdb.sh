#!/bin/sh

cd "$(dirname "$0")"

clojure -M xtdb.clj
