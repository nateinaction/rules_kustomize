<!-- Generated with Stardoc: http://skydoc.bazel.build -->

<a name="#kustomization"></a>

## kustomization

<pre>
kustomization(<a href="#kustomization-name">name</a>, <a href="#kustomization-srcs">srcs</a>, <a href="#kustomization-images">images</a>, <a href="#kustomization-visibility">visibility</a>, <a href="#kustomization-tags">tags</a>)
</pre>

Builds a kustomization defined by the input srcs.

The output is a YAML multi-doc comprised of all the resources defined by
the customization.

See:

* https://kubectl.docs.kubernetes.io/references/kustomize/glossary/#kustomization
* https://kubectl.docs.kubernetes.io/references/kustomize/glossary/#kustomization-root


**PARAMETERS**


| Name  | Description | Default Value |
| :-------------: | :-------------: | :-------------: |
| name |  A unique name for this rule.   |  none |
| srcs |  Source inputs to run <code>kustomize build</code> against.  These are any   valid Bazel labels representing.<br><br>  Note that the Bazel glob() function can be used to specify which source   files to include and which to exclude, e.g.   <code>glob(["*.yaml"], exclude=["golden.yaml"])</code>.   |  none |
| images |  A list of kustomize_image labels to include in the kustomization.   |  <code>[]</code> |
| visibility |  The visibility of this rule.   |  <code>None</code> |
| tags |  Sets tags on the rule.  The <code>block-network</code> tag is strongly   recommended (but not enforced) to ensure hermeticity and   reproducibility.   |  <code>["block-network"]</code> |


