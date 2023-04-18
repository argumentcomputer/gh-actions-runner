# hello-docker-action
Template for a Docker container defining a self-hosted runner, using the following tutorials:

https://baccini-al.medium.com/how-to-containerize-a-github-actions-self-hosted-runner-5994cc08b9fb

## Set up the droplet
After logging in as root, run the following:
```
# adduser <username>
# usermod -aG docker <username>
# su <username>
# cd ~
```

## Set up the runner in the repo
- Go to `Settings->Actions->Runners->New self-hosted runner` and paste the given instructions in the droplet console.  
- Then, make a commit or re-run a previous workflow to see the magic happen!
- To run the runner persistently in the background as a systemd service, quit the `run.sh` command and run the following as root:
```
# ./svc.sh install
# ./svc.sh start
```
and quit with
```
# ./svc.sh stop
```

## Known security issues
According to the [docs](https://docs.github.com/en/actions/hosting-your-own-runners/about-self-hosted-runners#self-hosted-runner-security), there can be vulnerabilities with self-hosted runners on public repos which can be addressed by [security hardening](https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions#hardening-for-self-hosted-runners). Also, it's important to configure workflow permissions for public forks in `Settings->Actions->General`.
