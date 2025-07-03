#!/bin/bash
clear

# Parámetros:
# - Lista de Usuarios a crear
# - Usuario del cual se obtendrá la clave

# Tareas:
# - Crear los usuarios según la lista recibida en los grupos descriptos
# - Los usuarios deberán tener la misma clave que la del usuario pasado por parámetro

LISTA=$1

ANT_IFS=$IFS
IFS=$'\n'
for LINEA in `cat $LISTA | grep -v ^#`
do
    # G_R1_MAURO_LAIME
    # G_R2_ADRIAN_FERRERA
    # G_R3_MAURO_LAIME
    # G_R4_GOMEZ_EMILSE
    # G_R5_CARLA_LOPEZ
    # G_R6_NICOLAS_MARGNI
    
    USUARIO=$(echo $LINEA | awk -F ':' '{print $1}')
    GRUPO=$(echo $LINEA | awk -F ':' '{print $2}')
    echo "sudo useradd -m -s /bin/bash -g $GRUPO $USUARIO"
done
IFS=$ANT_IFS
