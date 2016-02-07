#!/bin/sh
free -m -l -t | awk '/Mem\:/ {memory=($3/$2)*100} END {printf "%.0f", memory}'
