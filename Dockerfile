#-----------------------------------
#--- sample-login-watir-cucumber ---
#-----------------------------------

#--- Base Image ---
# Ruby version must match that in Gemfile.lock
ARG BASE_IMAGE=ruby:3.3.4-slim-bookworm
FROM ${BASE_IMAGE} AS ruby-base

# Install packages common to builder (dev) and deploy
ARG BASE_PACKAGES='curl'

# Assumes debian based
RUN apt-get update \
  && apt-get -y dist-upgrade \
  && apt-get -y install ${BASE_PACKAGES} \
  && rm -rf /var/lib/apt/lists/*

#--- Builder Stage ---
FROM ruby-base AS builder

# Use the same version of Bundler in the Gemfile.lock
ARG BUNDLER_VERSION=2.5.17
ENV BUNDLER_VERSION=${BUNDLER_VERSION}

# Install base build packages
ARG BASE_BUILD_PACKAGES='build-essential'

# Assumes debian based
RUN apt-get update \
  && apt-get -y dist-upgrade \
  && apt-get -y install ${BASE_BUILD_PACKAGES} \
  && rm -rf /var/lib/apt/lists/* \
  # Update gem command to latest
  && gem update --system \
  # Install bundler
  && gem install bundler:${BUNDLER_VERSION}

# Install the Ruby dependencies (defined in the Gemfile/Gemfile.lock)
WORKDIR /app
COPY Gemfile Gemfile.lock ./

# Add support for multiple platforms
RUN bundle lock --add-platform ruby \
  && bundle lock --add-platform x86_64-linux \
  && bundle lock --add-platform aarch64-linux \
  && bundle install

#--- Dev Environment ---
# ASSUME source is docker volumed into the image
FROM builder AS devenv

# For Dev Env, add git and vim at least
ARG DEVENV_PACKAGES='git vim'

ARG BUNDLER_PATH=/usr/local/bundle

# Install dev environment specific build packages
# Assumes debian based
RUN apt-get update \
  && apt-get -y dist-upgrade \
  && apt-get -y install ${DEVENV_PACKAGES} \
  && rm -rf /var/lib/apt/lists/* \
  # Install app dependencies
  && bundle install \
  # Remove unneeded files (cached *.gem, *.o, *.c)
  && rm -rf ${BUNDLER_PATH}/cache/*.gem \
  && find ${BUNDLER_PATH}/gems/ -name '*.[co]' -delete

# Start devenv in (command line) shell
CMD ["bash"]

#--- Deploy Stage ---
FROM ruby-base AS deploy

# Throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1 \
  # Add a user so not running as root - Assumes debian based
  && adduser --disabled-password --gecos '' deployer

# Run as deployer USER instead of as root
USER deployer

# Copy over the built gems (directory)
COPY --from=builder --chown=deployer /usr/local/bundle/ /usr/local/bundle/

# Copy the app source to /app
WORKDIR /app
COPY --chown=deployer . /app/

# Run the tests but allow override
CMD ["./script/run", "tests"]
