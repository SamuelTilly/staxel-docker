# staxel-docker

Docker image for dedicated staxel server

# Setup server data

Run image with `STEAM_ACCOUNT` and `STEAM_PASSWORD`environment variables set will use
steamcmd to install staxel files into `/home/steam/staxel-dedicated`, this will not start the server,
only download/update the game files.

If you are using steam guard you will be requested to enter a steam guard code so it's recommended to
run docker using `-it` to interact with steamcmd when this pops up.

example:

```console
$ docker run -it \
    -e STEAM_ACCOUNT=%STEAM_USERNAME% \
    -e STEAM_PASSWORD=%STEAM_PASSWORD% \
    -v $PWD/data:/home/steam/staxel-dedicated \
    staxel_staxel:latest
```

# Start server

```console
$ docker run -it \
    -p "38465:38465"
    -e PASSWORD=CHANGE_ME \
    -v $PWD/data:/home/steam/staxel-dedicated \
    staxel_staxel:latest
```

## Avaliable options

| option          | default value |
| --------------- | ------------- |
| CREATIVE        | "false"       |
| NAME            | "myFarm"      |
| PASSWORD        | "potato"      |
| PLAYERLIMIT     | 8             |
| PORT            | 38465         |
| PUBLIC          | "false"       |
| STORAGE         | "myFarm"      |
| UPNP            | "false"       |
| ADDITIONAL_ARGS | ""            |

## Docker compose example

```yaml
version: "3"

services:
  staxel:
    build: ${PWD}/build
    ports:
      - "38465:38465"
    environment:
      PASSWORD: carrot
      PLAYERLIMIT: 14
    volumes:
      - ${PWD}/data:/home/steam/staxel-dedicated
```
