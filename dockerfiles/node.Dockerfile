FROM node:6.10.3
# debian jessie

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y zip \
    && apt-get clean

ARG USER=node
USER $USER

WORKDIR /home/$USER

# enable color prompt
RUN sed -i 's/#force_color_prompt/force_color_prompt/' .bashrc
