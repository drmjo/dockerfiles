FROM buildpack-deps:buster

LABEL maintainer="Majan Paul <paul@urbancoyote.com>"

RUN apt-get update -y && \
    apt-get install -y \
      zip \
      git \
    && apt-get clean

ENV PACKER_VERSION=1.5.5
ENV PACKER_SHA256SUM=07f28a1a033f4bcd378a109ec1df6742ac604e7b122d0316d2cddb3c2f6c24d1

RUN curl https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip > packer_${PACKER_VERSION}_linux_amd64.zip && \
    echo "${PACKER_SHA256SUM}  packer_${PACKER_VERSION}_linux_amd64.zip" > packer_${PACKER_VERSION}_SHA256SUMS && \
    sha256sum -c packer_${PACKER_VERSION}_SHA256SUMS && \
    unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /bin && \
    rm -f packer_${PACKER_VERSION}_linux_amd64.zip

ARG USER=packer
RUN adduser --disabled-password --gecos "" $USER

USER $USER

WORKDIR /home/$USER

# enable color prompt
RUN sed -i 's/#force_color_prompt/force_color_prompt/' .bashrc

ENTRYPOINT ["/bin/bash"]
