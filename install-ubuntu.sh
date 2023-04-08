#!/bin/bash

printf "\n"

echo "\e[31mATTENTION: PLEASE, AFTER ENDING INSTALLATION REBOOT THE MACHINE!!!\e[0m"

printf "\n"

echo "\e[32mSTARTING INSTALATION IN 10s....\e[0m"

printf "\n"

sleep 10s


echo '##########  Exec Update ############'
sudo apt-get update

printf "\n"
printf "\n"

if ! [ -x "$(command -v git)" ]; then
  echo '##########  Install Git ############'
  sudo apt-get install git -y
fi

printf "\n"
printf "\n"

if [ -x "$(command -v git)" ]; then
  echo 'Add config global git? 1 - Yes or 2 - No'
  read CONFIG_GIT
  if [ $CONFIG_GIT == 1 ] 
  then 
      echo "Please, enter with user"
      read USER_GIT
      git config --global user.name "${USER_GIT}"
      
      echo "Please, enter with e-mail"
      read EMAIL_GIT
      git config --global user.email "${EMAIL_GIT}"
  fi
fi

printf "\n"
printf "\n"

echo "Generate ssh key? 1 - Yes or 2 - No"
read KEY_SSH

if [ $KEY_SSH == 1 ] 
then 
    echo "Please, enter with you e-mail"
    read EMAIL_SSH
    ssh-keygen -t rsa -b 4096 -C "${EMAIL_SSH}"
fi

printf "\n"
printf "\n"

echo "Add key in repository Gitlab? 1 - Yes or 2 - No"
read ADD_KEY_REPO
if [ $ADD_KEY_REPO == 1 ] 
  then 
    echo "Please, enter with URL Gitlab"
    read URL_GITLAB
    
    if [ -z $URL_GITLAB ]
    then
      echo "URL Gitlab can't be empty";
      exit 1
    else 
      gitlab_host=$URL_GITLAB;
    fi

    echo "Please, enter with user gitlab"
    read USER_GITLAB
    read -s -p "Enter Password: " PASSWORD_GITLAB

    gitlab_user=$USER_GITLAB
    gitlab_password=$PASSWORD_GITLAB
    # 1. curl for the login page to get a session cookie and the sources with the auth tokens
    body_header=$(curl -c cookies.txt -i "${gitlab_host}/users/sign_in" -s)

    # grep the auth token for the user login for
    #   not sure whether another token on the page will work, too - there are 3 of them
    csrf_token=$(echo $body_header | perl -ne 'print "$1\n" if /new_user.*?authenticity_token"[[:blank:]]value="(.+?)"/' | sed -n 1p)

    # 2. send login credentials with curl, using cookies and token from previous request
    curl -b cookies.txt -c cookies.txt -i "${gitlab_host}/users/sign_in" \
      --data "user[login]=${gitlab_user}&user[password]=${gitlab_password}" \
      --data-urlencode "authenticity_token=${csrf_token}"

    # 3. send curl GET request to personal access token page to get auth token
    body_header=$(curl -H 'user-agent: curl' -b cookies.txt -i "${gitlab_host}/profile/personal_access_tokens" -s)
    csrf_token=$(echo $body_header | perl -ne 'print "$1\n" if /authenticity_token"[[:blank:]]value="(.+?)"/' | sed -n 1p)

    # 4. curl POST request to send the "generate personal access token form"
    #      the response will be a redirect, so we have to follow using `-L`
    body_header=$(curl -L -b cookies.txt "${gitlab_host}/profile/personal_access_tokens" \
      --data-urlencode "authenticity_token=${csrf_token}" \
      --data 'personal_access_token[name]=golab-generated&personal_access_token[expires_at]=&personal_access_token[scopes][]=api')

    # 5. Scrape the personal access token from the response HTML
    personal_access_token=$(echo $body_header | perl -ne 'print "$1\n" if /created-personal-access-token"[[:blank:]]value="(.+?)"/' | sed -n 1p)
    
    if [ -z "$personal_access_token" ]
    then
      printf "\n"
      printf "\n"
      printf "\n"
      echo "Token is empty. Please, access settings -> Access Tokens and create one token in you profile and try again."
      exit 1
    else
      curl -d '{"title":"'"$(date +'%Y-%m-%d %T')"'","key":"'"$(cat ~/.ssh/id_rsa.pub)"'"}' -H 'Content-Type: application/json' ${gitlab_host}/api/v4/user/keys?private_token=${personal_access_token}
    fi
fi

printf "\n"
printf "\n"
printf "\n"

echo "Add key in repository Bitbucket? 1 - Yes or 2 - No"
read KEY_SSH_BITBUCKET

if [ $KEY_SSH_BITBUCKET == 1 ] 
then 
    echo "Please, enter with email bitbucket"
    read LOGIN_BITBUCKET
    echo "Please, enter with username bitbucket"
    read USERNAME_BITBUCKET
    read -s -p "Enter Password: " PASSWORD_BITBUCKET
    curl -u "${LOGIN_BITBUCKET}:${PASSWORD_BITBUCKET}" -X POST -H "Content-Type: application/json" -d '{"label":"'"$(date +'%Y-%m-%d %T')"'","key":"'"$(cat ~/.ssh/id_rsa.pub)"'"}' https://api.bitbucket.org/2.0/users/${USERNAME_BITBUCKET}/ssh-keys
fi

printf "\n"
printf "\n"
printf "\n"

echo "Add key in repository Github? 1 - Yes or 2 - No"
read KEY_SSH_GITHUB

if [ $KEY_SSH_GITHUB == 1 ] 
then 
  echo "Please, enter with user github"
  read USER_GITHUB
  read -s -p "Enter Password: " PASSWORD_GITHUB
  curl -u "${USER_GITHUB}:${PASSWORD_GITHUB}" --data '{"title":"'"$(date +'%Y-%m-%d %T')"'","key":"'"$(cat ~/.ssh/id_rsa.pub)"'"}' https://api.github.com/user/keys
fi

printf "\n"
printf "\n"
printf "\n"

echo '##########  Install Dependencies ############'
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

printf "\n"
printf "\n"


if ! [ -x "$(command -v vim)" ]; then
  echo '##########  Install Vim ############'
  sudo apt-get install vim -y
fi

printf "\n"
printf "\n"

if ! [ -x "$(command -v snap)" ]; then
  echo '##########  Install Snap ############'
  sudo apt-get install snapd -y
fi

printf "\n"
printf "\n"

if ! [ -x "$(command -v code)" ]; then
  echo '##########  Install VSCODE ############'
  sudo snap install --classic code
fi

printf "\n"
printf "\n"

if ! [ -x "$(command -v subl)" ]; then
    echo '##########  Install Sublime ############'
    curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
    sudo add-apt-repository "deb https://download.sublimetext.com/ apt/stable/"
    sudo apt-get update
    sudo apt-get install sublime-text -y
fi

printf "\n"
printf "\n"

if ! [ -x "$(command -v insomnia)" ]; then
    echo '##########  Install Insomnia ############'
    sudo snap install insomnia
fi

printf "\n"
printf "\n"

if ! [ -x "$(command -v discord)" ]; then
    echo '##########  Install Discord ############'
    sudo snap install discord
fi

printf "\n"
printf "\n"

if ! [ -x "$(command -v psql)" ]; then
    echo '##########  Install Postgres Client ############'
    sudo apt-get install postgresql-contrib -y
fi

printf "\n"
printf "\n"

if ! [ -x "$(command -v node)" ]; then
  echo '##########  Install Node ############'
  sudo apt-get install nodejs -y
fi

printf "\n"
printf "\n"

if ! [ -x "$(command -v npm)" ]; then
  echo '##########  Install NPM ############'
  sudo apt install npm -y
fi

printf "\n"
printf "\n"

if ! [ -x "$(command -v yarn)" ]; then
    echo '##########  Install Yarn ############'
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt-get update && sudo apt-get install --no-install-recommends yarn -y
fi

printf "\n"
printf "\n"

if ! [ -x "$(command -v filezilla)" ]; then
  echo '##########  Install Filezilla ############'
  sudo apt-get install filezilla -y
fi

printf "\n"
printf "\n"


if ! [ -x "$(command -v docker)" ]; then
    
    echo '##########  Install Docker ############'
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
    
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io -y

    if ! [ -x "$(command -v docker-compose)" ]; then
      echo '##########  Install Dcoker Compose ############'
      sudo apt-get install docker-compose -y
    fi
    
    echo '##########  Exec Config Docker Pós Install ############'
    sudo usermod -aG docker $USER
    sudo systemctl enable docker
fi

printf "\n"
printf "\n"

if ! [ -x "$(command -v composer)" ]; then
  echo '##########  Install Composer ############'
  sudo apt install php-cli php-xml php-gd php-curl php-pgsql php-mysql php-zip  php-mbstring unzip -y
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
  HASH="$(wget -q -O - https://composer.github.io/installer.sig)"
  php -r "if (hash_file('SHA384', 'composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
  sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
fi

printf "\n"
printf "\n"

if ! [ -x "$(command -v zsh)" ]; then
    echo '##########  Install ZSH ############'
    sudo apt-get install zsh -y

    echo '##########  Install Oh my zsh ############'
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

if ! [ -x "$(command -v docker)" ]; then
  reboot
fi

