# Docker image for launch a server of yugioh-game

This image gives  to you a easy method to create an instanse of a [yugioh game server ](https://github.com/tspivey/yugioh-game.git)) an awesome text based server (powered by [ygopro core](https://github.com/Fluorohydride/ygopro-core.git)) to play yu-gi-oh in accessible method, using any mush client, telnet client, or the [web based client](https://allinaccess.com/game/)

## How to build

For the most simple usage, simply do this command in your command line:
```bash
docker build -t ygo .
```

## Run a basic server

For the most simple excecution, do this
```bash
docker run -p 4000:4000 ygo
```

Remember, this is a volatile excecution; after you stop the container (or it stoped automatically for any reason) all content on the local database will be lost

## Run with a persistant database

The server stores all information in a sqlite file named game.db on the /ygo folder, so, if you want keep the information on any excecution of the image, simply touch a game.db in any folder of your host, and mount it on the corresponding location. Example:

```bash
touch game.db
docker run -p 4000:4000 $PWD/game.db:/ygo/game.db ygo
```

_ note _ Only do the touch command in the first run of the image; after that the file will exist so you dont need create it again.

## Load more cards.cdb files

_ alert! _ This part is a work in progress

For default, this image gets the cards.cdb file only for the English Languaje, and is gets automatically from [this repository of the duelist-unite team](https://gitlab.com/duelists-unite/cdb), but you can load any other cdb file to fill the other languajes.
For that, you have to:

1. create a new folder named cdb
2. put on that folder all the cdb files that you want to add.
3. change the name of the default cdb of any languaje to the small write of that languaje. For example, if you add the cards.cdb for spanish, change its name to es.cdb
4. if you add more than one cdb per languaje, only the main cdb for that languaje must be named xx.cdb. the others can have any name, but with the languaje as a sufix with an extra _. Example: en_extra.cdb
5. when you run the image, mount the cdb folder at /ygo/cdb. example
```bash
docker run -p 4000:4000 -v $PWD/cdb:/ygo/cdb ygo
```


# extra notes

Don't use this image with more than one replica

All commands are considering that you are excecuting them from a linux terminal; if you are in windows, replase $PWD for %CD%

# credits.

A lot of thanks to Tspivey to create this awesome project. Without him, the blind people cant enjoy any digital adaptation of the yu-gi-oh TCG. Great work, crack!

Thanks to all people that works in any project that is part of the ygoPro ecosystem. These people creates an awesome engine that lets us play yu-gi-oh digitally. 

