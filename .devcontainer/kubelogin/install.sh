#!/bin/bash

mkdir -p /tmp/z.$$ 
wget -O /tmp/z.$$/zip https://github.com/Azure/kubelogin/releases/download/v0.1.0/kubelogin.zip 
unzip -q -o /tmp/z.$$/zip -d /tmp/z.$$ 
cp /tmp/z.$$/bin/linux_amd64/kubelogin /usr/local/bin 
rm -rf /tmp.z$$ 
kubelogin --version
