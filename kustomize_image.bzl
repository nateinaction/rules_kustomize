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

load("@bazel_skylib//lib:dicts.bzl", "dicts")
load("@io_bazel_rules_docker//container:providers.bzl", "PushInfo")

# https://kubectl.docs.kubernetes.io/references/kustomize/kustomization/images/
ImageInfo = provider(
    doc = "Image modification information",
    fields = {
        "partial": "A yaml file containing kustomize image replacement info",
    },
)

def _impl(ctx):
    image_name = '{}/{}'.format(ctx.attr.image_details[PushInfo].registry, ctx.attr.image_details[PushInfo].repository)
    output = '\n'.join([
        '\\055 name: {}'.format(image_name if ctx.attr.image_name == '' else ctx.attr.image_name),
        '  newName: {}'.format(image_name),
        '  digest: $(cat {})'.format(ctx.attr.image_details[PushInfo].digest.path),
    ])
    ctx.actions.run_shell(
        inputs = [ctx.attr.image_details[PushInfo].digest],
        outputs = [ctx.outputs.partial],
        arguments = [],
        command = 'printf "{}\n" > "{}"'.format(output, ctx.outputs.partial.path),
    )
    return [ImageInfo(partial = ctx.outputs.partial)]

kustomize_image_ = rule(
    attrs = dicts.add({
        "image_details": attr.label(
            doc = "A label containing the container_push output for an image.",
            cfg = "host",
            mandatory = True,
            allow_files = True,
            providers = [PushInfo]
        ),
        "image_name": attr.string(
            mandatory = False,
            default = "",
            doc = "The name of the image to be modified.",
        ),
    }),
    implementation = _impl,
    outputs = {
        "partial": "%{name}.yaml.partial",
    },
)

def kustomize_image(**kwargs):
    kustomize_image_(**kwargs)
