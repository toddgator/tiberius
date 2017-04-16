#!/bin/bash
mkdir /mnt/imageright/RPMUpload -p
echo '//batchprocessor.thig.com/batch_processing/ImageRight/Production/RPMUpload /mnt/imageright/RPMUpload cifs defaults,rw,noperms,credentials=/etc/samba/credentials,rsize=16384,wsize=16384 0 0' >> /etc/fstab
