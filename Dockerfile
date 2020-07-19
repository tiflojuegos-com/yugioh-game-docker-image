FROM alpine as intermediate

RUN apk --update --no-cache add \
    make git wget python3 python3-dev openssl-dev g++ libffi-dev libxml2-dev libxslt-dev readline-dev patch 

ENV ERR_USER ygo 

RUN mkdir /ygo && addgroup -g 1000 -S $ERR_USER && adduser -u 1000 -D -S -G $ERR_USER -h /ygo $ERR_USER && cd /ygo && chown -R $ERR_USER:$ERR_USER /ygo
USER $ERR_USER
WORKDIR /ygo

RUN git clone https://github.com/tspivey/yugioh-game.git &&\
git clone https://github.com/Fluorohydride/ygopro-core.git &&\
git clone https://github.com/Fluorohydride/ygopro-scripts &&\
git clone https://gitlab.com/duelists-unite/cdb

# install lua
RUN wget https://www.lua.org/ftp/lua-5.3.5.tar.gz &&\
tar xf lua-5.3.5.tar.gz &&\
cd lua-5.3.5 &&\
make linux CC=g++ CFLAGS='-O2 -fPIC'

RUN cd ~/yugioh-game && python3 -m venv venv && source venv/bin/activate && pip3 install --upgrade pip setuptools && \
    pip3 install --no-cache-dir -r ./requirements.txt

RUN cd ~/ygopro-core && patch -p0 < ../yugioh-game/etc/ygopro-core.patch && g++ -shared -fPIC -o ../yugioh-game/libygo.so *.cpp -I$HOME/lua-5.3.5/src -L$HOME/lua-5.3.5/src -llua -std=c++14 && cd ../yugioh-game && source venv/bin/activate && python3 duel_build.py

WORKDIR /ygo/yugioh-game
RUN source venv/bin/activate && /bin/sh ./compile.sh es && /bin/sh ./compile.sh fr && /bin/sh ./compile.sh de && /bin/sh ./compile.sh pt &&\
mv ~/cdb/cards.cdb ./locale/en/

FROM alpine
MAINTAINER sanslash332

RUN apk --update --no-cache add python3 libssl1.1
# COPY hardening.sh /hardening.sh
#RUN /bin/sh /hardening.sh

ENV ERR_USER ygo
USER root
RUN mkdir /ygo
RUN addgroup -g 5000 -S ${ERR_USER}
RUN adduser -u 1000 -D -S -G $ERR_USER -h /ygo $ERR_USER
RUN cd /ygo &&\
    chown -R $ERR_USER:$ERR_USER /ygo

USER $ERR_USER
COPY --from=intermediate /ygo/yugioh-game /ygo
COPY --from=intermediate /ygo/ygopro-scripts /ygo/script
WORKDIR /ygo
RUN touch game.db

EXPOSE 4000

CMD venv/bin/python ./ygo.py
