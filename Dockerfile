FROM fedora:39

ARG BUILD_DATE

# Metadata
LABEL org.label-schema.name="kubernetes-toolkits" \
    org.label-schema.build-date=$BUILD_DATE

WORKDIR /root

ENV DEBIAN_FRONTEND noninteractive
ENV KUBE_PS1_SYMBOL_DEFAULT K

COPY bootstrap.sh ./
COPY krew_plugin.sh ./
COPY entrypoint.sh /usr/local/bin/

RUN yum clean all && yum makecache && yum -y install \
    azure-cli \
    openssh-clients \
    postgresql \
    wget \
    git \
    ca-certificates \
    zsh \
    iptables \
    tmux \
    vim \
    net-tools \
    dnsutils \
    unzip \
    fd-find \
    ripgrep \
    tig \
    fzf \
    bat \
    lrzsz \
    ncdu \
    glances \
    multitail \ 
    shellcheck \
    ranger \
    axel \
    util-linux-user \
    python \
    python3-pip \
    ansible \
    go \
    nmap-ncat \
    nodejs-npm \
    dnf-plugins-core \
    pgcli \
    mycli \
    && chmod +x bootstrap.sh && ./bootstrap.sh && chmod +x krew_plugin.sh && ./krew_plugin.sh && chmod +x /usr/local/bin/entrypoint.sh \
    && rm -rf ~/* && rm -rf ~/.zshrc && rm -rf ~/.zsh_history

ENV SHELL /usr/bin/zsh

COPY README.md ./
COPY zsh-history ./.zsh_history
COPY zshrc ./.zshrc
COPY rootfs/.ssh/config ./.ssh/config

ENV GIT_USERNAME ""
ENV GIT_EMAIL ""

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["zsh"]
