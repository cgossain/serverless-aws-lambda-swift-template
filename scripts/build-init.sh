#!/bin/bash

set -eu

executable=$1

# start the ssh agent
eval $(ssh-agent) > /dev/null

# add ssh keys (the ssh key should not have a passphrase)
# ssh-add /root/.ssh/id_rsa
for possiblekey in ${HOME}/.ssh/id_*; do
    if grep -q PRIVATE "$possiblekey"; then
        ssh-add "$possiblekey"
    fi
done

# execute the build command
swift build --product $executable -c release
