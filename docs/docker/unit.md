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
# Run container
ExecStart=/usr/bin/docker run \
  --name f-backend \
  --restart=no \
  -p 5000:5000 \
  -e PG_HOST=10.0.0.2 \
  -e PG_PORT=5432 \
  -e PG_PASSWORD=friend \
  -e PG_USER=supperpassword \
  gitlab.usmonaliyev99.com:5050/apps/f-backend:prod
# Stop container
ExecStop=/usr/bin/docker stop f-backend

[Install]
WantedBy=multi-user.target
```

I you use your container registry, please login before start systemd.

```bash
docker login -u <user> -p <token|password> $CI_REGISTRY
```

Reload & start service

```bash
sudo systemctl daemon-reload
sudo systemctl enable f-backend.service
sudo systemctl start f-backend.service
```

Check status & logs

```bash
systemctl status f-backend.service
journalctl -u f-backend.service -f
```

If you want to expose it to world, use this `nginx` conf:

```
server {
    listen 80;
    server_name f-backend.usmonaliyev99.com;

    access_log /var/log/nginx/f-backend.access.log;
    error_log  /var/log/nginx/f-backend.error.log;

    location / {
        proxy_pass http://127.0.0.1:5000;

        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```
