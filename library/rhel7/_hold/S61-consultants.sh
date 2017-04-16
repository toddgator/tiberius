#!/bin/bash
useradd jamie
useradd venkat
useradd nick
useradd jeffm
echo "password" | passwd --stdin jeffm
echo "password" | passwd --stdin jamie
echo "password" | passwd --stdin venkat
echo "password" | passwd --stdin nick

echo "
jamie ALL=(root) NOPASSWD: ALL
jeffm ALL=(root) NOPASSWD: ALL
venkat ALL=(root) NOPASSWD: ALL
nick ALL=(root) NOPASSWD: ALL
" >> /etc/sudoers
