#! /bin/bash -e

cd $HELM_PLUGIN_DIR
version="$(cat plugin.yaml | grep "version" | cut -d '"' -f 2)"
echo "Installing helm-datree v${version} ..."

unameOut="$(uname -s)"

case "${unameOut}" in
    Linux*)     os=Linux;;
    Darwin*)    os=Darwin;;
    *)          os="UNKNOWN:${unameOut}"
esac

url="https://github.com/datreeio/datree/releases/download/${version}/datree-cli_${version}_${os}_x86_64.zip"

if [ "$url" = "" ]
then
    echo "Unsupported OS / architecture: ${os}_${arch}"
    exit 1
fi

filename=`echo ${url} | sed -e "s/^.*\///g"`

if [ -n $(command -v curl) ]
then
    curl -sSL -O $url
elif [ -n $(command -v wget) ]
then
    wget -q $url
else
    echo "Need curl or wget"
    exit -1
fi

rm -rf bin && mkdir bin && unzip $filename -d bin > /dev/null && rm -f $filename

echo "helm-datree ${version} is installed."
echo
echo "See https://hub.datree.io for help getting started."
