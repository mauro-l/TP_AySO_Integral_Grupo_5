#!/bin/bash
clear

###############################
#
# Parametros:
#  - Lista Dominios y URL
#
#  Tareas:
#  - Se debera generar la estructura de directorio pedida con 1 solo comando con las tecnicas enseñadas en clases
#  - Generar los archivos de logs requeridos.
#
###############################
LISTA=$1

LOG_FILE="/var/log/status_url.log"

ANT_IFS=$IFS
IFS=$'\n'

for LINEA in cat `cat $LISTA | grep -v ^#`
do
DOMINIO=$(echo $LINEA | awk '{print $1}')
URL=$(echo $LINEA | awk '{print $2}')

  # Obtener el código de estado HTTP
  STATUS_CODE=$(curl -LI -o /dev/null -w '%{http_code}\n' -s "$URL")

  # Fecha y hora actual en formato yyyymmdd_hhmmss
  TIMESTAMP=$(date +"%Y%m%d_%H%M%S")


 # Registrar en el archivo /var/log/status_url.log
  echo "$TIMESTAMP - Code:$STATUS_CODE - URL:$URL" |sudo tee -a  "$LOG_FILE"

done



IFS=$ANT_IFS
