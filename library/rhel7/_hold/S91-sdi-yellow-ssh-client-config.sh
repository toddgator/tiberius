#!/bin/bash
# all other hosts in environment (jbo, iab, wab, bat)
# place corresponding .pub file in authorized_keys
echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAv7AU4IHiUt6c/oYmWM6wT4aMvu3hh4kVUz8BOkmXwcuASGCc0Uq6HuKQg7t9TbQeMIeVqIkwpz9Ss84zDR8iPMYYyZNL5x9ROxFRdVTJInXyO1yYYBGFHVPB2loZHIe60Yh9P2K/tXRYVNKZa71Ror6x8+5jLwOZi0rJ+k+pARvVBINZ/1B0on918sN+VLkeg9urujyiECuIa888FcSLhfTi/KWrtbLtGE4s1roIpjcN/WU107GDCyEqp5GSoaTBLceOhXNry7S/P5kjnjee2SQmx2Rev5xLTG1jPQOOYA4Z2wfhQ1zUcG65pPgtsQrJ3oCQKKG9AakUREKXzVleIQ== sdi@$(hostname -s).thig.com" >> /home/sdi/.ssh/authorized_keys
echo -e "Host github.thig.com\n\tStrictHostKeyChecking no\n" >> /home/sdi/.ssh/config
