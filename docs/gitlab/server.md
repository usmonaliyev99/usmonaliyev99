## Enable SSH and open firewall ports

To open the needed firewall ports (80, 443, 22) and be able to access GitLab:

Enable and start the OpenSSH server daemon:

```yaml
sudo systemctl enable --now ssh
```

With `ufw` installed, open the firewall ports:

```bash
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw enable
```

## Add the GitLab package repository

To install GitLab, first add the GitLab package repository.

Install the needed packages:

```bash
sudo apt update
sudo apt install -y curl
```

Use the following script to add the GitLab repository (you can paste the script’s URL to your browser to see what it does before piping it to bash):

```bash
curl "https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh" | sudo bash
```

## Install the package

Install GitLab using your system’s package manager.

```bash
sudo EXTERNAL_URL="https://gitlab.example.com" apt install gitlab-ce
```

GitLab generates a random password and email address for the root administrator account stored in /etc/gitlab/initial_root_password for 24 hours. After 24 hours, this file is automatically removed for security reasons.

[Source](https://docs.gitlab.com/install/package/ubuntu/)
