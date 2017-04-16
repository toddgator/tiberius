#!/bin/bash
# all other hosts in environment (jbo, iab, wab, bat)
# place corresponding .pub file in authorized_keys
echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAvd8X1OUjLBAKV5kfc3cIRiAM7fLm246iiCMN8gED/0uATpIQwqhCZQI3AaT3yLUxALqyGZun4RzCAOJ2OWXuNjj2jw0OFuSn64zk8ZeozxVTgj+P1GofVvERk5a3YfUNwvRBDM8wtLadLnw7esmMDv2f0jc8Ej4p42+z53O+btVkhOuLg7pCAMkmB7FWyh5LD3mmMRA/rY9UEJ3vNeWsKIrKABhkDTukWxGWHX8Pir97cQMheeS5t5gzk9l2EeEYUTjQ+Z3B397FukyTo057nOgktbag74TMIThUD4iQYWdQfDul86SKTrxSNqkwyuf+QCJgVIK+ymzkOtWYEIjLYQ== sdi@$(hostname -s).thig.com" >> /home/sdi/.ssh/authorized_keys
echo -e "Host github.thig.com\n\tStrictHostKeyChecking no\n" >> /home/sdi/.ssh/config
