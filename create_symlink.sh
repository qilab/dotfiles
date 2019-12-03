#!/bin/bash

CURRENT_DIR=$(cd $(dirname $0);pwd)

create_symlink() {
  echo "create_symlink"
  if [ $# -ne 1 ]; then
    echo "invalid"
    return
  fi
  name=$1
  if [ ${name} = "git" ]; then
    git_symlink
  elif [ ${name} = "tmux" ]; then
    tmux_symlink
  elif [ ${name} = "vim" ]; then
    vim_symlink
  elif [ ${name} = "zsh" ]; then
    zsh_symlink
  else
    echo "invalid argument: ${name}"
  fi
}

git_symlink() {
  if [ -e ${HOME}/.gitconfig -o -e ${HOME}/.gitignore ]; then
    echo "${HOME}/.gitconfig or ${HOME}/.gitignore already exists"
    return
  fi
  echo "git_symlink"
  ln -snf ${CURRENT_DIR}/git/gitconfig ${HOME}/.gitconfig
  ln -snf ${CURRENT_DIR}/git/gitignore ${HOME}/.gitignore
}

tmux_symlink() {
  if [ -e ${HOME}/.tmux.conf ]; then
    echo "${HOME}/.tmux.conf already exists"
    return
  fi
  echo "tmux_symlink"
  ln -snf ${CURRENT_DIR}/tmux/tmux.conf ${HOME}/.tmux.conf
}

vim_symlink() {
  if [ -e ${HOME}/.vim -o -e ${HOME}/.vimrc ]; then
    echo "${HOME}/.vim or ${HOME}/.vimrc already exists"
    return
  fi
  echo "vim_symlink"
  git submodule update -i
  ln -snf ${CURRENT_DIR}/vim/vim ${HOME}/.vim
  ln -snf ${CURRENT_DIR}/vim/vimrc ${HOME}/.vimrc
  vim +PluginInstall +qall
}

zsh_symlink() {
  if [ -e ${HOME}/.zshrc ]; then
    echo "${HOME}/.zshrc already exists"
    return
  fi
  echo "zsh_symlink"
  ln -snf ${CURRENT_DIR}/zsh/zshrc ${HOME}/.zshrc
}

echo "start"
for x in "$@"
do
  create_symlink "$x"
done
echo "end"
