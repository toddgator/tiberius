#!/bin/bash
#
# Configures the 'reserved blocks percentage' for 'vg_root-lv_root' to 1 (the
#	lowest possible).

tune2fs -m1 /dev/mapper/vg_root-lv_root
 