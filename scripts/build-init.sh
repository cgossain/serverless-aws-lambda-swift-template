#!/bin/bash

set -eu

executable=$1

# start the ssh agent
eval $(ssh-agent) > /dev/null

# add the ssh key (the ssh key should not have a passphrase)
ssh-add /root/.ssh/id_rsa

# execute the build command
swift build --product $executable -c release
