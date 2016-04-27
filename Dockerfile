FROM ruby:2.2.1

RUN apt-get update && apt-get install -y \
  build-essential \
  nodejs \
  locales

RUN mkdir -p /app 
WORKDIR /app
COPY . ./
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

EXPOSE 3000

RUN rake db:drop db:create db:migrate db:seed

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]