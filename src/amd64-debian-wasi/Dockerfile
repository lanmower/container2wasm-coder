FROM debian:sid-slim AS juce_dev_machine

# Step 1: Update package list and install essential tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    wget 

RUN apt-get install -y --no-install-recommends \
    gnupg 

RUN apt-get install -y --no-install-recommends \
    software-properties-common 

# Step 2: Set up Debian Bullseye repositories
RUN echo "deb http://deb.debian.org/debian/ bullseye main contrib non-free" > /etc/apt/sources.list
RUN echo "deb http://deb.debian.org/debian/ bullseye-updates main contrib non-free" >> /etc/apt/sources.list
RUN echo "deb http://security.debian.org/debian-security bullseye-security main contrib non-free" >> /etc/apt/sources.list

# Step 3: Install build tools and libraries
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git 

RUN apt-get install -y --no-install-recommends \
    cmake 

RUN apt-get install -y --no-install-recommends \
    ninja-build 

RUN apt-get install -y --no-install-recommends \
    pkg-config 

RUN apt-get install -y --no-install-recommends \
    openssh-client 

RUN apt-get install -y --no-install-recommends \
    libjack-jackd2-dev 

RUN apt-get install -y --no-install-recommends \
    ladspa-sdk 

RUN apt-get install -y --no-install-recommends \
    libcurl4-openssl-dev 

RUN apt-get install -y --no-install-recommends \
    libfreetype6 

RUN apt-get install -y --no-install-recommends \
    libfreetype-dev 

RUN apt-get install -y --no-install-recommends \
    libx11-dev 

RUN apt-get install -y --no-install-recommends \
    libxcomposite-dev 

RUN apt-get install -y --no-install-recommends \
    libxcursor-dev 

RUN apt-get install -y --no-install-recommends \
    libxext-dev 

RUN apt-get install -y --no-install-recommends \
    libxinerama-dev 

RUN apt-get install -y --no-install-recommends \
    libxrandr-dev 

RUN apt-get install -y --no-install-recommends \
    libxrender-dev 

RUN apt-get install -y --no-install-recommends \
    libglu1-mesa-dev 

RUN apt-get install -y --no-install-recommends \
    mesa-common-dev 

RUN apt-get install -y --no-install-recommends \
    libxml2 

RUN apt-get install -y --no-install-recommends \
    libxslt1.1 

RUN apt-get install -y --no-install-recommends \
    libsqlite3-0 

RUN apt-get install -y --no-install-recommends \
    libwoff1 

RUN apt-get install -y --no-install-recommends \
    libwebp6 

RUN apt-get install -y --no-install-recommends \
    libwebsockets-dev 

RUN apt-get install -y --no-install-recommends \
    libwebkit2gtk-4.0-dev 

# Step 4: Download and install LLVM
RUN wget https://apt.llvm.org/llvm.sh && \
    chmod +x llvm.sh && \
    ./llvm.sh 11 && \
    rm llvm.sh

# Step 5: Install Clang and set alternatives
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    clang-11 

RUN update-alternatives --install /usr/bin/cc cc /usr/bin/clang-11 100 
RUN update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++-11 100 

# Step 6: Clean up
RUN apt-get clean && \
    apt-get autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Entry point or default command
CMD ["bash"]
