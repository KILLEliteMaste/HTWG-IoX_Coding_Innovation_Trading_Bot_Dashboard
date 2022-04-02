FROM hseeberger/scala-sbt:11.0.9.1_1.4.4_2.12.12

RUN apt-get --allow-releaseinfo-change update
RUN curl -sL https://deb.nodesource.com/setup_14.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh

RUN apt-get install -y nodejs
RUN npm install -g serve

# Scala Play
ADD . /sources
WORKDIR /sources
RUN sbt compile
RUN sbt dist
# VueJS
WORKDIR /sources/checkers-vue
RUN npm install
RUN npm run build


WORKDIR /sources/target/universal
RUN unzip -o play-server-1.0-SNAPSHOT.zip
RUN chmod +x /sources/target/universal/play-server-1.0-SNAPSHOT/bin/play-server

WORKDIR /sources
ENTRYPOINT ["bash","docker-services-startup.sh"]