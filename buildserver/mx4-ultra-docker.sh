

sudo docker run --name docker_$JOBNAME --rm --privileged \
    -v /media/jenkins:/media/jenkins \
    hostmobility/buildplatform-mx4-ultra \
	/bin/bash -c ""