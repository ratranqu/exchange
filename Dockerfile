FROM  mcr.microsoft.com/dotnet/nightly/sdk:8.0-jammy

RUN apt-get -y update && apt-get install -y \
    make \
    libboost-all-dev \
    golang \
    g++ \
    libicu-dev \
    wget \
    libtinfo5 \
    libncurses5 \
    ant \
    openjdk-11-jdk \
    vim \
    python3-pip \
    nodejs \
    npm \
              binutils \
          git \
          gnupg2 \
          libc6-dev \
          libcurl4-openssl-dev \
          libedit2 \
          libgcc-9-dev \
          libpython3.8 \
          libsqlite3-0 \
          libstdc++-9-dev \
          libxml2-dev \
          libz3-dev \
          pkg-config \
          tzdata \
          unzip \
          zlib1g-dev
    
#
# These are for the Cython builds
#
RUN pip3 install cython setuptools

#
# Clang
#
RUN curl -SL https://github.com/llvm/llvm-project/releases/download/llvmorg-17.0.1/clang+llvm-17.0.1-aarch64-linux-gnu.tar.xz | tar --strip-components 1 -xJC /usr/local
   
#
# Swift
#
RUN wget -q https://download.swift.org/development/ubuntu2204/swift-DEVELOPMENT-SNAPSHOT-2024-02-05-a/swift-DEVELOPMENT-SNAPSHOT-2024-02-05-a-ubuntu22.04.tar.gz \
    && tar zxf swift-DEVELOPMENT-SNAPSHOT-2024-02-05-a-ubuntu22.04.tar.g --strip-components=1 -C /

