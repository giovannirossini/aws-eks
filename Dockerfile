FROM alpine:latest

RUN apk add --no-cache python3 py3-pip curl
RUN pip3 install --upgrade pip --break-system-packages \
  && pip3 install --no-cache-dir awscli --break-system-packages \
  && rm -rf /var/cache/apk/*

RUN STABLE=$(curl -Ls https://dl.k8s.io/release/stable.txt | awk -F'.' '{print $2}'); \
  for i in $(seq $((STABLE-10)) $STABLE); do \
  curl -Ls https://dl.k8s.io/release/v1.$i.0/bin/linux/amd64/kubectl -o /usr/bin/kubectl-v1.$i; \
  chmod +x /usr/bin/kubectl-v1.$i; \
  done

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
