source ../environment/env.txt

mkdir -p cache

checkoutcontent="false"
if [ "$1" == "--content" ] || [ "$1" == "-c" ] || [ "$2" == "--content" ] || [ "$2" == "-c" ]; then
    checkoutcontent="true"
fi

if [ "$1" == "--all" ] || [ "$1" == "-a" ] || [ "$2" == "--all" ] || [ "$2" == "-a" ]; then
    pushd $BE_MX4_DIR
    git branch -r > $BE_MX4_BUILD_DIR/devtools/cache/mx4-branches.txt
    popd
else
    echo "origin/master" > $BE_MX4_BUILD_DIR/devtools/cache/mx4-branches.txt
    echo "origin/mx4-bsp-v1.2x" > $BE_MX4_BUILD_DIR/devtools/cache/mx4-branches.txt
    echo "origin/mx4-bsp-v1.3x" >> $BE_MX4_BUILD_DIR/devtools/cache/mx4-branches.txt
    echo "origin/mx4-bsp-v1.4x" >> $BE_MX4_BUILD_DIR/devtools/cache/mx4-branches.txt
    echo "origin/mx4-bsp-v1.4x-ultra" >> $BE_MX4_BUILD_DIR/devtools/cache/mx4-branches.txt
    echo "origin/mx4-bsp-v1.5x" >> $BE_MX4_BUILD_DIR/devtools/cache/mx4-branches.txt
    echo "origin/mx4-t30-fr" >> $BE_MX4_BUILD_DIR/devtools/cache/mx4-branches.txt
    echo "origin/ultra-v1.x.x" >> $BE_MX4_BUILD_DIR/devtools/cache/mx4-branches.txt
    echo "origin/mil-signed-update-image" >> $BE_MX4_BUILD_DIR/devtools/cache/mx4-branches.txt
fi

for i in $(cat $BE_MX4_BUILD_DIR/devtools/cache/mx4-branches.txt);
do
    for u in $(cat $BE_MX4_BUILD_DIR/devtools/cache/mx4-branches.txt);
    do
        if [ ! "$i" == "$u" ]; then
            ./checkoutdiff.sh mx4 $i $u
            if [ "$checkoutcontent" == "true" ]; then
                
            fi
        fi
    done    
done    

# ./checkoutdiff.sh mx4 origin/master origin/mx4-bsp-v1.5.x
# ./checkoutdiff.sh mx4 origin/master origin/mx4-bsp-v1.4.x
# ./checkoutdiff.sh mx4 origin/master origin/mx4-bsp-v1.4.x-ultra
# ./checkoutdiff.sh mx4 origin/master origin/mx4-bsp-v1.4.x-ultra