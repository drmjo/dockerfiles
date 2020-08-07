FROM buildpack-deps:buster

LABEL maintainer="Majan Paul <paul@urbancoyote.com>"

RUN apt-get update -y && \
    apt-get install -y \
      zip \
      git \
    && apt-get clean

ENV TERRAFORM_VERSION=0.12.29
ENV TERRAFORM_SHA256SUM=872245d9c6302b24dc0d98a1e010aef1e4ef60865a2d1f60102c8ad03e9d5a1d

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
