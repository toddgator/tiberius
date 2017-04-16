#!/bin/bash
# all other hosts in environment (jbo, iab, wab, bat)
# place corresponding .pub file in authorized_keys
echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA68w8m0yEW+2pXUMEdjH6SkLilZb7h0XIJfGCUxaDSX3CtzssZT86gNrSNkxxAeWtxXXuVOp843MGS6eB7fT8x8zOC/9vSMf1aYsQ9wh00S288sJBNTtOuTHxPag5tA6+3poe4HbpaT80ReFv4ExfFFAz3gRub6QSvkN9dIli922kD4ks01HdZP4pfkRIBR8zEuK3Vs/IIMzYAEThIvzIQXw1RfUuMD2agnC9cWf5+DhoTGbD/yEcY3rABz9E+pAtlp1mc7UxMLyQP1S5yXorh5TOpMPchDB7knYrFpcPFFadWMi5QDtuipmgvL6iUbqh3FaoWLr7NYIRXBH8GNnW6w== sdi@$(hostname -s).thig.com" >> /home/sdi/.ssh/authorized_keys
echo -e "Host github.thig.com\n\tStrictHostKeyChecking no\n" >> /home/sdi/.ssh/config
