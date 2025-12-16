#!/bin/bash
# start.sh
echo "Running database migrations..."
bundle exec rails db:migrate 2>/dev/null || echo "Migrations may have already run"

echo "Starting Rails server..."
exec bundle exec rails server -b 0.0.0.0 -p 10000