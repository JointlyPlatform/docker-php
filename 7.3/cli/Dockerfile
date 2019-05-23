FROM php:7.3-cli

LABEL \
	name="PHP 7.3 CLI" \
	image="mattiabasone/php" \
	tag="7.3-cli" \
	vendor="mattiabasone"

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
        libpng-dev \
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
        openssl \
	    && rm -rf /var/lib/apt/lists/*

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- \
        --install-dir=/usr/local/bin \
        --filename=composer

# Install PHP extensions
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
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

# Install APCu and APC backward compatibility
RUN pecl install apcu \
    && pecl install apcu_bc-1.0.3 \
    && docker-php-ext-enable apcu --ini-name 10-docker-php-ext-apcu.ini \
    && docker-php-ext-enable apc --ini-name 20-docker-php-ext-apc.ini

# Install PHPUnit
RUN curl -sS https://phar.phpunit.de/phpunit.phar -o /usr/local/bin/phpunit \
    && chmod +x /usr/local/bin/phpunit

# Install PHP Code Sniffer
RUN curl -sS https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar -o /usr/local/bin/phpcs \
    && chmod +x /usr/local/bin/phpcs

RUN curl -sS https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar -o /usr/local/bin/phpcbf \
    && chmod +x /usr/local/bin/phpcbf

# Clean repository
RUN apt-get clean