#!/bin/bash

##################
# Input: requires 2 argument, 1st as organisation name and 
# and secons as repository name
# 
# Author = Ashutosh Kumar
# Date = 27/08/24
# version = v1
# 
# This script access the github and fetches the user of a repository
# an organisation.
# 
# ################

# set -x
set -e

# github api url
API_URL="https://api.github.com"

# github username and personal access token
# export username="ashuto91"
# export token="sdghffgy"
USERNAME=$username
TOKEN=$token

# User and Repository information
# Two arguments are being passed - 1st as repo owner(organisation name 'DevOps24-Ashutosh')
# and second is repo name "GitHub_API_Integration"
REPO_OWNER=$1
REPO_NAME=$2

if [ $# -ne 2 ]; then
    echo "Provide 2 args"
    exit 1
fi

# Function to make a get request to GitHUb API
function github_api_get {
    local endpoint="$1"
    local url="${API_URL}/${endpoint}"

    # Send a GET request to GitHub API with authentication
    curl -s -u "${USERNAME}:${TOKEN}" "$url"

}


# Function to list users with read access to the repo
function list_users_with_read_access {

    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"

    # Fetch the list of collaborators with read access
    collaborators="$(github_api_get "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')"


    # Display the list of collaborators with list access
    if [[ -z "$collaborators" ]]; then
        echo "No users with read access found for ${REPO_OWNER}/${REPO_NAME}."
    else
        echo "Users with read access to ${REPO_OWNER}/${REPO_NAME}"
        echo "$collaborators"
    fi

}

echo "Listing users with read access to ${REPO_OWNER}/${REPO_NAME}..."
list_users_with_read_access
















