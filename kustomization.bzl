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

load("@bazel_skylib//lib:dicts.bzl", "dicts")
load("@bazel_skylib//lib:paths.bzl", "paths")
load("@bazel_skylib//lib:shell.bzl", "shell")
load("//:kustomize_image.bzl", "ImageInfo")

def _impl(ctx):
    # Create unhydrated yaml
    unhydrated_file = ctx.actions.declare_file('new/{}-unhydrated.yaml'.format(ctx.attr.name))
    unhydrated_dir = paths.dirname(ctx.attr.kustomization_yaml.files.to_list()[0].path)
    unhydrated_args = ctx.actions.args()
    unhydrated_args.add('build', unhydrated_dir)
    unhydrated_args.add('--load-restrictor', 'LoadRestrictionsNone')
    unhydrated_args.add('--output', unhydrated_file.path)
    ctx.actions.run(
        inputs = [file for target in ctx.attr.srcs for file in target.files.to_list()],
        outputs = [unhydrated_file],
        arguments = [unhydrated_args],
        executable = ctx.executable._kustomize,
    )

    # Create kustomization.yaml
    kustomization_file = ctx.actions.declare_file('new/kustomization.yaml')
    yaml = [
        'apiVersion: kustomize.config.k8s.io/v1beta1',
        'kind: Kustomization',
        'resources:',
        '- {}'.format(paths.basename(unhydrated_file.path)),
    ]
    if ctx.attr.images:
        yaml.append('images:')
        yaml.append('$(cat {})'.format(' '.join([shell.quote(image[ImageInfo].partial.path) for image in ctx.attr.images])))
    formatted_yaml = '\n'.join(yaml)
    ctx.actions.run_shell(
        inputs = [image[ImageInfo].partial for image in ctx.attr.images],
        outputs = [kustomization_file],
        arguments = [],
        command = 'printf "{}\n" > "{}"'.format(formatted_yaml, kustomization_file.path),
    )

    # Create hydrated yaml
    hydrated_args = ctx.actions.args()
    hydrated_args.add('build', paths.dirname(kustomization_file.path))
    hydrated_args.add('--load-restrictor', 'LoadRestrictionsNone')
    hydrated_args.add('--output', ctx.outputs.hydrated.path)
    ctx.actions.run(
        inputs = [unhydrated_file, kustomization_file],
        outputs = [ctx.outputs.hydrated],
        arguments = [hydrated_args],
        executable = ctx.executable._kustomize,
    )

kustomization_ = rule(
    attrs = dicts.add({
        'kustomization_yaml': attr.label(
            doc = 'Kustomization yaml file to build',
            allow_single_file = True,
            mandatory = True,
        ),
        'srcs': attr.label_list(
            doc = 'Source inputs to run `kustomize build` against. Note that the Bazel glob() function can be used to specify which source files to include and which to exclude, e.g. `glob(["*.yaml"], exclude=["golden.yaml"])`.',
            cfg = 'host',
            mandatory = True,
            allow_files = True,
        ),
        'images': attr.label_list(
            doc = 'A list of kustomize_image labels.',
            cfg = 'host',
            mandatory = False,
            allow_files = True,
            providers = [ImageInfo]
        ),
        '_kustomize': attr.label(
            default = '@kustomize//:file',
            cfg = 'host',
            executable = True,
        )
        # "tags": attr.list(
        #     default = ["block-network"],
        # )
    }),
    implementation = _impl,
    outputs = {
        'hydrated': '%{name}.yaml',
    },
)

def kustomization(**kwargs):
    kustomization_(**kwargs)
