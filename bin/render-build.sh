#!/bin/bash

# Run database migrations
bundle exec rails db:migrate

# Continue with the default build process
bundle exec rails assets:precompile
