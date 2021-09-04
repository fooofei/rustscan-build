#!/usr/bin/env bash
cur=$(dirname "$(readlink -f $0)")
set -x

ARCH=$(uname -m)
case $ARCH in
    x86_64)
        ARCH=amd64
        ;;
    aarch64)
        ARCH=arm64
        ;;
esac

build_from_source() {
  home=$cur/build_rustscan
  mkdir -p $home
  cd $home

  git clone https://github.com/RustScan/RustScan.git
  cd RustScan
  docker build . -t rustscan/rustscan:latest
}

if [ "$ARCH" == "amd64" ]; then
  # use the latest image, we not build from source
  docker pull rustscan/rustscan:latest
else
  build_from_source
fi



