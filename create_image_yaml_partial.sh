#!/usr/bin/env bash
# Copyright 2021 Nate Gay
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e

help_dialog(){
    {
        echo "Usage: ${0} NAME NEW_NAME DIGEST"
        echo
        echo 'NAME is the name of the image as described by the base yaml'
        echo 'NEW_NAME is the name that we want the image to use'
        echo 'DIGEST is the digest that we want the image to use'
    }
}

NAME="${1}"
NEW_NAME="${2}"
DIGEST="${3}"
[[ -z "${NAME}" ]] && help_dialog && exit 1
[[ -z "${NEW_NAME}" ]] && help_dialog && exit 1
[[ -z "${DIGEST}" ]] && help_dialog && exit 1

{
    echo "- name: ${NAME}"
    echo "  newName: ${NEW_NAME}"
    echo "  digest: ${DIGEST}"
}
