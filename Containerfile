ARG SOURCE_IMAGE="silverblue"
ARG SOURCE_SUFFIX="-main"

ARG SOURCE_TAG="gts"
ARG FEDORA_RELEASE="gts"

FROM scratch AS ctx
COPY build_files /
COPY sys_files /sys_files

FROM ghcr.io/ublue-os/${SOURCE_IMAGE}${SOURCE_SUFFIX}:${SOURCE_TAG}

RUN --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/var/tmp \
    --mount=type=bind,from=ctx,src=/,dst=/ctx \
    /ctx/build.sh && \
    ostree container commit
