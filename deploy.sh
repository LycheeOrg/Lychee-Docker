#!/bin/bash

echo "$REGISTRY_PASS" | docker login -u $REGISTRY_USER --password-stdin

#echo "TRAVIS_BRANCH: $TRAVIS_BRANCH"
#echo "TRAVIS_TAG: $TRAVIS_TAG"
#echo "TRAVIS_PULL_REQUEST: $TRAVIS_PULL_REQUEST"
#echo "TRAVIS_EVENT_TYPE: $TRAVIS_EVENT_TYPE"
#echo "TRAVIS_PULL_REQUEST_BRANCH: $TRAVIS_PULL_REQUEST_BRANCH"

build_push() {
  docker buildx build \
    --progress plain \
    --platform $PLATFORM \
    $BUILD_ARGS \
    --push \
    .
}

# testing
if [ "$TRAVIS_BUILD_STAGE_NAME" = "build" ]; then
  if [ -n "$TRAVIS_TAG" ]; then
    BUILD_ARGS="--build-arg TARGET=release"
    PLATFORM="linux/arm64,linux/amd64"
  else
    PLATFORM="linux/arm/v7,linux/arm/v6,linux/arm64,linux/amd64"
  fi
  BUILD_ARGS="$BUILD_ARGS -t $DOCKER_REPO:testing "
  build_push

elif [ "$TRAVIS_JOB_NAME" = "Test multiarch" ] && [ -n "$TRAVIS_TAG" ] ; then
  BUILD_ARGS="\
    --build-arg TARGET=release \
    -t $DOCKER_REPO:multiarch_test"
  PLATFORM="linux/arm/v7,linux/arm/v6,linux/arm64,linux/amd64"
  build_push

# tagged version
elif [[ -n "$TRAVIS_TAG" ]]; then
  echo "Checking for latest Lychee version"
  LYCHEE_TAG="$(curl -s https://raw.githubusercontent.com/LycheeOrg/Lychee/master/version.md)"
  echo "Building multi arch and pushing tagged version (:v$LYCHEE_TAG) and :latest"
  BUILD_ARGS="\
    --build-arg TARGET=release \
    -t $DOCKER_REPO:latest \
    -t $DOCKER_REPO:v$LYCHEE_TAG \
    -t $OLD_DOCKER_REPO:latest \
    -t $OLD_DOCKER_REPO:v$LYCHEE_TAG"
  PLATFORM="linux/arm64,linux/amd64"
  build_push

# new commit to master or nightly build
elif [[ "$TRAVIS_BRANCH" == "master" && "$TRAVIS_PULL_REQUEST" == "false" ]]; then
  echo "Building multi arch and pushing :dev"
  BUILD_ARGS="\
    -t $DOCKER_REPO:dev \
    -t $OLD_DOCKER_REPO:dev"
  PLATFORM="linux/arm/v7,linux/arm/v6,linux/arm64,linux/amd64"
  build_push

# anything else
else
  echo "Nothing to push"
fi
