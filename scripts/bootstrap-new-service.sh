#!/bin/bash

# This creates a new project from the template repository
# $1 - the name of your new microservice
service_name=$1
service_name_hook="templateservice"

echo "-------------------------------------------------------------------------"
echo "configuration"
echo "-------------------------------------------------------------------------"
echo "service name: $service_name"
echo "-------------------------------------------------------------------------"

echo "-------------------------------------------------------------------------"
echo "cloning template"
echo "-------------------------------------------------------------------------"
# Clone the template into the project directory
git clone --depth 1 https://github.com/cgossain/serverless-template-swift-aws-lambda.git $service_name

# Remove the `origin` remote from the cloned repository
git --git-dir="$service_name/.git" remote remove origin

# Replace all occurences of the `service_name_hook` with the actual service name
find ./$service_name ! -path "*/node_modules/*" ! -path "*/scripts/*" -name "*" -type f -print | LC_ALL=C xargs sed -i '' -e "s:$service_name_hook:$service_name:g"

echo "done"

echo "-------------------------------------------------------------------------"
echo "commiting changes"
echo "-------------------------------------------------------------------------"
# Stage all the above changes
find ./$service_name ! -path "*/node_modules/*" ! -path "*/scripts/*" -name "Package.swift" -execdir git add . \;

# Rename latest(i.e. `--depth 1`)/initial commit
git --git-dir="$service_name/.git" commit --amend -m "Initial commit"

echo "done"
