#! /bin/bash -e

cd $HELM_PLUGIN_DIR
echo "Installing helm-datree..."

osName=$(uname -s)
DOWNLOAD_URL=$(curl --silent "https://api.github.com/repos/datreeio/datree/releases/latest" | grep -o "browser_download_url.*\_${osName}_x86_64.zip")

DOWNLOAD_URL=${DOWNLOAD_URL//\"}
DOWNLOAD_URL=${DOWNLOAD_URL/browser_download_url: /}

echo $DOWNLOAD_URL
OUTPUT_BASENAME=datree-latest
OUTPUT_BASENAME_WITH_POSTFIX=$OUTPUT_BASENAME.zip

if [ "$DOWNLOAD_URL" = "" ]
then
    echo "Unsupported OS / architecture: ${osName}"
    exit 1
fi

if [ -n $(command -v curl) ]
then
    curl -L $DOWNLOAD_URL -o $OUTPUT_BASENAME_WITH_POSTFIX
else
    echo "Need curl"
    exit -1
fi

rm -rf bin && mkdir bin && unzip $OUTPUT_BASENAME_WITH_POSTFIX -d bin > /dev/null && rm -f $OUTPUT_BASENAME_WITH_POSTFIX

echo "helm-datree is installed."
echo
echo "See https://hub.datree.io for help getting started."
