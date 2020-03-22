#! /bin/bash

# 
# sudo apt-get remove --purge vim vim-runtime vim-gnome vim-tiny vim-gui-common

# sudo apt-get install python-dev ruby-dev libperl-dev libncurses5-dev libatk1.0-dev libx11-dev libxpm-dev libxt-dev  luajit liblua5.1-0 liblua5.1-dev

# sudo rm -rf /usr/local/share/vim /usr/bin/vim

cd ~
git clone https://github.com/vim/vim
cd vim
git pull && git fetch

# instead of using master branch - checkout the latest tag:
git checkout v8.2.0416


# In case Vim was already installed
cd src
make distclean
cd ..

# export LUA_PREFIX=/usr

./configure \
--enable-multibyte \
--enable-perlinterp=dynamic \
--enable-rubyinterp=dynamic \
--with-ruby-command=/usr/bin/ruby \
--enable-python3interp \
--with-python3-config-dir=/usr/lib/python3.8/config-3.8m-x86_64-linux-gnu \
--enable-cscope \
--enable-gui=auto \
--with-features=huge \
--with-x \
--enable-fontset \
--enable-largefile \
--disable-netbeans \
--with-compiledby="user" \
--enable-gtk2-check \
--enable-gnome-check \
--enable-fail-if-missing \
--prefix=/opt/vim82

# --enable-pythoninterp=dynamic \
# --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
# --enable-luainterp \
# --with-luajit \

# make && sudo make install

# ln -s /opt/vim82/bin/ex /usr/bin/ex 
# ln -s /opt/vim82/bin/rview /usr/bin/rview 
# ln -s /opt/vim82/bin/rvim /usr/bin/rvim 
# ln -s /opt/vim82/bin/view /usr/bin/view 
# ln -s /opt/vim82/bin/vim /usr/bin/vim 
# ln -s /opt/vim82/bin/vimdiff /usr/bin/vimdiff



