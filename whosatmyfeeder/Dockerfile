# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

# Execute during the build of the image
ARG TEMPIO_VERSION BUILD_ARCH
RUN \
    curl -sSLf -o /usr/bin/tempio \
    "https://github.com/home-assistant/tempio/releases/download/${TEMPIO_VERSION}/tempio_${BUILD_ARCH}"

RUN apt-get update && apt-get -y install \
    git \
    python3-dev=3.9.2-3 \
    python3-distutils=3.9.2-1 \
    python3-minimal=3.9.2-3 \
    ffmpeg \
    libsm6 \
    libxext6 \
    && curl https://bootstrap.pypa.io/get-pip.py | python3 

# Copy root filesystem
COPY rootfs /

RUN mkdir /usr/app
WORKDIR /usr/app
RUN git clone https://github.com/mmcc-xx/WhosAtMyFeeder .

RUN pip3 install --no-cache-dir -r requirements.txt && \
    apt-get remove -y git && apt-get autoremove -y && \
    rm -rf /usr/app/.cache /usr/app/.cargo
