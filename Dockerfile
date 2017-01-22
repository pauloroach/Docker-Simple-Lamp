FROM ubuntu:14.04
MAINTAINER  Paulo Guevara "paulo.guevara@gmail.com"

# Configure Locale
RUN export LANGUAGE=en_US.UTF-8 && \
	export LANG=en_US.UTF-8 && \
	export LC_ALL=en_US.UTF-8 && \
	locale-gen en_US.UTF-8 && \
	DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales

# Install dependencies
RUN apt-get update -y
RUN apt-get install -y git curl apache2 apache2-mpm-prefork apache2-utils libexpat1 ssl-cert php5-redis libapache2-mod-php5 php5 php5-common php-apc php5-curl php5-dev php5-gd php5-imagick php5-mcrypt php5-memcache php5-memcached php5-mhash php5-mysql php5-pspell php5-snmp php5-sqlite php5-xmlrpc php5-xsl build-essential tcl8.5
RUN php5enmod mcrypt

# Setup Composer
RUN curl -sS https://getcomposer.org/installer | php && \
	mv composer.phar /usr/local/bin/composer

# Install app
RUN rm -rf /var/www/*
VOLUME ["/var/www"]
#ADD content /var/www/web/

# Configure apache
RUN a2enmod rewrite
RUN chown -R www-data:www-data /var/www
RUN echo "ServerName dockerlamp" >> /etc/apache2/apache2.conf

# Remove default site
RUN rm /etc/apache2/sites-available/000-default.conf
RUN rm -Rf /etc/apache2/sites-enabled/000-default.conf
#RUN rm /etc/apache2/sites-available/default-ssl.conf

# Add custom default site
COPY ./apache/dockerlamp.conf /etc/apache2/sites-available/dockerlamp.conf
RUN ln -s /etc/apache2/sites-available/dockerlamp.conf /etc/apache2/sites-enabled/

# Set Apache environment variables (can be changed on docker run with -e)
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_SERVERADMIN admin@localhost
ENV APACHE_SERVERNAME www.dockerlamp.com
ENV APACHE_SERVERALIAS www.local.dockerlamp.com
ENV APACHE_DOCUMENTROOT /var/www/web/content

EXPOSE 80

#ADD start.sh /start.sh
#RUN chmod 0755 /start.sh
#CMD ["bash", "start.sh"]

CMD ["/usr/sbin/apache2", "-D",  "FOREGROUND"]
