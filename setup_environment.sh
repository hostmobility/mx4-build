mx4builddir="${PWD}"

curr_repo="$(basename $(git rev-parse --show-toplevel) || \"\")"
if [ ! "$curr_repo" == "mx4-build" ] || [ ! "${PWD##*/}" == "mx4-build" ]; then
    echo "Error! Must run setup_environment from mx4-build repository and mx4-build base directory!!!"
    exit 1
fi

mx4dir="../mx4"
if [ ! $# -eq 0 ]; then
    mx4dir="$1"
fi
if [ ! "${mx4dir:0:1}" == "/" ]; then
    # mx4dir is relative, so we make it absolute!
    mx4dir="${PWD}/${mx4dir}"
fi

git config --global credential.helper "cache --timeout=3600"

mkdir -p environment
echo "export mx4builddir=\"${mx4builddir}\"" > environment/mx4dir.txt
echo "export mx4dir=\"${mx4dir}\"" >> environment/mx4dir.txt

if [ -d "$mx4dir" ]; then
    cd "$mx4dir"
    mx4_repo="$(basename $(git rev-parse --show-toplevel) || \"\")"
    if [ "$mx4_repo" == "mx4" ]; then
        echo "mx4 repository found!"
    else
        echo "Error! mx4 repository did not exists in the expected directory \"$mx4dir\""
        exit 1
    fi
else
    echo "No mx4 repository found! Do you want to checkout from https://github.com/hostmobility/mx4.git? into directory \"$mx4dir\"(y/n)"
    read checkoutmx4
    if [ "$checkoutmx4" == "Y" ] || [ "$checkoutmx4" == "y" ]; then
        mkdir "$mx4dir"
        cd "$mx4dir"
        $mx4builddir/buildtools/./checkoutrepo.sh mx4
    else
        echo "Error! Must have mx4 repository!!!"
        exit 1
    fi
fi

cd "$mx4dir"
$mx4builddir/buildtools/./checkoutrepo.sh pic
cd "$mx4dir"
$mx4builddir/buildtools/./checkoutrepo.sh linux_vf
cd "$mx4dir"
$mx4builddir/buildtools/./checkoutrepo.sh u-boot_vf

cd $mx4builddir

