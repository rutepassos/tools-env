## Quick start

- Open you terminal
- `cd tools-env`
- `./install-ubuntu.sh`

## Config Git

#### Change Editor Config Git

```
git config --global core.editor code

git config --global --edit

```

The last command opening file of config git with vscode, so in line
[core] add flag --wait. EX:

```
[core]
  editor = code --wait

```

#### Alias Git

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
