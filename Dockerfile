FROM ruby:2.5.0-alpine

RUN apk update && apk add \
    nodejs \
    build-base \
    libxml2-dev \
    libxslt-dev \
    postgresql \
    postgresql-dev

RUN mkdir /app
WORKDIR /app

COPY Gemfile ./Gemfile
COPY Gemfile.lock ./Gemfile.lock

RUN bundle install