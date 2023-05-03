# Use pre-configured GitHub runner action
FROM myoung34/github-runner:ubuntu-jammy

# Install CUDA and OpenCL
RUN apt update && \
    apt install -y --no-install-recommends \
    nvidia-cuda-toolkit \
    clinfo \
    ocl-icd-dev

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

RUN nvcc --version
RUN nvidia-smi
RUN clinfo

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

ENV PATH="${PATH}:~/.cargo/bin"

RUN rustc --version
