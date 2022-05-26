#!/bin/sh

cd "$(dirname "$0")"

clojure -M xtdb.clj &

until $(curl --output /dev/null --silent --fail http://localhost:6666/_xtdb/status); do
    echo 'Waiting for XTDB to be up'
    sleep 1
done
cd ..

smalltalkci -s $1
