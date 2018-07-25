#!/usr/bin/env bash

for ip in "$@"
do
  mkdir -v -p $ip
done

echo "Starting TCP Scan"

parallel 'nmap -A -p- --reason -T4 -sS --script=safe,vuln -oA {}/{}.tcp {}' ::: $@ &

echo "Starting UDP Scan (top 100 ports)"

parallel 'nmap -sU -sV -T4 --top-ports 100 --script=safe,vuln -oA {}/{}.udp {}' ::: $@ &

wait

echo "Done!"