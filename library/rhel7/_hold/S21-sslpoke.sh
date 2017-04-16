#!/bin/bash
cat << \EOF > /sbin/sslpoke
#!/bin/bash
echo #########################################################
echo # Must use arguments of server and port as args 2 and 3
echo #  
echo # example: sslpoke oasis.red.thig.com 443
echo #
echo #
echo ########################################################
unalias cp >/dev/null 2>&1
cp /opt/sdi/sdi_service_scripts/supplemental/SSLPoke.class /sbin
if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
fi
echo "OpenSSL obtained certs for $1:$2"
echo "" | openssl s_client -connect $1:$2 -prexit 2>/dev/null | sed -n -e '/BEGIN\ CERTIFICATE/,/END\ CERTIFICATE/ p' | openssl x509 -text -noout | egrep "DNS:|Not After"
echo " " 
pushd /sbin  > /dev/null
java SSLPoke $1 $2
popd > /dev/null
EOF
chmod +x /sbin/sslpoke
