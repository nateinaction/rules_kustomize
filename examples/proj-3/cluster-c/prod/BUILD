# load("@com_benchsci_rules_kustomize//:defs.bzl", "kustomization", "kustomize_image")
# load("@bazel_tools//tools/build_rules:test_rules.bzl", "file_test")

# kustomize_image(
#     name = "echoserver",
#     image_name = "k8s.gcr.io/echoserver",
#     new_image_name = "docker.io/myimage",
#     image_digest = "sha256:1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef",
# )

# kustomization(
#     name = "prod",
#     srcs = [
#         "kustomization.yaml",
#         "//base/echoapp",
#     ],
#     images = [
#         ":echoserver",
#     ],
# )

# golden = """apiVersion: v1
# kind: Pod
# metadata:
#   labels:
#     cluster: c
#   name: echo
#   namespace: prod
# spec:
#   containers:
#   - image: k8s.gcr.io/echoserver:1.4
#     name: echo
# """

# file_test(
#     name = "golden",
#     content = golden,
#     file = ":prod",
# )
