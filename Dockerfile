FROM ghcr.io/okteto/okteto:3.19.0
ENV OKTETO_ORIGIN=github_action

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"] 
