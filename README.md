# docker-jekyll-stack

Haskell Stack (using GHC 8.6.5) on jekyll/builder (on Alpine Linux)

See [ednutting/jekyll-haskell-stack on Docker](https://hub.docker.com/repository/docker/ednutting/jekyll-haskell-stack)

See my other repositories for GHC-Up, GHC and Agda on Jekyll/builder.

## Using this docker image

Don't `FROM` this image directly. You don't need to. You only need a subset of the files included
in this image in order to use `stack`.

See the Dockerfile in my docker-jekyll-agda repo for the variables and files you need.
