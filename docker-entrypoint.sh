#!/bin/bash

# tells the bash script to exit whenever anything returns a non-zero return value.
set -e

if [ -z "${RUN_FOREVER}" ]; then
    echo "skip forever"
else
    while :; do echo 'Hit CTRL+C'; sleep 1; done
    exit 1
fi

if [ -z "${APP_CURRENT_DIR}" ]; then
    echo "No APP_CURRENT_DIR"
    exit 1
else
    echo "aim in: '$APP_CURRENT_DIR'"
    cd "$APP_CURRENT_DIR"
fi

bundle check || bundle install --full-index --without development test

if [ -z "${WITH_SEEDS_MIGRATIONS}" ]; then
    echo "skip db:migrate / db:seeds / data:migrate"
else
    # run migrations
    bundle exec rake db:migrate

    # seeds and data migrations
    bundle exec rake db:seed
    bundle exec rake data:migrate
fi

if [ -z "${WITH_ASSETS}" ]; then
    echo "skip assets:precompile"
else
    # run asset precompile
    bundle exec rake assets:precompile RAILS_GROUPS=assets
fi

if [ -z "${WITH_DB_VIEWS}" ]; then
    echo "skip db:views"
else
    # run db:views
    bundle exec rake db:views
fi

exec "$@"
