# Use pre-configured GitHub runner action
FROM myoung34/github-runner:ubuntu-jammy

RUN apt update \
    && apt install -y \
    pkg-config \
    libssl-dev \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

ENV PATH="${PATH}:/root/.cargo/bin"

RUN rustc --version

COPY entrypoint-wrapper.sh /
ENTRYPOINT ["/entrypoint-wrapper.sh"]
CMD ["/actions-runner/bin/runsvc.sh"]
VOLUME /var/tmp/runner
