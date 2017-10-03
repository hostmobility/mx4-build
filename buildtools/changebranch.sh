
if [ $# -eq 0 ]; then
    echo "Choose a repository(mx4, pic, linux_vf, u-boot_vf)"
    exit 1
fi
curr_repo="$(basename $(git rev-parse --show-toplevel) || \"\")"
if [ "$curr_repo" == "mx4-build" ]; then
    if [ -d "../mx4" ]; then
        pushd "../mx4"
    else
        pushd "../../mx4"
    fi
elif [ "$curr_repo" != "mx4" ]; then
    echo "Could not identify mx4 repository(found \"$curr_repo\")! Make sure changebranch.sh is executed from the mx4 repository!"
    exit 1
else
    pushd ""
fi
if [ "$2" ]; then
    if [ "$curr_repo" != "mx4" ]; then
        echo "Could not identify mx4 repository(found \"$curr_repo\")! Make sure changebranch.sh is executed from the mx4 repository!"
        popd
        exit 1
    fi
fi
if [ "$1" == "mx4" ]; then
    if [ -z "$2" ]; then
        git branch -a --column
        echo "select branch using: ./changebranch mx4 <BRANCH_NAME>"
    else
        git checkout "$2"
    fi
fi
if [ "$1" == "linux_vf" ]; then
    cd t20/linux_vf
    if [ -z "$2" ]; then
        git branch -a --column
        echo "select branch using: ./changebranch linux_vf <BRANCH_NAME>"
    else
        git checkout "$2"
    fi
    cd ../..
fi
if [ "$1" == "u-boot_vf" ]; then
    cd t20/u-boot_vf
    if [ -z "$2" ]; then
        git branch -a --column
        echo "select branch using: ./changebranch u-boot_vf <BRANCH_NAME>"
    else
        git checkout "$2"
    fi
    cd ../..
fi
if [ "$1" == "pic" ]; then
    cd pic
    if [ -z "$2" ]; then
        git branch -a --column
        echo "select branch using: ./changebranch pic <BRANCH_NAME>"
    else
        git checkout "$2"
    fi
    cd ..
fi
if [ "$1" == "ultra" ]; then
    cd ../ultra
    if [ -z "$2" ]; then
        git branch -a --column
        echo "select branch using: ./changebranch ultra <BRANCH_NAME>"
    else
        git checkout "$2"
    fi
    cd ../mx4
fi
popd