echo '##########  Executando Update ############'
sudo apt-get update

if ! [ -x "$(command -v git)" ]; then
  echo '##########  Instalando Git ############'
  sudo apt-get install git -y
fi

echo '##########  Instalando Dependencias ############'
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

if ! [ -x "$(command -v snap)" ]; then
  echo '##########  Instalando Snap ############'
  sudo apt-get install snapd -y
fi

if ! [ -x "$(command -v code)" ]; then
  echo '##########  Instalando VSCODE ############'
  sudo snap install --classic code
fi

if ! [ -x "$(command -v subl)" ]; then
    echo '##########  Instalando Sublime ############'
    curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
    sudo add-apt-repository "deb https://download.sublimetext.com/ apt/stable/"
    sudo apt-get update
    sudo apt-get install sublime-text
#     # Abrir sublime pelo terminal
#     #sudo ln -s /opt/sublime/sublime_text /usr/bin/subl
fi

if ! [ -x "$(command -v insomnia)" ]; then
    echo '##########  Instalando Insomnia ############'
    sudo snap install insomnia
fi

if ! [ -x "$(command -v psql)" ]; then
    echo '##########  Instalando Postgres Client ############'
    sudo apt-get install postgresql-contrib -y
fi

if ! [ -x "$(command -v node)" ]; then
  echo '##########  Instalando Node ############'
  sudo apt-get install nodejs -y
fi

if ! [ -x "$(command -v npm)" ]; then
  echo '##########  Instalando NPM ############'
  sudo apt install npm -y
fi

if ! [ -x "$(command -v yarn)" ]; then
    echo '##########  Instalando Yarn ############'
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt-get update && sudo apt-get install --no-install-recommends yarn -y
fi


if ! [ -x "$(command -v filezilla)" ]; then
  echo '##########  Instalando Filezilla ############'
  sudo apt-get install filezilla -y
fi

# if ! [ -x "$(command -v mysql-workbench)" ]; then
#     echo '##########  Instalando Mysql Workbench ############'
#     sudo apt install mysql-workbench
# fi


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
#fi

if ! [ -x "$(command -v docker)" ]; then
    
    echo '##########  Instalando Docker ############'
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
    
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io -y

    if ! [ -x "$(command -v docker-compose)" ]; then
      echo '##########  Instalando Dcoker Compose ############'
      sudo apt-get install docker-compose -y
    fi
    
    echo '##########  Executando Configuração Docker Pós Instalação ############'
    sudo usermod -aG docker $USER
    sudo systemctl enable docker
fi

if ! [ -x "$(command -v zsh)" ]; then
    echo '##########  Instalando ZSH ############'
    sudo apt-get install zsh -y

    echo '##########  Instalando Oh my zsh ############'
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    #echo '##########  Instalando Plugin ZPLUGIN ############'
    #sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
fi

echo '##########  Reinicie a Máquina ############'
