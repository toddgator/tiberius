#!/bin/bash
/etc/init.d/sdi.opendj start
sleep 11
exit
/etc/init.d/sdi.opendj import
sleep 40
