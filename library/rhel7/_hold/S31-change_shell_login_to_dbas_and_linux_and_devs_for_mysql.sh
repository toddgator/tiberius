#!/bin/bash
# Change shell allowed login from "Linux Admins" to "G_DBA_Dev_Shell_Login"
sed -i "s/S-1-5-21-464601995-1902203606-794563710-15628/S-1-5-21-464601995-1902203606-794563710-34235/g" /etc/pam.d/password-auth-ac
sed -i "s/S-1-5-21-464601995-1902203606-794563710-15628/S-1-5-21-464601995-1902203606-794563710-34235/g" /etc/pam.d/system-auth
echo "User_Alias DBAS = jkern, bjohnston, chines" >> /etc/sudoers
echo "DBAS ALL=(root) NOPASSWD: ALL" >> /etc/sudoers
echo "User_Alias DEVS = jmichell, nbeyer" >> /etc/sudoers
echo "DEVS ALL=(root) NOPASSWD: ALL" >> /etc/sudoers

