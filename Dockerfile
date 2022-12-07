FROM ubuntu:jammy

LABEL maintainer="Tom Akehurst <tom@wiremock.org>"

RUN apt-get update -y && apt-get install -y git curl rbenv ruby-build

RUN groupadd -r jekyll && useradd -r -m -g jekyll -s /usr/bin/bash jekyll \
  && chmod a+wx /usr/bin && chmod -R a+rwx /var && chmod -R a+rw /usr/local/bin && chmod -R a+rw /bin && chmod -R a+rwx /var/cache

USER jekyll

ENV NODE_VERSION=8.11.2

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash -x
RUN ls -la /home/jekyll
RUN ls -l /home/jekyll/.nvm
RUN . "/home/jekyll/.nvm/nvm.sh" \
  && nvm install $NODE_VERSION \
  && nvm alias default $NODE_VERSION \
  && nvm use default

# add node and npm to path so the commands are available
ENV NODE_PATH "/home/jekyll/.nvm/v$NODE_VERSION/lib/node_modules"
ENV PATH "/home/jekyll/.nvm/versions/node/v$NODE_VERSION/bin:$PATH"

COPY init.sh /init.sh
COPY entrypoint.sh /entrypoint.sh

RUN rbenv init
RUN rbenv exec gem install bundler

WORKDIR /sources
RUN /init.sh

EXPOSE 4000

ENTRYPOINT [ "/entrypoint.sh" ]