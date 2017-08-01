source ../environment/env.txt

mkdir -p cache

checkoutfiles="false"
if [ $# -ge 3 ]; then
    gitrepo="$1"
    commit_tag1="$2"
    commit_tag2="$3"
    if [ $# -ge 4 ]; then
        if [ "$4" == "-files" ]; then
            checkoutfiles="true"
        fi
    fi
else
    echo "Error! Must specify 2 commits!"
    exit 1
fi

if [ $gitrepo == "mx4" ]; then
    cd $BE_MX4_DIR
elif [ $gitrepo == "pic" ]; then
    cd $BE_MX4_DIR/pic
elif [ $gitrepo == "linux_vf" ]; then
    cd $BE_MX4_DIR/t20/linux_vf
elif [ $gitrepo == "u-boot_vf" ]; then
    cd $BE_MX4_DIR/t20/u-boot_vf
fi

mkdir -p $BE_MX4_BUILD_DIR/devtools/cache/$gitrepo

diff_commits="${commit_tag1}..${commit_tag2}"
commit1="${commit_tag1}"
commit2="${commit_tag2}"
commit_tag1="${commit_tag1/origin\//}"
commit_tag2="${commit_tag2/origin\//}"
commit_tag1="${commit_tag1/\//_}"
commit_tag2="${commit_tag2/\//_}"

mkdir -p $BE_MX4_BUILD_DIR/devtools/cache/$gitrepo/$commit_tag1
git diff --name-only $diff_commits > $BE_MX4_BUILD_DIR/devtools/cache/$gitrepo/$commit_tag1/$commit_tag2_UNFILTERED.txt
git diff --diff-filter=ar --name-only $diff_commits > $BE_MX4_BUILD_DIR/devtools/cache/$gitrepo/$commit_tag1/$commit_tag2.txt
echo "################################################" >> $BE_MX4_BUILD_DIR/devtools/cache/$gitrepo/diffbranches.txt
echo "$commit1" >> $BE_MX4_BUILD_DIR/devtools/cache/$gitrepo/diffbranches.txt
echo "$commit2" >> $BE_MX4_BUILD_DIR/devtools/cache/$gitrepo/diffbranches.txt
echo "$BE_MX4_BUILD_DIR/devtools/cache/$gitrepo/$commit_tag1/$commit_tag2.txt" >> $BE_MX4_BUILD_DIR/devtools/cache/$gitrepo/diffbranches.txt

if [ "$checkoutfiles" == "true" ]; then
    cd $BE_MX4_DIR
    git fetch origin $commit_tag1:$commit_tag1
    git fetch
    mkdir -p $BE_MX4_BUILD_DIR/devtools/cache/$gitrepo/$commit_tag1/diff-against
    cd $BE_MX4_BUILD_DIR/devtools/cache/$gitrepo/$commit_tag1/diff-against
    git clone --shared --no-checkout $BE_MX4_DIR/.git $commit_tag2
    cd $commit_tag2
    git fetch origin $commit_tag1:$commit_tag1
    git fetch
    echo "git checkout $commit_tag1 -- (cat $BE_MX4_BUILD_DIR/devtools/cache/$gitrepo/$commit_tag1/$commit_tag2.txt)"
    for file in $(cat $BE_MX4_BUILD_DIR/devtools/cache/$gitrepo/$commit_tag1/$commit_tag2.txt);
    do
        git checkout --force $commit_tag1 -- $file
    done
    git checkout --force $commit_tag1 -- $(cat $BE_MX4_BUILD_DIR/devtools/cache/$gitrepo/$commit_tag1/$commit_tag2.txt)
fi