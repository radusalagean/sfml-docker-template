# Base image
FROM ubuntu:jammy AS base

ENV OSX_CROSS_PATH=/osxcross
ENV SFML_PATH=/SFML
ENV DEPENDENCIES_PATH=/dependencies
ENV WORKSPACE_PATH=/workspace

ARG OSX_VERSION_MIN=11.0
ARG OSX_SDK=MacOSX13.1.sdk

FROM base AS base-latest
RUN apt-get update -qq && apt-get install -y -q --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    git \
    clang \
    make \
    cmake \
    patch \
    libxml2-dev \
    libssl-dev \
    lzma-dev \
    python3.10 \
    bzip2 \
    cpio \
    libbz2-dev \
    xz-utils


FROM base-latest AS macos-sdk
WORKDIR "${OSX_CROSS_PATH}"
# # TODO Replace this with the original repo when pull request is merged https://github.com/tpoechtrager/osxcross/pull/382
RUN git clone https://github.com/joseluisq/osxcross . \
    && git checkout 7740274 \
    && rm -rf ./.git
# This is generated from: https://github.com/tpoechtrager/osxcross#packaging-the-sdk
ADD https://github.com/joseluisq/macosx-sdks/releases/download/13.1/MacOSX13.1.sdk.tar.xz "${OSX_CROSS_PATH}/tarballs/${OSX_SDK}.tar.xz"
RUN UNATTENDED=yes OSX_VERSION_MIN=${OSX_VERSION_MIN} ./build.sh
ENV PATH ${OSX_CROSS_PATH}/target/bin:$PATH

FROM macos-sdk AS sfml-macos
WORKDIR "${SFML_PATH}"
RUN git clone --depth=1 --branch 2.6.x https://github.com/SFML/SFML.git . && rm -rf ./.git
COPY cmake/toolchain-macos.cmake cmake/toolchain-macos.cmake
RUN cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug -DCMAKE_OSX_ARCHITECTURES="arm64" -DCMAKE_TOOLCHAIN_FILE=cmake/toolchain-macos.cmake
RUN cmake --build build
RUN mkdir -p ${DEPENDENCIES_PATH}/lib/macos/Frameworks \
    && mkdir -p ${DEPENDENCIES_PATH}/lib/macos/macos-arm64-debug \
    && cp -r ${SFML_PATH}/build/lib/* ${DEPENDENCIES_PATH}/lib/macos/macos-arm64-debug \
    && cp -r ${SFML_PATH}/extlibs/libs-osx/Frameworks/* ${DEPENDENCIES_PATH}/lib/macos/Frameworks
WORKDIR ${WORKSPACE_PATH}