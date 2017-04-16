#!/bin/bash

sed -i "s|PollTime=\"60000\"|PollTime=\"600000000\"|g" /home/innovation/app/PROD/prefs/mda/template/email-listener-settings.xml 
sed -i "s|imap.thig.com|notanimap.thig.com|g" /home/innovation/app/PROD/prefs/mda/template/email-listener-settings.xml 
