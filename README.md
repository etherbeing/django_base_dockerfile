# Django Base Docker Deployment

This repo aims to create a base for most common django projects to be deployed through Docker

## Usage
```bash
git clone --depth=1 https://github.com/etherbeing/django_base_docker_deployment ./deploy
NAME=my_project TAG=1.0.0 docker-compose --file deploy/docker-compose.yml --project-name $NAME up -d 
```