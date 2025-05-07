# Django Base Docker Deployment

This repo aims to create a base for most common django projects to be deployed through Docker

## Usage
```bash
git clone --depth=1 https://github.com/etherbeing/django_base_docker_deployment ./deploy
docker compose --env-file ./.env --file deploy/docker-compose.yml --project-name=yourprojectname up -d --build 
```

## Env File
```.env
NAME=Your project name
DJANGO_SUPERUSER_PASSWORD=mysecurepassword
USERNAME=mysecureusername
EMAIL=myemail@email.com
STATICFILES_PATH=/app/static/
MEDIA_PATH=/app/media/
```
## Reading Logs

```bash
docker compose --env-file=./.env --file=deploy/docker-compose.yml --project-name yourprojectname logs -f
```

## Opening a Shell

```bash
docker compose --env-file=./.env --file=deploy/docker-compose.yml --project-name yourprojectname exec -it django_app ash
```