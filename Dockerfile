# sample-login-watir-cucumber
### Builder Stage ###
FROM ruby:2.6.6-alpine AS builder
# Need to add lib-ffi to build ffi gem native extensions
RUN apk --update add --virtual build-dependencies build-base libffi-dev

# Use the same version of Bundler in the Gemfile.lock
RUN gem install bundler -v 2.1.4
WORKDIR /app
# Install the Ruby dependencies (defined in the Gemfile/Gemfile.lock)
COPY Gemfile Gemfile.lock ./
RUN bundle install

### Dev Environment ###
# Before any checks stages so that we can always build a dev env
# ASSUME source is docker volumed into the image
FROM builder AS devenv
# Add git and vim at least
RUN apk add --no-cache git
RUN apk add --no-cache vim
# Start devenv in (command line) shell
CMD /bin/ash

### Lint Stage ###
FROM builder AS lint
COPY . .
RUN bundle exec rake rubocop

### Security Static Scan Stage ###
# Keep build dependencies
FROM builder AS secscan
# Add git for bundler-audit
RUN apk add --no-cache git
# Just need Rakefile and Gemfile.lock
COPY Rakefile ./
RUN bundle exec rake bundle:audit

### Deploy Stage ###
FROM ruby:2.6.6-alpine AS deploy
# Throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN adduser -D deployer
USER deployer

# Copy over the built gems directory from builder image
COPY --from=builder --chown=deployer /usr/local/bundle/ /usr/local/bundle/
# Copy in app source
WORKDIR /app
COPY . .

# To Run the tests - altho this is orchestrated by the docker-compose.yml file
#CMD bundle exec rake
