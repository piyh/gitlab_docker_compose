FROM docker:19.03.12
RUN apk update
RUN apk add --no-cache py-pip python3-dev libffi-dev openssl-dev gcc libc-dev make rust cargo
RUN pip install docker-compose

#docker push piyh/gitlab_docker_compose:19.03.12
