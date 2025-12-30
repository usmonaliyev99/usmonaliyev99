FROM python:3.12-slim AS building

RUN apt-get update \
    && apt-get install -y git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /docs

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY . .

RUN sed -i 's|^site_url:.*|site_url: https://usmonaliyev99.com/|' mkdocs.yml

RUN mkdocs build

FROM nginx:alpine

COPY --from=building /docs/site /usr/share/nginx/html

EXPOSE 80
