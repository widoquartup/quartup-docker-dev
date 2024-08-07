# Use an official PHP image
FROM php:7.2-apache

# Set build arguments
ARG HTTP_PORT
ARG DEBUG_PORT

# Set environment variables
ENV HTTP_PORT=${HTTP_PORT}
ENV DEBUG_PORT=${DEBUG_PORT}

# Instalar dependencias
# Install dependencies
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    libicu-dev \
    g++ \
    libmagickwand-dev \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Instalar extensiones de PHP
RUN docker-php-ext-install pdo pdo_mysql mysqli zip bcmath

# Instalar Xdebug
RUN pecl channel-update pecl.php.net
RUN pecl install imagick && \
    docker-php-ext-enable imagick

RUN pecl install xdebug-2.9.8

RUN docker-php-ext-enable xdebug

# Crear directorio /app
RUN mkdir -p /app

# Crear usuario y grupo www-data

# Establecer permisos
RUN chown -R www-data:www-data /app

# Configurar Apache
RUN echo "Listen ${HTTP_PORT}" > /etc/apache2/ports.conf
RUN echo "<VirtualHost *:${HTTP_PORT}>" > /etc/apache2/sites-available/000-default.conf
RUN echo "    DocumentRoot /app" >> /etc/apache2/sites-available/000-default.conf
RUN echo "    <Directory /app>" >> /etc/apache2/sites-available/000-default.conf
RUN echo "        Options FollowSymLinks" >> /etc/apache2/sites-available/000-default.conf
RUN echo "        AllowOverride All" >> /etc/apache2/sites-available/000-default.conf
RUN echo "        Require all granted" >> /etc/apache2/sites-available/000-default.conf
RUN echo "    </Directory>" >> /etc/apache2/sites-available/000-default.conf
RUN echo "</VirtualHost>" >> /etc/apache2/sites-available/000-default.conf

RUN a2enmod rewrite
RUN a2ensite 000-default.conf
# Start Apache service
RUN chmod 0775 /app

COPY ./90-quartup.ini /usr/local/etc/php/conf.d/

# Expose ports
EXPOSE ${HTTP_PORT} ${DEBUG_PORT}
