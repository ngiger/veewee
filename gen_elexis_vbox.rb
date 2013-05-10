#!/usr/bin/env ruby
#
# Nota bene: To avoid nameclashes between vagrant 1.1 and 1.0.7
# you have to build this with vagrant 1.0.7 and HOME=/opt/vagrant_1.0/
#
require 'fileutils'
name = ARGV[0]
name = 'Elexis-Wheezy-amd64' unless name
buildTarget = "#{name}-#{Time.now.strftime('%Y%m%d')}"
def system(cmd)
  logName = cmd.split(' ')[2]
  logName = cmd.split(' ')[1] unless logName
  startTime = Time.now
  puts "time #{cmd} 2>&1 | tee #{logName}.log" 
  return true
  res = Kernel.system(cmd)
  endTime = Time.now
  puts "Executing #{cmd} took #{endTime - startTime} seconds"
  unless res
    puts "Running #{cmd} failed. exiting"
    exit 2
  end
  res
end

FileUtils.rm_f('Vagrantfile', :verbose => true)
# FileUtils.rm_f('*.box', :verbose => true)

exit unless system("bundle install")
#puts "We always edit the templates file, not the definition"
puts "if anything goes wrong. You might try to login using 
#  ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -p 7222 -l vagrant 127.0.0.1"
exit unless system("veewee vbox define #{buildTarget} #{name} --force")
exit unless system("veewee vbox build #{buildTarget} --force")
exit unless system("veewee vbox export #{buildTarget} --force")
exit unless system("veewee vbox box add #{buildTarget} #{File.expand_path(buildTarget)}.box --force")
if 0
  exit unless system("vagrant init #{buildTarget}")
  exit unless system("vagrant up")
  exit unless system("vagrant ssh")
end

