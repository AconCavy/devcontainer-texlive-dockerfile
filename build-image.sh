#!/bin/sh

TAG=devcontainer-texlive

if [ command -v docker &> /dev/null ];
then 
    docker image build --tag $TAG .
elif [ command -v nerdctl &> /dev/null ];
then
    nerdctl build --tag $TAG
fi
