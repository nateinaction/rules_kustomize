<!-- Generated with Stardoc: http://skydoc.bazel.build -->

<a name="#kustomization_"></a>

## kustomization_

<pre>
kustomization_(<a href="#kustomization_-name">name</a>, <a href="#kustomization_-images">images</a>, <a href="#kustomization_-kustomization_yaml">kustomization_yaml</a>, <a href="#kustomization_-srcs">srcs</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :-------------: | :-------------: | :-------------: | :-------------: | :-------------: |
| name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| images |  A list of kustomize_image labels.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| kustomization_yaml |  Kustomization yaml file to build   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |  |
| srcs |  Source inputs to run <code>kustomize build</code> against. Note that the Bazel glob() function can be used to specify which source files to include and which to exclude, e.g. <code>glob(["*.yaml"], exclude=["golden.yaml"])</code>.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | required |  |


<a name="#kustomization"></a>

## kustomization

<pre>
kustomization(<a href="#kustomization-kwargs">kwargs</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :-------------: | :-------------: | :-------------: |
| kwargs |  <p align="center"> - </p>   |  none |


