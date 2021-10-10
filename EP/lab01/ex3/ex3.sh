#!/bin/bash

script_name="ex3.sh"
directory_name="part2"
zip_times=()
zip_ratios=()
zip_sizes=()

for file in *
do

	if [[ ""$file"" != "$script_name" ]]; then
		for i in {0..9}
		do
			#echo "zipping $file with -$i..."
			zip_times+=($({ time zip -$i $file.zip $file >/dev/null; } |& grep real | awk '{print $2}'))
			zip_ratios+=($(unzip -v $file.zip | tail -1 | awk '{print $3}'))
			zip_sizes+=($(unzip -v $file.zip | tail -1 | awk '{print $2}'))
			rm $file.zip
			#echo
		done
	fi
done

echo "${zip_ratios[*]}"
echo
echo "${zip_times[*]}"
echo
echo "${zip_sizes[*]}"

