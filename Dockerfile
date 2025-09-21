# Buildozer/Kivy Android build (Ubuntu 20.04, Python 3.8)
# This Dockerfile creates a fully compatible environment for building APKs with Buildozer and Kivy.

FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3.8 python3.8-venv python3.8-dev python3-pip \
    openjdk-8-jdk unzip git wget zip \
    build-essential autoconf automake libtool pkg-config \
    libffi-dev libssl-dev libsqlite3-dev zlib1g-dev \
    libncurses5-dev libncursesw5-dev libreadline-dev \
    libgdbm-dev libbz2-dev liblzma-dev libxml2-dev libxslt1-dev \
    libjpeg-dev libfreetype6-dev libpng-dev \
    libavcodec-dev libavformat-dev libswscale-dev \
    libtiff5-dev libblas-dev liblapack-dev gfortran \
    ccache \
    && rm -rf /var/lib/apt/lists/*

# Set Python 3.8 as default
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1

# Install pip and Python packages
RUN python3 -m pip install --upgrade pip setuptools wheel
RUN python3 -m pip install cython==0.29.36 kivy==2.1.0 buildozer==1.3.0

# Install Android SDK/NDK via Buildozer on first build

# Set up workspace
WORKDIR /app
COPY . /app

# Entrypoint for build
CMD ["buildozer", "-v", "android", "debug"]
