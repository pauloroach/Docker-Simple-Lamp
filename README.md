# Docker-Simple-Lamp

This setup is great for writing quick apps in PHP from an OSX machine. It uses apache with custom installation. Exposes to por 80

### Install Docker
[Download Docker](https://www.docker.com/products/overview)

### Build & Run!

```
docker-compose up -d
```
you can now start writing your app!

### Stop

```
docker-compose kill
```

### MySQL

Check out `app/index.php` for getting credentials from the ENV variables.