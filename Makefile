NAME = ardop
TAG  = kd2qar/ardop

DEVICE=/dev/ttyUSB0

PORT=-p 8515:8515 -p 8516:8516

#DEVICE="plughw:1,0"
#DEVICE=/dev/snd
DEV=--device ${DEVICE}:${DEVICE}
#DEVICE=
DEV=

DEVICE=--device=/dev/ttyUSB0

VOL=-v /dev/snd:/dev/snd

PRIV="--privileged"

all:: build

run:
	#docker run -d --rm --restart=always ${DEV} ${PORT} ${VOL} --name ${NAME} ${TAG} 
	docker run -d --restart=unless-stopped ${PRIV}  ${DEV} ${PORT} ${VOL} --name ${NAME} ${TAG}

test: 
	docker run -it --rm --name testrun ${TAG}

build:
	docker build --pull --force-rm --tag=$(TAG) . 

remove:
	docker stop ${NAME} || true
	docker rm ${NAME} || true

shell:
	docker run -it --rm ${DEV} ${VOL} --net host  --entrypoint /bin/bash ${TAG}
