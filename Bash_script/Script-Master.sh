#!/bin/bash

echo "=============================="
echo "Iniciando Script-Master.sh"
echo "=============================="

echo "[1] Alta de usuarios"
if [ -f Bash_script/alta_usuarios/Grupo_5.sh ]; then
    chmod +x Bash_script/alta_usuarios/Grupo_5.sh
    bash Bash_script/alta_usuarios/Grupo_5.sh ansible/Bash_script/alta_usuarios/Lista_Usuarios.txt
else
    echo "❌ Script de alta de usuarios no encontrado"
fi

echo ""
echo "[2] Ejecución de Ansible"
if [ -f ansible/playbook.yml ]; then
    cd ansible
    ansible-playbook playbook.yml
    cd ..
else
    echo "❌ Playbook de Ansible no encontrado"
fi

echo "=============================="
echo "Script-Master.sh finalizado"
echo "=============================="
