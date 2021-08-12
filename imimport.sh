#!/bin/bash

carpeta_actual=$(pwd) # Para parametrizarlo si queremos desde parámetro

for file in *
do
	if [ ! -e "$file" ]
	then
		echo "$file no es un archivo"
	else
		echo "Importando... " "$file"
		REPOTAG=$(echo "$file" | awk -F_ '{print $1":"$2}')
		if ! docker image import "$carpeta_actual"/"$file" "$REPOTAG";
		then
			echo "La imagen $file falló al importar."
			echo
		else
			echo "$file importada correctamente."
			echo
		fi
	fi
done
