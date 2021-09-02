# Datree Helm Plugin

A Helm plugin to validate charts against the Datree policy  
Docs: https://hub.datree.io/helm-plugin

## Installation
```
helm plugin install https://github.com/datreeio/helm-datree
```

## Usage

### Test against the default policy
```
helm datree test CHART_DIRECTORY
```

### Check plugin version
```
helm datree version
```

### See help text
```
helm datree help
```

## Disclaimer

Datree's Helm plugin is at an early stage of development. We do our best to maintain backwards compatibility but there may be breaking changes in
the future to the command usage, flags, and configuration file formats. The CLI will output a warning message when a new version with breaking changes is detected.
We encourage you to use Datree to test your Kubernetes manifests files and Helm charts, see what
breaks, and [contribute](./CONTRIBUTING.md).
