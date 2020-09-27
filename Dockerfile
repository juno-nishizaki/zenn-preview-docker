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
        install -o node -g node -d /opt/zenn; \
        cd /opt/zenn; \
        \
        gosu node npm init --yes; \
        gosu node npm install zenn-cli; \
        \
        gosu node npx zenn init;

USER node
WORKDIR /opt/zenn

# setup git repository
RUN set -eux; \
        sed -i -e '$a*.json\n\nREADME.md\n\n.keep' .gitignore; \
        git init;

CMD ["npx", "zenn", "preview"]

