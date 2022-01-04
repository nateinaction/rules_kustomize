load("@com_benchsci_rules_kustomize//:defs.bzl", "kustomize_image")
load("@io_bazel_rules_docker//oci:oci.bzl", "oci_push")

registry="ghcr.io"
owner="nateinaction"
image_name = "rules_kustomize-test-image"
repository = owner + "/" + image_name
oci_push(
   name = "push",
   image = "@busybox//image",
   registry = registry,
   repository = repository,
)

new_image_name = registry + "/" + repository
kustomize_image(
    name = "echoserver",
    image_name = "k8s.gcr.io/echoserver",
    new_image_name = new_image_name,
    image_digest = ":push.digest",
    visibility = ["//visibility:public"],
)
