if [ $# -eq 0 ]; then
    echo "Error: Argument0 missing. Choose a repository part of mx4 product(\"mx4\" (https://github.com/hostmobility/mx4) or \"pic\" (https://github.com/hostmobility/mx4-pic) or \"linux_vf\" (https://github.com/hostmobility/linux-toradex) or \"u-boot_vf\" (https://github.com/hostmobility/u-boot-toradex))"
    exit 1
fi
needsdirpop="false"
curr_repo="$(basename $(git rev-parse --show-toplevel) || \"\")"
if [ "$curr_repo" == "mx4" ]; then
    if [ "$1" == "mx4" ]; then
        echo "Error: can not checkout mx4 inside mx4!"
        exit 1
    fi
    if [ "${PWD##*/}" == "mx4" ]; then
        needsdirpop="true";
        if [ "$1" == "pic" ]; then
            mkdir -p "pic"
            pushd "pic"
        elif [ "$1" == "linux_vf" ]; then
            mkdir -p "t20/linux_vf"
            pushd "t20/linux_vf"
        elif [ "$1" == "u-boot_vf" ]; then
            mkdir -p "t20/u-boot_vf"
            pushd "t20/u-boot_vf"
        else
            needsdirpop="false";
        fi
    else
        echo "currently not supported to run outside of mx4!"
        exit 1
    fi
fi

if [ "$(ls -A)" ]; then
    echo "Error: folder $PWD is not empty!"
    if [ "$needsdirpop" == "true" ]; then
        popd
    fi
    exit 1
else
    echo "Folder is empty."
fi
if [ "$1" == "mx4" ]; then
    git init
    if [ "$(uname -a | grep Microsoft)" == "" ]; then
        echo "not microsoft"
    else
        echo "microsoft, Enabling sparse-checkout!"
        git config core.sparseCheckout true
        mkdir -p ".git/info"
        echo "*
!t20/colibri-t20-L4T-linux-kernel/include/linux/netfilter/*
!t20/colibri-t20-L4T-linux-kernel/include/linux/netfilter_ipv4/*
!t20/colibri-t20-L4T-linux-kernel/include/linux/netfilter_ipv6/*
!t20/colibri-t20-L4T-linux-kernel/net/netfilter/*
!t20/colibri-t20-L4T-linux-kernel/net/ipv4/netfilter/*" > .git/info/sparse-checkout
    fi
    git remote add -f origin http://github.com/hostmobility/mx4
    git pull origin master
elif [ "$1" == "linux_vf" ]; then
    git init
    if [ "$(uname -a | grep Microsoft)" == "" ]; then
        echo "not microsoft"
    else
        echo "microsoft, Enabling sparse-checkout!"
        git config core.sparseCheckout true
        mkdir -p ".git/info"
        echo "*
!include/uapi/linux/netfilter/*
!include/uapi/linux/netfilter_ipv4/*
!include/uapi/linux/netfilter_ipv6/*
!net/netfilter/*
!net/ipv4/netfilter/*" > .git/info/sparse-checkout
    fi
    git remote add -f origin http://github.com/hostmobility/linux-toradex
    git pull origin hm_tegra
elif [ "$1" == "u-boot_vf" ]; then
    git init
    git remote add -f origin http://github.com/hostmobility/u-boot-toradex
    git pull origin 2015.04-hm
elif [ "$1" == "pic" ]; then
    git init
    git remote add -f origin http://github.com/hostmobility/mx4-pic
    git pull origin master
else
    echo "Error: invalid parameter \"$1\""
    if [ "$needsdirpop" == "true" ]; then
        popd
    fi
    exit 1
fi

if [ "$needsdirpop" == "true" ]; then
    popd
fi
