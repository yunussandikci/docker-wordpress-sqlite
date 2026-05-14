ARG TAG=apache
FROM wordpress:${TAG}
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
ENV WORDPRESS_SOURCE_DIR="/usr/src/wordpress"
ENV WORDPRESS_TARGET_DIR="/var/www/html"
ENV SQLITE_DIR="${WORDPRESS_SOURCE_DIR}/wp-content/mu-plugins/sqlite-database-integration"

# Install the latest version of sqlite-database-integration
RUN if command -v apk >/dev/null 2>&1; then \
        apk add --no-cache unzip; \
    else \
        apt-get update && apt-get install -y --no-install-recommends unzip && rm -rf /var/lib/apt/lists/*; \
    fi && \
    VERSION=$(curl -sI "https://github.com/WordPress/sqlite-database-integration/releases/latest" | grep -i '^location' | awk -F'/' '{print $NF}' | tr -d '\r\n') && \
    curl -sL "https://github.com/WordPress/sqlite-database-integration/releases/download/${VERSION}/plugin-sqlite-database-integration.zip" -o /tmp/sq.zip && \
    unzip -o /tmp/sq.zip -d "${WORDPRESS_SOURCE_DIR}/wp-content/mu-plugins" && \
    mv "${WORDPRESS_SOURCE_DIR}/wp-content/mu-plugins/plugin-sqlite-database-integration" "${SQLITE_DIR}" && \
    rm -f /tmp/sq.zip

# Configure sqlite-database-integration
RUN mv "${SQLITE_DIR}/db.copy" "${WORDPRESS_SOURCE_DIR}/wp-content/db.php" && \
    sed -i "s#{SQLITE_IMPLEMENTATION_FOLDER_PATH}#${WORDPRESS_TARGET_DIR}/wp-content/mu-plugins/sqlite-database-integration#" "${WORDPRESS_SOURCE_DIR}/wp-content/db.php" && \
    sed -i "s#{SQLITE_PLUGIN}#${WORDPRESS_TARGET_DIR}/wp-content/mu-plugins/sqlite-database-integration/load.php#" "${WORDPRESS_SOURCE_DIR}/wp-content/db.php" && \
    sed -i "s#<?php#<?php\ndefine( 'WP_SQLITE_AST_DRIVER', true );#" "${WORDPRESS_SOURCE_DIR}/wp-content/db.php"
