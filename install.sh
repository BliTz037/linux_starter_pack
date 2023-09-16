#!/usr/bin/env bash

clear
echo -e "\e[32m[BliTz Linux Starter Pack]\e[39m Installing packages"
if [ "$(id -u)" -ne 0 ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Update packages
echo -e "\e[32m[BliTz Linux Starter Pack]\e[39m Updating packages"

apt-get update -y
apt-get upgrade -y

echo -e "\e[32m[BliTz Linux Starter Pack]\e[39m Installing packages"

# Install packages
# List of packages to install
packages_list=(build-essential
                vim
                git
                htop
                curl
                wget
                ca-certificates
                gnupg

)
apt-get install -y ${packages_list[@]}

# Install NodeJS
echo -e "\e[32m[BliTz Linux Starter Pack]\e[39m Installing NodeJS"

mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
NODE_MAJOR=20
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list

apt-get update -y
apt-get install -y nodejs

# Install Docker & Docker Compose
echo -e "\e[32m[BliTz Linux Starter Pack]\e[39m Installing Docker & Docker Compose"

# Add Docker's official GPG key:
apt-get update -y
apt-get install -y ca-certificates curl gnupg
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg |  gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
   tee /etc/apt/sources.list.d/docker.list > /dev/null
 apt-get -y update

# Install Docker & Docker Compose:
apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Give permissions to current user
echo -e "\e[32m[BliTz Linux Starter Pack]\e[39m Giving permissions to current user for Docker"
groupadd docker
usermod -aG docker $USER

# Install Brave Browser
echo -e "\e[32m[BliTz Linux Starter Pack]\e[39m Installing Brave Browser"
curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"| tee /etc/apt/sources.list.d/brave-browser-release.list
apt update -y
apt install -y brave-browser

# Install VSCode
echo -e "\e[32m[BliTz Linux Starter Pack]\e[39m Installing VSCode"

apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

echo -e "\e[32m[BliTz Linux Starter Pack]\e[39m Install finished! Please Logout and Login again to apply changes !"
echo -e "\e[32m[BliTz Linux Starter Pack]\e[39m Have a happy coding day !"