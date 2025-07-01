# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and install required system libraries
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libboost-all-dev \
    libopencv-dev \
    libspdlog-dev \
    libfmt-dev \
    libgoogle-glog-dev \
    libopenblas-dev \
    libdlib-dev \
    libjsoncpp-dev \
    libfltk1.3-dev \
    libyaml-cpp-dev \
    python3-pip \
    python3-dev \
    cmake \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory, where subsequent commands will run
WORKDIR /app

# Copy all local source files needed for installation into the container
COPY gsl.tar.gz /tmp/gsl.tar.gz
COPY eigen-3.3.7.tar.gz /tmp/eigen-3.3.7.tar.gz

# --- Install gsl ---
# Create a dedicated directory, extract the source, build, and install.
# The --strip-components=1 flag removes the top-level folder from the tarball,
# giving us a clean and predictable directory structure.
RUN mkdir -p /tmp/gsl_src && \
    tar -xzf /tmp/gsl.tar.gz -C /tmp/gsl_src --strip-components=1 && \
    cd /tmp/gsl_src && \
    ./configure CFLAGS="-g -O0" && \
    make -j$(nproc) && \
    make install

# --- Install eigen ---
# Apply the same robust pattern for installing Eigen.
RUN mkdir -p /tmp/eigen_src && \
    tar -xzf /tmp/eigen-3.3.7.tar.gz -C /tmp/eigen_src --strip-components=1 && \
    cd /tmp/eigen_src && \
    mkdir -p build && \
    cd build && \
    cmake .. && \
    make install

# --- Clean up temporary source files ---
RUN rm -rf /tmp/*

# --- SDK Installation ---
# Copy the SDK files from the build context to the working directory
COPY DexHandSDK-1.1.0-Linux.deb .
COPY pxdex-1.1.0-cp310-cp310-linux_x86_64.whl .

# 1. Install the C++ core SDK (.deb package)
RUN apt-get update && apt-get install -y ./DexHandSDK-1.1.0-Linux.deb && \
    rm -rf /var/lib/apt/lists/*

# 2. Install the Python SDK wrapper (.whl file)
RUN python3 -m pip install --no-cache-dir ./pxdex-1.1.0-cp310-cp310-linux_x86_64.whl

# Command to keep the container running so you can connect to it
CMD ["/bin/bash"]