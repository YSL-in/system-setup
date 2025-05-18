#!/bin/bash
set -ex

cp assets/.bashrc ~/.bashrc
cp assets/.bashrc-dev ~/.bashrc-dev
cp assets/.bash_aliases ~/.bash_aliases
sudo cp ~/.bashrc /root/.bashrc

cp assets/.tmux.conf ~/.tmux.conf
cp assets/.vimrc ~/.vimrc
sudo cp ~/.vimrc /root/.vimrc

###############
# CLI utility #
###############
sudo apt-get install -y curl htop openssh-server snap sshfs tmux vim xsel zenity sxhkd usb-creator-gtk \
    fcitx5 fcitx5-chewing chewing-editor \
    guake libfuse2

mkdir -p ~/.config/fcitx5/    && cp -R assets/.config/fcitx5/* ~/.config/fcitx5/
mkdir -p ~/.config/sxhkd/     && cp assets/.config/sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc
mkdir -p ~/.config/Code/User/ && cp assets/.config/Code/User/settings.json ~/.config/Code/User/settings.json

guake --restore-preferences assets/.guake.pref
mkdir -p ~/.config/autostart/ && cp assets/.config/autostart/* ~/.config/autostart/

if kvm-ok; then
    sudo apt-get install -y qemu-kvm libvirt-daemon-system libvirt-clients virt-manager virtinst bridge-utils
    # qemu-kvm: the emulator
    # libvirt-daemon-system: the libvirt daemon
    # libvirt-clients: the CLI utils that manages VMs and hypervisors
    # virt-manager: the Qt-based graphical interface for managing VMs
    # virtinst: the CLI utils that provisions and modifies VMs
fi

if [[ "$(sudo dmidecode -s system-manufacturer)" == "System76" ]]; then
    sudo apt-add-repository -y ppa:system76-dev/stable
    sudo apt-get update
    sudo apt install -y system76-driver system76-firmware
    sudo system76-firmware-cli schedule

    if [[ "$(lspci | grep -i nvidia)" ]]; then
        sudo apt-get install -y system76-driver-nvidia
    fi
fi

# vim & tmux plugins
sudo apt install -y clangd fonts-powerline
curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
sudo ln -s ~/.vim /root/.vim
vim +'PlugInstall --sync' +qa || true

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins || true

###############
# GUI utility #
###############
sudo apt-get install -y gnome-shell-extension-manager flatpak
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

AFFINE_VERSION=0.21.6  # Ref: https://github.com/toeverything/AFFiNE/releases
wget -O affine.deb "https://github.com/toeverything/AFFiNE/releases/download/v$AFFINE_VERSION/affine-$AFFINE_VERSION-stable-linux-x64.deb"
wget -O chrome.deb 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'
wget -O vscode.deb 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64'
sudo apt-get install -y ./affine.deb ./chrome.deb ./vscode.deb
rm affine.deb chrome.deb vscode.deb

# gnome extensions
sudo apt-get install -y chrome-gnome-shell libcanberra-gtk-module

#############
# dev tools #
#############
sudo apt-get -y install build-essential gcc git make
sudo snap install lxd yq vivaldi notion-desktop
sudo snap install astral-uv --classic
sudo usermod -aG lxd $USER && newgrp lxd

# git-status in bash
mkdir -p ~/.gitstatus
git clone --depth=1 https://github.com/romkatv/gitstatus.git ~/.gitstatus

git config --global user.name YSL
git config --global user.email linyusung1998@gmail.com
git config --global core.editor vim
git config --global core.ignorecase true
git config --global core.quotepath off
git config --global init.defaultBranch master
git config --global alias.amend "commit --amend --no-edit"
git config --global alias.br branch
git config --global alias.brn 'rev-parse --abbrev-ref HEAD'
git config --global alias.co checkout
git config --global alias.st 'status --untracked-file=no'
git config --global alias.dtree 'diff-tree -r --name-status HEAD'
git config --global alias.pop 'stash pop'
git config --global alias.ll 'ls --graph'
git config --global alias.ls 'log --pretty=format:"%C(yellow)%h %<(10,trunc)%C(green)%an %C(blue)%as (%ar) %C(bold)%d %C(reset)%s%x09" -10'
# %C(...): switch font style
# %<(N,trunc): keep N-char widths for the next placeholder
# %<(N): keep at least N-char widths for the next placeholder
# %h: abbreviated commit hash
# %an: author name
# %ah: author date (short)
# %ar: author date (relative)
# %s: subject
# %x09: tab
git config --global --add merge.ff true

# docker
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker $USER

# docker-desktop, go
GO_VERSION=1.24.3

wget -O docker-desktop.deb 'https://desktop.docker.com/linux/main/amd64/docker-desktop-amd64.deb'
wget -O go.tar.gz "https://go.dev/dl/go$GO_VERSION.linux-amd64.tar.gz"
sudo apt-get install -y ./docker-desktop.deb
sudo tar -C /usr/local -xzf go.tar.gz
sudo ln -s /usr/local/go/bin/go /usr/local/bin/go

rm docker-desktop.deb go.tar.gz

go install github.com/posener/complete/v2/gocomplete@latest
echo yes | COMP_INSTALL=1 ~/go/bin/gocomplete

# k3s, helm, krew
curl -sfL https://get.k3s.io | sh -s - --cluster-init
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config \
    && chown $USER ~/.kube/config \
    && chmod 600 ~/.kube/config \
    && export KUBECONFIG=~/.kube/config

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh && ./get_helm.sh && rm get_helm.sh

# python
PYTHON_VERSION=3.12.10  # Ref: `pyenv install --list | grep '  3.'`

sudo apt-get -y install libbz2-dev libffi-dev libncursesw5-dev libreadline-dev libsqlite3-dev libssl-dev liblzma-dev tk-dev zlib1g-dev python3-dev libpq-dev
curl -fsSL https://pyenv.run | bash
source ~/.bashrc-dev

pyenv install $PYTHON_VERSION
pyenv global $PYTHON_VERSION
pip install --user pipx pipenv wheel



### final steps ###
bash setup-pref.sh

wget -O ~/Pictures/grub-bg.jpg https://images.unsplash.com/photo-1543941296-3c2f4b15b1c6?ixlib=rb-4.1.0&q=85&fm=jpg&crop=entropy&cs=srgb&dl=aaron-roth-s6zbz7CFjbo-unsplash.jpg&w=1920
sudo tee -a /etc/default/grub > /dev/null <<EOF
GRUB_BACKGROUND="/home/$USER/Pictures/grub-bg.jpg"
GRUB_TIMEOUT=3
GRUB_RECORDFAIL_TIMEOUT=\$GRUB_TIMEOUT
EOF
sudo update-grub2

sudo apt update && sudo apt upgrade -y --allow-downgrades
sudo apt autoremove


################
# manual steps #
################
echo "Final steps before reboot!"

echo "1. Log in!!!"
echo -e "\t- notion-desktop"
echo -e "\t- affine"

echo "2. Switch the default input method!!"
echo -e "\t- sudo im-config"

echo "3. Import $(realpath assets/chewing.json) with chewing-editor!"
echo -e "\t- chewing-editor"

echo "4. Fix guake-toggle issue..."
echo -e "\tSettings > Keyboard > View and Customize Shortcuts > Custom Shortcuts > ..."
echo -e "\tName:     guake-toggle"
echo -e "\tCommand:  guake-toggle"
echo -e "\tShortcut: F10"

echo "5. Configure Gnome extensions accordingly..."
echo -e "\tgoogle-chrome https://chromewebstore.google.com/detail/gnome-shell-integration/gphhapmejobijbbhgpjhcjognlahblep https://extensions.gnome.org"
echo ""
cat assets/gnome-extensions.txt

echo ""
read -p "Reboot now? [y/N] " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    sudo reboot now
fi
