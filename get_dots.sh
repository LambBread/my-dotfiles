#!/bin/bash
git clone https://github.com/LambBread/my-nvim-config.git nvim
git clone https://github.com/LambBread/conky-themes temp-conky-themes
mkdir -p conky
cp temp-conky-themes/themes/strip/dark-strip-l-1920-1080.conf conky/conky.conf
cp temp-conky-themes/themes/strip/dark-strip-r-1366-768.conf conky/conky_laptop.conf
cp temp-conky-themes/themes/basic_conky.conf conky/conky_basic.conf
rm -rf temp-conky-themes
#git clone https://github.com/junegunn/vim-plug temp-vim-plug
#mkdir -p nvim/autoload
#cp temp-vim-plug/plug.vim nvim/autoload/plug.vim
#rm -rf temp-vim-plug
