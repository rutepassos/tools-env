## Execute Script

- Open you terminal
- Execute:

```
cd tools-env
sudo chmod +x install-ubuntu.sh
./install-ubuntu.sh

```

## Configuration Git

#### Editor

For change editor:

```
git config --global core.editor code
```

For open file of config:

```
git config --global --edit

```

The last command opening file of config git with vscode, so in line
[core] add flag --wait. EX:

```
[core]
  editor = code --wait

```

#### Alias

The alias are commands small for git, this help in productivity. For create alias add line [alias]. Ex:

```
[alias]
  s = !git status -s
```

In this repository there is a file `.gitconfig`, him contain some alias.

Example of use:

```
git s
git c "my message commit"
git l

```

## Hook Message Commit Policy

### Mode 1: Using Configuration Inside Repository Git

```
cd path/your_repository_git

# Copy content in git-hooks/commit-message-policy or git-hooks/commit-message-policy2 in the file:
vim .git/hooks/commit-msg

```

### Mode 1: Using Library Husky to Execute Script

#### Script in Ruby

Script hook is in ruby, for install ruby:

```
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
\curl -sSL https://get.rvm.io | bash -s stable --ruby
source ~/.rvm/scripts/rvm
reboot

```

```

yarn install
sudo chmod +x git-hooks/commit-message-policy

```

#### Script in Bash

Change in file package.json

```
"hooks": {
  "commit-msg": "git-hooks/commit-message-policy2 ${HUSKY_GIT_PARAMS}"
}
```

```
yarn install
sudo chmod +x git-hooks/commit-message-policy2

```
