FROM myoung34/github-runner:2.303.0

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

RUN . "/root/.cargo/env"
ENV PATH="${PATH}:/root/.cargo/bin"

RUN rustc --version
