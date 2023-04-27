FROM myoung34/github-runner:2.303.0
FROM rust:1.67.1

RUN rustc --version

#ENV PATH="$MY-VAR:$PATH"
