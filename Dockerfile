FROM ubuntu:16.04

# Installng dependencies
RUN apt-get update && apt-get -y upgrade && DEBIAN_FRONTEND=noninteractive apt-get -y install apt-utils apache2
RUN apt-get autoclean

# Installing apache and write Hello world! message
RUN echo "Hello World!" > /var/www/html/index.html

# Setting apache environment
RUN a2enmod rewrite
RUN chown -R www-data:www-data /var/www
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

EXPOSE 80

CMD /usr/sbin/apache2ctl -D FOREGROUND
