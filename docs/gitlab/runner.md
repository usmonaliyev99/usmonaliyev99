# To install GitLab Runner

### Add the official GitLab repository:

1 Download the repository configuration script:

```shell
curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh" -o script.deb.sh
```

2 Inspect the script before running it:

```shell
less script.deb.sh
```

3 Run the script:

```shell
sudo bash script.deb.sh
```

### Install the latest version of GitLab Runner, or skip to the next step to install a specific version:

```bash
sudo apt install gitlab-runner
```

[Source](https://docs.gitlab.com/runner/install/linux-repository/)

4 After install gitlab runner, you should create volume for your worker to use docker in your pipeline.

```shell
sudo vim /etc/gitlab-runner/config.toml
```

Mount `/var/run/docker.sock:/var/run/docker.sock` file like this:

```toml
[[runners]]
  name = "docker-runner"
  url = "https://about.gitlab.com/"
  token = "your-token"
  executor = "docker"
  [runners.custom_build_dir]
  [runners.docker]
    tls_verify = false
    image = "docker:latest"
    privileged = true
    disable_entrypoint_overwrite = false
    oom_kill_disable = false
    disable_cache = false
    volumes = ["/cache", "/var/run/docker.sock:/var/run/docker.sock"]
    shm_size = 0
```

5 After change `config.toml`, restart your gitlab runner

```shell
sudo gitlab-runner restart
```
