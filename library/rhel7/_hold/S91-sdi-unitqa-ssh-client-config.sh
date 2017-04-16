#!/bin/bash
# all other hosts in environment (jbo, iab, wab, bat)
# place corresponding .pub file in authorized_keys
echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA0PrK6LvCV439heskZBxH46sp86J4dIC72txrKPa5OGD1eS/i7D8Mq5R9D3WNpZFs4cIVrklwoblGcHjdBwMcst29GOhGkLdB4VAqsIqxsJDdx3ap9P7Vxdan91Gu6H8A/18tJItyDYxs6KVzu7R9KR1w3mTSZCy6L5At4MrVKjrr6yN9N1L6kXn19LJTlo+SccIz/H8GIby30yJngi/LUVplLQDh0EkvfqgLUe62qyh0i1Nj4sP0B3loCyfOOepJsahOsOQzFMi5HqX6CvYwSeL/3MVW+srZILoccOI4udBCV0BKIkl6NUSBUG83ZQOLTJqI9L4hEEYjNyOsf/xXFw== sdi@$(hostname -s).thig.com" >> /home/sdi/.ssh/authorized_keys
echo -e "Host github.thig.com\n\tStrictHostKeyChecking no\n" >> /home/sdi/.ssh/config
