#!/bin/bash
##===----------------------------------------------------------------------===##
##
## This source file is part of the SwiftAWSLambdaRuntime open source project
##
## Copyright (c) 2017-2018 Apple Inc. and the SwiftAWSLambdaRuntime project authors
## Licensed under Apache License v2.0
##
## See LICENSE.txt for license information
## See CONTRIBUTORS.txt for the list of SwiftAWSLambdaRuntime project authors
##
## SPDX-License-Identifier: Apache-2.0
##
##===----------------------------------------------------------------------===##

set -eu

DIR="$(cd "$(dirname "$0")" && pwd)"
source $DIR/config.sh

echo -e "\ndeploying $targets"

$DIR/build-and-package.sh "$targets"

echo "-------------------------------------------------------------------------"
echo "deploying using Serverless"
echo "-------------------------------------------------------------------------"

# I'm unable to access the $targets variable as an array out here. To fix, we can
# convert it back to an array and store in a new variable
# https://stackoverflow.com/a/9294015/485352
functions=($targets)

# If multiple functions were selected deploy everything, otherwise deploy the specific function
serverless deploy --config "serverless.yml" --stage dev -v
# if [[ ${#functions[@]} > 1 ]]; then
#     serverless deploy --config "serverless.yml" --stage dev -v
# else
#     serverless deploy --config "serverless.yml" --stage dev -v -f $targets
# fi
