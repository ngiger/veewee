# To update the path to get access the newly installed rvm/gem/ruby we need to source /etc/profile
source /etc/profile

if [ -f .veewee_params ]
then
  . .veewee_params
fi

# Add puppet user and group
adduser --system --group --home /var/lib/puppet puppet

# Installing Puppet and hiera-pgpg
apt-get build-dep puppet --assume-yes --no-install-recommends 
if [ $? -ne 0 ] ; then exit 1; fi
gem install puppet hiera-gpg --no-ri --no-rdoc
if [ $? -ne 0 ] ; then exit 1; fi

if [ -z "$PUPPET_VERSION" ]; then
  # Default to latest
  gem install puppet --no-ri --no-rdoc
else
  gem install puppet --no-ri --no-rdoc --version $PUPPET_VERSION
fi
if [ $? -ne 0 ] ; then exit 1; fi
