sudo apt update

sudo apt install git -y

sudo apt install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
    
sudo apt install snapd -y

# vscode
sudo snap install --classic code

# sublime
sudo snap install sublime-text

# zsh
sudo apt install zsh -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# plugin zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"

#  insominia
sudo snap install insomnia -y

#  client postgres terminal
sudo apt install postgresql-contrib -y

# client mysql gui
#sudo apt install mysql-workbench

# client mongo terminal
#wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
#sudo apt-get install gnupg -y
#wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
#echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
#sudo apt-get update
#sudo apt-get install -y mongodb-org-shell

# cliente mongo gui
#wget https://downloads.mongodb.com/compass/mongodb-compass_1.15.1_amd64.deb
#sudo dpkg -i mongodb-compass_1.15.1_amd64.deb

# docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
   
sudo apt update

sudo apt install docker-ce -y

# docker compose
sudo apt install docker-compose -y

# config docker
sudo usermod -aG docker $USER
sudo systemctl enable docker
reboot
