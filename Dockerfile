# Use pre-configured GitHub runner action
FROM myoung34/github-runner:2.303.0

# Install CUDA and OpenCL
RUN apt update && \
    apt install nvidia-cuda-toolkit -y && \
    apt install clinfo -y && \
    apt install ocl-icd-dev -y

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

RUN nvcc --version
RUN clinfo

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

RUN . "/root/.cargo/env"
ENV PATH="${PATH}:/root/.cargo/bin"

RUN rustc --version

