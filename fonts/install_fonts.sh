#!/bin/bash

if [[ $# == 0 ]]; then
	echo "Usage: install_fonts.sh [INPUT FILE]"
	exit 1
fi

path=$(realpath $1)

if [[ ! -d $path ]]; then
	echo "Could not find path" $1
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

zipFiles=$(find $path -type f -name "*.zip")

if [[ $zipFiles == "" ]]; then
	echo "Did not find any font zip files in" $path
	exit 1
fi

mkdir -p ~/.fonts

if [[ $useParallel == "true" ]]; then
	parallel '[ ! -e "$HOME/.fonts/$(basename {} .zip)" ] && unzip {} -d "$HOME/.fonts/$(basename {} .zip)"' ::: $zipFiles
else
	printf "%s\n" $zipFiles | xargs -I {} bash -c 'dir="$HOME/.fonts/$(basename {} .zip)"; [ ! -e "$dir" ] && unzip "{}" -d "$dir"'
fi
