#!/bin/bash
# Change shell allowed login from "Linux Admins" to "G_OracleShellLogin"
sed -i "s/S-1-5-21-464601995-1902203606-794563710-15628/S-1-5-21-464601995-1902203606-794563710-30253/g" /etc/pam.d/password-auth-ac
sed -i "s/S-1-5-21-464601995-1902203606-794563710-15628/S-1-5-21-464601995-1902203606-794563710-30253/g" /etc/pam.d/system-auth
User_Alias DBAS = jkern, bjohnston, chines
DBAS ALL=(root) NOPASSWD: ALL
