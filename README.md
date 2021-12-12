# gitlab_docker_compose
a docker compose image to use with dind in gitlab.

Installing docker compose is a pain in the ass in gitab if you're using docker.  This repo is so I don't forget how to do it and if you want to as well.
There's other similar images like tmaier's, but this has a completely permissive license.

Boilerplate to use in your gitlab-ci.yml is as follows 

    image: piyh/gitlab_docker_compose:19.03.12

    variables:
      DOCKER_TLS_CERTDIR: "/certs"
      DOCKER_DRIVER: overlay2

    services:
      - docker:19.03.12-dind  # necessary for docker to build and run my images 

    compose-build:
      stage: build
      before_script:
      # smoke test that this is working
        - docker info

      script:
        - docker-compose build

