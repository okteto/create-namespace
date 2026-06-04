FROM ghcr.io/okteto/okteto:3.20.0
ENV OKTETO_ORIGIN=github_action

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"] 
