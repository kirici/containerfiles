FROM fedora:40

RUN dnf install -y \
  dnf-plugin-config-manager \
  dnf-plugins-core \
  libedit \
  yum-utils \
  && dnf clean all

RUN ln -s /usr/lib64/libedit.so.0 /usr/lib64/libedit.so.2

RUN curl -fsSL https://dl.modular.com/public/installer/setup.rpm.sh| bash

RUN dnf install -y modular \
  && dnf clean all

RUN modular install mojo || true

RUN echo 'export MODULAR_HOME="/root/.modular"' >> /root/.bashrc \
  && echo 'export PATH="/root/.modular/pkg/packages.modular.com_mojo/bin:$PATH"' >> /root/.bashrc
