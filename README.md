# Django Base Docker Deployment

This repo aims to create a base for most common django projects to be deployed through Docker

## Usage
```bash
git clone --depth=1 https://github.com/etherbeing/django_base_docker_deployment ./deploy
docker-compose --env-file ./.env --file deploy/docker-compose.yml up --project-name=yourprojectname -d 
```

## Env File
```.env
NAME=Your project name
DJANGO_SUPERUSER_PASSWORD=mysecurepassword
USERNAME=mysecureusername
STATICFILES_PATH=/app/static/
MEDIA_PATH=/app/media/
```
