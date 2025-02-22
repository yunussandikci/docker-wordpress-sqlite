ARG TAG=apache
FROM wordpress:${TAG}

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
ENV WORDPRESS_SOURCE_DIR="/usr/src/wordpress"
ENV WORDPRESS_TARGET_DIR="/var/www/html"

# Install the latest version of sqlite-database-integration
RUN export SQLITE_PLUGIN_VERSION=$(curl -sI "https://github.com/WordPress/sqlite-database-integration/releases/latest" | grep -i location | awk -F'/' '{print $NF}' | tr -d '\r') && \
    mkdir -p ${WORDPRESS_SOURCE_DIR}/wp-content/mu-plugins/sqlite-database-integration && \
    curl -L "https://github.com/WordPress/sqlite-database-integration/archive/refs/tags/${SQLITE_PLUGIN_VERSION}.tar.gz" | \
    tar xz --strip-components=1 -C ${WORDPRESS_SOURCE_DIR}/wp-content/mu-plugins/sqlite-database-integration

# Configure sqlite-database-integration
RUN mv "${WORDPRESS_SOURCE_DIR}/wp-content/mu-plugins/sqlite-database-integration/db.copy" "${WORDPRESS_SOURCE_DIR}/wp-content/db.php" && \
    sed -i "s#{SQLITE_IMPLEMENTATION_FOLDER_PATH}#${WORDPRESS_TARGET_DIR}/wp-content/mu-plugins/sqlite-database-integration#" "${WORDPRESS_SOURCE_DIR}/wp-content/db.php" && \
    sed -i "s#{SQLITE_PLUGIN}#${WORDPRESS_TARGET_DIR}/wp-content/mu-plugins/sqlite-database-integration/load.php#" "${WORDPRESS_SOURCE_DIR}/wp-content/db.php"
