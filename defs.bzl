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

def kustomization(
        name,
        srcs,
        images = [],
        visibility = None,
        tags = ["block-network"]):
    """Builds a kustomization defined by the input srcs.

    The output is a YAML multi-doc comprised of all the resources defined by
    the customization.

    See:

    * https://kubectl.docs.kubernetes.io/references/kustomize/glossary/#kustomization
    * https://kubectl.docs.kubernetes.io/references/kustomize/glossary/#kustomization-root

    Args:
      name: A unique name for this rule.
      srcs: Source inputs to run `kustomize build` against.  These are any
        valid Bazel labels representing.

        Note that the Bazel glob() function can be used to specify which source
        files to include and which to exclude, e.g.
        `glob(["*.yaml"], exclude=["golden.yaml"])`.
      images: A list of kustomize_image labels to include in the kustomization.
      visibility: The visibility of this rule.
      tags: Sets tags on the rule.  The `block-network` tag is strongly
        recommended (but not enforced) to ensure hermeticity and
        reproducibility.
    """
    kwargs = {}
    if visibility:
        kwargs["visibility"] = visibility

    native.filegroup(
        name = name + ".srcs",
        srcs = srcs,
        **kwargs
    )

    # Used only to be able to generate a path to the kustomization file.
    native.filegroup(
        name = name + ".kustomization",
        srcs = ["kustomization.yaml"],
        visibility = ["//visibility:private"],
    )

    # Create a kustomization file and include name.kustomization as a resource
    images_paths = ",".join(["$(location {})".format(label) for label in images])
    native.genrule(
        name = name + ".new_kustomization",
        srcs = [
            name + ".kustomization",
        ],
        outs = ["new/kustomization.yaml"],
        cmd = " ".join([
            "$(location @com_benchsci_rules_kustomize//:create_kustomization_yaml)",
            "$(OUTS)",
            "$(location :{}.kustomization)".format(name),
            "'{}'".format(images_paths),
            "> \"$@\"",
        ]),
        tools = ["@com_benchsci_rules_kustomize//:create_kustomization_yaml"] + images,
    )

    build_cmd = [
        "./$(location @kustomize//:file) ",
        "build",
        # This can be dangerous, but Bazel forces us to be explicit in
        # defining dependencies and we use the "block-network" tag below to
        # disallow fetches.
        "--load-restrictor=LoadRestrictionsNone",
    ]

    native.genrule(
        name = name,
        srcs = [
            ":" + name + ".srcs",
            ":" + name + ".kustomization",
            ":" + name + ".new_kustomization",
        ],
        outs = [name + ".yaml"],
        cmd = " ".join(build_cmd + [
            "$$( dirname '$(location :{}.new_kustomization)' )".format(name),
            "> \"$@\"",
        ]),
        # Ideally we'd use something like:
        #
        #   kbin = "{}//:kustomize".format(native.repository_name())
        #
        # See https://github.com/bazelbuild/bazel/issues/4092
        tools = ["@kustomize//:file"],
        tags = tags,
        **kwargs
    )

def kustomize_image(
        name,
        image_name,
        new_image_name,
        image_digest,
        visibility = None,
    ):
    """Templates a file that can be appended to a kustomization yaml to replace an image.

    Args:
      name: A unique name for this rule.
      image_name: The name of the image to be replaced.
      new_image_name: The name of the image to replace it with.
      image_digest: A label pointed to a file containing the digest of the new image.
      visibility: The visibility of this rule.
    """
    kwargs = {}
    if visibility:
        kwargs["visibility"] = visibility

    native.genrule(
        name = name,
        srcs = [],
        outs = [name + ".yaml.partial"],
        cmd = " ".join([
            "$(location @com_benchsci_rules_kustomize//:create_image_yaml_partial)",
            image_name,
            new_image_name,
            "$$(cat '$(location {})')".format(image_digest),
            "> $@"
        ]),
        tools = ["@com_benchsci_rules_kustomize//:create_image_yaml_partial", image_digest],
        **kwargs
    )
