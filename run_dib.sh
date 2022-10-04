#!/bin/bash

image_name="ipa-centos-8stream-aarch64-$(date -I)"
echo "setting image name to ${image_name}"

IRONIC_BRANCH="stable/xena"
BUILD_ARCH="aarch64"
DISTRO_NAME="centos"
DIB_RELEASE="8-stream"

docker run \
     --rm \
     --privileged \
     --network=host \
     -v /opt/dib/output:/opt/dib/output \
     -v /opt/dib/tmp:/opt/dib/tmp \
     -v /opt/dib/image_cache:/opt/dib/image_cache \
     --env DIB_SHOW_IMAGE_USAGE=1 \
     --env DIB_DEBUG_TRACE=1 \
     --env TMPDIR=/opt/dib/tmp \
     --env DIB_IMAGE_CACHE=/opt/dib/image_cache \
     --env DIB_REPOREF_ironic_python_agent="${IRONIC_BRANCH}" \
     --env DIB_REPOREF_ironic_lib="${IRONIC_BRANCH}" \
     --env DIB_REPOREF_requirements="${IRONIC_BRANCH}" \
     --env ARCH=${BUILD_ARCH} \
     --env YUM=dnf \
     --env DISTRO_name="${DISTRO_NAME}" \
     --env DIB_RELEASE="${DIB_RELEASE}" \
     ipa_builder:latest \
     disk-image-create \
     -o /opt/dib/output/${image_name} \
     ironic-python-agent-ramdisk \
     burn-in \
     dynamic-login \
     centos
