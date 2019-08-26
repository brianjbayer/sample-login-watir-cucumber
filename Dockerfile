# sample-login-watir-cucumber
FROM ruby:2.4.5

# Use the same version of Bundler in the Gemfile.lock
RUN gem install bundler -v 2.0.2

# Throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /app

# Install the Ruby dependencies (defined in the Gemfile/Gemfile.lock)
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Populate the Docker Working Directory with this project's source code
COPY . .

# To Run the tests - altho this is orchestrated by the docker-compose.yml file
#CMD bundle exec rake
