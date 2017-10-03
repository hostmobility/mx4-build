if [ $# -eq 0 ]; then
    echo "Choose a build target(t20, gtt, ultra-gtt, ct, ...)"
    exit 1
elif [ $# -eq 4 ]; then
    set -x
    EXTRAPARAMS="-g -k -u -j $(nproc)"
    TARGET=$1
    DIR_WORK=$2
    DIR_ROOTFS=$3
    DIR_YOCTO=$4
    cd $DIR_WORK/mx4/t20
    if [ "$TARGET" == "ultra-gtt" ] ; then
        TARGET=gtt
        EXTRAPARAMS="-v $DIR_WORK/ultra/src/ $EXTRAPARAMS"
        EXEC_AFTER=$DIR_WORK/ultra/src/tests/build/linux/clang/release/./tests
    fi
    ./make_system.sh -t $TARGET -r $DIR_ROOTFS -d $DIR_YOCTO $EXTRAPARAMS
    if [[ "$EXEC_AFTER" ]] ; then
        $EXEC_AFTER
    fi
    sudo $DIR_WORK/mx4/t20/./make_system_sudo.sh clean
    echo "Build Finished with success"
    exit 0
else
    echo "Wrong amount of arguments! Need <TARGET> <DIR_WORK> <DIR_ROOTFS> <DIR_YOCTO>"
    echo "EXAMPLE: ./mx4-build.sh t20 '/media/jenkins/workspace/t20-test' '/media/jenkins/rootfs/t20-test' '/media/jenkins/yocto-ultra-1.x.x'"
    exit 1
fi
