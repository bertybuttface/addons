# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM as compiler
ARG TEMPIO_VERSION BUILD_ARCH

# renovate: datasource=github-releases depName=dmunozv04/iSponsorBlockTV
ARG ISPONSORBLOCKTV_VERSION=v2.6.1

RUN curl -sSLf -o /usr/bin/tempio "https://github.com/home-assistant/tempio/releases/download/${TEMPIO_VERSION}/tempio_${BUILD_ARCH}"
RUN apk add --no-cache uv git
ENV UV_COMPILE_BYTECODE=1 UV_LINK_MODE=copy UV_PYTHON_DOWNLOADS=0
WORKDIR /app
RUN git clone --branch ${ISPONSORBLOCKTV_VERSION} --depth 1 https://github.com/dmunozv04/iSponsorBlockTV /repo
RUN cp -r /repo/src/* /app/ && cp /repo/requirements.txt /app/
RUN uv pip install --system --index-strategy unsafe-best-match -r requirements.txt
# TODO: we need the below as UV_COMPILE_BYTECODE=1 is not working as expected, remove once fixed
RUN python3 -m compileall -b -f . && \
    find . -name "*.py" -type f -delete

FROM $BUILD_FROM
ENV iSPBTV_docker=True iSPBTV_data_dir=data TERM=xterm-256color COLORTERM=truecolor
WORKDIR /app
COPY --from=compiler /usr/bin/tempio /usr/bin/tempio
COPY --from=compiler /app .
COPY --from=compiler /usr/local/lib/python*/site-packages /usr/local/lib/python3.13/site-packages/
COPY rootfs/ /
