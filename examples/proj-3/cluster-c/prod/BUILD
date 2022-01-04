load("@com_benchsci_rules_kustomize//:defs.bzl", "kustomization")
load("@bazel_tools//tools/build_rules:test_rules.bzl", "file_test")

kustomization(
    name = "prod",
    srcs = [
        "kustomization.yaml",
        "//base/echoapp",
    ],
    images = [
        "//image:echoserver",
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
  - image: ghcr.io/nateinaction/rules_kustomize-test-image@sha256:b5160586d347d93fc5c1a6fed1f43fc307b6f10a9bc49627ac093c76a9f2f04b
    name: echo
"""

file_test(
    name = "golden",
    content = golden,
    file = ":prod",
)
