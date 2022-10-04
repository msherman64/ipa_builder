# FROM python: 3.9.14-bullseye
FROM debian:bullseye

# Package Explanations:
# patch, git: use our forks, customizations to upstream
# cpio, procps; Needed for ironic-python-agent-ramdisk element
# sudo: needed for chroot
# dnf: centos-based builds
# binfmt-support, qemu-user, qemu-user-static: build arm64/aarch64

RUN apt update && apt install -y \
	python3 \
	python3-pip \
	patch \
	git \
	cpio \
	procps \
	sudo \
	dnf \
	binfmt-support \
	qemu-user \
	qemu-user-static

COPY requirements.txt .
RUN pip install -r requirements.txt

# Apply patch for issue https://bugs.launchpad.net/diskimage-builder/+bug/1974350
COPY dib.patch .
RUN patch /usr/local/lib/python3.9/dist-packages/diskimage_builder/elements/sysprep/bin/extract-image dib.patch

# set elements path to use ironic DIB with diskimage-builder
ENV ELEMENTS_PATH=/usr/local/share/ironic-python-agent-builder/dib
CMD diskimage-builder
