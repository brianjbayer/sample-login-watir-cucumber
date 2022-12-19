#-----------------------------------
#--- sample-login-watir-cucumber ---
#-----------------------------------

### Base Image ###
ARG BASE_IMAGE=ruby:2.7.7-alpine
FROM ${BASE_IMAGE} AS ruby-alpine

### Builder Stage ###
FROM ruby-alpine AS builder

# Need to add lib-ffi to build ffi gem native extensions
ARG BUILD_PACKAGES='build-dependencies build-base libffi-dev'

# Use the same version of Bundler in the Gemfile.lock
ARG BUNDLER_VER=2.3.26

RUN apk --update add --virtual ${BUILD_PACKAGES} \
  && gem install bundler:${BUNDLER_VER}

WORKDIR /app
# Install the Ruby dependencies (defined in the Gemfile/Gemfile.lock)
COPY Gemfile Gemfile.lock ./
RUN bundle install

### Dev Environment ###
# Before any checks stages so that we can always build a dev env
# ASSUME source is docker volumed into the image
FROM builder AS devenv

# For Dev Env, add git and vim at least
ARG DEVENV_PACKAGES='git vim'

RUN apk --update add ${DEVENV_PACKAGES}

# Start devenv in (command line) shell
CMD sh

### Deploy Stage ###
FROM ruby-alpine AS deploy

# Throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1 \
  # Add a user so not running as root
  && adduser -D deployer

USER deployer

# Copy over the built gems (directory)
COPY --from=builder --chown=deployer /usr/local/bundle/ /usr/local/bundle/

# Copy source to /app
WORKDIR /app
COPY --chown=deployer . /app/

# Run the tests
CMD ./script/runtests
