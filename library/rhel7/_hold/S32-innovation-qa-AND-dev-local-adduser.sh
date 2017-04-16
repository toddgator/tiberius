#!/bin/bash
#Script to add local user account 'mark' to innovation qa and dev hosts w/ sudo rights and require password change

/usr/sbin/useradd -G wheel mark && echo 1password | passwd mark --stdin && chage -d 0 mark
