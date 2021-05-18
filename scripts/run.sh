#! /bin/bash -e

temp_manifest_name=/tmp/manifest.yaml
helm_options=()
datree_options=()
eoo=0

while [[ $1 ]]
do
    if ! ((eoo)); then
        case "$1" in
            version|help)
                $HELM_PLUGIN_DIR/bin/datree $1
                exit
                ;;
            --output|-o)
                datree_options+=("$1")
                datree_options+=("$2")
                shift 2
                ;;
            *)
                helm_options+=("$1")
                shift
                ;;
        esac
    else
        helm_options+=("$1")
        shift
    fi
done

helm template "${helm_options[@]}" > ${temp_manifest_name}

$HELM_PLUGIN_DIR/bin/datree test ${temp_manifest_name} "${datree_options[@]}"
