filegroup(
    name = "exec",
    srcs = ["exec.sh"],
    visibility = ["//visibility:public"]
)

filegroup(
    name = "execpwd",
    srcs = ["execpwd.sh"],
    visibility = ["//visibility:public"]
)

filegroup(
    name = "create_image_yaml_partial",
    srcs = ["create_image_yaml_partial.sh"],
    visibility = ["//visibility:public"]
)

filegroup(
    name = "create_kustomization_yaml",
    srcs = ["create_kustomization_yaml.sh"],
    visibility = ["//visibility:public"]
)

sh_binary(
    name = "kustomize",
    srcs = [":execpwd"],
    args = ["$(location @kustomize//:file)"],
    data = ["@kustomize//:file"],
    visibility = ["//visibility:public"]
)

# Exported for documentation (see //tools:docs).
exports_files(["defs.bzl"])
