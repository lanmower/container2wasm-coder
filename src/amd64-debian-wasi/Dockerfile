# Stage 1: Build stage with full development environment
FROM debian:sid-slim AS build

# Install required packages and tools in one step to minimize layers
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    wget \
    gnupg \
    software-properties-common && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add necessary repositories in one step
RUN echo "deb http://deb.debian.org/debian/ bullseye main contrib non-free" > /etc/apt/sources.list && \
    echo "deb http://deb.debian.org/debian/ bullseye-updates main contrib non-free" >> /etc/apt/sources.list && \
    echo "deb http://security.debian.org/debian-security bullseye-security main contrib non-free" >> /etc/apt/sources.list

# Pin specific libraries to avoid conflicts and install build dependencies in one step
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libfreetype6=2.10.4+dfsg-1+deb11u1 \
    libfreetype6-dev=2.10.4+dfsg-1+deb11u1 && \
    apt-get install -y --no-install-recommends \
    git \
    cmake \
    ninja-build \
    pkg-config \
    openssh-client \
    libjack-jackd2-dev \
    ladspa-sdk \
    libcurl4-openssl-dev \
    libx11-dev \
    libxcomposite-dev \
    libxcursor-dev \
    libxext-dev \
    libxinerama-dev \
    libxrandr-dev \
    libxrender-dev \
    libglu1-mesa-dev \
    mesa-common-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add LLVM repo for clang-11, install clang and clean up
RUN wget https://apt.llvm.org/llvm.sh && \
    chmod +x llvm.sh && \
    ./llvm.sh 11 && \
    rm llvm.sh && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    clang-11 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install libwebkit2gtk-4.0-dev and its dependencies, then clean up
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libxml2 \
    libxslt1.1 \
    libsqlite3-0 \
    libwoff1 \
    libwebp6 \
    libwebsockets15 \
    libwebkit2gtk-4.0-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Make sure clang is the default compiler and clean up
RUN update-alternatives --install /usr/bin/cc cc /usr/bin/clang-11 100 && \
    update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++-11 100 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Stage 2: Runtime stage with only the necessary runtime dependencies
FROM debian:slim AS runtime

# Copy only the necessary runtime dependencies from the build stage
COPY --from=build /usr /usr
COPY --from=build /lib /lib

# Add remaining runtime dependencies and clean up
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libx11-6 \
    libxcomposite1 \
    libxcursor1 \
    libxext6 \
    libxinerama1 \
    libxrandr2 \
    libxrender1 \
    libwebkit2gtk-4.0-37 \
    libxml2 \
    libxslt1.1 \
    libsqlite3-0 \
    libwoff1 \
    libwebp6 \
    libwebsockets15 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
