#!/bin/bash

image_name="ipa-centos-8stream-aarch64-$(date -I)"

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
     --env DIB_REPOREF_ironic_python_agent=stable/xena \
     --env DIB_REPOREF_ironic_lib=stable/xena \
     --env DIB_REPOREF_requirements=stable/xena \
     --env ARCH=aarch64 \
     --env YUM=dnf \
     --env DISTRO_name=centos \
     --env DIB_RELEASE=8-stream \
     ipa_builder:latest \
     disk-image-create \
     -o /opt/dib/output/${image_name} \
     ironic-python-agent-ramdisk \
     burn-in \
     dynamic-login \
     centos
