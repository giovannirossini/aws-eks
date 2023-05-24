FROM alpine:latest as base

RUN apk add --no-cache python3 py3-pip curl
RUN pip3 install --upgrade pip \
  && pip3 install --no-cache-dir awscli \
  && rm -rf /var/cache/apk/*
RUN curl -Ls -o /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl -o /usr/bin/kubectl \
  && chmod +x /usr/bin/kubectl
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Add a new user
RUN adduser --disabled-password --gecos '' aws-eks

RUN chown aws-eks:aws-eks /usr/bin/aws \
  && chown aws-eks:aws-eks /usr/bin/kubectl \
  && chown aws-eks:aws-eks /entrypoint.sh \
  && chmod 755 /usr/bin/aws \
  && chmod 755 /usr/bin/kubectl \
  && chmod 755 /entrypoint.sh
# FROM gcr.io/distroless/base
# ENV PATH=/cli/bin:${PATH}
USER aws-eks
# COPY --from=base /cli /cli
# COPY --from=base /usr/bin/kubectl /usr/bin/kubectl
# COPY --from=base /entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
