FROM ruby:2.5-stretch

ARG USER=jekyll
RUN adduser --disabled-password --gecos "" $USER

USER $USER

RUN gem install jekyll

WORKDIR /home/$USER

# enable color prompt
RUN sed -i 's/#force_color_prompt/force_color_prompt/' .bashrc
