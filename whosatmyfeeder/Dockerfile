# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

# Execute during the build of the image
ARG TEMPIO_VERSION BUILD_ARCH
RUN \
    curl -sSLf -o /usr/bin/tempio \
    "https://github.com/home-assistant/tempio/releases/download/${TEMPIO_VERSION}/tempio_${BUILD_ARCH}"

RUN apk add gcc musl-dev build-base linux-headers git

# Copy root filesystem
COPY rootfs /

RUN mkdir /usr/app
WORKDIR /usr/app
RUN git clone https://github.com/mmcc-xx/WhosAtMyFeeder .

RUN pip3 install --upgrade pip setuptools-rust wheel && \
    pip3 install -r requirements.txt && \
    apk del gcc musl-dev build-base linux-headers git && \
    rm -rf /usr/app/.cache /usr/app/.cargo
