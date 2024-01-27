FROM alpine:latest

RUN apk add --no-cache python3 py3-pip curl
RUN pip3 install --upgrade pip --break-system-packages \
  && pip3 install --no-cache-dir awscli --break-system-packages \
  && rm -rf /var/cache/apk/*
RUN curl -Ls -o /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl -o /usr/bin/kubectl \
  && chmod +x /usr/bin/kubectl
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]