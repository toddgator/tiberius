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


export_thig_config () {
  # Create a default THIG configuration directory
  mkdir -p /etc/thig

  # THIG hostname convention:
  #   ${locationCode}-${appRole}-${environment}-${node}
  #
  #   example: aws-www-prod-01
  #
  # The hostname is assigned by either the kickstart configuration when building
  # a new VM or from the cloud-init configuration when starting a new EC2. Since
  # that's already assumed to be setup properly during the OS installation we
  # can now determine the necessary environment variables needed for our build.
  local servername="$(hostname -s)"
  local os="$(get_operating_system)"

  # Write our system configuration variables to '/etc/thig/thig-settings' for
  # future use by other scripts and/or projects.
  cat << EOF > /etc/thig/thig-settings
export ENVIRONMENT=$(echo ${servername} | awk -F- '{print $3}')
export LOCATIONCODE=$(echo ${servername} | awk -F- '{print $1}')
export OS=${os}
export ROLE=$(echo ${servername} | awk -F- '{print $2}')
export NODE=$(echo ${servername} | awk -F- '{print $4}')
EOF
}


# Disable 'nullglob' shell option (to avoid glob matching issues)
shopt -s nullglob

THIG_HOME="/opt/thig"
PROJECT_NAME="tiberius"
PROJECT_HOME="${THIG_HOME}/${PROJECT_NAME}"
LOG_FULL_PATH="/var/log/tiberuis-build-output.log"
LOG_TIMESTAMP="$(date +"%m-%d-%Y %H:%M:%S")"

# Generate THIG system configuration variables
export_thig_config

# Pulling in the system variables we just exported
source /etc/thig/thig-settings

# Surrounding the actual script executions in parens so as to redirect output
# to log file.
(
  if [ "${OS}" = "unknown" ] || [ -z "${OS}" ]; then
    echo "${LOG_TIMESTAMP} - Unable to determine OS type for build; Exiting"
    exit
  else
    # This loop executes all the scripts relevant to the particular os, role,
    # and environment designated for the build.
    for script in ${PROJECT_HOME}/os/${OS}/all/*.sh \
        ${PROJECT_HOME}/os/${OS}/roles/all/*.sh \
        ${PROJECT_HOME}/os/${OS}/roles/${ROLE}/all/*.sh \
        ${PROJECT_HOME}/os/${OS}/roles/${ROLE}/${ENVIRONMENT}/*.sh
    do
      echo "${LOG_TIMESTAMP} - Attempting to execute ${script}"
      /bin/bash ${script}
      echo "${LOG_TIMESTAMP} - Completed ${script}"
    done
  fi
) &> ${LOG_FULL_PATH}