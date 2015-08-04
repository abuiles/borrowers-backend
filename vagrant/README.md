## Vagrantfile

This folder includes a `Vagranfile` to run this railsapp locally.

#### base box

This project use `"alvaro/ubuntu1402-ruby222"` as base box.

There is a [packer](../packer) folder that you can use to build your own base box.


### networking

As is, the `Vagrantfile` will start the guest and map port `3000` from guest to host.

If you wish to use this backend with intra vagrant vms netork, you can add:

For [private network](https://docs.vagrantup.com/v2/networking/private_network.html) :

```ruby
  config.vm.network "private_network", ip: "192.168.50.4"
```

For [public network](https://docs.vagrantup.com/v2/networking/public_network.html) (bridged) :

```ruby
config.vm.network "public_network", ip: "192.168.0.17"
```


### provision scripts

The `provision.sh` script, is idempotent, on first time will setup all the requirements, or skip them if found.

On a second run, it will restart the rails application if running.

Rails server will be started in tmux. Use 'vagrant ssh -c "tmux a"' to connect
To detach and leave rails server running, use CTRL+b d
To cancel rails server, use CTRL+c

### Folder structure

Inside the virtual guest, `/vagrant` is mapped to the /vagrant folder.

The rails app will be available on `/srv/railsapp` folder.

### vagrant up

On first run, `vagrant up` will download the base box and then will start the guest.

On my mac mini, once the base box is cached, a new start takes about 2 minutes to deploy the backend.

Once the machine is up, the rails app will be running on port 3000 on the guest and this port will be mapped to the host.

You can test the rails app with:

```bash
curl http://127.0.0.1:3000/api/friends.json
curl http://127.0.0.1:3000/api/articles.json
```

### vagrant provision

After changes in the rails app, you can manually restart rails, or you can run `vagrant provision`.

This will:
- Stop rails app if running
- Stop tmux if running
- Start rails app inside tmux

sample run:

```bash
==> default: Running provisioner: shell...
    default: Running: /var/folders/_h/d14sw7c55ds3qr05nnp6ckhc0000gn/T/vagrant-shell20150804-94357-1jnlno9.sh
==> default: Swap found: 524284 Kb
==> default: ~ ~
==> default: /usr/bin/tmux
==> default: /usr/bin/git
==> default: /usr/bin/pg_config
==> default: /usr/bin/sqlite3
==> default: /usr/bin/jq
==> default: /home/vagrant/.rbenv/plugins/ruby-build/bin/ruby-build
==> default: /srv/railsapp ~ ~
==> default: ok: local rbenv is 2.2.2 (set by /srv/railsapp/.ruby-version)
==> default: Successfully installed bundler-1.10.6
==> default: 1 gem installed
==> default: Using rake 10.3.2
==> default: Using i18n 0.6.11
==> default: Using json 1.8.1
==> default: Using minitest 5.4.0
==> default: Using thread_safe 0.3.4
==> default: Using tzinfo 1.2.2
==> default: Using activesupport 4.1.5
==> default: Using builder 3.2.2
==> default: Using erubis 2.7.0
==> default: Using actionview 4.1.5
==> default: Using rack 1.5.2
==> default: Using rack-test 0.6.2
==> default: Using actionpack 4.1.5
==> default: Using mime-types 1.25.1
==> default: Using polyglot 0.3.5
==> default: Using treetop 1.4.15
==> default: Using mail 2.5.4
==> default: Using actionmailer 4.1.5
==> default: Using activemodel 4.1.5
==> default: Using active_model_serializers 0.8.1
==> default: Using arel 5.0.1.20140414130214
==> default: Using activerecord 4.1.5
==> default: Using after_commit_action 0.1.4
==> default: Using counter_culture 0.1.29
==> default: Using hike 1.2.3
==> default: Using multi_json 1.10.1
==> default: Using pg 0.17.1
==> default: Using rack-cors 0.2.9
==> default: Using bundler 1.10.6
==> default: Using thor 0.19.1
==> default: Using railties 4.1.5
==> default: Using tilt 1.4.1
==> default: Using sprockets 2.12.1
==> default: Using sprockets-rails 2.1.3
==> default: Using rails 4.1.5
==> default: Using rails-api 0.2.1
==> default: Using rails_serve_static_assets 0.0.2
==> default: Using rails_stdout_logging 0.0.3
==> default: Using rails_12factor 0.0.2
==> default: Using shoulda-context 1.2.1
==> default: Using shoulda-matchers 2.6.2 from https://github.com/thoughtbot/shoulda-matchers.git (at master)
==> default: Using shoulda 3.5.0
==> default: Using spring 1.1.3
==> default: Using sqlite3 1.3.9
==> default: Bundle complete! 11 Gemfile dependencies, 44 gems now installed.
==> default: Use `bundle show [gemname]` to see where a bundled gem is installed.
==> default: user exist on postgres
==> default: database exist on postgres
==> default: rails: 1 windows (created Mon Aug  3 22:23:47 2015) [80x23]
==> default: Rails server will be started in tmux. Use 'vagrant ssh -c "tmux a"' to connect
==> default: To detach and leave rails server running, use CTRL+b d
==> default: To cancel rails server, use CTRL+c
==> default:  
==> default: To test api use:
==> default: curl http://127.0.0.1:3000/api/friends.json
==> default: curl http://127.0.0.1:3000/api/articles.json
==> default: ~ ~
```
