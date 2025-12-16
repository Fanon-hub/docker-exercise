# Dockerfile
FROM ruby:3.2.2

RUN apt-get update -qq && apt-get install -y \
    nodejs \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install bundler
RUN gem install bundler

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy the entire application
COPY . .

# Add a script to be executed every time the container starts
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 10000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "10000"]