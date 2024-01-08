# CNI plugins installer

## Overview

The repository contains Dockerfile plus Github Actions to produce container
images for [CNI plugins](https://github.com/containernetworking/plugins) (up to
three most recent releases) and scripting machinery (from
https://github.com/rancher/image-build-cni-plugins) to install selected subset
of on target systems.

Primarily designed for K3S since it provides only limited number of CNI
plugins.

## Usage

Please see [image-build-cni-plugins repository](https://github.com/rancher/image-build-cni-plugins/blob/main/README.md) for usage notes.
