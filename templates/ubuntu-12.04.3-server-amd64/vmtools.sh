if test -f .vmfusion_version ; then                                                                                                                                          [15/436]

  cd /tmp
  mkdir -p /mnt/cdrom
  mount -o loop /home/vagrant/linux.iso /mnt/cdrom
  tar zxvf /mnt/cdrom/VMwareTools-*.tar.gz -C /tmp/
  /tmp/vmware-tools-distrib/vmware-install.pl -d
  rm /home/vagrant/linux.iso
  umount /mnt/cdrom

fi

if test -f .vbox_version ; then                                                                                                                                               [3/436]

  # Without libdbus virtualbox would not start automatically after compile
  apt-get -y install --no-install-recommends libdbus-1-3

  # The netboot installs the VirtualBox support (old) so we have to remove it
  /etc/init.d/virtualbox-ose-guest-utils stop
  rmmod vboxguest
  aptitude -y purge virtualbox-ose-guest-x11 virtualbox-ose-guest-dkms virtualbox-ose-guest-utils
  aptitude -y install dkms

  # Install the VirtualBox guest additions
  VBOX_VERSION=$(cat /home/vagrant/.vbox_version)
  VBOX_ISO=VBoxGuestAdditions_$VBOX_VERSION.iso
  mount -o loop $VBOX_ISO /mnt
  yes|sh /mnt/VBoxLinuxAdditions.run
  umount /mnt

  #Cleanup VirtualBox
  rm $VBOX_ISO
fi
