#FROM raspbian/stretch
#FROM debian:buster-slim
FROM debian:bullseye-slim AS builder

RUN <<SETUP
apt-get update &&
apt-get -y install build-essential make
SETUP

#COPY source/ARDOPC /ARDOPC
COPY source/ARDOPProjects/ARDOPC /ARDOPC

WORKDIR /mnt
RUN ln -s /ARDROPC adropc

WORKDIR /ARDOPC

RUN apt-get install -y libasound-dev
RUN apt-get install -y libpthread-stubs0-dev

#RUN make

FROM debian:stable-slim
#FROM kd2qar/hamlib
ENV DEBIAN_FRONTEND="noninteractive" TZ="America/New_York"
LABEL maintainer="KD2QAR@gmail.com"

#COPY --from=builder /bin/ardopc /root/ardopc

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

#ADD --chmod=755 piardopc /usr/local/bin/
ADD --chmod=755 piardopc64 /usr/local/bin/piardopc
ADD --chmod=755 ardoprun /usr/local/bin/
ADD --chmod=755 tools    /usr/local/bin/
ADD dot.bashrc /root/.bashrc

#RUN ls -alh /usr/local/bin/

RUN chmod +x /usr/local/bin/ardoprun /usr/local/bin/piardopc /usr/local/bin/tools
ENTRYPOINT ["ardoprun"]


