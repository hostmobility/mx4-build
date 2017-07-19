if [ $# -eq 0 ]; then
    echo "Choose a bsp"
    exit 1
fi

require_linux_vf="false"
require_uboot_vf="false"
require_pic="true"

mx4_branch="master"
linux_vf_branch=""
uboot_vf_branch=""
pic_branch=""

make_system_cmd=""

if [ $# -eq 1 ]; then
    echo "Choose a bsp version"
    exit 1
elif [ "$2" == "1.5" ]; then
    mx4_branch="mx4-bsp-v1.5.x"
    pic_branch="mx4-bsp-v1.5.x"

    if [ "$1" == "GTT" ]; then
        make_system_cmd="./make_system.sh -t gtt -r /home/username/project/rootfs/$1 -d /home/username/project/yocto-$2 -g -k -u -j $(nproc) -m -T 512"
    elif [ "$1" == "VCC" ]; then
        make_system_cmd="./make_system.sh -t vcc -r /home/username/project/rootfs/$1 -d /home/username/project/yocto-$2 -g -k -u -j $(nproc) -m -T 512"
    elif [ "$1" == "CT" ]; then
        make_system_cmd="./make_system.sh -t ct -r /home/username/project/rootfs/$1 -d /home/username/project/yocto-$2 -g -k -u -j $(nproc) -m -T 512"
    elif [ "$1" == "T20" ]; then
        make_system_cmd="./make_system.sh -t t20 -r /home/username/project/rootfs/$1 -d /home/username/project/yocto-$2 -g -k -u -j $(nproc) -m -T 512"
    elif [ "$1" == "T30" ]; then
        require_linux_vf="true"
        linux_vf_branch="mx4-bsp-v1.5.x-tegra"

        require_uboot_vf="true"
        uboot_vf_branch="2015.04-hm"

        make_system_cmd="./make_system.sh -t t30 -r /home/username/project/rootfs/$1 -d /home/username/project/yocto-$2 -g -k -u -j $(nproc) -m -T 512"
    elif [ "$1" == "V61" ]; then
        require_linux_vf="true"
        linux_vf_branch="mx4-bsp-v1.5.x-vf"

        require_uboot_vf="true"
        uboot_vf_branch="2015.04-hm"

        make_system_cmd="./make_system.sh -t v61 -r /home/username/project/rootfs/$1 -d /home/username/project/yocto-$2 -g -k -u -j $(nproc) -m -T 512"
    elif [ "$1" == "C61" ]; then
        require_linux_vf="true"
        linux_vf_branch="mx4-bsp-v1.5.x-vf"

        require_uboot_vf="true"
        uboot_vf_branch="2015.04-hm"

        make_system_cmd="./make_system.sh -t c61 -r /home/username/project/rootfs/$1 -d /home/username/project/yocto-$2 -g -k -u -j $(nproc) -m -T 512"
    elif [ "$1" == "MIL" ]; then
        require_linux_vf="true"
        linux_vf_branch="mx4-bsp-v1.5.x-tegra"

        require_uboot_vf="true"
        uboot_vf_branch="2015.04-hm"

        make_system_cmd="./make_system.sh -t mil -r /home/username/project/rootfs/$1 -d /home/username/project/yocto-$2 -g -k -u -j $(nproc) -m -T 512"
    fi
else
    echo "No valid $1 version $2"
    exit 1
fi

cd buildtools
./changebranch.sh "mx4" "$mx4_branch"

if [ "$require_pic" == "true" ]; then
    if [ ! -d "../pic" ]; then
        ./checkoutrepo.sh "pic"
    fi
    ./changebranch.sh "pic" "$pic_branch"
fi
if [ "$require_linux_vf" == "true" ]; then
    if [ ! -d "../t20/linux_vf" ]; then
        ./checkoutrepo.sh "linux_vf"
    fi
    ./changebranch.sh "linux_vf" "$linux_vf_branch"
fi
if [ "$require_uboot_vf" == "true" ]; then
    if [ ! -d "../t20/u-boot_vf" ]; then
        ./checkoutrepo.sh "u-boot_vf"
    fi
    ./changebranch.sh "u-boot_vf" "$uboot_vf_branch"
fi
./checkbranches.sh
cd ..


echo "Run this command in mx4/t20 folder: $make_system_cmd"
