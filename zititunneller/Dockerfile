# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

# renovate: datasource=github-releases depName=openziti/ziti-tunnel-sdk-c
ARG ZITI_VERSION=v1.9.7

# Copy root filesystem
COPY rootfs /

WORKDIR /opt

# Setup
RUN apt-get update && apt-get -y install unzip && mkdir /identities \
&& if [ -z "${BUILD_ARCH}" ]; then export BUILD_ARCH=$(uname -m); fi \
    && if [ "${BUILD_ARCH}" = "aarch64" ]; then ARCH="arm64"; fi \
    && if [ "${BUILD_ARCH}" = "amd64" ]; then ARCH="x86_64"; fi \
    && curl -sSL https://github.com/openziti/ziti-tunnel-sdk-c/releases/download/${ZITI_VERSION}/ziti-edge-tunnel-Linux_${ARCH}.zip -o /opt/ziti-edge-tunnel-Linux_${ARCH}.zip \
    && unzip /opt/ziti-edge-tunnel-Linux_${ARCH}.zip \
    && rm /opt/ziti-edge-tunnel-Linux_${ARCH}.zip \
    && chmod -c +x /opt/ziti-edge-tunnel

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="bertybuttface <none@example.com>" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="bertybuttface" \
    org.opencontainers.image.authors="bertybuttface <none@example.com>" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://addons.community" \
    org.opencontainers.image.source="https://github.com/bertybuttface/addons/zititunneller" \
    org.opencontainers.image.documentation="https://github.com/bertybuttface/addons/zititunneller/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}
