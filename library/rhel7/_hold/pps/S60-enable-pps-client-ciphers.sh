#!/bin/bash
echo "Starting cipher change for sshd_config so pps can get in over ssh"
sed -i "s/Ciphers /#Ciphers /g" /etc/ssh/sshd_config
echo "Done with ciphers change"
