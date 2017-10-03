if [ $# -eq 0 ]; then
    echo "Choose a build target(t20, gtt, ...)"
    exit 1
elif [ $# -eq 4 ]; then
    TARGET=$1
    DIR_WORK=$2
    DIR_ROOTFS=$3
    DIR_YOCTO=$4
    cd $DIR_WORK/mx4/t20
    ./make_system.sh -t $TARGET -r $DIR_ROOTFS -d $DIR_YOCTO -g -k -u -j $(nproc)
    sudo $DIR_WORK/mx4/t20/./make_system_sudo.sh clean
    echo "Build Finished with success"
    exit 0
else
    echo "Wrong amount of arguments! Need <TARGET> <DIR_WORK> <DIR_ROOTFS> <DIR_YOCTO>"
    echo "EXAMPLE: ./mx4-build.sh t20 '/media/jenkins/workspace/t20-test' '/media/jenkins/rootfs/t20-test' '/media/jenkins/yocto-ultra-1.x.x'
    exit 1
fi
