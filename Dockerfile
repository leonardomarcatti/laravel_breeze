FROM dunglas/frankenphp

WORKDIR /app


# Dependências do sistema
RUN apt-get update &&  apt upgrade -y && apt-get install -y \
    libjpeg-dev \
    libpng-dev \
    git \
    unzip \
    netcat-openbsd \
    net-tools \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/*

# Extensões PHP necessárias
RUN install-php-extensions \
    pdo_mysql \
    gd \
    intl \
    zip \
    opcache \
    exif \
    pcntl

# Instala Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copia o código da aplicação
COPY . /app

COPY start.sh /start.sh

# Instala todas as dependências (dev incluídas)
RUN composer install && composer require laravel/octane

# Porta interna do container

EXPOSE 80

ENTRYPOINT ["/start.sh"]
