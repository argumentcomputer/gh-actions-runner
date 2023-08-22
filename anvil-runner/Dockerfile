# Use pre-configured GitHub runner action
FROM myoung34/github-runner:ubuntu-jammy

# Install Foundry
RUN curl -L https://foundry.paradigm.xyz | bash

ENV PATH="${PATH}:~/.foundry/bin"

RUN foundryup

RUN anvil --version
RUN cast --version

COPY /entrypoint-wrapper.sh /
ENTRYPOINT ["/entrypoint-wrapper.sh"]
CMD ["/actions-runner/bin/runsvc.sh"]
VOLUME /var/tmp/runner

