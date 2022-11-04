@echo off

set TAG=devcontainer-texlive

docker image build --tag %TAG% .
