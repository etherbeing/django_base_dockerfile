FROM python:3-alpine

RUN apk add gettext
# Install a WSGI server to serve our files, later this should also include daphne to serve ASGI in case is needed with a conditional script based on a build argument
RUN pip install gunicorn

COPY ./deploy/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

COPY ./ /app/

# This is at this place to make this instruction not to invalid the previous one 
ARG REQUIREMENTS_BASE_FOLDER=.

WORKDIR /app/

# Install your requirements from a requirements.txt file (support for poetry, pipenv should also be included at some point)
RUN pip install -r ${REQUIREMENTS_BASE_FOLDER}/requirements.txt

RUN yes yes | python manage.py collectstatic

RUN python manage.py compilemessages

ENTRYPOINT ["sh", "-c", "/entrypoint.sh"]