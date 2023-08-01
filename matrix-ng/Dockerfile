# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
ARG MAU_GO_BRIDGES="discord gmessages slack whatsapp"
ARG MAU_PY_BRIDGES="facebook telegram"

# ------ Matrix Homeservers ------ #
FROM matrixdotorg/dendrite-monolith:latest as dendrite
# FROM matrixdotorg/synapse:latest as synapse
# FROM matrixconduit/matrix-conduit:latest as conduit

# ------ Matrix Clients ------ #
# FROM ghcr.io/msrd0/element:multiarch as element
FROM rust:alpine AS element
SHELL ["/bin/ash", "-uo", "pipefail", "-c"]
RUN apk add --update --no-cache gpg gpg-agent wget build-base python3 python3-dev py3-pip
RUN cargo install oxipng --locked
RUN pip3 install --upgrade pip \
    && pip3 install setuptools setuptools-rust wheel \
    && pip3 wheel --wheel-dir=/opt/wheels cryptg==0.4.0
ARG BUILD_ARCH
ENV TARGET "${BUILD_ARCH}-unknown-linux-musl"
ENV ELEMENT_VERSION 1.11.37
RUN mkdir /src
WORKDIR /src
COPY ./web .
RUN if [ "$BUILD_ARCH" = "amd64" ]; then \
    export TARGET="x86_64-unknown-linux-musl"; \
    fi \
    && rustup target add "$TARGET" \
    && cargo build --release --target "$TARGET" \
    && mv "target/$TARGET/release/element" . \
    && strip element
WORKDIR /
COPY ./web/E95B7699E80B68A9EAD9A19A2BAA9B8552BD9047.key .
RUN wget -qO element.tar.gz "https://github.com/vector-im/element-web/releases/download/v$ELEMENT_VERSION/element-v$ELEMENT_VERSION.tar.gz" \
    && wget -qO element.tar.gz.asc "https://github.com/vector-im/element-web/releases/download/v$ELEMENT_VERSION/element-v$ELEMENT_VERSION.tar.gz.asc" \
    && gpg --batch --import E95B7699E80B68A9EAD9A19A2BAA9B8552BD9047.key \
    && gpg --batch --verify element.tar.gz.asc element.tar.gz \
    && mkdir -p /opt/element \
    && tar xfz element.tar.gz --strip-components=1 -C /opt/element \
    && rm /opt/element/config.sample.json; \
    find /opt/element -name '*.png' | while read file; do oxipng -o6 "$file"; done; \
    find /opt/element -name '*.html' -or -name '*.js' -or -name '*.css' -or -name '*.html' -or -name '*.svg' -or -name '*.json' | while read file; do gzip -k9 "$file"; done

# ------ Matrix Bridges ------ #

# Olm Dependency (C)
FROM alpine:3.18 as olm
RUN apk add --no-cache olm
# Lottie Dependency (Golang)
FROM dock.mau.dev/tulir/lottieconverter:alpine-3.18 AS lottie
# Golang bridges
FROM dock.mau.dev/mautrix/discord:latest as discord
FROM dock.mau.dev/mautrix/gmessages:latest as gmessages
FROM dock.mau.dev/mautrix/slack:latest as slack
FROM dock.mau.dev/mautrix/whatsapp:latest as whatsapp

# ------ Fetch all Binaries ------ #

# FROM scratch as addon
FROM $BUILD_FROM

RUN apk add --no-cache -u \
    su-exec ca-certificates yq jq curl bash netcat-openbsd llvm14-libs \
    postgresql15-jit postgresql15 postgresql15-dev postgresql15-contrib-jit postgresql15-contrib \
    python3 py3-pip py3-setuptools py3-wheel \
    py3-aiohttp py3-cffi py3-commonmark py3-future py3-magic py3-olm \
    py3-pillow py3-pycryptodome py3-ruamel.yaml py3-unpaddedbase64 \
    py3-aiohttp-socks py3-paho-mqtt py3-pysocks \
    py3-brotli py3-idna py3-mako py3-phonenumbers py3-pyaes py3-qrcode py3-rsa
RUN rm /usr/libexec/postgresql \
    && ln -s /usr/libexec/postgresql15 /usr/libexec/postgresql \
    && rm /usr/share/postgresql \
    && ln -s /usr/share/postgresql15 /usr/share/postgresql
RUN mkdir -p /run/postgresql \
    && chown -R postgres:postgres /run/postgresql \
    && mkdir -p /run/postgresql/extensions \
    && chown -R postgres:postgres /run/postgresql/extensions
ENV S6_SERVICES_GRACETIME=50000 \
    S6_CMD_WAIT_FOR_SERVICES_MAXTIME=0

ARG MAU_PY_BRIDGES
COPY --from=element /opt/wheels /opt/wheels
RUN apk add --virtual .build-deps python3-dev libffi-dev build-base \
    && pip3 install /opt/wheels/cryptg-*.whl \
    && pip3 install aiodns brotli \
    && pip3 install heisenbridge \
    && for bridge in $MAU_PY_BRIDGES; do pip3 install --no-cache-dir --upgrade mautrix-$bridge[all]; done \
    && apk del .build-deps

# TODO: these names are a bit generic (e.g. generate-config) and may conflict with other images
COPY --from=dendrite /usr/bin/create-account /usr/local/bin/create-account
COPY --from=dendrite /usr/bin/generate-config /usr/local/bin/generate-config
COPY --from=dendrite /usr/bin/generate-keys /usr/local/bin/generate-keys
COPY --from=dendrite /usr/bin/dendrite /usr/local/bin/dendrite

COPY --from=element /src/element /bin/element
COPY --from=element /opt/element /opt/element

# --- More Mau Bridge Stuff --- #

# Olm Dependency
COPY --from=olm /usr/lib/libolm.so* /usr/lib/
# FFMPEG Dependency
COPY --from=mwader/static-ffmpeg:6.0 /ffmpeg /usr/local/bin/
COPY --from=mwader/static-ffmpeg:6.0 /ffprobe /usr/local/bin/
# Discord
COPY --from=lottie /usr/lib/librlottie.so* /usr/lib/
COPY --from=lottie /usr/local/bin/lottieconverter /usr/local/bin/lottieconverter
COPY --from=discord /usr/bin/mautrix-discord /usr/bin/mautrix-discord
COPY --from=discord /opt/mautrix-discord/example-config.yaml /opt/mautrix-discord/example-config.yaml
# Gmessages
COPY --from=gmessages /usr/bin/mautrix-gmessages /usr/bin/mautrix-gmessages
COPY --from=gmessages /opt/mautrix-gmessages/example-config.yaml /opt/mautrix-gmessages/example-config.yaml
# Slack
COPY --from=slack /usr/bin/mautrix-slack /usr/bin/mautrix-slack
COPY --from=slack /opt/mautrix-slack/example-config.yaml /opt/mautrix-slack/example-config.yaml
# Whatsapp
COPY --from=whatsapp /usr/bin/mautrix-whatsapp /usr/bin/mautrix-whatsapp
COPY --from=whatsapp /opt/mautrix-whatsapp/example-config.yaml /opt/mautrix-whatsapp/example-config.yaml

# -- Manhole Stuff --- #
ARG BUILD_ARCH
RUN case "$BUILD_ARCH" in \
    "amd64") PLATFORM="x86_64-unknown-linux-musl" ;; \
    "aarch64") PLATFORM="aarch64-unknown-linux-musl" ;; \
    *) echo "Unsupported platform: $BUILD_ARCH"; exit 1 ;; \
    esac \
    && curl -L -o /usr/bin/miniserve "https://github.com/svenstaro/miniserve/releases/download/v0.24.0/miniserve-0.24.0-${PLATFORM}" \
    && chmod +x /usr/bin/miniserve

# -- Remaining Stuff --- #
COPY rootfs /
WORKDIR /usr/app
RUN for bridge in $MAU_PY_BRIDGES; do \
    curl -o /usr/app/bridge-$bridge-default-config.yaml https://raw.githubusercontent.com/mautrix/$bridge/master/mautrix_$bridge/example-config.yaml; \
    done
RUN /usr/local/bin/generate-keys --private-key /usr/app/matrix_key.pem && /usr/local/bin/generate-keys --tls-cert /usr/app/server.crt --tls-key /usr/app/server.key
# TODO: Add volumes for dendrite (e.g. media etc)
EXPOSE 8099 8008 8448 8080
