# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM as compiler
ARG TEMPIO_VERSION BUILD_ARCH
RUN curl -sSLf -o /usr/bin/tempio "https://github.com/home-assistant/tempio/releases/download/${TEMPIO_VERSION}/tempio_${BUILD_ARCH}"
RUN apk add --no-cache uv git
ENV UV_COMPILE_BYTECODE=1 UV_LINK_MODE=copy UV_PYTHON_DOWNLOADS=0
WORKDIR /app
RUN git clone https://github.com/dmunozv04/iSponsorBlockTV /repo
# START PATCH (remove patch once isponsorblock is updated to aiohttp 3.11.12)
RUN sed -i 's/aiohttp==3.9.5/aiohttp==3.11.12/g' /repo/requirements.txt && \
    sed -i 's/pyytlounge==2.1.1/pyytlounge==2.1.2/g' /repo/requirements.txt
RUN cd /repo && git config user.email "none" && git config user.name "none" && \
    git revert ae6da834e492554d40c279fadff7cfa00b70ac0e && cd ..
# END PATCH
RUN cp -r /repo/src/* /app/ && cp /repo/requirements.txt /app/
RUN uv pip install --system -r requirements.txt
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
