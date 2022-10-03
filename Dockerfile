FROM zuul/nodepool-builder

RUN apt update && apt install -y \
	patch \
	git \
	cpio \
	procps \
	sudo \
	dnf \
	binfmt-support \
	qemu-user \
	qemu-user-static

COPY dib.patch .
RUN patch /usr/local/lib/python3.10/site-packages/diskimage_builder/elements/sysprep/bin/extract-image dib.patch

COPY requirements.txt .
RUN pip install  -r requirements.txt

ENV ELEMENTS_PATH=/usr/local/share/ironic-python-agent-builder/dib
