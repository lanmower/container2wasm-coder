#!/bin/bash

set -euo pipefail
wget https://github.com/ktock/container2wasm/releases/download/v0.6.5/container2wasm-v0.6.5-linux-amd64.tar.gz
tar -xf container2wasm-v0.6.5-linux-amd64.tar.gz
SOURCE=./src/
DEST=./out/
WASI_MAX_CHUNK=50MB
C2W=./c2w
C2W_EXTRA_FLAGS_V=${C2W_EXTRA_FLAGS:-}
 
# /image : image name
# /Dockerfile : dockerfile to use
# /target : target compiler (wasi, emscripten, default: wasi)
# /arch : image architecture (default: amd64)

for I in $(ls -1 ${SOURCE}) ;
do
    OUTPUT_NAME="${I}-container"
    rm -r /tmp/*
    if [ $(cat "${SOURCE}/${I}/target" || true) == "emscripten" ] ; then
        TARGETARCH=$(cat "${SOURCE}/${I}/arch" || true)
        if [ "${TARGETARCH}" == "" ] ; then
            TARGETARCH="amd64"
        fi
        if [ -f "${SOURCE}/${I}/image" ]; then
            ${C2W} --to-js --target-arch="${TARGETARCH}" ${C2W_EXTRA_FLAGS_V} --build-arg JS_OUTPUT_NAME=${OUTPUT_NAME} "$(cat ${SOURCE}/${I}/image)" "${DEST}"
        elif [ -f "${SOURCE}/${I}/Dockerfile" ]; then
            cat ${SOURCE}/${I}/Dockerfile | docker buildx build --progress=plain -t ${I} --platform="linux/${TARGETARCH}" --load -
            ${C2W} --to-js --target-arch="${TARGETARCH}" ${C2W_EXTRA_FLAGS_V} --build-arg JS_OUTPUT_NAME=${OUTPUT_NAME} "${I}" "${DEST}"
        else
            echo "no image source found for ${I}"
            exit 1
        fi
    else
        TARGETARCH=$(cat "${SOURCE}/${I}/arch" || true)
        if [ "${TARGETARCH}" == "" ] ; then
            TARGETARCH="amd64"
        fi
        if [ -f "${SOURCE}/${I}/image" ]; then
            ${C2W} --target-arch="${TARGETARCH}" ${C2W_EXTRA_FLAGS_V} "$(cat ${SOURCE}/${I}/image)" "${DEST}/${OUTPUT_NAME}.wasm"
        elif [ -f "${SOURCE}/${I}/Dockerfile" ]; then
            cat ${SOURCE}/${I}/Dockerfile | docker buildx build --progress=plain -t ${I} --platform="linux/${TARGETARCH}" --load -
            ${C2W} --target-arch="${TARGETARCH}" ${C2W_EXTRA_FLAGS_V} "${I}" "${DEST}/${OUTPUT_NAME}.wasm"
        else
            echo "no image source found for ${I}"
            exit 1
        fi
        split -d -b "${WASI_MAX_CHUNK}" --additional-suffix=.wasm "${DEST}/${OUTPUT_NAME}.wasm" "${DEST}/${OUTPUT_NAME}"
        rm "${DEST}/${OUTPUT_NAME}.wasm"
        mv ./docs/* ${DEST}
    fi
done
