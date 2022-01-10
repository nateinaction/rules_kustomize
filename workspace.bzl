# Copyright 2021 BenchSci Analytics Inc.
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

"""rules_kustomize"""

load(":archive.bzl", "http_archive_by_os")

def download_kustomize_deps():
    http_archive_by_os(
        name = "kustomize",
        build_file_content = """filegroup(
    name = "file",
    srcs = ["kustomize"],
    visibility = ["//visibility:public"],
) """,
        sha256 = {
            "darwin": "f1e54fdb659a68e5ec0a65aa52868bcc32b18fd3bc2b545db890ba261d3781c4",
            "linux": "f028cd2b675d215572d54634311777aa475eb5612fb8a70d84b957c4a27a861e",
        },
        url = {
            "darwin": "https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv4.1.3/kustomize_v4.1.3_darwin_amd64.tar.gz",
            "linux": "https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv4.1.3/kustomize_v4.1.3_linux_amd64.tar.gz",
        },
    )
