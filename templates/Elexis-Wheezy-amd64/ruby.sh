# install rvm and ruby 1.9.2
# Similar to https://raw.github.com/ngiger/elexis-vagrant/with_hiera/bootstrap_debian.sh
# Thanks to ideas from templates/ubuntu-11.10-server-amd64-rvm/postinstall.sh
debInst()
{
    dpkg-query -Wf'${db:Status-abbrev}' "${1}" 2>/dev/null | grep -q '^i'
}

packets_needed="curl"
for j in $packets_needed
do
  if debInst $j; then
      echo $j seems to be already installed
  else
      apt-get install $j
  fi
done

echo "(Re)installing needed packets for RVM and ruby"
apt-get --assume-yes --no-install-recommends install bash curl git patch bzip2 \
  build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev \
  libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf \
  libc6-dev libgdbm-dev ncurses-dev automake libtool bison subversion libffi-dev libvirt-dev

# Install Ruby Version Manager
echo "Installing rvm as multi user into $RVM_MULTI_PATH"
curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer -o /tmp/rvm-installer
chmod +x /tmp/rvm-installer
/tmp/rvm-installer stable

# Enable RVM for all users
(cat <<'EOP'
[[ -s "/usr/local/rvm/scripts/rvm" ]] && source "/usr/local/rvm/scripts/rvm"
EOP
) > /etc/profile.d/rvm.sh
echo "gem: --no-rdoc --no-ri" > /home/vagrant/.gemrc
chown vagrant:vagrant /home/vagrant/.gemrc


# Install Ruby using RVM
echo "Installing Ruby 1.9.2 as default ruby"
bash -c '
 source /etc/profile
 rvm install 1.9.2
 rvm alias create default ruby-1.9.2
 rvm use 1.9.2 --default

 echo "Installing default RubyGems"
 gem install --no-rdoc --no-ri puppet hiera-gpg '

# Make default user member of RVM group
usermod -a -G rvm vagrant
  