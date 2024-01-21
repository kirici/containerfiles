FROM almalinux:8

RUN dnf -y install sudo passwd && dnf clean all

RUN adduser -m radix \
    && echo "radix" | passwd radix --stdin \
    && usermod -aG wheel radix \
    && chown radix:radix -R  /home/radix/

RUN echo "radix ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
    && echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers

USER radix
WORKDIR /home/radix
