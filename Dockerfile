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
    asdf install java openjdk-12.0.1 && \
    asdf reshim


# run with command:  docker run -it alpine-asdf bash

