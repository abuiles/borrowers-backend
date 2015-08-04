#!/bin/bash

#if VM has no swap,create swapfile
SWAP="`awk '$1=="SwapTotal:"{if ($2>0) print $2}' /proc/meminfo`"
if [ $SWAP ]; then
  echo "Swap found: $SWAP Kb"
else
  [ -f /swapfile ] || sudo fallocate -l 512M /swapfile
  sudo blkid /swapfile || (sudo mkswap -f /swapfile  ; sudo swapon /swapfile)
  sudo sysctl vm.swappiness=10
fi

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

pushd /srv/railsapp
#set local ruby to 2.2.2
RBENV_VERSION="`rbenv version`"
if [[ "$RBENV_VERSION" =~ "2.2.2" ]]; then
  echo "ok: local rbenv is $RBENV_VERSION"
else
  rbenv local 2.2.2                                                                            
fi

#bundle install for rails app
gem install bundler
bundle install

#evaluate variables
eval export `jq  '.env' app.json | tr -d ',{}" ' | tr ':' '='`

#check vagrant user in postgres
PGUSER="`sudo -u postgres psql postgres -tAc "SELECT 0 FROM pg_roles WHERE rolname='vagrant'"`"
if [ "$PGUSER" == "0" ]; then
  echo "user exist on postgres"
else
  sudo -u postgres createuser vagrant
fi

#check db/production in postgres
sudo -u postgres psql db/production -c '\q' 2>/dev/null
if [ $? -eq 0 ]; then
  echo "database exist on postgres"
else
  sudo -u postgres createdb db/production
fi

#configure db backend
if [ ! -f /srv/railsapp/config/database.yml ]; then
  cp /vagrant/database.yml /srv/railsapp/config
fi

#populate db
bundle exec rake db:migrate

#kill rails if running
if [ -f /vagrant/tmp/pids/server.pid ]; then
  PID="`cat tmp/pids/server.pid`"
  [ "$PID" ] && kill $PID
  rm /vagrant/tmp/pids/server.pid 
fi
PID="`lsof -i TCP:3000 | awk '/LISTEN/ { print $2 }' 2>/dev/null`"
[ "$PID" ] && kill $PID

#kill tmux if running
tmux ls 2>/dev/null && tmux kill-server

#run rails
tmux new -d -s rails 'echo "To detach and leave rails server running, use CTRL+b d" ; rails server --binding 0.0.0.0'
sleep .5

echo "Rails server will be started in tmux. Use 'vagrant ssh -c \"tmux a\"' to connect"
echo "To detach and leave rails server running, use CTRL+b d"
echo "To cancel rails server, use CTRL+c"
echo " "
echo "To test api use:"
echo curl http://127.0.0.1:3000/api/friends.json
echo curl http://127.0.0.1:3000/api/articles.json
popd
#end
