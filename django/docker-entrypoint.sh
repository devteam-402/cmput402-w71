#!/bin/bash

# Wait for PostgresSQL
until nc -z postgres 5432; do
    sleep 1
done

python manage.py migrate
python manage.py loaddata fixtures/*
python manage.py collectstatic --noinput

gunicorn --log-level=debug apiserver.wsgi:application -w 2 -b :8000 --reload

exec "$@"
