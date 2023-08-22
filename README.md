# GitHub Actions runner
This repository contains Docker images defining self-hosted runners and associated systemd services in `/test-runner`, `/bench-runner`, and `/gpu-runner`. They are largely based on the following:

https://github.com/myoung34/docker-github-actions-runner  
https://baccini-al.medium.com/how-to-containerize-a-github-actions-self-hosted-runner-5994cc08b9fb

## Test runner tutorial
- Create a server on e.g. DigitalOcean
- Copy the files over:
```
cd scripts
# First edit this file with the path to the desired runner type and the server IP address
./server_files.sh
```
- SSH into the server
- Run `apt update && apt upgrade -y`, and reboot if needed (e.g. kernel update)
- Run `./setup.sh` and check that it ran without errors
- Edit `gh-actions-runner.env` with the desired repo URL and GitHub PAT
    - Note: Only tested with classic personal tokens and the following permissions:
        - repo (all)
        - workflow
        - admin:public_key (read:public_key)
        - admin:repo_hook (read:repo_hook)
        - notifications
    - Fine-grained and organization-level tokens will need different permissions and may cause issues
    - See https://github.com/myoung34/docker-github-actions-runner/issues/262 for discussion
- Optionally, edit `gh-actions-runner.service` to set the number of parallel workers with `--scale worker=<num>`
- Run `./install.sh` to start the runners
- Run `journalctl -f -u gh-actions-runner.service --no-hostname --no-tail` to inspect the log
- Check the runners are connected to the desired GitHub repo by going to Settings->Actions->Runners
- Run `crontab -e` and add the following lines:
```
0 0 1 * * /root/docker_cleanup.sh
0 0 * * * /root/runner_cleanup.sh
```

## GPU runner tutorial
The GPU runner uses the following CUDA-enabled image: https://github.com/lurk-lab/github-actions-runner-cuda/tree/cuda

The instructions are the same as above, with the following modifications:
- Once logged into the server, run `nvidia-smi` to check the drivers are working
- Don't run `apt update`/`apt upgrade`, as a new kernel version will break the GPU drivers
- Run `./gpu_setup.sh` instead of `setup.sh`, and then `./install.sh` as usual
    - Note: This script is specialized for a Vultr Nvidia GPU server on Ubuntu; behavior will likely vary with other GPU providers.

# Troubleshooting
- Try restarting the `systemd` service with `systemctl restart gh-actions-runner`
- Try restarting docker itself with `service docker restart`
- Reinstall the `systemd` service with `./remove.sh` and `./install.sh`
- Check GitHub PAT has the correct permissions and hasn't expired
- Check the `.env` file has the right PAT and the right repo URL
- Check Docker Hub for the correct image, which must match the `compose` file
- Nvidia errors: Check https://github.com/NVIDIA/nvidia-docker/issues/. Other than that, good luck :)

## Known security issues
According to the [docs](https://docs.github.com/en/actions/hosting-your-own-runners/about-self-hosted-runners#self-hosted-runner-security), there can be vulnerabilities with self-hosted runners on public repos which can be addressed by [security hardening](https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions#hardening-for-self-hosted-runners). Also, it's important to configure workflow permissions for public forks in `Settings->Actions->General`.

## License
MIT or Apache 2.0
