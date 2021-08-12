#!/bin/bash

carpeta_actual=$(pwd) # Para parametrizarlo si queremos desde parámetro

for image_id in $(docker images | grep -oE "[0-9a-z]{12}")
do
	REPOTAG=$(docker image inspect "$image_id" | grep -A1 RepoTags | tail -1 | sed -e 's/"//g'|  awk -F: '{print $1"_"$2}' | sed -e 's/ //g')
	echo "Salvando ... " "$image_id: $REPOTAG"
	if ! docker save "$image_id" -o "$carpeta_actual"/"$REPOTAG";
	then
		echo "*** Falló la exportación ***"
	else
		echo "Imagen exportada correctamente"
	fi
	echo
done
