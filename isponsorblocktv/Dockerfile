# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM as compiler

# Execute during the build of the image
ARG TEMPIO_VERSION BUILD_ARCH
RUN \
    curl -sSLf -o /usr/bin/tempio \
    "https://github.com/home-assistant/tempio/releases/download/${TEMPIO_VERSION}/tempio_${BUILD_ARCH}"

RUN apk add --no-cache git

WORKDIR /app

RUN git clone https://github.com/dmunozv04/iSponsorBlockTV /repo
RUN cp -r /repo/src/* .

RUN python3 -m compileall -b -f . && \
    find . -name "*.py" -type f -delete

FROM $BUILD_FROM

ENV PIP_NO_CACHE_DIR=off iSPBTV_docker=True iSPBTV_data_dir=data TERM=xterm-256color COLORTERM=truecolor
WORKDIR /app

COPY --from=compiler /repo/requirements.txt .
COPY --from=compiler /usr/bin/tempio /usr/bin/tempio

RUN pip install --upgrade pip wheel && \
    pip install -r requirements.txt && \
    pip uninstall -y pip wheel && \
    python3 -m compileall -b -f /usr/local/lib/python3.*/site-packages && \
    find /usr/local/lib/python3.*/site-packages -name "*.py" -type f -delete && \
    find /usr/local/lib/python3.*/ -name "__pycache__" -type d -exec rm -rf {} +

COPY --from=compiler /app .
COPY rootfs/ /
