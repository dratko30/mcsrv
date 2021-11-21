FROM ubuntu:20.04

#this is test vor new version
LABEL maintainer="Ratko Dimovski" \
      name="my_first_ms_server" \
      version="1.0"

#set env variables
ENV DEBIAN_FRONTEND noninteractive

#install packages
RUN apt -y update  \
    && apt -y upgrade \
    && apt -y install \
       openjdk-8-jre-headless \
       wget \
    && apt-get clean autoclean \
    && apt-get autoremove - \
    && rm -rf /var/lib/apt/lists/*

#add dedicated minecraft user
RUN useradd -m -d /srv minecraft

#add entrypoint script
ADD start.sh /start.sh

#create needed data dir and set user as owner
RUN mkdir -p /srv \
    && chown -R minecraft:minecraft /srv
RUN chmod +x /start.sh \
    && chown minecraft:minecraft /start.sh

#expose a volume so data is persistant
VOLUME /srv

#minecraft port
EXPOSE 25565

#switch to the user for entrypoint execution
USER minecraft
ENTRYPOINT [ "./start.sh" ]