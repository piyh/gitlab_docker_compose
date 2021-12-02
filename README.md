# gitlab_docker_compose
a docker compose image to use with dind in gitlab
installing docker compose is a pain in the ass in gitab if you're using docker

Boilerplate to use in your gitlab-ci.yml is as follows 



  image: piyh/gitlab_docker_compose:19.03.12

  variables:
    DOCKER_TLS_CERTDIR: "/certs"
    DOCKER_DRIVER: overlay2

  services:
    - docker:19.03.12-dind  # necessary for docker to build and run my images 
