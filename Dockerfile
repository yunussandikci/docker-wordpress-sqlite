ARG TAG=apache
FROM wordpress:${TAG}
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
ENV WORDPRESS_SOURCE_DIR="/usr/src/wordpress"
ENV WORDPRESS_TARGET_DIR="/var/www/html"
ENV SQLITE_DIR="${WORDPRESS_SOURCE_DIR}/wp-content/mu-plugins/sqlite-database-integration"

# Install the latest version of sqlite-database-integration
RUN apt-get update && apt-get install -y --no-install-recommends unzip jq && rm -rf /var/lib/apt/lists/* && \
    URL=$(curl -s https://api.github.com/repos/WordPress/sqlite-database-integration/releases/latest \
        | jq -r '.assets[] | select(.name | endswith(".zip")) | .browser_download_url' | head -1) && \
    curl -sL "$URL" -o /tmp/sq.zip && \
    unzip -o /tmp/sq.zip -d "${WORDPRESS_SOURCE_DIR}/wp-content/mu-plugins" && \
    mv "${WORDPRESS_SOURCE_DIR}/wp-content/mu-plugins/plugin-sqlite-database-integration" "${SQLITE_DIR}" && \
    rm -f /tmp/sq.zip

# Configure sqlite-database-integration
RUN mv "${SQLITE_DIR}/db.copy" "${WORDPRESS_SOURCE_DIR}/wp-content/db.php" && \
    sed -i "s#{SQLITE_IMPLEMENTATION_FOLDER_PATH}#${WORDPRESS_TARGET_DIR}/wp-content/mu-plugins/sqlite-database-integration#" "${WORDPRESS_SOURCE_DIR}/wp-content/db.php" && \
    sed -i "s#{SQLITE_PLUGIN}#${WORDPRESS_TARGET_DIR}/wp-content/mu-plugins/sqlite-database-integration/load.php#" "${WORDPRESS_SOURCE_DIR}/wp-content/db.php" && \
    sed -i "s#<?php#<?php\ndefine( 'WP_SQLITE_AST_DRIVER', true );#" "${WORDPRESS_SOURCE_DIR}/wp-content/db.php"
