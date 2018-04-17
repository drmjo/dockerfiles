FROM ruby:2.5-stretch

ARG USER=jekyll
RUN adduser --disabled-password --gecos "" $USER

USER $USER

RUN gem install jekyll
