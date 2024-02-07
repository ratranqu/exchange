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
    npm
    
#
# These are for the Cython builds
#
RUN pip3 install cython setuptools

#
# Clang
#
RUN curl -SL https://github.com/llvm/llvm-project/releases/download/llvmorg-17.0.1/clang+llvm-17.0.1-aarch64-linux-gnu.tar.xz | tar --strip-components 1 -xJC /usr/local
