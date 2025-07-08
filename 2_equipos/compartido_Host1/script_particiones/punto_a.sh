#!/bin/bash

sudo fdisk /dev/sdc << EOF
n
p
1

+2.5G
t
8e
n
p
2

+10M
t
2
8e
w
EOF

sudo fdisk /dev/sdd << EOF
n
p
1

+2.5G
t
82
w
EOF

sudo fdisk /dev/sde << EOF
n
p
1

+1G
t
82
w
EOF
