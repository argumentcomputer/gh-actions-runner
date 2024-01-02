# Use pre-configured GitHub runner action
FROM lurklab/gh-actions-runner-cuda:latest

# Install OpenCL and Lurk dependencies
RUN apt-get update \
    && apt-get install -y \
    clinfo \
    ocl-icd-dev \
    ocl-icd-opencl-dev \
    ocl-icd-libopencl1 \
    opencl-headers \
    pkg-config \
    libssl-dev \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

RUN nvcc --version

RUN mkdir -p /etc/OpenCL/vendors && \
    echo "libnvidia-opencl.so.1" > /etc/OpenCL/vendors/nvidia.icd

COPY entrypoint-wrapper.sh /
ENTRYPOINT ["/entrypoint-wrapper.sh"]
CMD ["/actions-runner/bin/runsvc.sh"]
VOLUME /var/tmp/runner
