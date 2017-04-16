#!/bin/bash
. /etc/sdi/thig-settings

echo "Creating the /etc/pro4.ini and /etc/pro4v7.ini files for settings and \
license info..."

if [ -f /etc/pro4v7.ini ]; then
  mv -v /etc/pro4v7.ini /etc/pro4v7.ini.default
fi

cp -vf /opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/${ROLE}/all/pro4.ini /etc/pro4.ini
cp -vf /opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/${ROLE}/all/pro4v7.ini /etc/pro4v7.ini

# Notes environment name required to be upper case to match environment.ini
NOTES_ENVIRONMENT=$(echo ${ENVIRONMENT} | tr '[:lower:]' '[:upper:]')

for fd in /etc/pro4.ini /etc/pro4v7.ini; do
  sed -i "s/sed-me-to-environment-subdomain/${ENVIRONMENT_SUBDOMAIN_FOR_URLS}/g" ${fd}
  sed -i "s/sed-me-to-dbname/${DBNAME}/g" ${fd}
  sed -i "s/sed-me-to-notes-environment/${NOTES_ENVIRONMENT}/g" ${fd}
  if [[ $ENVIRONMENT == "prod" ]]; then
    sed -i 's/sed-me-to-license-server/qflgnvppl01.thig.com/g' ${fd}
  else
    sed -i 's/sed-me-to-license-server/qflgnvppl01.thig.com/g' ${fd}
  fi
  echo "# HOSTNAME" >> ${fd}
  echo "HOSTNAME=$(hostname -f)" >> ${fd}
done

# Linking pro4v6.ini (just in case; should be deprecated in future)
ln -sv /etc/pro4.ini /etc/pro4v6.ini

echo "Done."
echo ""
