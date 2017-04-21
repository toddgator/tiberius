#!/usr/bin/env bash
#
# Updates the Apache configuration as needed in order to create a production
# www.thig.com virtual host.

# Note:
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
# Returns: String (project name; which is the directory we create)
get_apache24_configs_repo () {
local github_project_name="aws-apache24-site-configs.git"
local toddgator_github_user="toddgatorthig"
local toddgator_github_path="https://github.com/toddgator/${github_project_name}"

su - ${toddgator_github_user} -c "git clone ${toddgator_github_path}"

# Return the name of the directory we just created using 'git clone'
echo ${github_project_name}
}


# Begin
cd /tmp

repo_directory=$(get_apache24_configs_repo)
/tmp/${repo_directory}/install.sh

# Return to the directory where we were before moving to /tmp
cd -