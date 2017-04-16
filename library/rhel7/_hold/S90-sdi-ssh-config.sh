#!/bin/bash

# IAB

rm -f /home/sdi/.ssh/config
rm -f /home/sdi/.ssh/id_rsa
rm -f /home/sdi/.ssh/id_rsa.pub

mkdir -p /home/sdi/.ssh
chown -R sdi:sdi /home/sdi/.ssh
chmod 700 /home/sdi/.ssh
cat << EOF >> /home/sdi/.ssh/config 
	StrictHostKeyChecking no
	UserKnownHostsFile=/dev/null
Host github.thig.com
	StrictHostKeyChecking no
EOF

chmod 700 /home/sdi/.ssh/config 

cat << EOF > /home/sdi/.ssh/id_rsa
-----BEGIN RSA PRIVATE KEY-----
MIIEoAIBAAKCAQEA6v9PIuS6sjF5kHtcEYg27gln4k9X9in3WQkYyDChJAPlGa2n
9tW3He/pX/BXhT5L48LggOWjv91iGVRPiyHppLY/tTDvWRY+mtrAgFbBT4svzDw4
fqOyLpzc9Kz89ALfnAdL7H0WIBFE7HAk4d/RMB45gBOFTpHUfUqlV412mdk7HKvY
HpA8nh5aDRJtz+s1yWmXgRZ6ciHasyfAb5TODrJyO0WdxKoby8P5xI7XWau16FGP
Q/gAsm9tmLz0wnoH0LZdxSVtfzEb5jVN5hxznySa2fSCFPSbq+WoOFq5Xe0W+VJk
YBNCCY4/Bzoh3BX7mOtzouQ1YkHhMS7/558nrwIBIwKCAQByJDxhZ8hlLfk3jF/r
QilPC+IANSq5ZNc539jWQ4F35KJ6L8acdm7ip7p/DlZlSiTcV1caCSOmVZYMTYW4
m3F7434HjMwGswh3Gcs3BZEYAcbCSSLBKvAlROBZldny3NMCpHVVm9eL6yF6J9dm
ZWWbB13B3ZiFP4R3XsVWaUg8GB+8HHnf4zushpPHyIMa73lUjxPyJD4yASYE1gNX
3wGDynAwn+yX0Puq7L1iY5GpGSrljh+xYU3glIiA1xQ3IlTDnQ2r/V/QqrMUNpjX
GL1APoiSsja+VZgChTTUhhZRP3iGftu5frk54UvR5n1kbx9iTs1U/bvQiFJDq3xW
2Q9jAoGBAPvLoohhVzTcmzZLlQmX0dzKqE09ALnD9goy5Zg6rx12LgojSDioPlQQ
UVxySf4dPQiPYzpLUCe9IXYwURvy+U/ywwCCOREYT2RjTcskTKVECgnGvV6r8aY+
aov9fsyqVYD/gJB0yfI3twoMM/7naOsa5BlvdhMNoc6p4hsY++pFAoGBAO7r3b47
kl+4qk3a4JKILFAjfJmr6UChktyUa2yeGo9cAb1ZhvZ6cjoQP+o8aMt24II1BfWa
hSmQWGXmsQmLKvpLN4xoWy25RgqVhin36CqamdI/i/3/Q61oSr6FT2Rmq3+3vZcT
CCzTJXrDWMZxMbHCsGgqGHJ6Hf+/vqiUTcNjAoGADmNoX5CIo+9ZU49KWFHRelS5
KPwr7VunqM+1WSfsv9reDzU3U7HXrQg/KdqlJHazB82t5hLuoy9g/3B5qdNetByA
K+ovJYxcTuEaY2Eo84A7FoBil7INzvxAmkj/7nAiJKDixm0S2qQZFoRavhvaHBAq
SpinqVE8cjWX5EqSDWMCgYA9b9nvFqH7W17+E7YXDRK1hXfPvn3OynY4uHNlErZf
YM0/UYkazwduBC2xQrvcjEhb/wGITE4goXXRD29aObqYIfhXTgjRPkU16+9MntVM
yKs2EFcyr1qLrRqIwzGsGmadLz9hXKpUq1LHy9T/0/bV8Dv9hyrbm76SOJ69onpl
cQKBgCSZlSCVjftTO2b38R5f3y2njqrn2QqjhmSyXpgEuVI8F8xeidSSQh4RHHCl
K6YzXmT4BjnCnFyClRzDV3H0T1a9/2LZtjLFFPl7Pbrp/SPlPfo4FYj83L/0WfLy
eTN0kfNuHcVTe4PmcwWI/rcKag+JgL5a/lFT7HwwGqVO/Y+Q
-----END RSA PRIVATE KEY-----
EOF

chmod 700 /home/sdi/.ssh
chmod 600 /home/sdi/.ssh/authorized_keys
chmod 600 /home/sdi/.ssh/id_rsa
chmod 644 /home/sdi/.ssh/id_rsa.pub
chown -R sdi:sdi /home/sdi/.ssh


