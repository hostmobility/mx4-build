BE_MX4_BUILD_DIR="${PWD}"

curr_repo="$(basename $(git rev-parse --show-toplevel) || \"\")"
if [ ! "$curr_repo" == "mx4-build" ] || [ ! "${PWD##*/}" == "mx4-build" ]; then
    echo "Error! Must run setup_environment from mx4-build repository and mx4-build base directory!!!"
    exit 1
fi

BE_MX4_DIR="../mx4"
if [ ! $# -eq 0 ]; then
    BE_MX4_DIR="$1"
fi
if [ ! "${BE_MX4_DIR:0:1}" == "/" ]; then
    # BE_MX4_DIR is relative, so we make it absolute!
    BE_MX4_DIR="${PWD}/${BE_MX4_DIR}"
fi

git config --global credential.helper "cache --timeout=3600"

mkdir -p environment
echo "export BE_MX4_BUILD_DIR=\"${BE_MX4_BUILD_DIR}\"" > environment/env.txt
echo "export BE_MX4_DIR=\"${BE_MX4_DIR}\"" >> environment/env.txt

if [ -d "$BE_MX4_DIR" ]; then
    cd "$BE_MX4_DIR"
    mx4_repo="$(basename $(git rev-parse --show-toplevel) || \"\")"
    if [ "$mx4_repo" == "mx4" ]; then
        echo "mx4 repository found!"
    else
        echo "Error! mx4 repository did not exists in the expected directory \"$BE_MX4_DIR\""
        exit 1
    fi
else
    echo "No mx4 repository found! Do you want to checkout from https://github.com/hostmobility/mx4.git? into directory \"$BE_MX4_DIR\"(y/n)"
    read checkoutmx4
    if [ "$checkoutmx4" == "Y" ] || [ "$checkoutmx4" == "y" ]; then
        mkdir "$BE_MX4_DIR"
        cd "$BE_MX4_DIR"
        $BE_MX4_BUILD_DIR/buildtools/./checkoutrepo.sh mx4
    else
        echo "Error! Must have mx4 repository!!!"
        exit 1
    fi
fi

cd "$BE_MX4_DIR"
$BE_MX4_BUILD_DIR/buildtools/./checkoutrepo.sh pic
cd "$BE_MX4_DIR"
$BE_MX4_BUILD_DIR/buildtools/./checkoutrepo.sh linux_vf
cd "$BE_MX4_DIR"
$BE_MX4_BUILD_DIR/buildtools/./checkoutrepo.sh u-boot_vf

cd $BE_MX4_BUILD_DIR

