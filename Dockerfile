FROM okteto/okteto:2.9.1
ENV OKTETO_ORIGIN github_action

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"] 
