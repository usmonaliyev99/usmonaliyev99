# Running a Docker container via systemd

Create systemd unit file

```bash
sudo vim /etc/systemd/system/f-backend.service
```

Example systemd unit for Docker container

```bash
[Unit]
Description=Friend backend docker container
After=docker.service
Requires=docker.service

[Service]
Restart=always
TimeoutStartSec=0
# Clean up old container if exists
ExecStartPre=-/usr/bin/docker rm -f f-backend
# Run container
ExecStart=/usr/bin/docker run \
  --name f-backend \
  --restart=no \
  -p 8080:80 \
  -e APP_ENV=production \
  -v /var/f-backend/storage:/var/www/storage \
  docker.io/f-backend:latest
# Stop container
ExecStop=/usr/bin/docker stop f-backend

[Install]
WantedBy=multi-user.target
```

Reload & start service

```bash
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable f-backend.service
sudo systemctl start f-backend.service
```

Check status & logs

```bash
systemctl status f-backend.service
journalctl -u f-backend.service -f
```
