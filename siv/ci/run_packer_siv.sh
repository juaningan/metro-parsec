#!/bin/bash

set -e -x
export
#docker daemon &
#sleep 5
cd packer-siv
packer build ci/packer.json
