#!/bin/bash
# all other hosts in environment (jbo, iab, wab, bat)
# place corresponding .pub file in authorized_keys
echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6v9PIuS6sjF5kHtcEYg27gln4k9X9in3WQkYyDChJAPlGa2n9tW3He/pX/BXhT5L48LggOWjv91iGVRPiyHppLY/tTDvWRY+mtrAgFbBT4svzDw4fqOyLpzc9Kz89ALfnAdL7H0WIBFE7HAk4d/RMB45gBOFTpHUfUqlV412mdk7HKvYHpA8nh5aDRJtz+s1yWmXgRZ6ciHasyfAb5TODrJyO0WdxKoby8P5xI7XWau16FGPQ/gAsm9tmLz0wnoH0LZdxSVtfzEb5jVN5hxznySa2fSCFPSbq+WoOFq5Xe0W+VJkYBNCCY4/Bzoh3BX7mOtzouQ1YkHhMS7/558nrw== sdi@$(hostname -s).thig.com" >> /home/sdi/.ssh/authorized_keys
echo -e "Host github.thig.com\n\tStrictHostKeyChecking no\n" >> /home/sdi/.ssh/config
