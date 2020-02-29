# docker-jekyll-stack

Haskell Stack (using GHC 8.6.5) on jekyll/builder (on Alpine Linux)

See [ednutting/jekyll-haskell-stack on Docker](https://hub.docker.com/repository/docker/ednutting/jekyll-haskell-stack)

See my other repositories for GHC-Up, GHC and Agda on Jekyll/builder.

## Using this docker image

You can `FROM` the associated docker image directly to use `stack`. It excludes the build sources.

Note: Give your Docker instance 4 CPUs and 8GB RAM minimum or the build may randomly fail.
