#!/bin/bash
##===----------------------------------------------------------------------===##
##
## This source file is part of the SwiftAWSLambdaRuntime open source project
##
## Copyright (c) 2020 Apple Inc. and the SwiftAWSLambdaRuntime project authors
## Licensed under Apache License v2.0
##
## See LICENSE.txt for license information
## See CONTRIBUTORS.txt for the list of SwiftAWSLambdaRuntime project authors
##
## SPDX-License-Identifier: Apache-2.0
##
##===----------------------------------------------------------------------===##

set -eu

targets=$1
workspace="$(pwd)"

# Create the "builder" docker image
echo "-------------------------------------------------------------------------"
echo "preparing docker build image"
echo "-------------------------------------------------------------------------"
docker build . -t builder
echo "done"

# Build and package each executable
for executable in ${targets[@]}; do
    echo "-------------------------------------------------------------------------"
    echo "building \"$executable\" lambda"
    echo "-------------------------------------------------------------------------"
    docker run --rm \
       -v ~/.ssh:/root/.ssh \
       -v "$workspace":/workspace \
       -w /workspace builder \
       bash -cl "./scripts/build-init.sh $executable"
    echo "done"

    echo "-------------------------------------------------------------------------"
    echo "packaging \"$executable\" lambda"
    echo "-------------------------------------------------------------------------"
    docker run --rm \
       -v "$workspace":/workspace \
       -w /workspace builder \
       bash -cl "./scripts/package.sh $executable"
    echo "done"
done
