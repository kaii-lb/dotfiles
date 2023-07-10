#!/bin/sh

pids=""
cpus=${1:-$1}
seconds=${2:-60}
echo loading $cpus CPUs for $seconds seconds
trap 'for p in $pids; do kill $p; done' 0
for ((i=0;i<cpus;i++)); do while : ; do : ; done & pids="$pids $!"; done
sleep $seconds
