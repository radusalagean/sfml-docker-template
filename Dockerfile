# Base image
FROM ubuntu:jammy AS base

ENV SFML_PATH=/SFML
ENV WORKSPACE_PATH=/workspace
ENV SFML_VERSION=2.6.0

FROM base AS base-latest
RUN apt-get update -qq && apt-get install -y -q --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    git \
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

# Mac OS

FROM base-latest AS macos-sdk
RUN apt-get install -y -q --no-install-recommends \
    clang \
    icnsutils
ENV OSX_CROSS_PATH=/osxcross
ARG OSX_VERSION_MIN=11.0
ARG OSX_SDK=MacOSX13.1.sdk
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
RUN git clone --depth=1 --branch ${SFML_VERSION} https://github.com/SFML/SFML.git . && rm -rf ./.git
COPY cmake/toolchains/toolchain-macos.cmake cmake/toolchains/toolchain-macos.cmake
RUN cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug -DCMAKE_OSX_ARCHITECTURES="arm64" -DCMAKE_TOOLCHAIN_FILE=cmake/toolchains/toolchain-macos.cmake
RUN cmake --build build
WORKDIR ${WORKSPACE_PATH}

# Windows

FROM base-latest AS sfml-windows
RUN apt-get install -y -q \
    g++-mingw-w64-x86-64
WORKDIR "${SFML_PATH}"
RUN git clone --depth=1 --branch ${SFML_VERSION} https://github.com/SFML/SFML.git . && rm -rf ./.git
COPY cmake/toolchains/toolchain-x86_64-w64-mingw32.cmake cmake/toolchains/toolchain-x86_64-w64-mingw32.cmake
COPY cmake/Modules/FindVORBIS.cmake cmake/Modules/FindVORBIS.cmake
COPY cmake/Modules/FindFLAC.cmake cmake/Modules/FindFLAC.cmake
RUN rm extlibs/headers/FLAC/assert.h && \
    echo 'target_include_directories(sfml-audio SYSTEM PRIVATE "${PROJECT_SOURCE_DIR}/extlibs/headers")' >> src/SFML/Audio/CMakeLists.txt && \
    cd extlibs/libs-mingw/x64 && \
    mkdir libs && \
    mv libFLAC.a  libfreetype.a  libogg.a  libopenal32.a  libvorbis.a  libvorbisenc.a  libvorbisfile.a libs/ && \
    cd libs && \
    mv libopenal32.a openal.a && \
    mv libvorbis.a vorbis.a && \
    mv libogg.a ogg.a && \
    mv libvorbisenc.a vorbisenc.a && \
    mv libvorbisfile.a vorbisfile.a && \
    mv libFLAC.a FLAC.a
WORKDIR "${SFML_PATH}"
RUN cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug -DCMAKE_TOOLCHAIN_FILE=cmake/toolchains/toolchain-x86_64-w64-mingw32.cmake
RUN cmake --build build
WORKDIR ${WORKSPACE_PATH}

# Linux

FROM base-latest AS sfml-linux
WORKDIR "${SFML_PATH}"
RUN git clone --depth=1 --branch ${SFML_VERSION} https://github.com/SFML/SFML.git . && rm -rf ./.git
COPY cmake/toolchains/toolchain-linux.cmake cmake/toolchains/toolchain-linux.cmake
RUN apt-get install -y -q \
    gcc \
    g++ \
    xorg-dev \
    libudev-dev \
    libopenal-dev \
    libvorbis-dev \
    libflac-dev
RUN cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug -DCMAKE_TOOLCHAIN_FILE=cmake/toolchains/toolchain-linux.cmake
RUN cmake --build build
WORKDIR ${WORKSPACE_PATH}
