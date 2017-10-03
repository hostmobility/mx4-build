
mx4branch="$(git branch | grep \*)"

if [ -d "t20/linux_vf" ]; then
    cd t20/linux_vf
    vfkernelbranch="$(git branch | grep \*)"
    cd ../..
else
    vfkernelbranch="---"
fi

if [ -d "t20/u-boot_vf" ]; then
    cd t20/u-boot_vf
    vfubootbranch="$(git branch | grep \*)"
    cd ../..
else
    vfubootbranch="---"
fi

if [ -d "pic" ]; then
    cd pic
    picbranch="$(git branch | grep \*)"
    cd ..
else
    picbranch="---"
fi
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
printf "\t\tmx4\t\t= ${GREEN}${mx4branch:2:999}${NC}\n\t\tlinux_vf\t= ${GREEN}${vfkernelbranch:2:999}${NC}\n\t\tu-boot_vf\t= ${GREEN}${vfubootbranch:2:999}${NC}\n\t\tpic\t\t= ${GREEN}${picbranch:2:999}${NC}\n"