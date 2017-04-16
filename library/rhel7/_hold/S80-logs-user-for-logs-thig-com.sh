#!/bin/bash
useradd logs
echo "limeclam25." | passwd --stdin logs
printf "limeclam25.\nlimeclam25." | smbpasswd -s -a logs
