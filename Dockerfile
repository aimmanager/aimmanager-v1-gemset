FROM ruby:2.3.6-jessie

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN curl -sL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

RUN apt-get update -qq && apt-get install -qq -y --fix-missing --no-install-recommends \
                        build-essential \
                        nodejs \
                        chrpath \
                        libxft-dev \
                        libfreetype6 \
                        libfreetype6-dev \
                        libfontconfig1 \
                        libfontconfig1-dev \
                        postgresql-client-10 \
                        gdal-bin \
                        libgdal-dev \
                        python-gdal \
                        wkhtmltopdf \
                        xvfb \
                        zip \
                        unzip \
                      && apt-get clean \
                      && rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

ENV BUNDLE_PATH /bundle_path

WORKDIR /aim_gem
RUN mkdir -p /aim_gem
COPY Gemfile* /aim_gem/

RUN bundle install --full-index --without development test

COPY wkhtmltopdf.sh /usr/local/bin/
chmod a+x /usr/local/bin/wkhtmltopdf.sh
RUN ln -s /usr/local/bin/wkhtmltopdf.sh /usr/bin/wkhtmltopdf.sh

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
RUN ln -s /usr/local/bin/docker-entrypoint.sh /usr/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
