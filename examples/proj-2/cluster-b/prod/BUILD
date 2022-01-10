load("@com_nateinaction_rules_kustomize//:defs.bzl", "kustomization")
load("@bazel_tools//tools/build_rules:test_rules.bzl", "file_test")

kustomization(
    name = "prod",
    kustomization_yaml = "kustomization.yaml",
    srcs = [
        "kustomization.yaml",
        "//base/echoapp",
    ],
)

golden = """apiVersion: v1
kind: Pod
metadata:
  labels:
    cluster: b
  name: echo
  namespace: prod
spec:
  containers:
  - image: k8s.gcr.io/echoserver:1.4
    name: echo
  - image: localhost:5000/rules_kustomize/test-image:testtag
    name: test
"""

file_test(
    name = "parallel_test",
    content = golden,
    file = ":prod",
)
