#!/bin/bash
set -e

echo "Configuración de LVM con 3 discos"

DISCO_1="/dev/sdc" # 5G
DISCO_2="/dev/sdd" # 3G
DISCO_3="/dev/sde" # 2G

# Verificar si los discos existen
if lsblk -n -o NAME /dev/sdf /dev/sde | grep -qE 'sdf1|sde1'; then
	    echo "Ya existen particiones"
	        exit 1
fi


# limpieza y particionado
for disco in $DISCO_1 $DISCO_2; do
	    echo "Preparando $disco..."
	        wipefs -a "$disco"

		    fdisk "$disco" <<EOF
n
p
1


t
8e
w
EOF

    partprobe "$disco"
        sleep 1
done

# particionado swap
wipefs -a "$DISCO_3"
fdisk "$DISCO_3" <<EOF
n
p
1


t
82
w
EOF
partprobe "$DISCO_3"

# CREAR PV2
pvcreate ${DISCO_1}1
pvcreate ${DISCO_2}1


# CREAR VGS
vgcreate vg_datos ${DISCO_1}1
vgcreate vg_temp ${DISCO_2}1

# CREAR LVS
lvcreate -L 10M -n lv_docker vg_datos
lvcreate -L 2.5G -n lv_workareas vg_datos
lvcreate -L 2.5G -n lv_swap vg_temp


# FORMATEAR
mkfs.ext4 /dev/vg_datos/lv_docker
mkfs.ext4 /dev/vg_datos/lv_workareas
mkswap /dev/vg_temp/lv_swap
mkswap ${DISCO_3}1

# CREAR DIRECTORIOS
mkdir -p /var/lib/docker
mkdir -p /work

# MONTAR Y ENCENDER SWAP
mount /dev/vg_datos/lv_docker /var/lib/docker
mount /dev/vg_datos/lv_workareas /work
swapon /dev/vg_temp/lv_swap
swapon ${DISCO_3}1

# REINICIAR DOCKER
if which docker &>/dev/null; then
	    systemctl restart docker
fi

# PERSISTENCIA
grep -q "${DISCO_3}1" /etc/fstab || echo "${DISCO_3}1 none swap sw 0 0" >> /etc/fstab
grep -q "lv_docker" /etc/fstab || echo "/dev/vg_datos/lv_docker /var/lib/docker ext4 defaults 0 2" >> /etc/fstab
grep -q "lv_workareas" /etc/fstab || echo "/dev/vg_datos/lv_workareas /work ext4 defaults 0 2" >> /etc/fstab
grep -q "lv_swap" /etc/fstab || echo "/dev/vg_temp/lv_swap none swap sw 0 0" >> /etc/fstab

echo "Configuración terminada."

lsblk
sudo vgs
sudo lvs

