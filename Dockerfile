ARG TAG=apache

# Prepare sqlite-database-integration natively on the build platform, so the WordPress stage only copies files (no extra packages, no emulated RUN)
FROM --platform=$BUILDPLATFORM alpine:3.22 AS sqlite
SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN apk add --no-cache curl unzip

# Download the latest version of sqlite-database-integration
RUN VERSION=$(curl -fsSI "https://github.com/WordPress/sqlite-database-integration/releases/latest" | grep -i '^location' | awk -F'/' '{print $NF}' | tr -d '\r\n') && \
    curl -fsSL "https://github.com/WordPress/sqlite-database-integration/releases/download/${VERSION}/plugin-sqlite-database-integration.zip" -o /tmp/sq.zip && \
    unzip -q /tmp/sq.zip -d /tmp && \
    mkdir -p /wp-content/mu-plugins && \
    mv /tmp/plugin-sqlite-database-integration /wp-content/mu-plugins/sqlite-database-integration

# Configure the db.php drop-in, and load the plugin since WordPress only loads PHP files placed directly in mu-plugins
RUN sed -e "s#{SQLITE_IMPLEMENTATION_FOLDER_PATH}#/var/www/html/wp-content/mu-plugins/sqlite-database-integration#" \
        -e "s#{SQLITE_PLUGIN}#sqlite-database-integration/load.php#" \
        /wp-content/mu-plugins/sqlite-database-integration/db.copy > /wp-content/db.php && \
    printf '%s\n' '<?php' "require_once __DIR__ . '/sqlite-database-integration/load.php';" > /wp-content/mu-plugins/sqlite-database-integration.php

FROM wordpress:${TAG}
# Any WORDPRESS_* variable makes the upstream entrypoint generate wp-config.php (with random salts) on first start, so the image runs without configuration
ENV WORDPRESS_SOURCE_DIR="/usr/src/wordpress"
ENV WORDPRESS_TARGET_DIR="/var/www/html"
COPY --from=sqlite --chown=www-data:www-data /wp-content/ ${WORDPRESS_SOURCE_DIR}/wp-content/
