import shutil
import sys
import time

import re

'''
This script's purpose is to do a text search of a default tomcat server.xml
configuration file and search for the default clustering xml element(s)
(which are commented out by default) and then replace the commented out section
with the text block below found in the "new_configuration_lines" variable.
'''

# RPM multicast port must be given as an argument.
mcast_port = str(sys.argv[1])

# This variable is the string representation of the regex pattern that will be
# used to match the text to be removed from the configuration file.
#
# This regex was written with the regex flags passed within the pattern because
# in re.sub in python 2.6 (default for RHEL's anaconda installer) doesn't
# understand the flags passed directly. If you want further information please
# refer to this stackoverflow thread:
# http://stackoverflow.com/questions/8813265/why-doesnt-ignorecase-flag-re-i-work-in-re-sub
lines_2_replace = '(?m)^\s*<!--\n\s*<Cluster\sclassName="org\.apache.catalina\.ha\.tcp\.SimpleTcpCluster"/>\n\s*-->$'

# The following text block will enable tomcat clustering and configure the
# multicast port based on the port given at runtime.
new_configuration_lines = """

        <!-- This section added by THIG automation -->
        <Cluster className="org.apache.catalina.ha.tcp.SimpleTcpCluster"
                 channelSendOptions="8">

          <Manager className="org.apache.catalina.ha.session.DeltaManager"
                   expireSessionsOnShutdown="false"
                   notifyListenersOnReplication="true"/>

          <Channel className="org.apache.catalina.tribes.group.GroupChannel">
            <Membership className="org.apache.catalina.tribes.membership.McastService"
                        address="228.0.0.4"
                        port="%s"
                        frequency="500"
                        dropTime="3000"/>
            <Receiver className="org.apache.catalina.tribes.transport.nio.NioReceiver"
                      address="auto"
                      port="4000"
                      autoBind="100"
                      selectorTimeout="5000"
                      maxThreads="6"/>

            <Sender className="org.apache.catalina.tribes.transport.ReplicationTransmitter">
              <Transport className="org.apache.catalina.tribes.transport.nio.PooledParallelSender"/>
            </Sender>
            <Interceptor className="org.apache.catalina.tribes.group.interceptors.TcpFailureDetector"/>
            <Interceptor className="org.apache.catalina.tribes.group.interceptors.MessageDispatch15Interceptor"/>
          </Channel>

          <Valve className="org.apache.catalina.ha.tcp.ReplicationValve"
                 filter=""/>
          <Valve className="org.apache.catalina.ha.session.JvmRouteBinderValve"/>

          <Deployer className="org.apache.catalina.ha.deploy.FarmWarDeployer"
                    tempDir="/tmp/war-temp/"
                    deployDir="/tmp/war-deploy/"
                    watchDir="/tmp/war-listen/"
                    watchEnabled="false"/>

          <ClusterListener className="org.apache.catalina.ha.session.ClusterSessionListener"/>
        </Cluster>
        <!-- End THIG added configuration -->

""" % mcast_port

fd_name = '/opt/rpm/conf/server.xml'
fmt_date = time.strftime("%Y-%m-%d")
fd_tmp_name = fd_name + '.bak-' + fmt_date

# Rename the server.xml so that we still have the original configuration in
# order to read it.
shutil.move(fd_name, fd_tmp_name)

# Open the newly created backup file and read in the default provided
# configuration.
fd_data = open(fd_tmp_name, 'r').read()
match = re.search(lines_2_replace, fd_data, re.MULTILINE)

# Open the true server.xml file to write the new configuration
fd_new = open(fd_name, 'w')

if match:
    # This re.sub() does an in place replacement against the fd_data string,
    # however it's only stored as a variable and no files have been updated
    # since the shutil.move() execution above.
    result = re.sub(lines_2_replace, new_configuration_lines, fd_data, count=1)

    # Now that our desired configuration has been created and stored as 'result'
    # we write that data to the original server.xml file.
    fd_new.write(result)
else:
    # If we weren't able to match the pattern with the re.search() above, then
    # we just rewrite the original configuration to server.xml.
    fd_new.write(fd_data)
