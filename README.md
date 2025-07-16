# WordPress Docker Images with SQLite Support
> Always up-to-date WordPress Docker images with built-in SQLite support simply. <br>

[![License: GPL v2](https://img.shields.io/badge/License-GPL_v2-blue.svg)](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)
[![Multi-Architecture Support](https://img.shields.io/badge/arch-linux%2Famd64-green)](https://github.com/yunussandikci/docker-wordpress-sqlite/pkgs/container/wordpress-sqlite)
[![Multi-Architecture Support](https://img.shields.io/badge/arch-linux%2Farm%2Fv7-green)](https://github.com/yunussandikci/docker-wordpress-sqlite/pkgs/container/wordpress-sqlite)
[![Multi-Architecture Support](https://img.shields.io/badge/arch-linux%2Farm%2Fv8-green)](https://github.com/yunussandikci/docker-wordpress-sqlite/pkgs/container/wordpress-sqlite)

TL;DR 
```
docker run -d -p 8080:80 ghcr.io/yunussandikci/wordpress-sqlite:6.8.2-php8.4-apache
```

This repository provides always up-to-date WordPress Docker images with SQLite support, making it the best choice for quick development, testing, and small-scale deployments. [Check all available docker images!](https://github.com/yunussandikci/docker-wordpress-sqlite/pkgs/container/wordpress-sqlite/versions)

<img src="https://github.com/user-attachments/assets/79f287b9-ef4d-4b12-b9a6-fbb5152d5517"  width="600"/>

## ✨ Features 

- **SQLite Integration**: WordPress is pre-configured to use SQLite as the database, thanks to the [SQLite Database Integration Plugin](https://github.com/WordPress/sqlite-database-integration). No extra setup required!
- **Automated Builds**: Docker images are automatically built and pushed to the GitHub Container Registry (`ghcr.io`) whenever new WordPress tags are released.
- **Multi-Architecture Support**: Images are built for multiple architectures ensuring compatibility across a wide range of systems.
  - `linux/amd64`, `linux/arm/v7`, `linux/arm64/v8` 
- **Minimalistic**: Only WordPress and the SQLite plugin are included—nothing extra. Lightweight and efficient!

## 🚀 Usage
To run the container, use the following command:

```bash
docker run -d -p 8080:80 ghcr.io/yunussandikci/wordpress-sqlite:6.8.2-php8.4-apache
```

This will start a WordPress instance with SQLite as the database, accessible at `http://localhost:8080`.

## 🏷️ Available Tags

The available tags correspond to the official WordPress Docker tags. You can find the list of supported tags in the [tags.txt](tags.txt) file.

## 🤝 Contributing 

We welcome contributions! If you'd like to contribute, please follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bugfix.
3. Make your changes and commit them with a clear commit message.
4. Push your changes to your fork.
5. Submit a pull request to the `main` branch of this repository.

Please ensure your code follows the existing style and includes appropriate tests if applicable.

## 🙏 Acknowledgments 

- [WordPress](https://wordpress.org/) for the amazing CMS.
- [SQLite Database Integration Plugin](https://github.com/WordPress/sqlite-database-integration) for enabling SQLite support in WordPress.

## ❤️ Support ❤️

If you encounter any issues or have questions, please open an issue in the [GitHub repository](https://github.com/yunussandikci/wordpress-sqlite/issues).

## 📄 License 

This project is licensed under the GPL-2.0 License. See the [LICENSE](LICENSE) file for details.
