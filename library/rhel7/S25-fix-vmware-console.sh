#!/bin/bash
echo "GRUB_GFXMODE=1280x800x32" >> /etc/default/grub
echo "GRUB_GFXPAYLOAD_LINUX=keep" >> /etc/default/grub
echo "GRUB_TERMINAL=gfxterm" >> /etc/default/grub
grub2-mkconfig -o /boot/grub2/grub.cfg
