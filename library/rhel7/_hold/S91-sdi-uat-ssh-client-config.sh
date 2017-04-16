#!/bin/bash
# all other hosts in environment (jbo, iab, wab, bat)
# place corresponding .pub file in authorized_keys
echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAmuTXyVy0EkbvinI+ahSldgzM8GZ2OnWYNvji/yTcvLQvnZtNqMq335cEV1O7jUHoS/raVnh1quJqmV3bkFglY63fm22M8xWzfBfgfRANE+Fivi6fVfGI9jrfRQbWctUE+i3o5ZMHq51i6KI9SmEH0JQ2hjnM5wGbGb/eM7eim1dlBIgF1GBQ/BCRnR70Iqb9IEDxUDr0u6Dbwdd8rb1DZBsIjksZqF3EunGVIVKjjYGWV4RBrt8cItzHNXe8oG9b/ltIGQ3kfPy/eZBGwqoe/GG2aotjmF/fg8fHdgV+4nQDmTgE6cuYKUuX7jPKuTlOT2NEiTiwoY4PAGDCih46eQ== sdi@$(hostname -s).thig.com" >> /home/sdi/.ssh/authorized_keys
echo -e "Host github.thig.com\n\tStrictHostKeyChecking no\n" >> /home/sdi/.ssh/config
