FROM python:3.6-stretch

RUN apt-get update -y && \
    apt-get install -y groff less && \
    apt-get clean

RUN pip install awscli boto3 troposphere awacs

ARG USER=aws
RUN adduser --disabled-password --gecos "" $USER

USER $USER

WORKDIR /home/aws
