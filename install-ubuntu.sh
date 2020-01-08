echo '##########  Executando Update ############'
sudo apt update

if ! [ -x "$(command -v git)" ]; then
  echo '##########  Instalando Git ############'
  sudo apt install git -y
  exit 1
fi

echo '##########  Instalando Dependencias ############'
sudo apt install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

if ! [ -x "$(command -v snap)" ]; then
  echo '##########  Instalando Snap ############'
  sudo apt install snapd -y
  exit 1
fi

if ! [ -x "$(command -v code)" ]; then
  echo '##########  Instalando VSCODE ############'
  sudo snap install --classic code
  exit 1
fi

if ! [ -x "$(command -v subl)" ]; then
    echo '##########  Instalando Sublime ############'
    curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
    sudo add-apt-repository "deb https://download.sublimetext.com/ apt/stable/"
    sudo apt update
    sudo apt install sublime-text
    # Abrir sublime pelo terminal
    #sudo ln -s /opt/sublime/sublime_text /usr/bin/subl
  exit 1
fi

if ! [ -x "$(command -v zsh)" ]; then
    echo '##########  Instalando ZSH ############'
    sudo apt install zsh -y
  exit 1
fi

if ! [ -x "$(command -v insomnia)" ]; then
    echo '##########  Instalando Insomnia ############'
    sudo snap install insomnia
  exit 1
fi

if ! [ -x "$(command -v psql)" ]; then
    echo '##########  Instalando Postgres Client ############'
    sudo apt install postgresql-contrib -y
  exit 1
fi

echo '##########  Instalando Node ############'
sudo apt install nodejs

if ! [ -x "$(command -v yarn)" ]; then
    echo '##########  Instalando Yarn ############'
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt update && sudo apt install --no-install-recommends yarn
  exit 1
fi


if ! [ -x "$(command -v filezilla)" ]; then
  echo '##########  Instalando Filezilla ############'
  sudo apt-get install filezilla 
  exit 1
fi

if ! [ -x "$(command -v npm)" ]; then
  echo '##########  Instalando NPM ############'
  sudo apt install npm
  exit 1
fi

#if ! [ -x "$(command -v mysql-workbench)" ]; then
    #echo '##########  Instalando Mysql Workbench ############'
    #sudo apt install mysql-workbench
    #exit 1
#fi


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

#if ! [ -x "$(command -v gitkraken)" ]; then
    #echo '##########  Instalando Git Kraken ############'
    #wget https://release.gitkraken.com/linux/gitkraken-amd64.deb
    #dpkg -i gitkraken-amd64.deb
    #exit 1
#fi

echo '##########  Instalando Oh my zsh ############'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo '##########  Instalando Plugin ZPLUGIN ############'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"


if ! [ -x "$(command -v docker)" ]; then
    echo '##########  Instalando Docker ############'
    sudo apt update
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(bionic) stable"
    sudo apt update
    sudo apt-get install docker-ce docker-ce-cli containerd.io -y
    if ! [ -x "$(command -v docker-compose)" ]; then
      echo '##########  Instalando Dcoker Compose ############'
      sudo apt install docker-compose -y
      exit 1
    fi
    
    echo '##########  Executando Configuração Docker Pós Instalação ############'
    sudo usermod -aG docker $USER
    sudo systemctl enable docker

    echo '##########  Reiniciando a Máquina ############'
    reboot
  exit 1
fi
