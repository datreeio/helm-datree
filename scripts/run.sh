#! /bin/bash -e

temp_manifest_name=/tmp/manifest.yaml
helm_options=()
datree_options=()
helm_chart_location=""
datree_command=""
eoo=0

while [[ $1 ]]; do
    if ! ((eoo)); then
        case "$1" in
        version | help | --help | config)
            $HELM_PLUGIN_DIR/bin/datree $@
            exit
            ;;
        test)
            datree_command="$1"
            helm_chart_location="$2"
            shift 2
            ;;
        --)
            eoo=1
            shift
            ;;
        *)
            datree_options+=("$1")
            shift
            ;;
        esac
    else
        helm_options+=("$1")
        shift
    fi
done

helm template "$helm_chart_location" "${helm_options[@]}" > ${temp_manifest_name}

$HELM_PLUGIN_DIR/bin/datree $datree_command "$temp_manifest_name" "${datree_options[@]}"
