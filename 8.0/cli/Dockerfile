FROM php:8.0-cli

LABEL \
	name="PHP 8.0 CLI" \
	image="jointly/php" \
	tag="8.0-cli" \
	vendor="jointly"

# Get repository and install wget and vim
RUN apt-get update && apt-get install --no-install-recommends -y \
        gnupg \
        wget \
        vim \
        git \
        unzip \
        && rm -rf /var/lib/apt/lists/*

# Add PostgreSQL repository
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
      apt-key add -

# Install PHP extensions deps
RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        libpq-dev \
        libpq5 \
        postgresql-server-dev-9.5 \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libmagickwand-dev \
        libpng-dev \
        libjpeg-dev \
        zlib1g-dev \
        libicu-dev \
        libtidy-dev \
        libxml2-dev \
        g++ \
        unixodbc-dev \
        libxml2-dev \
        libaio-dev \
        libmemcached-dev \
        freetds-dev \
	    libssl-dev \
        libzip-dev \
        libonig-dev \
        openssl \
        openssh-client \
	    && rm -rf /var/lib/apt/lists/*

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- \
        --install-dir=/usr/local/bin \
        --filename=composer

# Install PHP extensions
RUN docker-php-ext-configure gd --enable-gd --with-jpeg \
    && docker-php-ext-configure pdo_dblib --with-libdir=/lib/x86_64-linux-gnu \
    && pecl install redis \
    && pecl install memcached \
    && pecl install xdebug \
    && docker-php-ext-install \
            bcmath \
            dom \
            iconv \
            mbstring \
            intl \
            gd \
            pgsql \
            mysqli \
            pdo_pgsql \
            pdo_mysql \
            pdo_dblib \
            soap \
            sockets \
            zip \
            pcntl \
            ftp \
            tidy \
            tokenizer \
            xml \
    && docker-php-ext-enable \
            redis \
            memcached \
            opcache \
            xdebug \
            zip

# install imagick
# use github version for now until release from https://pecl.php.net/get/imagick is ready for PHP 8
RUN mkdir -p /usr/src/php/ext/imagick; \
    curl -fsSL https://github.com/Imagick/imagick/archive/06116aa24b76edaf6b1693198f79e6c295eda8a9.tar.gz | tar xvz -C "/usr/src/php/ext/imagick" --strip 1; \
    docker-php-ext-install imagick

# Install PHPUnit
RUN curl -sS https://phar.phpunit.de/phpunit.phar -o /usr/local/bin/phpunit \
    && chmod +x /usr/local/bin/phpunit

# Install PHP Code Sniffer
RUN curl -sS https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar -o /usr/local/bin/phpcs \
    && chmod +x /usr/local/bin/phpcs

RUN curl -sS https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar -o /usr/local/bin/phpcbf \
    && chmod +x /usr/local/bin/phpcbf

# Envoy
RUN composer global require "laravel/envoy"

# Clean repository
RUN apt-get clean && composer global clear-cache