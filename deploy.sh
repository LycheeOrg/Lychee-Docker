#!/bin/bash

if [[ "$TRAVIS_BRANCH" == "master" ]]; then
  docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD ;
  docker push $REPO':dev' ;
fi

if [[ "$TRAVIS_BRANCH" == "tags" ]]; then
  docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD ;
  docker push $REPO':dev' ;
  docker tag $REPO':'$TRAVIS_TAG $REPO':latest' ;
  docker push $REPO':'$TRAVIS_TAG ;
  docker push $REPO':latest' ;
fi
