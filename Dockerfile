FROM nginx:alpine

# Installing apache and write Hello world! message
COPY ./src/ /usr/share/nginx/html/

EXPOSE 80
