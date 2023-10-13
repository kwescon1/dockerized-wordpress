# Local WordPress Development with Docker

Easily set up a local development environment for WordPress with Docker, leveraging Nginx, MySQL, and HTTPS support.

## Prerequisites

- Docker
- Docker-compose
- [mkcert](https://github.com/FiloSottile/mkcert) (For HTTPS support)

## Setup Steps

### 1. Clone the Project

```bash
git clone [repo_url] [optional_directory_name]
cd [directory_name_or_optional_directory_name]
```

### 2. Make Entrypoint Script Executable

Before proceeding, ensure the `entrypoint.sh` script is executable:

```bash
chmod +x docker-files/php/entrypoint.sh
```

### 3. Install & Configure `mkcert`

If `mkcert` isn't installed, it's essential for generating locally-trusted certificates:

- [Install mkcert](https://github.com/FiloSottile/mkcert)

Once installed, generate certificates for Nginx to enable HTTPS:

```bash
mkdir -p docker-files/nginx/certs && cd docker-files/nginx/certs
mkcert localhost
```

This process results in the creation of `localhost.pem` and `localhost-key.pem`.

### 4. Setup Configuration File

From the project root directory:

```bash
cp .env.example .env
```

### 5. Modify Configuration

Edit the `.env` file to configure your database:

```dotenv
DB_DATABASE=your_db_name
DB_USERNAME=your_db_username
DB_PASSWORD=your_db_password
```

### 6. Build and Start Containers

Firstly, build the containers:

```bash
docker-compose build --no-cache
```

Subsequently, initiate the services:

```bash
docker-compose up -d
```

### 7. Access Your WordPress Site

- **Secure Connection (HTTPS)**: [https://localhost:7010](https://localhost:7010)
- **Regular Connection (HTTP)**: [http://localhost:7009](http://localhost:7009)

## Database Management

For database management, utilize Adminer available at [DB Management Interface](http://localhost:7011) and log in with:

- System: MySQL
- Server: mysql
- Username: `your_db_username`
- Password: `your_db_password`
- Database: `your_db_name`

## Useful Commands

- **Start Services**: `docker-compose up -d`
- **Stop Services**: `docker-compose down`
- **Check Logs**: `docker-compose logs` (For specific logs, append service name, e.g., `docker-compose logs php`)

## Troubleshooting

If problems arise, examine the logs through `docker-compose logs`. Additionally, verify that the ports detailed in the `.env` and `docker-compose.yml` files are available on your machine.

## Contributing

Contributions are greatly appreciated! Please fork this repository and offer pull requests.

## License

This project is licensed under the [MIT License](LICENSE.txt).
