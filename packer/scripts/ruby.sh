#!/bin/bash

pushd /home/vagrant
which tmux git pg_config sqlite3 jq ruby-build 2>/dev/null
if [ $? -ne 0 ]; then
  sudo apt-get update
  sudo apt-get install -y tmux git postgresql postgresql-server-dev-all sqlite3 libsqlite3-dev jq ruby-build
  hash -r
fi

[ -f ~/.gemrc ] || echo 'gem: --no-document' > ~/.gemrc

#rbenv and local ruby
if [ ! -f .rbenv/bin/rbenv ]; then
  git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
  echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
  git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
  echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bash_profile
  git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash
fi

source ~/.bash_profile
hash -r
rbenv rehash
source ~/.bash_profile

#install ruby 2.2.2
if [ ! -d ~/.rbenv/versions/2.2.2 ]; then
  rbenv install 2.2.2
  rbenv local 2.2.2
  #update rubygems
  gem install rubygems-update
  update_rubygems
  gem update
fi
