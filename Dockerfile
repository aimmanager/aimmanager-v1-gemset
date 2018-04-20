FROM ruby:2.3.7-alpine

ENV LIBV8_VERSION 3.16.14.18

# Minimal requirements to run a Rails app
RUN apk add --no-cache --update --virtual build-dependencies \
                                build-base \
                                bash \
                                linux-headers \
                                git \
                                sqlite-dev \
                                libpq \
                                postgresql-dev \
                                postgresql-client \
                                imagemagick \
                                nodejs \
                                tzdata \
                                xvfb \
                                zip \
                                unzip \
                                && apk del build-base \
                                && rm -rf /var/cache/apk/*

ENV BUNDLE_PATH /bundle_path

WORKDIR /aim_gem
RUN mkdir -p /aim_gem
COPY Gemfile* /aim_gem/

RUN bundle install --full-index --without development test

COPY wkhtmltopdf.sh /usr/local/bin/
RUN chmod a+x /usr/local/bin/wkhtmltopdf.sh
RUN ln -s /usr/local/bin/wkhtmltopdf.sh /usr/bin/wkhtmltopdf.sh

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
RUN ln -s /usr/local/bin/docker-entrypoint.sh /usr/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
