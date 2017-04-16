#!/bin/bash
#
# Force named-chroot.service to be loaded before remote-fs-pre.target is 
#	loaded.

if [[ -f /usr/lib/systemd/system/remote-fs-pre.target ]]; then

cat << EOF >> /usr/lib/systemd/system/remote-fs-pre.target

Requires=named-chroot.service
After=named-chroot.service
EOF

fi
