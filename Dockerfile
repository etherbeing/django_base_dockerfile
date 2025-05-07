FROM python:3-alpine


# Install a WSGI server to serve our files, later this should also include daphne to serve ASGI in case is needed with a conditional script based on a build argument
RUN pip install gunicorn

COPY ./ /app/

# This is at this place to make this instruction not to invalid the previous one 
ARG REQUIREMENTS_BASE_FOLDER=.

WORKDIR /app/

# Install your requirements from a requirements.txt file (support for poetry, pipenv should also be included at some point)
RUN pip install -r ${REQUIREMENTS_BASE_FOLDER}/requirements.txt


RUN yes yes | python manage.py collectstatic

ENTRYPOINT \
    "sh -c\ 
    python manage.py migrate &&\
    gunicorn --access-logfile /var/log/app/logfile $(ls */wsgi.py | cut -d / -f 1).wsgi:application --bind :8000"