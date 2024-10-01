FROM debian:sid-slim AS juce_dev_machine

# Install essential tools and dependencies in one step to minimize layers
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    wget \
    gnupg \
    software-properties-common && \
    echo "deb http://deb.debian.org/debian/ bullseye main contrib non-free" > /etc/apt/sources.list && \
    echo "deb http://deb.debian.org/debian/ bullseye-updates main contrib non-free" >> /etc/apt/sources.list && \
    echo "deb http://security.debian.org/debian-security bullseye-security main contrib non-free" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    cmake \
    ninja-build \
    pkg-config \
    openssh-client \
    libjack-jackd2-dev \
    ladspa-sdk \
    libcurl4-openssl-dev \
    libfreetype6 \
    libfreetype-dev \
    libx11-dev \
    libxcomposite-dev \
    libxcursor-dev \
    libxext-dev \
    libxinerama-dev \
    libxrandr-dev \
    libxrender-dev \
    libglu1-mesa-dev \
    mesa-common-dev \
    libxml2 \
    libxslt1.1 \
    libsqlite3-0 \
    libwoff1 \
    libwebp6 \
    libwebsockets-dev \ # Changed from libwebsockets15 to libwebsockets-dev
    libwebkit2gtk-4.0-dev \
    wget https://apt.llvm.org/llvm.sh && \
    chmod +x llvm.sh && \
    ./llvm.sh 11 && \
    rm llvm.sh && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    clang-11 && \
    update-alternatives --install /usr/bin/cc cc /usr/bin/clang-11 100 && \
    update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++-11 100 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Final cleanup
RUN apt-get autoclean && apt-get autoremove -y && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Entry point or default command
CMD ["bash"]
