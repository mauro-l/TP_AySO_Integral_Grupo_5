#!/bin/bash

echo "=============================="
echo "CHECK.SH - Verificación del TP"
echo "=============================="

# 1. Validación de estructura
echo "[1] Verificando estructura del proyecto..."

REQUIRED_DIRS=("ansible" "ansible/ansible/roles" "ansible/ansible/roles/TP_INI" "ansible/ansible/roles/TP_INI/vars")
REQUIRED_FILES=("Bash_script/Script-Master.sh" "ansible/playbook.yml")


for dir in "${REQUIRED_DIRS[@]}"; do
  if [ ! -d "$dir" ]; then
    echo "ERROR: Falta el directorio $dir"
    exit 1
  fi
done

for file in "${REQUIRED_FILES[@]}"; do
  if [ ! -f "$file" ]; then
    echo "ERROR: Falta el archivo $file"
    exit 1
  fi
done

echo "Estructura OK."

# 2. Verificación de sintaxis de Ansible
echo "[2] Verificando sintaxis del playbook..."
ansible-playbook ansible/playbook.yml --syntax-check
if [ $? -ne 0 ]; then
  echo "ERROR: Fallo la verificación de sintaxis."
  exit 1
fi
echo "Sintaxis OK."

# 3. Ejecutar Script-Master
echo "[3] Ejecutando Script-Master.sh..."
bash Bash_script/Script-Master.sh
if [ $? -ne 0 ]; then
  echo "ERROR: Fallo la ejecución del Script-Master."
  exit 1
fi
echo "Script-Master ejecutado correctamente."

echo "=============================="
echo "CHECK FINALIZADO EXITOSAMENTE"
echo "=============================="
