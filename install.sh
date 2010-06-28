#!/bin/sh

if [ -e $HOME/.vim/plugin/MKD.vim ]; then
  echo "Removing old version of vim-markdown-preview ..."
  rm $HOME/.vim/plugin/MKD.vim
  echo "DONE.."
fi

echo "Copying plugin/* to $HOME/.vim/plugin ... "
cp -R plugin/* $HOME/.vim/plugin
echo "DONE.."

