FROM buildpack-deps:stretch

MAINTAINER "Majan Paul <paul@urbancoyote.com>"

RUN apt-get update -y && \
    apt-get install -y \
      zip \
      git \
    && apt-get clean

ENV TERRAFORM_VERSION=0.11.6
ENV TERRAFORM_SHA256SUM=aed5c7388a3c54dc816986903d4dea32e182a002d746295e1016f6db741f472d

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
