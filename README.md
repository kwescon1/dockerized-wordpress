# Local WordPress Development with Docker

Easily set up a local development environment for WordPress with Docker, leveraging Nginx, MySQL, and HTTPS support.

## **Prerequisites**

- Docker
- Docker-compose
- [mkcert](https://github.com/FiloSottile/mkcert) (For HTTPS support)

## **Setup Steps**

### 1. **Clone the Project**

```bash
git clone [repo_url] [optional_directory_name]
cd [directory_name_or_optional_directory_name]
```

### 2. **Install & Configure `mkcert`**

Ensure `mkcert` is installed for generating locally-trusted certificates. If not:

- [Install mkcert](https://github.com/FiloSottile/mkcert)

Once installed, while in the project root directory:

```bash
mkdir -p docker-files/nginx/certs && cd docker-files/nginx/certs
mkcert localhost
```

This generates `localhost.pem` and `localhost-key.pem` for Nginx, enabling HTTPS.

### 3. **Setup Configuration File**

```bash
cd [project_root_directory]
cp .env.example .env
```

### 4. **Modify Configuration**

Edit the `.env` file and set:

```dotenv
DB_DATABASE=your_db_name
DB_USERNAME=your_db_username
DB_PASSWORD=your_db_password
```

### 5. **Build and Start Containers**

First, build the containers:

```bash
docker-compose build --no-cache
```

Then, start the services:

```bash
docker-compose up -d
```

### 6. **Access Your WordPress Site**

- **Secure Connection (HTTPS)**: [https://localhost:7010](https://localhost:7010)

- **Regular Connection (HTTP)**: [http://localhost:7009](http://localhost:7009)

## **Database Management**

Use Adminer at [DB Management Interface](http://localhost:7011) with:

- System: MySQL
- Server: mysql
- Username: `your_db_username`
- Password: `your_db_password`
- Database: `your_db_name`

## **Useful Commands**

- **Start**: `docker-compose up -d`
- **Stop**: `docker-compose down`
- **Logs**: `docker-compose logs` (Add service name for specific logs, e.g., `docker-compose logs php`)

## **Troubleshooting**

For issues, refer to the logs via `docker-compose logs`. Ensure that ports in the `.env` and `docker-compose.yml` are available on your machine.

## **Contributing**

Contributions are welcome! Fork this repository and submit pull requests.

## **License**

This project uses the [MIT License](LICENSE).
