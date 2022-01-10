load("@io_bazel_stardoc//stardoc:stardoc.bzl", "stardoc")

stardoc(
    name = "kustomization",
    out = "kustomization.md",
    deps = [
        "@bazel_skylib//lib:dicts",
        "@bazel_skylib//lib:paths",
        "@bazel_skylib//lib:shell",
        "//:kustomize_image",
        "@io_bazel_rules_docker//container:providers"
    ],
    input = "//:kustomization.bzl",
    visibility = ["//visibility:public"],
)

stardoc(
    name = "kustomize_image",
    out = "kustomize_image.md",
    deps = [
        "@bazel_skylib//lib:dicts",
        "@io_bazel_rules_docker//container:providers",
    ],
    input = "//:kustomize_image.bzl",
    visibility = ["//visibility:public"],
)