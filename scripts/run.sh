#! /bin/bash

set -eo pipefail

helm_options=()
datree_options=()
helm_chart_location=""
helm_chart_name=""
datree_command=""
eoo=0

while [[ $1 ]]; do
    if ! ((eoo)); then
        if [[ $1 == "--" ]]; then
            eoo=1
        elif [[ $helm_chart_location == "" && $(helm show chart $1 2> /dev/null | grep apiVersion) == apiVersion* ]]; then
            helm_chart_location=$1
            helm_chart_name=$(helm show chart $1 | grep -o '^name: .*' | cut -c 7-)
        else
            datree_options+=("$1")
        fi

        shift
    else
        helm_options+=("$1")
        shift
    fi
done

if [[ ${helm_chart_location} != "" ]]; then
    currUinxTimestamp=$(date +%s)
    tempManifestPath="/tmp/${helm_chart_name}_$currUinxTimestamp.yaml"
    helm template "${helm_options[@]}" "$helm_chart_location" > "$tempManifestPath"
    $HELM_PLUGIN_DIR/bin/datree "${datree_options[@]}" "$tempManifestPath"
else
    $HELM_PLUGIN_DIR/bin/datree "${datree_options[@]}"
fi
