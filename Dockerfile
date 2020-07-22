FROM raspbian/stretch

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

COPY * /srv/ardop/

COPY * /usr/local/bin/


ENTRYPOINT ["ardoprun"]


