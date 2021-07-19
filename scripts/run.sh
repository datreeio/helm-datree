#! /bin/bash

helm_options=()
datree_options=()
helm_chart_location=""
datree_command=""
eoo=0

while [[ $1 ]]; do
    if ! ((eoo)); then
        if [[ $1 == "--" ]]; then
            eoo=1
        elif [[ $helm_chart_location == "" && $(helm show chart $1 2> /dev/null) != "" ]]; then
            helm_chart_location=$1
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
    helm template "$helm_chart_location" "${helm_options[@]}" | $HELM_PLUGIN_DIR/bin/datree "${datree_options[@]}" -
else
    $HELM_PLUGIN_DIR/bin/datree "${datree_options[@]}"
fi
