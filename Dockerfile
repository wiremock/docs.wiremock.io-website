FROM ruby:2.7.2-alpine3.13

RUN apk add bash curl

RUN adduser -h /home/jekyll -s /usr/bin/bash -D jekyll jekyll && chmod a+wx /usr/bin && chmod a+wx /bin

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

# RUN /init.sh

WORKDIR /sources

EXPOSE 4000

ENTRYPOINT [ "/entrypoint.sh" ]