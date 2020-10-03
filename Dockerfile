# sample-login-watir-cucumber
FROM ruby:2.6.6-alpine

# Need to add lib-ffi to build ffi gem native extensions
RUN apk --update add --virtual build-dependencies build-base libffi-dev

# Use the same version of Bundler in the Gemfile.lock
RUN gem install bundler -v 2.1.4

# Throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /app

# Install the Ruby dependencies (defined in the Gemfile/Gemfile.lock)
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Clean up build/bundle dependencies
RUN apk del build-dependencies
RUN rm -rf /var/lib/apt/lists/*

# Populate the Docker Working Directory with this project's source code
COPY . .

# To Run the tests - altho this is orchestrated by the docker-compose.yml file
#CMD bundle exec rake
