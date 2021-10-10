#!/bin/bash

#Generate list of cores
target_cores=($(for (( i = 1; i < $((`nproc` - 1)); i=i+2 )); do echo $i ; done | paste -s -d ' ')) 

# Start workers
sudo stress -v --cpu $(((`nproc` - 1) / 2)) --timeout 180 > ./stress.txt 2>&1 &

# Get workers PIDs
worker_pids=($(cat stress.txt | grep forked | awk '{print $8}' | sed 's/.$//' | sed 's/^.//g' | paste -s -d ' ')) 

echo "${target_cores[*]}"
echo
echo "${worker_pids[*]}"
echo

counter=0
for i in "${target_cores[@]}"
do
	sudo taskset -cp $i ${worker_pids[$counter]} 2>&1
	counter=$((counter+1))
	echo
done
