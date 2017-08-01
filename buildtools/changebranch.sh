if [ $# -eq 0 ]; then
    echo "Choose a repository(mx4, pic, linux_vf, u-boot_vf)"
    exit 1
fi
if [ ! -d "mx4" ]; then
    echo "Could not find mx4 directory! Make sure changebranch.sh is executed from the parent folder of mx4 repository!"
    exit 1
fi
if [ "$1" == "mx4" ]; then
    cd mx4
    if [ -z "$2" ]; then
        git branch -a --column
        echo "select branch using: ./changebranch mx4 <BRANCH_NAME>"
    else
        git checkout "$2"
    fi
    cd ..
fi
if [ "$1" == "linux_vf" ]; then
    cd mx4/t20/linux_vf
    if [ -z "$2" ]; then
        git branch -a --column
        echo "select branch using: ./changebranch linux_vf <BRANCH_NAME>"
    else
        git checkout "$2"
    fi
    cd ..
fi
if [ "$1" == "u-boot_vf" ]; then
    cd mx4/t20/u-boot_vf
    if [ -z "$2" ]; then
        git branch -a --column
        echo "select branch using: ./changebranch u-boot_vf <BRANCH_NAME>"
    else
        git checkout "$2"
    fi
    cd ..
fi
if [ "$1" == "pic" ]; then
    cd mx4/pic
    if [ -z "$2" ]; then
        git branch -a --column
        echo "select branch using: ./changebranch pic <BRANCH_NAME>"
    else
        git checkout "$2"
    fi
    cd ..
fi
if [ "$1" == "ultra" ]; then
    cd ultra
    if [ -z "$2" ]; then
        git branch -a --column
        echo "select branch using: ./changebranch ultra <BRANCH_NAME>"
    else
        git checkout "$2"
    fi
    cd ..
fi

