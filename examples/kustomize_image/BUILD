load("@com_nateinaction_rules_kustomize//:defs.bzl", "kustomize_image")
load("@io_bazel_rules_docker//oci:oci.bzl", "oci_push")
load("@bazel_tools//tools/build_rules:test_rules.bzl", "file_test")

oci_push(
   name = "push",
   image = "@busybox//image",
   registry = "localhost:5000",
   repository = "rules_kustomize/test-image",
)

kustomize_image(
    name = "default",
    image_details = ":push",
    visibility = ["//visibility:public"],
)

default = """- name: localhost:5000/rules_kustomize/test-image
  newName: localhost:5000/rules_kustomize/test-image
  digest: sha256:b5160586d347d93fc5c1a6fed1f43fc307b6f10a9bc49627ac093c76a9f2f04b
"""

file_test(
    name = "test_default",
    content = default,
    file = ":default",
)

kustomize_image(
    name = "with_replacement_name",
    image_name = "k8s.gcr.io/echoserver",
    image_details = ":push",
    visibility = ["//visibility:public"],
)

with_replacement_name = """- name: k8s.gcr.io/echoserver
  newName: localhost:5000/rules_kustomize/test-image
  digest: sha256:b5160586d347d93fc5c1a6fed1f43fc307b6f10a9bc49627ac093c76a9f2f04b
"""

file_test(
    name = "test_with_replacement_name",
    content = with_replacement_name,
    file = ":with_replacement_name",
)
