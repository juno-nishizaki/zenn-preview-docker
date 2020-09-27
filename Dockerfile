FROM node:lts-buster

# install gosu
# see: https://github.com/tianon/gosu/blob/master/INSTALL.md
RUN set -eux; \
	apt-get update; \
	apt-get install -y gosu; \
	rm -rf /var/lib/apt/lists/*; \
# verify that the binary works
	gosu nobody true

# install zenn-cli
RUN set -eux; \
        gosu node mkdir /home/node/app; \
        cd /home/node/app; \
        \
        gosu node npm init --yes; \
        gosu node npm install zenn-cli; \
        \
        gosu node npx zenn init;

USER node
WORKDIR /home/node/app

CMD ["npx", "zenn", "preview"]

