FROM ubuntu:22.04
ARG MODULAR_AUTH_KEY

RUN groupadd --gid 1000 mojician \
    && useradd --uid 1000 --gid 1000 -m -d /home/mojician mojician

RUN apt-get update \
    && apt-get install -y \
    build-essential \
    wget \
    curl \
    python3.10 \
    python3.10-venv \
    libedit2

RUN apt-get install -y apt-transport-https \
    && keyring_location=/usr/share/keyrings/modular-installer-archive-keyring.gpg \
    && curl -1sLf 'https://dl.modular.com/bBNWiLZX5igwHXeu/installer/gpg.0E4925737A3895AD.key' \
    | gpg --dearmor >> ${keyring_location} \
    && curl -1sLf 'https://dl.modular.com/bBNWiLZX5igwHXeu/installer/config.deb.txt?distro=debian&codename=wheezy' > /etc/apt/sources.list.d/modular-installer.list \
    && apt-get update \
    && apt-get install -y modular

USER mojician

WORKDIR /home/mojician

RUN modular auth ${MODULAR_AUTH_KEY} \
    && modular install mojo

RUN mkdir -p ${HOME}/.local/bin

RUN BASHRC=$( [ -f "$HOME/.bash_profile" ] && echo "$HOME/.bash_profile" || echo "$HOME/.bashrc" ) \
    && echo 'export MODULAR_HOME="/home/mojician/.modular"' >> "$BASHRC" \
    && echo 'export PATH="/home/mojician/.modular/pkg/packages.modular.com_mojo/bin:$PATH:$HOME/.local/bin"' >> "$BASHRC"
