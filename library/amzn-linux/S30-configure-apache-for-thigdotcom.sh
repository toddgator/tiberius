#!/usr/bin/env bash
#
# Updates the Apache configuration as needed in order to create a production
# www.thig.com virtual host.

# Notes:
#   This script is intended for use on a base install of Apache/PHP and not
# a server that already has some level of customized configuration or
# pre-existing non-default virtual host(s). Since www.thig.com, as served in
# AWS, will be a dynamicly sized (and load-balanced) webfarm the apache servers
# involved will serve the www.thig.com site exclusively, which is not in-line
# with the on-prem @thig method of sharing a single front-end webfarm for all of
# the webapps in that respective environment.

# Function downloads the latest version of the "aws-apache24-site-configs"
# github repository.
#
# Arguments: None
# Returns: None
get_apache24_configs_repo () {
github_user="thig"
github_path="git@github.thig.com:IT-Operations/thig-apache2.4-site-configs.git"

su - ec2-user -c "git clone ${github_path}"
}


# Begin
orig_working_dir="$(pwd)" # get current working dir

cd /tmp
get_apache24_configs_repo




cd ${current_working_dir}