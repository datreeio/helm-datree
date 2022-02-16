# Datree Helm Plugin

A Helm plugin to validate charts against the Datree policy  

## Installation
```
helm plugin install https://github.com/datreeio/helm-datree
```

## Usage

### Trigger datree policy check via the helm CLI
```
helm datree test [CHART_DIRECTORY]
```

### Passing arguments
If you need to pass helm arguments to your template, you will need to add `--` before them:
```
helm datree test [CHART_DIRECTORY] -- --values values.yaml --set name=prod
```

### Check plugin version
```
helm datree version
```

### See help text
```
helm datree help
```

### Using other helm command
Helm might be installed through other tooling like microk8s. The `DATREE_HELM_COMMAND` allows specifying a command to run helm (default: `helm`):
```
DATREE_HELM_COMMAND="microk8s helm3" helm datree test [CHART_DIRECTORY]
```

## Example

```
helm plugin install https://github.com/datreeio/helm-datree
git clone git@github.com:datreeio/examples.git
helm datree test examples/helm-chart/nginx
```

![image](https://user-images.githubusercontent.com/19731161/131975552-b66a84f8-5aa9-4d70-a08e-aae97aa76116.png)


## Troubleshooting
### K8s schema validation error
This error occurs when trying to scan Chart.yaml or values.yaml files instead of the chart directory.  
**Solution:** Pass the helm chart directory path to Datree's CLI, instead of to the file itself:  
* Correct - `helm datree test examples/helm-chart/nginx`
* Wrong - `helm datree test examples/helm-chart/nginx/values.yaml`

### The policy check returns false-positive results
The best way to determine if a false-positive result is a bug or a true misconfiguration, is by rendering the Kubernetes manifest with helm and then checking it manually:
```
helm template [CHART_DIRECTORY]
```
If after eyeballing the rendered manifest you still suspect it's a bug, please open an issue [here](https://github.com/datreeio/datree/issues/new?assignees=&labels=bug&template=bug_report.md&title=). 

## Disclaimer

Datree's Helm plugin is at an early stage of development. We do our best to maintain backwards compatibility but there may be breaking changes in
the future to the command usage, flags, and configuration file formats. The CLI will output a warning message when a new version with breaking changes is detected.
We encourage you to use Datree to test your Kubernetes manifests files and Helm charts, see what
breaks, and [contribute](./CONTRIBUTING.md).
