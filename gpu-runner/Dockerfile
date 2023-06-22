# Use pre-configured GitHub runner action
FROM myoung34/github-runner:ubuntu-jammy

# Install CUDA and OpenCL
RUN apt-get update && \
    apt-get install -y \
    nvidia-cuda-toolkit \
    clinfo \
    ocl-icd-dev \
    ocl-icd-opencl-dev \
    gcc-10 g++-10 \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

RUN nvcc --version

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

ENV PATH="${PATH}:~/.cargo/bin"

RUN rustc --version
