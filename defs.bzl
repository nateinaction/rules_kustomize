# Copyright 2021 BenchSci Analytics Inc.
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

"rules_kustomize"

load("//:kustomization.bzl", _kustomization = "kustomization")
load("//:kustomize_image.bzl", _kustomize_image = "kustomize_image")

kustomization = _kustomization
kustomize_image = _kustomize_image
