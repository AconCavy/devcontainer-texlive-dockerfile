FROM mcr.microsoft.com/vscode/devcontainers/base:alpine

ENV PATH $PATH:/usr/local/texlive/bin/x86_64-linuxmusl

COPY texlive.profile /tmp/

RUN apk --no-cache add make fontconfig-dev \
    perl perl-log-dispatch perl-namespace-autoclean perl-specio perl-unicode-linebreak \
    && curl -L https://cpanmin.us/ -o /usr/local/bin/cpanm \
    && chmod +x /usr/local/bin/cpanm \
    && cpanm -n App::cpanminus \
    && cpanm -n File::HomeDir \
    && cpanm -n Params::ValidationCompiler \
    && cpanm -n YAML::Tiny \
    && cpanm -n Unicode::GCString

RUN wget https://texlive.texjp.org/current/tlnet/install-tl-unx.tar.gz \
    && mkdir /tmp/texlive \
    && tar xvf install-tl-unx.tar.gz -C /tmp/texlive --strip-components=1 \
    && /tmp/texlive/install-tl --profile=/tmp/texlive.profile \
    && tlmgr update --self --all \
    && rm -rf /tmp/texlive