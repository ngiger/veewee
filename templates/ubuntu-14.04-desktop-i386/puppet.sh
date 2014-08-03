# GEM=/opt/ruby/bin/gem

adduser --system --group --home /var/lib/puppet puppet
# $GEM install puppet --no-ri --no-rdoc --version=3.5.1
# $GEM install librarian-puppet --no-ri --no-rdoc --version=1.0.3
#  /etc/profile.d/vagrantruby.sh
code_name=`lsb_release -c | cut -f2`
wget https://apt.puppetlabs.com/puppetlabs-release-${code_name}.deb
sudo dpkg -i puppetlabs-release-${code_name}.deb
sudo apt-get update
sudo apt-get build-dep --yes librarian-puppet
sudo apt-get install -y git puppet-common=3.6.1-1puppetlabs1 puppet=3.6.1-1puppetlabs1 hiera=1.3.4-1puppetlabs1
sudo gem install librarian-puppet --version=1.3.1 --no-ri --no-rdoc
