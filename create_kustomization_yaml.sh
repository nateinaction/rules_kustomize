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
        echo "Usage: ${0} CURRENT_PATH RESOURCE_PATH IMAGE_PATHS"
        echo
        echo 'CURRENT_PATH is the path to the kustomization file we are creating'
        echo 'RESOURCE_PATH is the path to the kustomize resource we are referencing'
        echo 'IMAGE_PATHS is a comma delineated string containing paths to image replacement partials'
    }
}

CURRENT_PATH="${1}"
RESOURCE_PATH="${2}"
IMAGE_PATHS="${3}"
[[ -z "${CURRENT_PATH}" ]] && help_dialog && exit 1
[[ -z "${RESOURCE_PATH}" ]] && help_dialog && exit 1

real_resource_path="$(dirname $(realpath --relative-to="${CURRENT_PATH}" "${RESOURCE_PATH}"))"
{
    echo 'apiVersion: kustomize.config.k8s.io/v1beta1'
    echo 'kind: Kustomization'
    echo 'resources:'
    echo "- ${real_resource_path}"
}

if [[ -n "${IMAGE_PATHS}" ]]; then
    echo 'images:'
    for image_path in $(echo "${IMAGE_PATHS}" | tr ',' '\n'); do
        cat "${image_path}"
    done
fi
