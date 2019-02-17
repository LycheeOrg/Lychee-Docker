#!/bin/bash

docker login -u $REGISTRY_USER -p $REGISTRY_PASS

echo "TRAVIS_BRANCH: $TRAVIS_BRANCH"
echo "TRAVIS_TAG: $TRAVIS_TAG"
echo "TRAVIS_PULL_REQUEST: $TRAVIS_PULL_REQUEST"
echo "TRAVIS_EVENT_TYPE: $TRAVIS_EVENT_TYPE"
echo "TRAVIS_PULL_REQUEST_BRANCH: $TRAVIS_PULL_REQUEST_BRANCH"

# if its a tagged version
if [[ -n "$TRAVIS_TAG" ]]; then
  echo "Pushing tagged version and latest"
  docker tag $REPO':'$TRAVIS_BUILD_NUMBER $REPO':latest'
  docker tag $REPO':'$TRAVIS_BUILD_NUMBER $REPO':'$TRAVIS_TAG
  docker push $REPO':'$TRAVIS_TAG
  docker push $REPO':latest'

# if its a merged pr or nightly
elif [[ "$TRAVIS_BRANCH" == "master" && -z "$TRAVIS_PULL_REQUEST" ]]; then
  echo "Pushing dev"
  docker tag $REPO':'$TRAVIS_BUILD_NUMBER $REPO':dev'
  docker push $REPO':dev'

# if a pr is created, or anything otherwise
else
  echo "Pushing testing"
  docker tag $REPO':'$TRAVIS_BUILD_NUMBER $REPO':testing'
  docker push $REPO':testing'

fi


# notes:
# create pr branch = testing
# create pr = testing
# merge pr = ? should be dev
# create tag = tag/latest
