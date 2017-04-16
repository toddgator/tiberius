#!/bin/bash
# groupadd forgerock
groupadd forgerock
mkdir /opt/forgerock
chgrp -HR forgerock /opt/forgerock
chown root:forgerock /opt/forgerock
chmod g+w /opt/forgerock

