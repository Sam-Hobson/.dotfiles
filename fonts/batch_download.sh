#!/bin/bash

errorMessage() {
	echo "Usage: batch_download.sh [FONT ARCHIVE URL]... [OUTPUT DIRECTORY]"
	echo "  or: batch_download.sh -f [INPUT FILE] [OUTPUT DIRECTORY]"
	echo
}

if [[ $# < 2 ]]; then
	errorMessage
	exit 1
fi

if [[ $1 == "-f" ]]; then
	if [[ $# != 3 ]]; then
		errorMessage
		exit 1
	fi

	inputFile=$(realpath ${2})

	if [[ ! -f $inputFile ]]; then
		errorMessage
		echo "Could not find file" ${2}
		exit 1
	fi
fi

outputDir=$(realpath ${!#})

if [[ ! -d $outputDir ]]; then
	errorMessage
	echo "Could not find directory" ${!#}
	exit 1
fi

useParallel="true"

if ! command -v parallel >/dev/null 2>&1; then
	while [[ true ]]; do
		printf "GNU parallel is recommended for speed, would you like to proceed without it? (y/n) "
		read input

		if [[ "$input" =~ ^[YyNn]$ ]]; then
			break
		fi

		echo "Invalid input. Please enter 'y' or 'n'."
	done

	if [[ "$input" =~ ^[Nn]$ ]]; then
		exit 1
	fi

	useParallel="false"
fi

if [[ -z $inputFile ]]; then
	data="${@:1:$#-1}"
else
	data=$(cat $inputFile)
fi

if [[ $useParallel == "true" ]]; then
	parallel "pushd \"$outputDir\" > /dev/null && curl -L -O {}; popd > /dev/null" ::: $data
else
	for url in $data; do
		pushd "$outputDir" > /dev/null
		curl -L -O "$url"
		popd > /dev/null
	done
fi
