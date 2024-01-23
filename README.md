# gitlab_docker_compose
a docker compose image to use with dind in gitlab.

Installing docker compose is a pain in the ass in gitab if you're using docker.  This repo is so I don't forget how to do it and if you want to as well.
There's other similar images like tmaier's, but this has a completely permissive license.

Boilerplate to use in your gitlab-ci.yml is as follows 

    image: piyh/gitlab_docker_compose:22.04

    variables:
      DOCKER_TLS_CERTDIR: "/certs"
      DOCKER_DRIVER: overlay2

    services:
      - docker:22.04  # necessary for docker to build and run my images 

    compose-build:
      stage: build
      before_script:
      # smoke test that this is working
        - docker info

      script:
        - docker-compose build

# Building this image
One time setup on M1 Macbook to enable mulit-architecture (amd64 & arm64) builds:

    docker buildx create --name mybuilder --use
    docker buildx inspect --bootstrap

then build and push:

    docker buildx build --platform linux/amd64,linux/arm64 -t piyh/gitlab_docker_compose:22.04 --push .
    
    
`docker login` if it's been a while and credentials have expired.


Previously I was building and pushing using normal commands, but since I develop in arm and have a gitlab runner on x86, I had this cross arch error.


    Using docker image sha256:a11c0763411e2eb473e6894b1bbdfe228dcdbc9c2c6cecfae04091107f2912d1 for piyh/gitlab_docker_compose:22.04 with digest piyh/gitlab_docker_compose@sha256:f04f6a597b7d4c2896cda8ea8cef90fa583a12e947c4dddca5bf8c08b3634abd ...
    exec /usr/bin/sh: exec format error

If we ever go back to a single architecture again, these commands alone will do.

    docker build . -t piyh/gitlab_docker_compose:22.04
    docker push piyh/gitlab_docker_compose:22.04


# Self hosted gitlab runner cheat sheet

`systemctl status gitlab-runner`

If installed as root, the runner config is at `/etc/gitlab-runner/config.toml`.

For docker in docker, the priviledge flag and volume config must be changed to:

    volumes = ["/var/run/docker.sock:/var/run/docker.sock", "/cache"]
    privileged = true
