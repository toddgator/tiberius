#!/bin/bash

mkdir /tmp/rundeck
cd /tmp/rundeck

curl -O http://sflgnvcfs02.thig.com/thiglocalmirror/third-party/rundeck-2.6.9-1.21.GA.noarch.rpm  
curl -O http://sflgnvcfs02.thig.com/thiglocalmirror/third-party/rundeck-config-2.6.9-1.21.GA.noarch.rpm
rpm -i rundeck-2.6.9-1.21.GA.noarch.rpm rundeck-config-2.6.9-1.21.GA.noarch.rpm


