#!/bin/sh
if [ ! -f "$STATICFILES_PATH" ]; then
  yes yes | python manage.py collectstatic
fi
python manage.py migrate
# TODO Please use a secret file path with something like $(cat mysecret) for this, perhaps or something securer
python manage.py createsuperuser --no-input --username=$USERNAME
gunicorn $(ls */wsgi.py | cut -d / -f 1).wsgi:application --bind :8000