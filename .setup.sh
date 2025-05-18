### GUI utilities ###
flatpak install -y flathub com.playonlinux.PlayOnLinux4

WARP_VERSION=0.2025.05.14.08.11
ETCHER_VERSION=2.1.3
wget -O etcher.deb "https://github.com/balena-io/etcher/releases/download/v$ETCHER_VERSION/balena-etcher_$ETCHER_VERSION_amd64.deb"
wget -O warp.deb "https://releases.warp.dev/stable/v$WARP_VERSION.stable_03/warp-terminal_$WARP_VERSION.stable.03_amd64.deb"
wget -O postman.tar.gz 'https://dl.pstmn.io/download/latest/linux_64'
sudo apt-get install -y ./warp.deb ./etcher.deb
sudo tar -C /opt -xzf postman.tar.gz
rm warp.deb etcher.deb postman.tar.gz

cat << EOF >> ~/.local/share/applications/Postman.desktop
[Desktop Entry]
Encoding=UTF-8
Name=Postman
Exec=/opt/Postman/app/Postman %U
Icon=/opt/Postman/app/resources/app/assets/icon.png
Terminal=false
Type=Application
Categories=Development
EOF



### dev tools ###
curl -sSL https://install.python-poetry.org | python3 -
source ~/.bashrc && poetry completions bash >> ~/.bash_completion
# mkdir ~/.zfunc
# poetry completions zsh > ~/.zfunc/_poetry
