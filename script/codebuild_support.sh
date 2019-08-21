#!/bin/bash

export CI=true
export AWS_CODEBUILD=true

export ND_GIT_BRANCH=`git symbolic-ref HEAD --short 2>/dev/null`
if [ "$ND_GIT_BRANCH" == "" ] ; then
  ND_GIT_BRANCH=`git branch -a --contains HEAD | sed -n 2p | awk '{ printf $1 }'`
  export ND_GIT_BRANCH=${ND_GIT_BRANCH#remotes/origin/}
fi

export ND_GIT_MESSAGE=`git log -1 --pretty=%B`
export ND_GIT_AUTHOR=`git log -1 --pretty=%an`
export ND_GIT_AUTHOR_EMAIL=`git log -1 --pretty=%ae`
export ND_GIT_COMMIT=`git log -1 --pretty=%H`
export ND_GIT_TAG=`git describe --tags --abbrev=0`

export ND_PULL_REQUEST=false
if [[ $ND_GIT_BRANCH == pr-* ]] ; then
  export ND_PULL_REQUEST=${ND_GIT_BRANCH#pr-}
fi

export ND_PROJECT=${ND_BUILD_ID%:$ND_LOG_PATH}
export ND_BUILD_URL=https://$AWS_DEFAULT_REGION.console.aws.amazon.com/codebuild/home?region=$AWS_DEFAULT_REGION#/builds/$ND_BUILD_ID/view/new

echo "==> AWS CodeBuild Extra Environment Variables:"
echo "==> CI = $CI"
echo "==> AWS_CODEBUILD = $AWS_CODEBUILD"
echo "==> ND_GIT_AUTHOR = $ND_GIT_AUTHOR"
echo "==> ND_GIT_AUTHOR_EMAIL = $ND_GIT_AUTHOR_EMAIL"
echo "==> ND_GIT_BRANCH = $ND_GIT_BRANCH "
echo "==> ND_GIT_COMMIT = $ND_GIT_COMMIT"
echo "==> ND_GIT_MESSAGE = $ND_GIT_MESSAGE"
echo "==> ND_GIT_TAG = $ND_GIT_TAG"
echo "==> ND_PROJECT = $ND_PROJECT"
echo "==> ND_PULL_REQUEST = $ND_PULL_REQUEST"

