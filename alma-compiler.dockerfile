FROM almalinux:9

RUN dnf update -y && \
    dnf install -y 'dnf-command(config-manager)' && \
    dnf config-manager --set-enabled crb && \
    dnf install -y git gcc make kernel-headers python3-pip &&\
    dnf clean all