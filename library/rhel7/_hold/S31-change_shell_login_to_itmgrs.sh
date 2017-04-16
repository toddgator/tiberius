#!/bin/bash
# Change shell allowed login from "Linux Admins" to "G_AWS_ITMGR_Linux_Shell_Login"
sed -i "s/S-1-5-21-464601995-1902203606-794563710-15628/S-1-5-21-464601995-1902203606-794563710-34236/g" /etc/pam.d/password-auth-ac
sed -i "s/S-1-5-21-464601995-1902203606-794563710-15628/S-1-5-21-464601995-1902203606-794563710-34236/g" /etc/pam.d/system-auth
echo "User_Alias ITMGRS = ahoward, cbell, chines" >> /etc/sudoers
echo "ITMGRS ALL=(root) NOPASSWD: ALL" >> /etc/sudoers

