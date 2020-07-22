NAME = ardop
TAG  = ardop/madhut

DEVICE=/dev/ttyUSB0
#SETTINGS=-m 135 -r ${DEVICE} -s 4800 -d NONE 

#PORT=-p 4532:4532
PORT=-p 8515:8515

#DEVICE="plughw:1,0"
#DEVICE=/dev/snd
DEV=--device ${DEVICE}:${DEVICE}
#DEVICE=
DEV=

DEVICE=--device=/dev/ttyUSB0

VOL=

PRIV="--privileged"

all:: build

run:
	#docker run -d --rm --restart=always ${DEV} ${PORT} ${VOL} --name ${NAME} ${TAG} 
	docker run -d --rm -v /dev/snd:/dev/snd  ${PRIV}  ${DEV} ${PORT} ${VOL} --name ${NAME} ${TAG}
test: 
	docker run -it --rm --name testrun ${TAG}	
build:
	docker build  --rm --tag=$(TAG) . 

#rigctl:
#	docker run -it --rm ${DEV} --name rigctl --entrypoint rigctl ${TAG} ${SETTINGS}

#rigctld:
#	docker run -it --rm ${DEV} --name rigctld --entrypoint rigctld ${TAG} ${SETTINGS}

shell:
	docker run -it --rm #{DEV} --net host  --entrypoint /bin/bash ${TAG}
