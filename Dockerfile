ARG JEKYLL_BASE_IMAGE=jekyll/builder:latest
ARG JEKYLL_GHCUP_IMAGE=ednutting/jekyll-ghcup:latest
ARG JEKYLL_GHC_IMAGE=ednutting/jekyll-ghc:latest

###################################################
#   Haskell stack pre-requisites
###################################################

FROM $JEKYLL_GHCUP_IMAGE AS stack-tooling

ENV STACK_VERSION=2.1.3
ENV STACK_SHA256="4e937a6ad7b5e352c5bd03aef29a753e9c4ca7e8ccc22deb5cd54019a8cf130c  stack-${STACK_VERSION}-linux-x86_64-static.tar.gz"

# Download, verify, and install stack
RUN echo "Downloading and installing stack" &&\
    cd /tmp &&\
    wget -P /tmp/ "https://github.com/commercialhaskell/stack/releases/download/v${STACK_VERSION}/stack-${STACK_VERSION}-linux-x86_64-static.tar.gz" &&\
    if ! echo -n "${STACK_SHA256}" | sha256sum -c -; then \
    echo "stack-${STACK_VERSION} checksum failed" >&2 &&\
    exit 1 ;\
    fi ;\
    tar -xvzf /tmp/stack-${STACK_VERSION}-linux-x86_64-static.tar.gz &&\
    cp -L /tmp/stack-${STACK_VERSION}-linux-x86_64-static/stack /usr/bin/stack &&\
    rm /tmp/stack-${STACK_VERSION}-linux-x86_64-static.tar.gz &&\
    rm -rf /tmp/stack-${STACK_VERSION}-linux-x86_64-static


###################################################
#   Haskell Stack
###################################################

# Note: Give your Docker instance 4 CPUs and 8GB RAM minimum or the build may randomly fail

FROM $JEKYLL_BASE_IMAGE

# NOTE: 'stack --docker' needs bash + usermod/groupmod (from shadow)
RUN apk add --no-cache bash shadow openssh-client tar curl xz

# Carry build args through to this stage
ARG GHC_BUILD_TYPE=gmp
ARG GHC_VERSION=8.6.5

COPY --from=$JEKYLL_GHC_IMAGE /.ghcup /.ghcup
COPY --from=$JEKYLL_GHC_IMAGE /usr/bin/ghcup /usr/bin/ghcup
COPY --from=stack-tooling /usr/bin/stack /usr/bin/stack

# Add ghcup's bin directory to the PATH so that the versions of GHC it builds
# are available in the build layers
ENV GHCUP_INSTALL_BASE_PREFIX=/
ENV PATH=/.ghcup/bin:$PATH

RUN ghcup set ${GHC_VERSION} &&\
    stack config set system-ghc --global true
