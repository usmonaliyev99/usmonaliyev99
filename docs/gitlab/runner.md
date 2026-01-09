## To install GitLab Runner

1. Add the official GitLab repository:

1.1 Download the repository configuration script:

```shell
curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh" -o script.deb.sh
```

1.2 Inspect the script before running it:

```shell
less script.deb.sh
```

1.3 Run the script:

```shell
sudo bash script.deb.sh
```

2. Install the latest version of GitLab Runner, or skip to the next step to install a specific version:

```bash
sudo apt install gitlab-runner
```

3. To install a specific version of GitLab Runner:

```bash
apt-cache madison gitlab-runner
sudo apt install gitlab-runner=17.7.1-1 gitlab-runner-helper-images=17.7.1-1
```

If you attempt to install a specific version of gGitlab-runner without installing the same version of gitlab-runner-helper-images, you might encounter the following error:

```bash
sudo apt install gitlab-runner=17.7.1-1
...
The following packages have unmet dependencies:
 gitlab-runner : Depends: gitlab-runner-helper-images (= 17.7.1-1) but 17.8.3-1 is to be installed
E: Unable to correct problems, you have held broken packages.
```

[Source](https://docs.gitlab.com/runner/install/linux-repository/)
