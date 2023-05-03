FROM nvidia/cuda:12.0.0-devel-ubuntu22.04 as cuda

RUN nvcc --version
RUN which nvcc

# Use pre-configured GitHub runner action
FROM myoung34/github-runner:2.303.0

RUN apt update && \
    apt install -y --no-install-recommends \
    clinfo \
    ocl-icd-dev

COPY --from=cuda /usr/local /usr/local
COPY --from=cuda /usr/bin /usr/bin
COPY --from=cuda /usr/lib /usr/lib
COPY --from=cuda /usr/share usr/share
COPY --from=cuda /usr/local/cuda/bin/nvcc /usr/bin

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

RUN nvcc --version
RUN clinfo
      
# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

ENV PATH="${PATH}:~/.cargo/bin"

RUN rustc --version

 