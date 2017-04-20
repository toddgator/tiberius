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
#     in order for the respective OS lsb_release ID to be reported.


# Globals - Basic project env
THIG_OPT_ROOT="/opt/thig"
APPLICATION_NAME="tiberius"
APPLICATION_ROOT="${THIG_OPT_ROOT}/${APPLICATION_NAME}"

# Globals - Logging
FD_LOG_PATH="/var/log/tiberuis-build-output.log"
LOG_TIMESTAMP="$(date +"%m-%d-%Y %H:%M:%S")"

THIG_ETC_ROOT="/etc/sdi"
AWS_ETC_ROOT="/etc/thig"

# Globals - provider codes ("declare -r" keeps the provider codes immutable)
declare -r PROVIDER_AMAZON="aws"
declare -r PROVIDER_THIG="thig"
declare -r PROVIDER_UNKNOWN="unknown"


# Method determines our environment configs from the hostname and writes out
# the relevant values to a config file.
#
# Arguments: None
# Returns: None
export_srvr_config () {
  local provider="$1"
  local os="$2"
  local settings_filename="thig-settings"
  local servername

  # Getting the hostname from the system's 'hostname' utility (using the '-s'
  # option gives only the base name without the domain section of the FQDN)
  servername="$(hostname -s)"

  case "${provider}" in
    ${PROVIDER_AMAZON})
      mkdir -p ${AWS_ETC_ROOT}
      cat << EOF > ${AWS_ETC_ROOT}/${settings_filename}
export LOCATIONCODE=$(echo ${servername} | awk -F- '{print $1}')
export ROLE=$(echo ${servername} | awk -F- '{print $2}')
export ENVIRONMENT=$(echo ${servername} | awk -F- '{print $3}')
export NODE=$(echo ${servername} | awk -F- '{print $4}')
export PROVIDER=${provider}
export OS=${os}

EOF
      ;;

    ${PROVIDER_THIG})
      # TODO: Does the kickstart already do this part of the build for Thig?
      [ -d ${THIG_ETC_ROOT} ] || mkdir -p ${THIG_ETC_ROOT}
      ;;

    *)
      # TODO: Should we technically be exiting with an error code at this point?
      ;;
  esac
}

# Determine the operating system of the virtual machine and return an ID
# accordingly.
#
# Arguments: None
# Returns: string (os code)
get_thig_os_code () {
  local lsb_os_code

  # IDs returned by the respective distros via the 'lsb_release' util
  local lsb_code_amazon="AmazonAMI"
  local lsb_code_redhat="RedHatEnterpriseServer"
  local lsb_code_ubuntu="ubuntu"

  # THIG codenames for the distros
  local thig_code_amazon="amzn-linux"
  local thig_code_redhat="redhat"
  local thig_code_ubuntu="ubuntu"

  # Note - xargs just used to strip whitespace
  lsb_os_code=$(lsb_release -i | awk -F: '{print $2}' | xargs)

  case "${lsb_os_code}" in
    ${lsb_code_amazon})
      echo ${thig_code_amazon}
      ;;
    ${lsb_code_redhat})
      echo ${thig_code_redhat}
      ;;
    ${lsb_code_ubuntu})
      echo ${thig_code_ubuntu}
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
# Returns: String (thig provider code)
get_provider () {
	local servername
	local provider

	local amzn_hostname_regex_match="^[a-zA-Z0-9]{3}-[a-zA-Z0-9]+-[a-zA-Z0-9]+-[0-9]{2}"
  local thig_hostname_regex_match="^[a-z]{9}[0-9]{2}"

	servername="$(hostname -s)"

	# If a hostname contains 4 sections delimited by hyphens then we define it as
	# provided by AWS. If it's a single string with 11 characters (9 lowercase
	# letters followed by 2 digits) then we define it as provided on-prem @thig.
	#
	# Amazon hostname example: aws-www-prod-01
	# Thig hostname example: sflgnvpps01

	if [[ "${servername}" =~ ${amzn_hostname_regex_match} ]]; then
		provider="${PROVIDER_AMAZON}"
	elif [[ "${servername}" =~ ${thig_hostname_regex_match} ]]; then
		provider="${PROVIDER_THIG}"
	else
	  provider="${PROVIDER_UNKNOWN}"
	fi
	
	echo ${provider}
}


main () {
  # Disable 'nullglob' shell option (to avoid glob matching issues)
  shopt -s nullglob

  # Define and export our build configuration variables
  virtual_provider=$(get_provider)
  thig_os_code=$(get_thig_os_code)
  export_srvr_config "${virtual_provider}" "${os_code}"

  case "${PROVIDER}" in
    ${PROVIDER_AMAZON})
      echo "${LOG_TIMESTAMP} - importing aws ec2 env configuration..."
      source ${AWS_ETC_ROOT}/thig-settings
      echo "${LOG_TIMESTAMP} - done"
      ;;

    ${PROVIDER_THIG})
      echo "${LOG_TIMESTAMP} - importing thig VM env configuration..."
      source ${THIG_ETC_ROOT}/thig-settings
      echo "${LOG_TIMESTAMP} - done"
      ;;

    *)
      # You should never end up here!!!!!!!
      echo "${LOG_TIMESTAMP} - Unable to set up environment variables for \"unknown\" virtual provider"
      echo "${LOG_TIMESTAMP} - Exiting..."
      exit
      ;;
  esac

  # Surrounding the actual installation script executions in parens (is this
  # what people are calling them these days??) so as to redirect output to log
  # file.
  (
    if [ "${PROVIDER}" = "unknown" ] || [ -z "${PROVIDER}" ]; then
      echo "${LOG_TIMESTAMP} - Unable to determine our virtual machine provider"
      echo "Exiting..."
      exit
    else
      # This loop executes all the scripts relevant to the particular os, role,
      # and environment designated for the build.
      echo "${LOG_TIMESTAMP} - Executing build..."
      for script in ${APPLICATION_ROOT}provider/${PROVIDER}/os/${OS}/all/*.sh \
          ${APPLICATION_ROOT}provider/${PROVIDER}/os/${OS}/roles/all/*.sh \
          ${APPLICATION_ROOT}provider/${PROVIDER}/os/${OS}/roles/${ROLE}/all/*.sh \
          ${APPLICATION_ROOT}provider/${PROVIDER}/os/${OS}/roles/${ROLE}/${ENVIRONMENT}/*.sh
      do
        echo "${LOG_TIMESTAMP} - Attempting to execute ${script}"
        /bin/bash ${script}
        echo "${LOG_TIMESTAMP} - Completed ${script}"
      done
      echo "${LOG_TIMESTAMP} - ...build completed!"
    fi
  ) &> ${FD_LOG_PATH}
}

main "$@"
