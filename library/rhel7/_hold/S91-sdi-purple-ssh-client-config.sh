#!/bin/bash
# all other hosts in environment (jbo, iab, wab, bat)
# place corresponding .pub file in authorized_keys
echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAwDRt6EU6/Od4BwUIY1WoBbKAkz/bQ19qySeFEz+IP2/o8nvjGvFl+iXth3j1kbUpHyrOA5l5n5wkXExAZmpBExND2DybWBwLr5jvd3zux6F/rcHi5z5OoWZRJgKQBQgeOJt2VzPF1q/u0Nc72/QEFlWDwT/X5bTUtT6vnmqBBlwV8h/DCUrdHz6M/XTO1LHnxZbBNbP1t+YdKZdAxrNM8lTC5bV3LudGRTrn5G48yN9PDOURy8IESIRID0hYSRbrkTFFdQmXryXFBCzW0hjQS8mkYW1vh/GOaOnca6BzfS/R6L6I1l4QC6YHFKJcmfgmo6Y+4e1Ibon7gNXTif+VAQ== sdi@$(hostname -s).thig.com" >> /home/sdi/.ssh/authorized_keys
echo -e "Host github.thig.com\n\tStrictHostKeyChecking no\n" >> /home/sdi/.ssh/config
