#!/bin/bash
set -ev
export TZ='Asia/Shanghai'

git clone -b master ${GH_REF} .deploy_git

cd .deploy_git
git checkout master
mv .git/ ../public/
cd ../public

git add .
git commit -m "Site updated: `date +"%Y-%m-%d %H:%M:%S"`"
git push origin master:master --force --quiet