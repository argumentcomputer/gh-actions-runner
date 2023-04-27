# Use pre-configured GitHub runner action
FROM myoung34/github-runner:2.303.0

# Install CUDA
RUN apt update && apt install nvidia-cuda-toolkit -y
RUN nvcc --version

# Install OpenCL
RUN apt install clinfo -y
RUN clinfo

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

RUN . "/root/.cargo/env"
ENV PATH="${PATH}:/root/.cargo/bin"

RUN rustc --version

