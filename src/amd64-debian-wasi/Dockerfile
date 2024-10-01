FROM debian:slim AS juce_dev_machine

# Install essential tools for adding repositories
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    wget \
    gnupg \
    software-properties-common && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add necessary repositories
RUN echo "deb http://deb.debian.org/debian/ bullseye main contrib non-free" > /etc/apt/sources.list && \
    echo "deb http://deb.debian.org/debian/ bullseye-updates main contrib non-free" >> /etc/apt/sources.list && \
    echo "deb http://security.debian.org/debian-security bullseye-security main contrib non-free" >> /etc/apt/sources.list

# Update package index
RUN apt-get update && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install development tools and libraries
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    cmake \
    ninja-build \
    pkg-config \
    openssh-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install audio dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libjack-jackd2-dev \
    ladspa-sdk && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install graphics and font dependencies without specific version pinning
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libfreetype-dev \
    libfreetype6 \
    libglu1-mesa-dev \
    mesa-common-dev \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install network and UI dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libcurl4-openssl-dev \
    libx11-dev \
    libxcomposite-dev \
    libxcursor-dev \
    libxext-dev \
    libxinerama-dev \
    libxrandr-dev \
    libxrender-dev \
    libwebkit2gtk-4.0-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install additional dependencies for webkit
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libxml2 \
    libxslt1.1 \
    libsqlite3-0 \
    libwoff1 \
    libwebp6 \
    libwebsockets15 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add LLVM repo for clang-11 and clean up
RUN wget https://apt.llvm.org/llvm.sh && \
    chmod +x llvm.sh && \
    ./llvm.sh 11 && \
    rm llvm.sh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install clang-11 and set as default compiler
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    clang-11 && \
    update-alternatives --install /usr/bin/cc cc /usr/bin/clang-11 100 && \
    update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++-11 100 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Final cleanup
RUN apt-get autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Entry point or default command
CMD ["bash"]
