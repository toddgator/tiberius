#!/bin/bash

if [[ -f /usr/lib/systemd/system/remote-fs-pre.target ]]; then

cat << EOF >> /usr/lib/systemd/system/remote-fs-pre.target

Requires=named-chroot.service
After=named-chroot.service
EOF

fi