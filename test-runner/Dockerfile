# Use pre-configured GitHub runner action
FROM myoung34/github-runner:ubuntu-jammy

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

ENV PATH="${PATH}:~/.cargo/bin"

RUN rustc --version

COPY ../scripts/entrypoint-wrapper.sh /
ENTRYPOINT ["/entrypoint-wrapper.sh"]
CMD ["/actions-runner/bin/runsvc.sh"]
VOLUME /var/tmp/runner
