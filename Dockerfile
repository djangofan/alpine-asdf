# build with command: docker build --no-cache -t alpine-asdf .

FROM alpine:latest

RUN apk add --virtual .asdf-deps --no-cache bash curl git build-base
SHELL ["/bin/bash", "-l", "-c"]
RUN adduser -s /bin/bash -h /asdf -D asdf
ENV PATH="${PATH}:/asdf/.asdf/shims:/asdf/.asdf/bin"

# USER root
# COPY asdf-install-toolset.sh /asdf/asdf-install-toolset.sh
# RUN chmod +x /asdf/asdf-install-toolset.sh && \
#     /asdf/asdf-install-toolset.sh java

USER asdf
WORKDIR /asdf

RUN git clone --depth 1 https://github.com/asdf-vm/asdf.git $HOME/.asdf && \
    echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.bashrc && \
    echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.profile && \
    source ~/.bashrc

RUN asdf plugin-add java && \
    asdf install java openjdk-12.0.1

RUN asdf plugin-add maven && \
    asdf install maven 3.6.1

RUN asdf plugin-add gradle && \
    asdf install gradle 5.5

RUN asdf reshim

#install Node  https://gist.github.com/isaacs/579814

## echo 'export PATH=$HOME/local/bin:$PATH' >> ~/.bashrc
## . ~/.bashrc
## mkdir ~/local
## mkdir ~/node-latest-install
## cd ~/node-latest-install
## curl http://nodejs.org/dist/node-latest.tar.gz | tar xz --strip-components=1
## ./configure --prefix=~/local
## make install # ok, fine, this step probably takes more than 30 seconds...
## curl https://www.npmjs.org/install.sh | sh



# run with command:  docker run -it alpine-asdf bash

## need to fix
## bash-5.0$ java -v
## /asdf/.asdf/lib/commands/shim-exec.sh: line 26: /asdf/.asdf/installs/java/openjdk-12.0.1/bin/java: No such file or directory




