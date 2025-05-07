#!/usr/bin/sh
python manage.py migrate
python manage.py createsuperuser --no-input
gunicorn --access-logfile /var/log/app/logfile $(ls */wsgi.py | cut -d / -f 1).wsgi:application --bind :8000