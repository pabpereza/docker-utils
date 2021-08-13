#!/bin/bash

# Help function
show_help() {
	echo -e "
\033[1mDOCKER UTILS\033[0m
A bundle of useful docker utils.

Generic command:
./docker_utils.sh COMMAND

\033[1mCOMMANDS\033[0m:
help \t\t Show this help.
export <path> \t Export all images. By default, in actual dir.
import <path> \t Import all images. By default, in actual dir.
"
}

# Cheking the mode variable and exits if it is not set
if [ -z "$1" ]; then
	show_help
	exit 1
fi

if [ $1 = "export" ]; then
	echo "Exporting all the images"

	# Checking if the variable path exists, by default it is the actual path
	if [ -z "$2" ]; then
		workdir=$(pwd)
	else
		workdir=$2
	fi

	for image_id in $(docker images --format "{{.Repository}}:{{.Tag}}")
	do
		echo "Saving... " "$image_id"
		if ! docker save "$image_id" -o "$workdir"/"$image_id";
		then
			echo "*** Exportation error ***"
		fi
	done

elif [ $1 = "import" ]; then
	echo "Importing all the images"

	# Checking if the variable path exists, by default it is the actual path
	if [ -z "$2" ]; then
		workdir=$(pwd)
	else
		workdir=$2
	fi

	# Searching all files in the workdir
	for file in $workdir*
	do
		if [ ! -e "$file" ]
		then
			echo "$file no es un archivo"
		else
			echo "Loading... " "$file"
			if ! docker load -i "$workdir"/"$file";
			then
				echo "*** The image $file fails"
			fi
		fi
	done

elif [ $1 = "help" ]; then
	show_help
fi


