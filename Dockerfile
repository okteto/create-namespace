FROM okteto/okteto:master
ENV OKTETO_ORIGIN github_action

USER 0


COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"] 
