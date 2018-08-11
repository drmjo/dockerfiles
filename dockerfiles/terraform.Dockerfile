FROM buildpack-deps:stretch

MAINTAINER "Majan Paul <paul@urbancoyote.com>"

RUN apt-get update -y && \
    apt-get install -y \
      zip \
      git \
    && apt-get clean

ENV TERRAFORM_VERSION=0.11.7
ENV TERRAFORM_SHA256SUM=6b8ce67647a59b2a3f70199c304abca0ddec0e49fd060944c26f666298e23418

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
