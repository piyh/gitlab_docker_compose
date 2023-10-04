FROM docker:24.0.6-dind-rootless
RUN apk update
RUN apk add --no-cache py-pip python3-dev libffi-dev openssl-dev gcc libc-dev make rust cargo
RUN pip install docker-compose

#docker push piyh/gitlab_docker_compose:24.0.6-dind-rootless