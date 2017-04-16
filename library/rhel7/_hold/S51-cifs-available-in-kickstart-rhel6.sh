#!/bin/bash
modprobe -d /mnt/sysimage md4 
modprobe -d /mnt/sysimage des_generic
modprobe -d /mnt/sysimage ecb
modprobe -d /mnt/sysimage fscache

