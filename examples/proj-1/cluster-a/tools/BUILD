load("@com_nateinaction_rules_kustomize//:defs.bzl", "kustomization")
load("@bazel_tools//tools/build_rules:test_rules.bzl", "file_test")

kustomization(
    name = "tools",
    kustomization_yaml = "kustomization.yaml",
    srcs = glob(["**/*.yaml"]),
)

golden = """apiVersion: v1
data:
  altGreeting: Good Morning!
  enableRisky: "false"
kind: ConfigMap
metadata:
  name: the-map
---
apiVersion: v1
data:
  password: YWRtaW4=
kind: Secret
metadata:
  name: password
type: Opaque
"""

file_test(
    name = "golden",
    content = golden,
    file = ":tools",
)
