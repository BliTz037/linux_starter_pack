#!/usr/bin/env bash

clear
echo -e "\e[32m[BliTz Linux Starter Pack]\e[39m Installing packages"

# Update packages
echo -e "\e[32m[BliTz Linux Starter Pack]\e[39m Updating packages"

sudo apt update -y
sudo apt upgrade -y

echo -e "\e[32m[BliTz Linux Starter Pack]\e[39m Installing packages"

# Install packages
# List of packages to install
packages_list=(build-essential
                neofetch
                jq
                vim
                git
                htop
                vlc
                curl
                wget
                ca-certificates
                apt-transport-https
                gnupg
                gpg
                snapd
                gimp
)

sudo apt install -y ${packages_list[@]}

# Install NodeJS
echo -e "\e[32m[BliTz Linux Starter Pack]\e[39m Installing NodeJS"

mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
NODE_MAJOR=20
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list

sudo apt update -y
sudo apt install -y nodejs
sudo npm install yarn -g

# Install Docker & Docker Compose
echo -e "\e[32m[BliTz Linux Starter Pack]\e[39m Installing Docker & Docker Compose"

# Add Docker's official GPG key:
sudo apt update -y
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker & Docker Compose:

sudo apt update -y
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Give permissions to current user
echo -e "\e[32m[BliTz Linux Starter Pack]\e[39m Giving permissions to current user for Docker"
sudo groupadd docker
sudo usermod -aG docker $USER

# Add Monokaï theme to Vim
echo -e "\e[32m[BliTz Linux Starter Pack]\e[39m Adding Monokaï theme to Vim"
mkdir -p ~/.vim/
mkdir -p ~/.vim/colors
wget https://raw.githubusercontent.com/sickill/vim-monokai/master/colors/monokai.vim -O ~/.vim/colors/monokai.vim
echo "syntax enable" >> ~/.vimrc
echo "colorscheme monokai" >> ~/.vimrc
echo "set number" >> ~/.vimrc

# Install VSCode
echo -e "\e[32m[BliTz Linux Starter Pack]\e[39m Installing VSCode"

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt update -y
sudo apt install -y code

# Install Brave Browser
echo -e "\e[32m[BliTz Linux Starter Pack]\e[39m Installing Brave Browser"
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"| sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update -y
sudo apt install -y brave-browser

# Install Postman
echo -e "\e[32m[BliTz Linux Starter Pack]\e[39m Installing Postman"
sudo snap install postman

# Install Discord
echo -e "\e[32m[BliTz Linux Starter Pack]\e[39m Installing Discord"
TMP_DISCORD_DEB="$(mktemp).deb"
wget -O "$TMP_DISCORD_DEB" "https://discordapp.com/api/download?platform=linux&format=deb"
sudo apt install -y "$TMP_DISCORD_DEB"
rm -f "$TMP_DISCORD_DEB"

# Install VPN
echo -e "\e[32m[BliTz Linux Starter Pack]\e[39m Installing VPN"
TMP_VPN_DEB="$(mktemp).deb"
wget -O "$TMP_VPN_DEB" "https://repo.hotspotshield.com/deb/rel/all/pool/main/h/hotspotshield/hotspotshield_1.0.7_amd64.deb?ko_click_id=ko_70f46520395074c88"
sudo apt install -y "$TMP_VPN_DEB"
rm -f "$TMP_VPN_DEB"

# Install Gnome Tweaks
echo -e "\e[32m[BliTz Linux Starter Pack]\e[39m Installing Gnome Tweaks"
sudo apt install -y gnome-tweaks

# Setting up Gnome settings
echo -e "\e[32m[BliTz Linux Starter Pack]\e[39m Setting up Gnome settings"

# Enable night light
echo -e "\e[32m[BliTz Linux Starter Pack]\e[39m Enabling night light"
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic true

# Edit desktop Options
echo -e "\e[32m[BliTz Linux Starter Pack]\e[39m Editing desktop options"
gsettings set org.gnome.desktop.interface show-battery-percentage true

# Install zsh
echo -e "\e[32m[BliTz Linux Starter Pack]\e[39m Installing zsh & oh-my-zsh"
sudo apt install -y zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"

# Change default shell to zsh
echo -e "\e[32m[BliTz Linux Starter Pack]\e[39m Changing default shell to zsh"
chsh -s $(which zsh)

# Change default theme to eastwood and add aliases
echo -e "\e[32m[BliTz Linux Starter Pack]\e[39m Changing default theme to eastwood & adding aliases"
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="eastwood"/' ~/.zshrc
echo "alias cls='clear'" >> ~/.zshrc

echo -e "\e[32m[BliTz Linux Starter Pack]\e[39m Install finished! Please Logout and Login again to apply changes !"
echo -e "\e[32m[BliTz Linux Starter Pack]\e[39m Have a happy coding day !"