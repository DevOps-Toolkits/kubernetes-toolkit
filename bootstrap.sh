#!/bin/bash
echo 'Bootstrap steps start here:'

echo '[STEP 0] Installing kubectl & helm client'
# Install kubectl
# Note: Latest version of kubectl may be found at:
# https://github.com/kubernetes/kubernetes/releases
KUBE_LATEST_VERSION="v1.28.5"
curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/bin/kubectl

# Install helm
# Note: Latest version of helm may be found at
# https://github.com/kubernetes/helm/releases
HELM_VERSION="v3.13.3"
wget -q https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm >/usr/local/bin/helm &&
     chmod +x /usr/local/bin/helm

echo '[STEP 1] Installing k9s awesomeness'
(
     set -x &&
          wget -c https://github.com/derailed/k9s/releases/download/v0.31.6/k9s_Linux_amd64.tar.gz -O - | tar -xz &&
          chmod +x k9s &&
          mv k9s /usr/local/bin/
)

echo '[STEP 2] Installing Oh-My-Zsh'
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo '[STEP 3] Installing zsh-autosuggestions git-open zsh-syntax-highlighting plugin'
git clone https://github.com/zsh-users/zsh-autosuggestions /root/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /root/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

echo '[STEP 4] Installing Okteto for local development'
curl https://get.okteto.com -sSfL | sh

echo '[STEP 5] Installing tmux with cool customizations'
git clone https://github.com/samoshkin/tmux-config.git
./tmux-config/install.sh

echo '[STEP 6] Installing flux cli'
curl -s https://fluxcd.io/install.sh | sh

echo '[STEP 7] Installing aws cli'
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
yum install -y https://s3.amazonaws.com/session-manager-downloads/plugin/latest/linux_64bit/session-manager-plugin.rpm

echo '[STEP 8] Installing telepresence'
curl -fL https://app.getambassador.io/download/tel2/linux/amd64/latest/telepresence -o /usr/local/bin/telepresence &&
     chmod a+x /usr/local/bin/telepresence

# need to be updated manually
echo '[STEP 9] Installing velero client'
wget -qnc -O velero.tgz https://github.com/vmware-tanzu/velero/releases/download/v1.9.1/velero-v1.9.1-linux-amd64.tar.gz &&
     tar xf velero.tgz -C /usr/bin --strip-components=1

echo '[STEP 10] Installing terraform and cdktf'
dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
dnf -y install terraform
npm install --global cdktf-cli@latest

echo '[STEP 11] Installing jfrog cli'
echo "[jfrog-cli]" >jfrog-cli.repo &&
     echo "name=jfrog-cli" >>jfrog-cli.repo &&
     echo "baseurl=https://releases.jfrog.io/artifactory/jfrog-rpms" >>jfrog-cli.repo &&
     echo "enabled=1" >>jfrog-cli.repo &&
     rpm --import https://releases.jfrog.io/artifactory/jfrog-gpg-public/jfrog_public_gpg.key &&
     sudo mv jfrog-cli.repo /etc/yum.repos.d/ &&
     yum install -y jfrog-cli-v2-jf &&
     jf intro

echo '[STEP 12] Clean up'
npm cache clean --force
yum clean all
rm -rf /tmp/*

echo '[STEP 13] Setting zsh as default shell'
chsh -s $(which zsh)
