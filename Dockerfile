#FROM raspbian/stretch
FROM debian:buster-slim

LABEL maintainer="KD2QAR@gmail.com"

RUN apt-get update && \
    apt-get -y install libasound2 alsa-utils pulseaudio && \
    apt-get -y autoremove && \
    apt-get purge && apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* /var/tmp/*  && \
    rm -rf /usr/share/doc/* && \
    rm -rf /usr/share/man/* ;
RUN arecord -l

WORKDIR /srv/ardop

#COPY * /srv/ardop/
#RUN ls -lh /srv/ardop/

COPY piardopc /usr/local/bin/
COPY ardoprun /usr/local/bin/
COPY tools    /usr/local/bin/

#RUN ls -alh /usr/local/bin/

RUN chmod +x /usr/local/bin/ardoprun /usr/local/bin/piardopc /usr/local/bin/tools
ENTRYPOINT ["ardoprun"]


