FROM almalinux:9

RUN dnf update -y \
    && dnf install -y python3-pip \
    && pip install numba
