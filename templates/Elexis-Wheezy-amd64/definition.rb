#Thanks to Fletcher Nichol - https://github.com/fnichol
# To get a list of all questions and answer do the following on an installed debian system
# sudo apt-get install debconf-utils
# sudo debconf-get-selections --installer
 
Veewee::Definition.declare({
  :cpu_count => '1',
  :memory_size=> '256',
  :disk_size => '10140', :disk_format => 'VDI', :hostiocache => 'off',
  :os_type_id => 'Debian_64',
  :iso_file => "debian-wheezy-DI-rc1-amd64-netinst.iso",
  :iso_src => "http://cdimage.debian.org/cdimage/wheezy_di_rc1/amd64/iso-cd/debian-wheezy-DI-rc1-amd64-netinst.iso",
  :iso_md5 => "412f77d4b98adf2a7d575745fd282d78",
  :iso_download_timeout => "1000",
  :boot_wait => "10", :boot_cmd_sequence => [
     '<Esc>',
     'install ',
     'preseed/url=http://%IP%:%PORT%/preseed.cfg ',
     'debian-installer=de_CH ',
     'auto ',
     'locale=de_CH.UTF-8 ',
     'kbd-chooser/method=sg ',
     'netcfg/get_hostname=%NAME% ',
     'netcfg/get_domain=vagrantup.com ',
     'fb=false ',
     'debconf/frontend=noninteractive ',
     'console-setup/ask_detect=false ',
     'keyboard-configuration/xkb-keymap=ch ',
     '<Enter>'
  ],
  :kickstart_port => "7122",
  :kickstart_timeout => "10000",
  :kickstart_file => "preseed.cfg",
  :ssh_login_timeout => "10000",
  :ssh_user => "vagrant",
  :ssh_password => "vagrant",
  :ssh_key => "",
  :ssh_host_port => "7222",
  :ssh_guest_port => "22",
  :sudo_cmd => "echo '%p'|sudo -S bash '%f'",
  :shutdown_cmd => "halt -p",
  :postinstall_files => [
    "base.sh",
    "vagrant.sh",
    "virtualbox.sh",
    "ruby.sh",
    "puppet.sh",
#    "chef.sh",
    "cleanup-virtualbox.sh",
    "cleanup.sh",
    "zerodisk.sh"
  ],
  :postinstall_timeout => "10000"
})
