# Easy Docker

An easy way to maintain PHP version with some essential config like as virtual Host, Mysql, Redis and more. It's only for localhost :)

Note: This package is forked from [rinkurock/easy-docker](https://github.com/rinkurock/easy-docker) package; thanks to the author of that package.

## Features

* Virtual Host with nginx
* PHP FPM
* PHP version 5.5.34, 5.6, 7.0, 7.1, 7.1.3, 7.2, 7.3.22, 7.4.13, 8.1.0 etc
* MySql 5.7, 8.0.19
* Postgres
* Adminer
* Redis
* Mongo
* Consul
* RabbitMq
* Elastic Search
* Kibana

## Getting started

1. Clone the `easy-docker` github repository

    ```bash
    git clone https://github.com/sarahman/easy-docker ~/easy-docker
    ```

1. Go to `easy-docker` directory

    ```bash
    cd ~/easy-docker
    ```

1. Copy `.env.example` to `.env`

    ```bash
    cp .env.example .env
    ```

1. Copy `docker-compose.yml.example` to `docker-compose.yml`

    ```bash
    cp docker-compose.yml.example docker-compose.yml
    ```

1. Edit `APPLICATION=/your-root-project-directory` & database setting on `.env` file

    ```bash
    nano .env
    ```

1. Run `docker-compose`

    ```bash
    docker-compose up -d
    ```

1. Go to <http://localhost:9999> on browser

## Setup Virtual Host for project

Run:

```bash
sudo ./v-host.sh
```

and follow the instructions on command line

* sudo for only adding local domain address on `/etc/hosts` file on your system.

You can check it by run:

```bash
cat /etc/hosts
```

Run:

```bash
docker-compose ps
```

## Accessing Globally

Sometimes you may want to `docker-compose` up your `easy-docker` machine from anywhere on your filesystem. You can do this on Unix systems by adding a Bash function to your Bash profile. These scripts will allow you to run any `docker-compose` command from anywhere on your system and will automatically point that command to your `easy-docker` installation:

```bash
function easydocker() {
    ( cd ~/easy-docker && docker-compose $* )
}
```

## Miscellaneous

### Setup ZSH Terminal For Better Terminal

[https://ohmyz.sh/](https://ohmyz.sh/) is used for the better terminal experience. [This link](https://vitux.com/ubuntu-zsh-shell) can be used to install the zsh terminal or can follow the following commands:

```bash
easydocker exec php bash
apt-get update && apt-get dist-upgrade -y
apt-get install -y build-essential curl file fonts-powerline git git-core zsh
dpkg-reconfigure dash
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git config --global oh-my-zsh.hide-status 1
git config --global oh-my-zsh.hide-dirty 1
exit
easydocker exec php zsh
```

## Contribution

All issues, PRs and advices are more than welcome to discuss about. :)

## License

MIT
