
curr_repo="$(basename $(git rev-parse --show-toplevel) || \"\")"
if [ ! "$curr_repo" == "mx4-build" ] || [ ! "${PWD##*/}" == "mx4-build" ]; then
    echo "Error! Must run setup_environment from mx4-build repository and mx4-build base directory!!!"
    exit 1
fi

source environment/env.txt

BE_MX4_ALL_DIR="/mnt/d/MX4_ALL/"
mkdir -p "$BE_MX4_ALL_DIR"
pushd "$BE_MX4_ALL_DIR"

echo "master" > mx4-branches.txt
echo "mx4-bsp-v1.2.x" >> mx4-branches.txt
echo "mx4-bsp-v1.3.x" >> mx4-branches.txt
echo "mx4-bsp-v1.4.x" >> mx4-branches.txt
echo "mx4-bsp-v1.4.x-ultra" >> mx4-branches.txt
echo "mx4-bsp-v1.5.x" >> mx4-branches.txt
echo "mx4-t30-fr" >> mx4-branches.txt
echo "ultra-v1.x.x" >> mx4-branches.txt
echo "ultra-v1.x.x" >> mx4-branches.txt
echo "wlan-backports-fix-1.5.x" >> mx4-branches.txt
echo "mx4-2.0" >> mx4-branches.txt

echo "master" > mx4-pic-branches.txt
echo "mx4-bsp-v1.2.x" >> mx4-pic-branches.txt
echo "mx4-bsp-v1.3.x" >> mx4-pic-branches.txt
echo "mx4-bsp-v1.4.x" >> mx4-pic-branches.txt
echo "mx4-bsp-v1.5.x" >> mx4-pic-branches.txt
echo "leds-driver" >> mx4-pic-branches.txt

echo "2015.04-hm" > u-boot-toradex-branches.txt
echo "2016.11-hm" >> u-boot-toradex-branches.txt
echo "mx4-bsp-v1.4.x" >> u-boot-toradex-branches.txt
echo "mx4-bsp-v1.5.x" >> u-boot-toradex-branches.txt

echo "hm_tegra" > linux-toradex-branches.txt
echo "hm_vf_4.4" >> linux-toradex-branches.txt
echo "mx4-bsp-v1.4.x-tegra" >> linux-toradex-branches.txt
echo "mx4-bsp-v1.5.x-tegra" >> linux-toradex-branches.txt
echo "mx4-bsp-v1.4.x-vf" >> linux-toradex-branches.txt
echo "mx4-bsp-v1.5.x-vf" >> linux-toradex-branches.txt

echo "master" > hostmobility-bsp-platform-branches.txt
echo "LinuxImageV2.1" >> hostmobility-bsp-platform-branches.txt
echo "LinuxImageV2.1-next" >> hostmobility-bsp-platform-branches.txt
echo "LinuxImageV2.6.1" >> hostmobility-bsp-platform-branches.txt
echo "LinuxImageV2.7" >> hostmobility-bsp-platform-branches.txt
    #mx4Branches="$($BE_MX4_BUILD_DIR/buildtools/./changebranch.sh mx4)"
    #git branch -r > $BE_MX4_BUILD_DIR/devtools/cache/mx4-branches.txt

echo "master" > mx4-wlink8-backport-branches.txt
echo "mx4-t30" >> mx4-wlink8-backport-branches.txt

repos3="mx4-pic"

repos="mx4 \
    mx4-pic \
    hostmobility-bsp-platform \
    meta-hostmobility-bsp \
    meta-hostmobility-distro \
    mx4-wlink8-backport \
    backports-3.10-2 \
    u-boot-toradex \
    linux-toradex"

repos2="linux-toradex \
    mx4 \
    mx4-pic \
    u-boot-toradex"

for repo in $repos;
do
    repoBranches="$(cat $repo-branches.txt || \"\")"
    if [ "$repoBranches" == "" ]; then
        repoBranches="master"
    fi
    mkdir -p "$repo"
    pushd "$repo"
    for repoBranch in $repoBranches;
    do
        branchName="${repoBranch/origin\//}"
        branchName="${branchName/\//_}"
        if [ -d "$branchName" ]; then
            echo "found $repo $branchName. Pulling newest from origin"
            cd $branchName
            git pull origin $branchName
            cd ..
        else
            echo "cloning $repo $branchName"
            mkdir -p "$branchName"
            cd "$branchName"
            $BE_MX4_BUILD_DIR/buildtools/checkoutrepo.sh $repo $branchName
            sleep 5
            git remote set-url --push origin https://github.com/ViktorFriberg/$repo
            cd ..
            #git clone https://github.com/hostmobility/$repo -b $branchName $branchName
        fi
        sleep 1
    done;
    popd
done;
popd