FROM nginx:alpine

RUN apt install curl -y

# Installing apache and write Hello world! message
#COPY ./src/ /usr/share/nginx/html/

HEALTHCHECK --interval=10s --timeout=3s CMD curl --fail http://localhost:80 || exit 1

EXPOSE 80
