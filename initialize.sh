#!/usr/bin/env bash
#
# initialize.sh:
#   This script initializes certain environment variables that will be needed
#   throughout the build routine. After determining the build environment it
#   configures a few global system variables that will then be used to
#   determine which scripts are proper for the environment and server role that
#   we are building/deploying.
#
# Dependencies:
#   - 'lsb_release' utility must be installed on target system during OS install
#     in order for the respective OS lsb_release ID to be reported during


# GLOBALS
THIG_HOME="/opt/thig"
PROJECT_NAME="tiberius"
PROJECT_HOME="${THIG_HOME}/${PROJECT_NAME}"
LOG_FULL_PATH="/var/log/tiberuis-build-output.log"
LOG_TIMESTAMP="$(date +"%m-%d-%Y %H:%M:%S")"

# GLOBALS - provider codes
PROVIDER_AMAZON="aws"
PROVIDER_THIG="thig"
PROVIDER_UNKNOWN="unknown"


# Derives our environment configs from the hostname and writes out the relevant
# values to a config file.
#
# Arguments: None
# Returns: None
export_srvr_config () {
	if [[ ${provider} == ${PROVIDER_AMAZON} ]]; then

    # Create a default THIG configuration directory for aws servers
    mkdir -p /etc/thig

    # The hostname is assigned by the cloud-init boot configuration executed
    # when an ec2 is started. From that we can determine the environment
    # configuration items we'll need to execute the build.
    #
    # Expected AWS hostname convention:
    #   ${locationCode}-${appRole}-${environment}-${node} -> aws-www-prod-01
    #
    local servername="$(hostname -s)"
    local os="$(get_operating_system)"
    local provider="$(get_provider)"

		# Write our system configuration variables to '/etc/thig/thig-settings' for
		# future use.
		cat << EOF > /etc/thig/thig-settings
export PROVIDER=${provider}
export ENVIRONMENT=$(echo ${servername} | awk -F- '{print $3}')
export LOCATIONCODE=$(echo ${servername} | awk -F- '{print $1}')
export OS=${os}
export ROLE=$(echo ${servername} | awk -F- '{print $2}')
export NODE=$(echo ${servername} | awk -F- '{print $4}')
EOF
	elif [[ ${provider} == ${PROVIDER_THIG} ]]; then
	  # Create a default THIG configuration directory for on-prem THIG servers
	  mkdir -p /etc/sdi

	  #TODO: What needs to go here that isn't already in the *.ks boot file??
	  #TODO: Or is that even how this should work anymore on-prem?
  fi
}

# Determine the operating system of the virtual machine and return an ID
# accordingly.
#
# Arguments: None
# Returns: string
get_os_code () {
  # IDs returned by the respective distros via the 'lsb_release' util
  local amazon_lsb_code="AmazonAMI"
  local redhat_lsb_code="RedHatEnterpriseServer"
  local ubuntu_lsb_code="ubuntu"

  # THIG codenames for the distros
  local thig_amazon_code="amzn-linux"
  local thig_redhat_code="redhat"
  local thig_ubuntu_code="ubuntu"

  # Note - xargs just used to strip whitespace
  os_code=$(lsb_release -i | awk -F: '{print $2}' | xargs)

  case "${os_code}" in
    ${amazon_lsb_code})
      echo ${thig_amazon_code}
      ;;
    ${redhat_lsb_code})
      echo ${thig_redhat_code}
      ;;
    ${ubuntu_lsb_code})
      echo ${thig_ubuntu_code}
      ;;
    *)
      echo "unknown"
      ;;
  esac
}

# Function determines the Virtual Machine provider based on the hostname.
# 
# AWS style hostname: aws-dev-web-01.aws.thig.com
# THIG style hostname: sflgnvrpm01.thig.com
# 
# Arguments: None
# Returns: String
get_provider () {
	local servername="$(hostname -s)"
	local provider=""
	
	# If the hostname contains hyphens then we can consider it AWS provided,
	# while if it is an 11 character string(9 letters followed with 2 digits)
	# w/out hyphens it's THIG provided.
	# * Amazon hostname example: aws-www-prod-01
	# * THIG hostname example: sflgnvpps01
	if [[ ${servername} =~ ^([A-Z][a-z]){3}-([A-Z][a-z])*-([A-z][a-z][0-9]){0,4}-[0-9]{2}$ ]]; then
		provider="${PROVIDER_AMAZON}"
	elif [[ ${servername} =~ ^([A-Z][a-z]){9})[0-9]{2}$ ]]; then
		provider="${PROVIDER_THIG}"
	else
	  provider="${PROVIDER_UNKNOWN}"
	fi
	
	echo ${provider}
}

get_thig_env () {
  export HOSTNAME=$(grep HOSTNAME /etc/sysconfig/network | awk -F= '{print $2}')
  hostname $HOSTNAME
  export SERVERNAME=$(hostname -s)
  export ROLE=$(echo ${SERVERNAME:6:3} | tr [:upper:] [:lower:])

}





# Disable 'nullglob' shell option (to avoid glob matching issues)
shopt -s nullglob

# Generate THIG system configuration variables
export_srvr_config

# Pulling in the system variables we just exported
source /etc/thig/thig-settings

# Surrounding the actual script executions in parens (is this what people are
# calling them these days??) so as to redirect output to log file.
(
  if [ "${OS}" = "unknown" ] || [ -z "${OS}" ]; then
    echo "${LOG_TIMESTAMP} - Unable to determine OS type for build; Exiting"
    exit
  else
    # This loop executes all the scripts relevant to the particular os, role,
    # and environment designated for the build.
    for script in ${PROJECT_HOME}provider/${PROVIDER}/os/${OS}/all/*.sh \
        ${PROJECT_HOME}provider/${PROVIDER}/os/${OS}/roles/all/*.sh \
        ${PROJECT_HOME}provider/${PROVIDER}/os/${OS}/roles/${ROLE}/all/*.sh \
        ${PROJECT_HOME}provider/${PROVIDER}/os/${OS}/roles/${ROLE}/${ENVIRONMENT}/*.sh
    do
      echo "${LOG_TIMESTAMP} - Attempting to execute ${script}"
      /bin/bash ${script}
      echo "${LOG_TIMESTAMP} - Completed ${script}"
    done
  fi
) &> ${LOG_FULL_PATH}
