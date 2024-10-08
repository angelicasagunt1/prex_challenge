# Dockerfile

# Utiliza la imagen oficial de PHP con FPM
FROM php:8.1-fpm

# Instala las dependencias necesarias para Symfony
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libicu-dev \
    libpq-dev \
    libzip-dev \
    libonig-dev \
    libjpeg-dev \
    libpng-dev \
    libfreetype6-dev \
    && docker-php-ext-install intl pdo pdo_pgsql pdo_mysql zip gd

# Instala Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Establece el directorio de trabajo
WORKDIR /var/www/symfony

# Copia los archivos del proyecto
COPY . .

# Da los permisos necesarios
RUN chown -R www-data:www-data /var/www/symfony

# Expone el puerto que usará PHP-FPM
EXPOSE 9000

# Comando por defecto al iniciar el contenedor
CMD ["php-fpm"]
