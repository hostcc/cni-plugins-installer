ARG CNI_PLUGINS_VER=v1.3.0
ARG CNI_DIR=/opt/cni/bin
ARG ALPINE_VER=3.19.0

FROM alpine:${ALPINE_VER} as build

ARG CNI_PLUGINS_VER
ARG CNI_DIR
ARG TARGETARCH

RUN \
	echo "Packaging CNI plugins ${CNI_PLUGINS_VER} for ${TARGETARCH} architecture" \
	&& apk -U add wget tar gzip \
	&& mkdir -p ${CNI_DIR} \
	&& wget --no-verbose \
		https://github.com/containernetworking/plugins/releases/download/${CNI_PLUGINS_VER}/cni-plugins-linux-${TARGETARCH}-${CNI_PLUGINS_VER}.tgz -O cni-plugins.tar.gz \
	&& tar zxf cni-plugins.tar.gz -C ${CNI_DIR}
 
FROM alpine:${ALPINE_VER}

ARG CNI_PLUGINS_VER
ARG CNI_DIR
ENV CNI_PLUGINS_VER=${CNI_PLUGINS_VER}

ADD --chmod=0755 https://raw.githubusercontent.com/rancher/image-build-cni-plugins/main/install-cnis.sh /
COPY --from=build ${CNI_DIR} ${CNI_DIR}
ENTRYPOINT ["/install-cnis.sh"]
