FROM buildpack-deps:buster

LABEL maintainer="Majan Paul <majan@mjo.io>"

RUN apt-get update -y && \
    apt-get install -y \
      zip \
      git \
    && apt-get clean

ENV TERRAFORM_VERSION=0.13.6
ENV TERRAFORM_SHA256SUM=55f2db00b05675026be9c898bdd3e8230ff0c5c78dd12d743ca38032092abfc9

RUN curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    echo "${TERRAFORM_SHA256SUM}  terraform_${TERRAFORM_VERSION}_linux_amd64.zip" > terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
    sha256sum -c terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin && \
    rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip

ARG USER=terraform
RUN adduser --disabled-password --gecos "" $USER

USER $USER

WORKDIR /home/$USER

# enable color prompt
RUN sed -i 's/#force_color_prompt/force_color_prompt/' .bashrc

ENTRYPOINT ["/bin/bash"]
