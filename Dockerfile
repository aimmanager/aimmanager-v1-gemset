FROM ruby:2.4.3-jessie

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN curl -sL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

RUN apt-get update -qq && apt-get install -qq -y --fix-missing --no-install-recommends \
                        build-essential \
                        postgresql-client-10 \
                      && apt-get clean \
                      && rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

ENV BUNDLE_PATH /bundle_path

WORKDIR /reports_gem
RUN mkdir -p /reports_gem
COPY Gemfile* /reports_gem/

RUN bundle install --full-index --without development test

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
RUN ln -s /usr/local/bin/docker-entrypoint.sh /usr/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
