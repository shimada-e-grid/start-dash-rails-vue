FROM ruby:2.7.4-slim

WORKDIR /home/app/start-dash-rails-vue

RUN apt-get update -qq && \
  apt-get install -y build-essential \
  libpq-dev \
  postgresql-client

COPY Gemfile .
COPY Gemfile.lock .

RUN bundle install --jobs=4

COPY . .

# Add a script to be executed every time the container starts.
COPY docker/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
