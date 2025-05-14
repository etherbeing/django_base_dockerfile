#!/bin/sh
MAIN_APP=$(find . -name wsgi.py | head -n1 | cut -d/ -f2)

if [ ! -f "$STATICFILES_PATH" ]; then
  yes yes | python manage.py collectstatic
fi
python manage.py migrate
# TODO Please use a secret file path with something like $(cat mysecret) for this, perhaps or something securer
eval $(cat .env | grep USERNAME) python manage.py createsuperuser --no-input --username=$USERNAME --email=$EMAIL
if [ -z "$USE_DAPHNE" ] || [ "$USE_DAPHNE" = "False"]; then
  gunicorn $MAIN_APP.wsgi:application --bind :8000
else
  daphne $MAIN_APP.asgi:application --bind :8000
fi