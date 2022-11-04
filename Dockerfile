FROM mcr.microsoft.com/vscode/devcontainers/base:debian

ENV PATH=$PATH:/usr/local/texlive/bin/x86_64-linux:/usr/local/texlive/bin/aarch64-linux

COPY texlive.profile /tmp/

RUN apt-get update -qq \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

RUN wget https://texlive.texjp.org/current/tlnet/install-tl-unx.tar.gz \
    && mkdir /tmp/texlive \
    && tar xzf install-tl-unx.tar.gz -C /tmp/texlive --strip-components=1 \
    && /tmp/texlive/install-tl --no-gui --profile=/tmp/texlive.profile \
    && tlmgr option repository http://mirror.ctan.org/systems/texlive/tlnet \
    && tlmgr update --self --all \
    && rm -rf install-tl-unx.tar.gz \
    && rm -rf /tmp/texlive
