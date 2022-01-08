<!-- Generated with Stardoc: http://skydoc.bazel.build -->

<a name="#kustomize_image_"></a>

## kustomize_image_

<pre>
kustomize_image_(<a href="#kustomize_image_-name">name</a>, <a href="#kustomize_image_-image_details">image_details</a>, <a href="#kustomize_image_-image_name">image_name</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :-------------: | :-------------: | :-------------: | :-------------: | :-------------: |
| name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| image_details |  A label containing the container_push output for an image.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |  |
| image_name |  The name of the image to be replaced.   | String | required |  |


<a name="#kustomize_image"></a>

## kustomize_image

<pre>
kustomize_image(<a href="#kustomize_image-kwargs">kwargs</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :-------------: | :-------------: | :-------------: |
| kwargs |  <p align="center"> - </p>   |  none |


