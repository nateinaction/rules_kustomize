load("@com_nateinaction_rules_kustomize//:defs.bzl", "kustomization")
load("@bazel_tools//tools/build_rules:test_rules.bzl", "file_test")

kustomization(
    name = "prod",
    kustomization_yaml = "kustomization.yaml",
    srcs = [
        "kustomization.yaml",
        "//base/echoapp",
    ],
    images = [
        "//kustomize_image:default", "//kustomize_image:with_replacement_name",
    ],
)

golden = """apiVersion: v1
kind: Pod
metadata:
  labels:
    cluster: c
  name: echo
  namespace: prod
spec:
  containers:
  - image: localhost:5000/rules_kustomize/test-image@sha256:b5160586d347d93fc5c1a6fed1f43fc307b6f10a9bc49627ac093c76a9f2f04b
    name: echo
  - image: localhost:5000/rules_kustomize/test-image@sha256:b5160586d347d93fc5c1a6fed1f43fc307b6f10a9bc49627ac093c76a9f2f04b
    name: test
"""

file_test(
    name = "golden",
    content = golden,
    file = ":prod",
)
