if [ $# -eq 0 ]; then
    echo "Choose a repository(mx4, pic, linux_vf, u-boot_vf)"
    exit 1
fi
pushd ../t20
if [ "$1" == "mx4" ]; then
    if [ -z "$2" ]; then
        git branch -a --column
        echo "select branch using: ./changebranch mx4 <BRANCH_NAME>"
    else
        git checkout "$2"
    fi
fi
if [ "$1" == "linux_vf" ]; then
    cd linux_vf
    if [ -z "$2" ]; then
        git branch -a --column
        echo "select branch using: ./changebranch linux_vf <BRANCH_NAME>"
    else
        git checkout "$2"
    fi
    cd ..
fi
if [ "$1" == "u-boot_vf" ]; then
    cd u-boot_vf
    if [ -z "$2" ]; then
        git branch -a --column
        echo "select branch using: ./changebranch u-boot_vf <BRANCH_NAME>"
    else
        git checkout "$2"
    fi
    cd ..
fi
if [ "$1" == "pic" ]; then
    cd ../pic
    if [ -z "$2" ]; then
        git branch -a --column
        echo "select branch using: ./changebranch pic <BRANCH_NAME>"
    else
        git checkout "$2"
    fi
    cd ../t20
fi
popd
