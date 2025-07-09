#!/bin/bash

echo "==== Creando volúmenes físicos ====="
sudo pvcreate /dev/sdc1 /dev/sdc2 /dev/sdd1

echo "===== Creando grupos de volúmenes ====="
sudo vgcreate vg_datos /dev/sdc1 /dev/sdc2
sudo vgcreate vg_temp /dev/sdd1

echo "===== Creando volúmenes lógicos ====="
sudo lvcreate -L 2.5G -n lv_workareas vg_datos
sudo lvcreate -l 100%FREE -n lv_docker vg_datos
sudo lvcreate -l 100%FREE: -n lv_swap vg_temp

echo "===== Creando sistema de archivos ====="
sudo mkfs.ext4 /dev/vg_datos/lv_workareas
sudo mkfs.ext4 /dev/vg_datos/lv_docker
sudo mkswap /dev/vg_temp/lv_swap

# Crear puntos de montaje
sudo mkdir -p /work
sudo mkdir -p /var/lib/docker

# Montar
sudo mount /dev/vg_datos/lv_workareas /work
sudo mount /dev/vg_datos/lv_docker /var/lib/docker

echo "===== Configurando SWAP ====="
sudo mkswap /dev/sde1
sudo swapon /dev/sde1
sudo swapon /dev/vg_temp/lv_swap

echo "/dev/vg_datos/lv_workareas   /work  ext4  defaults  0 0" | sudo tee -a /etc/fstab
echo "/dev/vg_datos/lv_docker      /var/lib/docker     ext4  defaults  0 0" | sudo tee -a /etc/fstab
echo "/dev/sde1                    none            swap  sw        0 0" | sudo tee -a /etc/fstab


echo "===== Finalizado ====="
sudo pvs
sudo vgs
sudo lvs
