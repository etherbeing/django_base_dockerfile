#!/bin/sh
MAIN_APP=$(find . -name wsgi.py | head -n1 | cut -d/ -f2)
# Check if setup has already been done
if [ ! -f .setup_done ]; then
  echo "Setup already done. Skipping..."
else
# Comma-separated list of fixture files
# Convert comma-separated list to space-separated
IFS=',' read -r -a files <<EOF
$FIXTURES
EOF

# Run loaddata for each file
for file in "${files[@]}"; do
  echo "Loading $file..."
  python manage.py loaddata "$file" || {
    echo "Failed to load $file. Aborting."
    exit 1
  }
done
# Mark setup as done
touch .setup_done
echo "Setup completed successfully."
fi

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
