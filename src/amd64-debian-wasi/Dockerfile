FROM debian:slim AS base

# Update and install necessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gnupg \
    software-properties-common && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add the necessary repositories
RUN echo "deb http://deb.debian.org/debian/ bullseye main contrib non-free" > /etc/apt/sources.list && \
    echo "deb http://deb.debian.org/debian/ bullseye-updates main contrib non-free" >> /etc/apt/sources.list && \
    echo "deb http://security.debian.org/debian-security bullseye-security main contrib non-free" >> /etc/apt/sources.list

# Update and install necessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    cmake \
    ninja-build \
    pkg-config \
    openssh-client \
    libjack-jackd2-dev \
    ladspa-sdk \
    libcurl4-openssl-dev  \
    libfreetype6-dev \
    libx11-dev  \
    libxcomposite-dev  \
    libxcursor-dev  \
    libxext-dev  \
    libxinerama-dev  \
    libxrandr-dev \
    libxrender-dev \
    libglu1-mesa-dev  \
    mesa-common-dev

# Add LLVM repo for clang-11
RUN wget https://apt.llvm.org/llvm.sh && \
    chmod +x llvm.sh && \
    ./llvm.sh 11

# Install clang-11
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y clang-11

# Install libwebkit2gtk-4.0-dev
RUN apt-get install -y libxml2 libxslt1.1 libsqlite3-0 libwoff1 libwebp6 libwebsockets15 && \
    apt-get install -y libwebkit2gtk-4.0-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Make sure clang is the default compiler
RUN update-alternatives --install /usr/bin/cc cc /usr/bin/clang-11 100 && \
    update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++-11 100
