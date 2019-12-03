sudo apt install curl -y
sudo apt install snapd -y

# vscode
sudo snap install --classic code

# docker
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
   
sudo apt-get update
sudo apt-get install git -y

sudo apt-get install docker-ce -y

# docker compose
sudo apt install docker-compose -y

# zsh
sudo apt install zsh -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# plugin zsg
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"

#  insominia
sudo snap install insomnia -y

#  client postgres
sudo apt install postgresql-contrib -y

# config docker
sudo usermod -aG docker $USER
sudo systemctl enable docker
reboot

# ajustes de tema do ubuntu
#sudo apt install gnome-tweaks -y
#sudo apt install gnome-shell-extensions -y
