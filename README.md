# GitHub Actions runner
This repository contains a Docker container defining a self-hosted runner and an associated systemd service in `/server`. It is largely based on the following:

https://github.com/myoung34/docker-github-actions-runner  
https://baccini-al.medium.com/how-to-containerize-a-github-actions-self-hosted-runner-5994cc08b9fb

## Known security issues
According to the [docs](https://docs.github.com/en/actions/hosting-your-own-runners/about-self-hosted-runners#self-hosted-runner-security), there can be vulnerabilities with self-hosted runners on public repos which can be addressed by [security hardening](https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions#hardening-for-self-hosted-runners). Also, it's important to configure workflow permissions for public forks in `Settings->Actions->General`.

## License
MIT or Apache 2.0
