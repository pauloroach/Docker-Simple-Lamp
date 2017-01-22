# Docker-Simple-Lamp

This setup is great for writing quick apps in PHP from an OSX machine. It uses apache with custom installation. Exposes to por 80

### Install Docker
[Download Docker](https://www.docker.com/products/overview)

### Build & Run!

```
docker-compose up -d
```

### Visit your local!

```
http://localhost/
```


you can now start writing your app!

### Stop

```
docker-compose kill
```

### MySQL

Check out `docker-compose.yml` for getting credentials from the ENV variables.

### Notes

If at running docker-compose up it displays "unauthorized: incorrect username or password" you must create an account at docker hub and after creating the user you need to issue the command docker login with your credentials