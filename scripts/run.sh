#! /bin/bash -e

temp_manifest_name=/tmp/manifest.yaml
helm_options=()
datree_options=()
helm_chart_dir=""

datree_first_command="$1"
shift

case $datree_first_command in
version | help)
    $HELM_PLUGIN_DIR/bin/datree $datree_first_command
    exit
    ;;
test)
    helm_chart_dir="$1"
    shift
    ;;
esac

while [[ $1 ]]; do
    case "$1" in
    --)
        datree_options+=("$2")
        shift 2
        ;;
    *)
        helm_options+=("$1")
        shift
        ;;
    esac
done

helm template $helm_chart_dir "${helm_options[@]}" >${temp_manifest_name}

$HELM_PLUGIN_DIR/bin/datree $datree_first_command ${temp_manifest_name} "${datree_options[@]}"
