FROM ruby:2.7.2-alpine3.12

LABEL maintainer "Viktor Adam <rycus86@gmail.com>"

ARG TRAVIS_VERSION=1.10.0

RUN apk --no-cache add --virtual build-deps make gcc libc-dev            \
      && apk --no-cache add git                                          \
      && gem install travis -v $TRAVIS_VERSION --no-document             \
      && ruby -r $(find $BUNDLE_PATH | grep travis/tools/completion.rb)  \
              -e Travis::Tools::Completion::install_completion           \
      && apk del build-deps

RUN adduser -S travis-cli
USER travis-cli
ENV HOME /home/travis-cli

WORKDIR /travis

ENTRYPOINT [ "travis" ]
